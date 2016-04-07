# Copyright (c) 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

package Syntax::Highlight::Engine::Kate::Template;

our $VERSION = '0.07';

use strict;
use Carp qw(cluck);
use Data::Dumper;

#my $regchars = '\\^.$|()[]*+?';

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my %args = (@_);

	my $debug = delete $args{'debug'};
	unless (defined($debug)) { $debug = 0 };
	my $substitutions = delete $args{'substitutions'};
	unless (defined($substitutions)) { $substitutions = {} };
	my $formattable = delete $args{'format_table'};
	unless (defined($formattable)) { $formattable = {} };
	my $engine = delete $args{'engine'};

	my $self = {};
	$self->{'attributes'} = {},
	$self->{'captured'} = [];
	$self->{'contextdata'} = {};
	$self->{'basecontext'} = '';
	$self->{'debug'} = $debug;
	$self->{'deliminators'} = '';
	$self->{'engine'} = '';
	$self->{'format_table'} = $formattable;
	$self->{'keywordcase'} = 1;
	$self->{'lastchar'} = '';
	$self->{'linesegment'} = '';
	$self->{'lists'} = {};
	$self->{'linestart'} = 1;
	$self->{'out'} = [];
	$self->{'plugins'} = {};
	$self->{'snippet'} = '';
	$self->{'snippetattribute'} = '';
	$self->{'stack'} = [];
	$self->{'substitutions'} = $substitutions;
	bless ($self, $class);
	unless (defined $engine) { $engine = $self };
	$self->engine($engine);
	$self->initialize;
	return $self;
}

sub attributes {
	my $self = shift;
	if (@_) { $self->{'attributes'} = shift; };
	return $self->{'attributes'};
}

sub basecontext {
	my $self = shift;
	if (@_) { $self->{'basecontext'} = shift; };
	return $self->{'basecontext'};
}

sub captured {
	my ($self, $c) = @_;
	if (defined($c)) {
		my $t = $self->engine->stackTop;
		my $n = 0;
		my @o = ();
		while (defined($c->[$n])) {
			push @o, $c->[$n];
			$n ++;
		}
		if (@o) {
			$t->[2] = \@o;
		}
	};
}

sub capturedGet {
	my ($self, $num) = @_;
	my $s = $self->engine->stack;
	if (defined($s->[1])) {
		my $c = $s->[1]->[2];
		$num --;
		if (defined($c)) {
			if (defined($c->[$num])) {
				my $r = $c->[$num];
				return $r;
			} else {
				warn "capture number $num not defined";
			}
		} else {
			warn "dynamic substitution is called for but nothing to substitute\n";
			return undef;
		}
	} else {
		warn "no parent context to take captures from";
	}
}

#sub captured {
#	my $self = shift;
#	if (@_) { 
#		$self->{'captured'} = shift;
##		print Dumper($self->{'captured'});
#	};
#	return $self->{'captured'}
##	my ($self, $c) = @_;
##	if (defined($c)) {
##		my $t = $self->engine->stackTop;
##		my $n = 0;
##		my @o = ();
##		while (defined($c->[$n])) {
##			push @o, $c->[$n];
##			$n ++;
##		}
##		if (@o) {
##			$t->[2] = \@o;
##		}
##	};
#}
#
#sub capturedGet {
#	my ($self, $num) = @_;
#	my $s = $self->captured;
#	if (defined $s) {
#		$num --;
#		if (defined($s->[$num])) {
#			return $s->[$num];
#		} else {
#			$self->logwarning("capture number $num not defined");
#		}
#	} else {
#		$self->logwarning("dynamic substitution is called for but nothing to substitute");
#		return undef;
#	}
#}

sub capturedParse {
	my ($self, $string, $mode) = @_;
	my $s = '';
	if (defined($mode)) {
		if ($string =~ s/^(\d)//) {
			$s = $self->capturedGet($1);
			if ($string ne '') {
				$self->logwarning("character class is longer then 1 character, ignoring the rest");
			}
		}
	} else {
		while ($string ne '') {
			if ($string =~ s/^([^\%]*)\%(\d)//) {
				my $r = $self->capturedGet($2);
				if ($r ne '') {
					$s = $s . $1 . $r
				} else {
					$s = $s . $1 . '%' . $2;
					$self->logwarning("target is an empty string");
				}
			} else {
				$string =~ s/^(.)//;
				$s = "$s$1";
			}
		}
	}
	return $s;
}

sub column {
	my $self = shift;
	return length($self->linesegment);
}

sub contextdata {
	my $self = shift;
	if (@_) { $self->{'contextdata'} = shift; };
	return $self->{'contextdata'};
}

sub contextInfo {
	my ($self, $context, $item) = @_;
	if  (exists $self->contextdata->{$context}) {
		my $c = $self->contextdata->{$context};
		if (exists $c->{$item}) {
			return $c->{$item}
		} else {
			return undef;
		}
	} else {
		$self->logwarning("undefined context '$context'");
		return undef;
	}
}

sub contextParse {
	my ($self, $plug, $context) = @_;
	if ($context =~ /^#pop/i) {
		while ($context =~ s/#pop//i) {
			$self->stackPull;
		}
	} elsif ($context =~ /^#stay/i) {
		#don't do anything 
	} elsif ($context =~ /^##(.+)/) {
		my $new = $self->pluginGet($1);
		$self->stackPush([$new, $new->basecontext]);
	} else {
		$self->stackPush([$plug, $context]);
	}
}

sub debug {
	my $self = shift;
	if (@_) { $self->{'debug'} = shift; };
	return $self->{'debug'};
}

sub debugTest {
	my $self = shift;
	if (@_) { $self->{'debugtest'} = shift; };
	return $self->{'debugtest'};
}

sub deliminators {
	my $self = shift;
	if (@_) { $self->{'deliminators'} = shift; };
	return $self->{'deliminators'};
}

sub engine {
	my $self = shift;
	if (@_) { $self->{'engine'} = shift; };
	return $self->{'engine'};
}


sub firstnonspace {
	my ($self, $string) = @_;
	my $line = $self->linesegment;
	if (($line =~ /^\s*$/) and ($string =~ /^[^\s]/)) {
		return 1
	}
	return ''
}

sub formatTable {
	my $self = shift;
	if (@_) { $self->{'format_table'} = shift; };
	return $self->{'format_table'};
}

sub highlight {
	my ($self, $text) = @_;
	$self->snippet('');
	my $out = $self->out;
	@$out = ();
	while ($text ne '') {
		my $top = $self->stackTop;
		if (defined($top)) {
			my ($plug, $context) = @$top;
			if ($text =~ s/^(\n)//) {
				$self->snippetForce;
				my $e = $plug->contextInfo($context, 'lineending');
				if (defined($e)) {
					$self->contextParse($plug, $e)
				}
				my $attr = $plug->attributes->{$plug->contextInfo($context, 'attribute')};
				$self->snippetParse($1, $attr);
				$self->snippetForce;
				$self->linesegment('');
				my $b = $plug->contextInfo($context, 'linebeginning');
				if (defined($b)) {
					$self->contextParse($plug, $b)
				}
			} else {
				my $sub = $plug->contextInfo($context, 'callback');
				my $result = &$sub($plug, \$text);
				unless($result) {
					my $f = $plug->contextInfo($context, 'fallthrough');
					if (defined($f)) {
						$self->contextParse($plug, $f);
					} else {
						$text =~ s/^(.)//;
						my $attr = $plug->attributes->{$plug->contextInfo($context, 'attribute')};
						$self->snippetParse($1, $attr);
					}
				}
			}
		} else {
			push @$out, length($text), 'Normal';
			$text = '';
		}
	}
	$self->snippetForce;
	return @$out;
}

sub highlightText {
	my ($self, $text) = @_;
	my $res = '';
	my @hl = $self->highlight($text);
	while (@hl) {
		my $f = shift @hl;
		my $t = shift @hl;
		unless (defined($t)) { $t = 'Normal' }
		my $s = $self->substitutions;
		my $rr = '';
		while ($f ne '') {
			my $k = substr($f , 0, 1);
			$f = substr($f, 1, length($f) -1);
			if (exists $s->{$k}) {
				 $rr = $rr . $s->{$k}
			} else {
				$rr = $rr . $k;
			}
		}
		my $rt = $self->formatTable;
		if (exists $rt->{$t}) {
			my $o = $rt->{$t};
			$res = $res . $o->[0] . $rr . $o->[1];
		} else {
			$res = $res . $rr;
			$self->logwarning("undefined format tag '$t'");
		}
	}
	return $res;
}

sub includePlugin {
	my ($self, $language, $text) = @_;
	my $eng = $self->engine;
	my $plug = $eng->pluginGet($language);
	if (defined($plug)) {
		my $context = $plug->basecontext;
		my $call = $plug->contextInfo($context, 'callback');
		if (defined($call)) {
			return &$call($plug, $text);
		} else {
			$self->logwarning("cannot find callback for context '$context'");
		}
	}
	return 0;
}

sub includeRules {
	my ($self, $context, $text) = @_;
	my $call = $self->contextInfo($context, 'callback');
	if (defined($call)) {
		return &$call($self, $text);
	} else {
		$self->logwarning("cannot find callback for context '$context'");
	}
	return 0;
}

sub initialize {
	my $self = shift;
	if ($self->engine eq $self) {
		$self->stack([[$self, $self->basecontext]]);
	}
}

sub keywordscase {
	my $self = shift;
	if (@_) { $self->{'keywordcase'} = shift; }
	return $self->{'keywordscase'}
}

sub languagePlug {
	my ($cw, $name) = @_;
	my %numb = (
		'1' => 'One',
		'2' => 'Two',
		'3' => 'Three',
		'4' => 'Four',
		'5' => 'Five',
		'6' => 'Six',
		'7' => 'Seven',
		'8' => 'Eight',
		'9' => 'Nine',
		'0' => 'Zero',
	);
	if ($name =~ s/^(\d)//) {
		$name = $numb{$1} . $name;
	}
	$name =~ s/\.//;
	$name =~ s/\+/plus/g;
	$name =~ s/\-/minus/g;
	$name =~ s/#/dash/g;
	$name =~ s/[^0-9a-zA-Z]/_/g;
	$name =~ s/__/_/g;
	$name =~ s/_$//;
	$name = ucfirst($name);
	return $name;
}

sub lastchar {
	my $self = shift;
	my $l = $self->linesegment;
	if ($l eq '') { return "\n" } #last character was a newline
	return substr($l, length($l) - 1, 1);
}

sub lastcharDeliminator {
	my $self = shift;
	my $deliminators = '\s|\~|\!|\%|\^|\&|\*|\+|\(|\)|-|=|\{|\}|\[|\]|:|;|<|>|,|\\|\||\.|\?|\/';
	if ($self->linestart or ($self->lastchar =~ /$deliminators/))  {
		return 1;
	}
	return '';
}

sub linesegment {
	my $self = shift;
	if (@_) { $self->{'linesegment'} = shift; };
	return $self->{'linesegment'};
}

sub linestart {
	my $self = shift;
	if ($self->linesegment eq '') {
		return 1
	}
	return '';
}

sub lists {
	my $self = shift;
	if (@_) { $self->{'lists'} = shift; }
	return $self->{'lists'}
}

sub out {
	my $self = shift;
	if (@_) { $self->{'out'} = shift; }
	return $self->{'out'};
}

sub listAdd {
	my $self = shift;
	my $listname = shift;
	my $lst = $self->lists;
	if (@_) {
		my @l = reverse sort @_;
		$lst->{$listname} = \@l;
	} else {
		$lst->{$listname} = [];
	}
}

sub logwarning {
	my ($self, $warning) = @_;
	my $top = $self->engine->stackTop;
	if (defined $top) {
		my $lang = $top->[0]->language;
		my $context = $top->[1];
		$warning = "$warning\n  Language => $lang, Context => $context\n";
	} else {
		$warning = "$warning\n  STACK IS EMPTY: PANIC\n"
	}
	cluck($warning);
}

sub parseResult {
	my ($self, $text, $string, $lahead, $column, $fnspace, $context, $attr) = @_;
	my $eng = $self->engine;
	if ($fnspace) {
		unless ($eng->firstnonspace($$text)) {
			return ''
		}
	}
	if (defined($column)) {
		if ($column ne $eng->column) {
			return '';
		}
	}
	unless ($lahead) {
		$$text = substr($$text, length($string));
		my $r;
		unless (defined($attr)) {
			my $t = $eng->stackTop;
			my ($plug, $ctext) = @$t;
			$r = $plug->attributes->{$plug->contextInfo($ctext, 'attribute')};
		} else {
			$r = $self->attributes->{$attr};
		}
		$eng->snippetParse($string, $r);
	}
	$eng->contextParse($self, $context);
	return 1
}

sub pluginGet {
	my ($self, $language) = @_;
	my $plugs = $self->{'plugins'};
	unless (exists($plugs->{$language})) {
		my $modname = 'Syntax::Highlight::Engine::Kate::' . $self->languagePlug($language);
		unless (defined($modname)) {
			$self->logwarning("no valid module found for language '$language'");
			return undef;
		}
		my $plug;
		eval "use $modname; \$plug = new $modname(engine => \$self);";
		if (defined($plug)) {
			$plugs->{$language} = $plug;
		} else {
			$self->logwarning("cannot create plugin for language '$language'\n$@");
		}
	}
	if (exists($plugs->{$language})) {
		return $plugs->{$language};
	} 
	return undef;
}

sub reset {
	my $self = shift;
	$self->stack([[$self, $self->basecontext]]);
	$self->out([]);
	$self->snippet('');
}

sub snippet {
	my $self = shift;
	if (@_) { $self->{'snippet'} = shift; }
	return $self->{'snippet'};
}

sub snippetAppend {
	my ($self, $ch) = @_;

	return if not defined $ch;
	$self->{'snippet'} = $self->{'snippet'} . $ch;
	if ($ch ne '') {
		$self->linesegment($self->linesegment . $ch);
	}
	return;
}

sub snippetAttribute {
	my $self = shift;
	if (@_) { $self->{'snippetattribute'} = shift; }
	return $self->{'snippetattribute'};
}

sub snippetForce {
	my $self = shift;
	my $parse = $self->snippet;
	if ($parse ne '') {
		my $out = $self->{'out'};
		push(@$out, $parse, $self->snippetAttribute);
		$self->snippet('');
	}
}

sub snippetParse {
	my $self = shift;
	my $snip = shift;
	my $attr = shift;
	if ((defined $attr) and ($attr ne $self->snippetAttribute)) { 
		$self->snippetForce;
		$self->snippetAttribute($attr);
	}
	$self->snippetAppend($snip);
}

sub stack {
	my $self = shift;
	if (@_) { $self->{'stack'} = shift; }
	return $self->{'stack'};
}

sub stackPush {
	my ($self, $val) = @_;
	my $stack = $self->stack;
	unshift(@$stack, $val);
}

sub stackPull {
	my ($self, $val) = @_;
	my $stack = $self->stack;
	return shift(@$stack);
}

sub stackTop {
	my $self = shift;
	return $self->stack->[0];
}

sub stateCompare {
	my ($self, $state) = @_;
	my $h = [ $self->stateGet ];
	my $equal = 0;
	if (Dumper($h) eq Dumper($state)) { $equal = 1 };
	return $equal;
}

sub stateGet {
	my $self = shift;
	my $s = $self->stack;
	return @$s;
}

sub stateSet {
	my $self = shift;
	my $s = $self->stack;
	@$s = (@_);
}

sub substitutions {
	my $self = shift;
	if (@_) { $self->{'substitutions'} = shift; }
	return $self->{'substitutions'};
}

sub testAnyChar {
	my $self = shift;
	my $text = shift;
	my $string = shift;
	my $insensitive = shift;
	my $test = substr($$text, 0, 1);
	my $bck = $test;
	if ($insensitive) {
		$string = lc($string);
		$test = lc($test);
	}
	if (index($string, $test) > -1) {
		return $self->parseResult($text, $bck, @_);
	}
	return ''
}

sub testDetectChar {
	my $self = shift;
	my $text = shift;
	my $char = shift; 
	my $insensitive = shift;
	my $dyn = shift;
	if ($dyn) {
		$char = $self->capturedParse($char, 1);
	}
	my $test = substr($$text, 0, 1);
	my $bck = $test;
	if ($insensitive) {
		$char = lc($char);
		$test = lc($test);
	}
	if ($char eq $test) {
		return $self->parseResult($text, $bck, @_);
	}
	return ''
}

sub testDetect2Chars {
	my $self = shift;
	my $text = shift;
	my $char = shift; 
	my $char1 = shift;
	my $insensitive = shift;
	my $dyn = shift;
	if ($dyn) {
		$char = $self->capturedParse($char, 1);
		$char1 = $self->capturedParse($char1, 1);
	}
	my $string = $char . $char1;
	my $test = substr($$text, 0, 2);
	my $bck = $test;
	if ($insensitive) {
		$string = lc($string);
		$test = lc($test);
	}
	if ($string eq $test) {
		return $self->parseResult($text, $bck, @_);
	}
	return ''
}

sub testDetectIdentifier {
	my $self = shift;
	my $text = shift;
	if ($$text =~ /^([a-zA-Z_][a-zA-Z0-9_]+)/) {
		return $self->parseResult($text, $1, @_);
	}
	return ''
}

sub testDetectSpaces {
	my $self = shift;
	my $text = shift;
	if ($$text =~ /^([\\040|\\t]+)/) {
		return $self->parseResult($text, $1, @_);
	}
	return ''
}

sub testFloat {
	my $self = shift;
	my $text = shift;
	if ($self->engine->lastcharDeliminator) {
		if ($$text =~ /^((?=\.?\d)\d*(?:\.\d*)?(?:[Ee][+-]?\d+)?)/) {
			return $self->parseResult($text, $1, @_);
		}
	}
	return ''
}

sub testHlCChar {
	my $self = shift;
	my $text = shift;
	if ($$text =~ /^('.')/) {
		return $self->parseResult($text, $1, @_);
	}
	return ''
}

sub testHlCHex {
	my $self = shift;
	my $text = shift;
	if ($self->engine->lastcharDeliminator) {
		if ($$text =~ /^(0x[0-9a-fA-F]+)/) {
			return $self->parseResult($text, $1, @_);
		}
	}
	return ''
}

sub testHlCOct {
	my $self = shift;
	my $text = shift;
	if ($self->engine->lastcharDeliminator) {
		if ($$text =~ /^(0[0-7]+)/) {
			return $self->parseResult($text, $1, @_);
		}
	}
	return ''
}

sub testHlCStringChar {
	my $self = shift;
	my $text = shift;
	if ($$text =~ /^(\\[a|b|e|f|n|r|t|v|'|"|\?])/) {
		return $self->parseResult($text, $1, @_);
	}
	if ($$text =~ /^(\\x[0-9a-fA-F][0-9a-fA-F]?)/) {
		return $self->parseResult($text, $1, @_);
	}
	if ($$text =~ /^(\\[0-7][0-7]?[0-7]?)/) {
		return $self->parseResult($text, $1, @_);
	}
	return ''
}

sub testInt {
	my $self = shift;
	my $text = shift;
	if ($self->engine->lastcharDeliminator) {
		if ($$text =~ /^([+-]?\d+)/) {
			return $self->parseResult($text, $1, @_);
		}
	}
	return ''
}

sub testKeyword {
	my $self = shift;
	my $text = shift;
	my $list = shift;
	my $eng = $self->engine;
	my $deliminators = $self->deliminators;
	if (($eng->lastcharDeliminator)  and ($$text =~ /^([^$deliminators]+)/)) {
		my $match = $1;
		my $l = $self->lists->{$list};
		if (defined($l)) {
			my @list = @$l;
			my @rl = ();
			unless ($self->keywordscase) {
				@rl = grep { (lc($match) eq lc($_)) } @list;
			} else {
				@rl = grep { ($match eq $_) } @list;
			}
			if (@rl) {
				return $self->parseResult($text, $match, @_);
			}
		} else {
			$self->logwarning("list '$list' is not defined, failing test");
		}
	}
	return ''
}

sub testLineContinue {
	my $self = shift;
	my $text = shift;
	my $lahead = shift;
	if ($lahead) {
		if ($$text =~ /^\\\n/) {
			$self->parseResult($text, "\\", $lahead, @_);
			return 1;
		}
	} else {
		if ($$text =~ s/^(\\)(\n)/$2/) {
			return $self->parseResult($text, "\\", $lahead, @_);
		}
	}
	return ''
}

sub testRangeDetect {
	my $self = shift;
	my $text = shift;
	my $char = shift;
	my $char1 = shift;
	my $insensitive = shift;
	my $string = "$char\[^$char1\]+$char1";
	return $self->testRegExpr($text, $string, $insensitive, 0, @_);
}

sub testRegExpr {
	my $self = shift;
	my $text = shift;
	my $reg = shift;
	my $insensitive = shift;
	my $dynamic = shift;
	if ($dynamic) {
		$reg = $self->capturedParse($reg);
	}
	my $eng = $self->engine;
	if ($reg =~ s/^\^//) {
		unless ($eng->linestart) {
			return '';
		}
	} elsif ($reg =~ s/^\\(b)//i) {
		my $lastchar = $self->engine->lastchar;
		if ($1 eq 'b') {
			if ($lastchar =~ /\w/) { return '' }
		} else {
			if ($lastchar =~ /\W/) { return '' }
		}
	}
#	$reg = "^($reg)";
	$reg = "^$reg";
	my $pos;
#	my @cap = ();
	my $sample = $$text;

	# emergency measurements to avoid exception (szabgab)
	$reg = eval { qr/$reg/ };
	if ($@) {
		warn $@;
		return '';
	}
	if ($insensitive) {
		if ($sample =~ /$reg/ig) {
			$pos = pos($sample);
#			@cap = ($1, $2, $3, $4, $5, $6, $7, $8, $9);
#			my @cap = ();
			if ($#-) {
				no strict 'refs';
				my @cap = map {$$_} 1 .. $#-;
				$self->captured(\@cap)
			}
#			my $r  = 1;
#			my $c  = 1;
#			my @cap = ();
#			while ($r) {
#				eval "if (defined\$$c) { push \@cap, \$$c } else { \$r = 0 }";
#				$c ++;
#			}
#			if (@cap) { $self->captured(\@cap) };
		}
	} else {
		if ($sample =~ /$reg/g) {
			$pos = pos($sample);
#			@cap = ($1, $2, $3, $4, $5, $6, $7, $8, $9);
#			my @cap = ();
			if ($#-) {
				no strict 'refs';
				my @cap = map {$$_} 1 .. $#-;
				$self->captured(\@cap);
			}
#			my $r  = 1;
#			my $c  = 1;
#			my @cap = ();
#			while ($r) {
#				eval "if (defined\$$c) { push \@cap, \$$c } else { \$r = 0 }";
#				$c ++;
#			}
#			if (@cap) { $self->captured(\@cap) };
		}
	}
	if (defined($pos) and ($pos > 0)) {
		my $string = substr($$text, 0, $pos);
		return $self->parseResult($text, $string, @_);
	}
	return ''
}

sub testStringDetect {
	my $self = shift;
	my $text = shift;
	my $string = shift;
	my $insensitive = shift;
	my $dynamic = shift;
	if ($dynamic) {
		$string = $self->capturedParse($string);
	}
	my $test = substr($$text, 0, length($string));
	my $bck = $test;
	if ($insensitive) {
		$string = lc($string);
		$test = lc($test);
	}
	if ($string eq $test) {
		return $self->parseResult($text, $bck, @_);
	}
	return ''
}


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Template - a template for syntax highlighting plugins

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Template is a framework to assist authors of plugin modules.
All methods to provide highlighting to the Syntax::Highlight::Engine::Kate module are there, Just
no syntax definitions and callbacks. An instance of Syntax::Highlight::Engine::Kate::Template 
should never be created, it's meant to be sub classed only. 

=head1 METHODS

=over 4

=item B<attributes>(I<?$attributesref?>);

Sets and returns a reference to the attributes hash.

=item B<basecontext>(I<?$context?>);

Sets and returns the basecontext instance variable. This is the context that is used when highlighting starts.

=item B<captured>(I<$cap>);

Puts $cap in the first element of the stack, the current context. Used when the context is dynamic.

=item B<capturedGet>(I<$num>);

Returns the $num'th element that was captured in the current context.

=item B<capturedParse>(I<$string>, I<$mode>);

If B<$mode> is specified, B<$string> should only be one character long and numeric.
B<capturedParse> will return the Nth captured element of the current context.

If B<$mode> is not specified, all occurences of %[1-9] will be replaced by the captured
element of the current context.

=item B<column>

returns the column position in the line that is currently highlighted.

=item B<contextdata>(I<\%data>);

Sets and returns a reference to the contextdata hash.

=item B<contextInfo>(I<$context>, I<$item>);

returns the value of several context options. B<$item> can be B<callback>, B<attribute>, B<lineending>,
B<linebeginning>, B<fallthrough>.

=item B<contextParse>(I<$plugin>, I<$context>);

Called by the plugins after a test succeeds. if B<$context> has following values:

 #pop       returns to the previous context, removes to top item in the stack. Can
            also be specified as #pop#pop etc.
 #stay      does nothing.
 ##....     Switches to the plugin specified in .... and assumes it's basecontext.
 ....       Swtiches to the context specified in ....

=item B<deliminators>(I<?$delim?>);

Sets and returns a string that is a regular expression for detecting deliminators.

=item B<engine>

Returns a reference to the Syntax::Highlight::Engine::Kate module that created this plugin.

=item B<firstnonspace>(I<$string>);

returns true if the current line did not contain a non-spatial character so far and the first 
character in B<$string> is also a spatial character.

=item B<formatTable>

sets and returns the instance variable B<format_table>. See also the option B<format_table>

=item B<highlight>(I<$text>);

highlights I<$text>. It does so by selecting the proper callback
from the B<commands> hash and invoke it. It will do so untill
$text has been reduced to an empty string. returns a paired list
of snippets of text and the attribute with which they should be 
highlighted.

=item B<highlightText>(I<$text>);

highlights I<$text> and reformats it using the B<format_table> and B<substitutions>

=item B<includePlugin>(I<$language>, I<\$text>);

Includes the plugin for B<$language> in the highlighting.

=item B<includeRules>(I<$language>, I<\$text>);

Includes the plugin for B<$language> in the highlighting.

=item B<keywordscase>

Sets and returns the keywordscase instance variable.

=item B<lastchar>

return the last character that was processed.

=item B<lastcharDeliminator>

returns true if the last character processed was a deliminator.

=item B<linesegment>

returns the string of text in the current line that has been processed so far,

=item B<linestart>

returns true if processing is currently at the beginning of a line.

=item B<listAdd>(I<'listname'>, I<$item1>, I<$item2> ...);

Adds a list to the 'lists' hash.

=item B<lists>(I<?\%lists?>);

sets and returns the instance variable 'lists'.

=item B<out>(I<?\@highlightedlist?>);

sets and returns the instance variable 'out'.

=item B<parseResult>(I<\$text>, I<$match>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

Called by every one of the test methods below. If the test matches, it will do a couple of subtests.
If B<$column> is a defined numerical value it will test if the process is at the requested column.
If B<$firnonspace> is true, it will test this also.
Ig it is not a look ahead and all tests are passed, B<$match> is then parsed and removed from B<$$text>.

=item B<pluginGet>(I<$language>);

Returns a reference to a plugin object for the specified language. Creating an 
instance if needed.

=item B<reset>

Resets the highlight engine to a fresh state, does not change the syntx.

=item B<snippet>

Contains the current snippet of text that will have one attribute. The moment the attribute 
changes it will be parsed.

=item B<snippetAppend>(I<$string>)

appends I<$string> to the current snippet.

=item B<snippetAttribute>(I<$attribute>)

Sets and returns the used attribute.

=item B<snippetForce>

Forces the current snippet to be parsed.

=item B<snippetParse>(I<$text>, I<?$attribute?>)

If attribute is defined and differs from the current attribute it does a snippetForce and
sets the current attribute to B<$attribute>. Then it does a snippetAppend of B<$text>

=item B<stack>

sets and returns the instance variable 'stack', a reference to an array

=item B<stackPull>

retrieves the element that is on top of the stack, decrements stacksize by 1.

=item B<stackPush>(I<$tagname>);

puts I<$tagname> on top of the stack, increments stacksize by 1

=item B<stackTop>

Retrieves the element that is on top of the stack.

=item B<stateCompare>(I<\@state>)

Compares two lists, \@state and the stack. returns true if they
match.

=item B<stateGet>

Returns a list containing the entire stack.

=item B<stateSet>(I<@list>)

Accepts I<@list> as the current stack.

=item B<substitutions>

sets and returns a reference to the substitutions hash.

=back

The methods below all return a boolean value.

=over 4

=item B<testAnyChar>(I<\$text>, I<$string>, I<$insensitive>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testDetectChar>(I<\$text>, I<$char>, I<$insensitive>, I<$dynamic>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testDetect2Chars>(I<\$text>, I<$char1>, I<$char2>, I<$insensitive>, I<$dynamic>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testDetectIdentifier>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testDetectSpaces>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testFloat>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testHlCChar>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testHlCHex>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testHlCOct>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testHlCStringChar>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testInt>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testKeyword>(I<\$text>, I<$list>, I<$insensitive>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testLineContinue>(I<\$text>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testRangeDetect>(I<\$text>,  I<$char1>, I<$char2>, I<$insensitive>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testRegExpr>(I<\$text>, I<$reg>, I<$insensitive>, I<$dynamic>, I<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=item B<testStringDetect>(I<\$text>, I<$string>, I<$insensitive>, I<$dynamic>, II<$lookahaed>, I<$column>, I<$firstnonspace>, I<$context>, I<$attribute>);

=back

=head1 ACKNOWLEDGEMENTS

All the people who wrote Kate and the syntax highlight xml files.

=head1 AUTHOR AND COPYRIGHT

This module is written and maintained by:

Hans Jeuken < haje at toneel dot demon dot nl >

Copyright (c) 2006 by Hans Jeuken, all rights reserved.

You may freely distribute and/or modify this module under same terms as
Perl itself 

=head1 SEE ALSO

Synax::Highlight::Engine::Kate http:://www.kate-editor.org