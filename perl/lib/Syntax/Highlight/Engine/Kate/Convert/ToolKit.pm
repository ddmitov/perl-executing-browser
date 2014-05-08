# Copyright (c) 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

package Syntax::Highlight::Engine::Kate::Convert::ToolKit;

our $VERSION = '0.07';

use strict;
use warnings;
use XML::Dumper;
require Syntax::Highlight::Engine::Kate::Convert::XMLData;

use File::Basename;

my $regfile = "SHEKREGISTRY.xml";
my $regchars = "\\^.\$|()[]{}*+?~!%^&/";

my %tests = (
	AnyChar => \&testRuleAnyChar,
	DetectChar => \&testRuleDetectChar,
	Detect2Chars => \&testRuleDetect2Chars,
	DetectIdentifier => \&testRuleDetectIdentifier,
	DetectSpaces => \&testRuleDetectSpaces,
	Float => \&testRuleFloat,
	HlCChar => \&testRuleHlCChar,
	HlCHex => \&testRuleHlCHex,
	HlCOct => \&testRuleHlCOct,
	HlCStringChar => \&testRuleHlCStringChar,
	IncludeRules => \&testRuleIncludeRules,
	Int => \&testRuleInt,
	keyword => \&testRuleKeyword,
	LineContinue => \&testRuleLineContinue,
	RangeDetect => \&testRuleRangeDetect,
	RegExpr => \&testRuleRegExpr,
	StringDetect => \&testRuleStringDetect,
);

my %parses = (
	AnyChar => \&pmRuleAnyChar,
	DetectChar => \&pmRuleDetectChar,
	Detect2Chars => \&pmRuleDetect2Chars,
	DetectIdentifier => \&pmRuleDetectIdentifier,
	DetectSpaces => \&pmRuleDetectSpaces,
	Float => \&pmRuleFloat,
	HlCChar => \&pmRuleHlCChar,
	HlCHex => \&pmRuleHlCHex,
	HlCOct => \&pmRuleHlCOct,
	HlCStringChar => \&pmRuleHlCStringChar,
	IncludeRules => \&pmRuleIncludeRules,
	Int => \&pmRuleInt,
	keyword => \&pmRuleKeyword,
	LineContinue => \&pmRuleLineContinue,
	RangeDetect => \&pmRuleRangeDetect,
	RegExpr => \&pmRuleRegExpr,
	StringDetect => \&pmRuleStringDetect,
);


my @stdoptions = qw(lookAhead column firstNonSpace context attribute);
my $stringtest = sub { return (length(shift) > 0) };
my $booltest = sub { my $l = lc(shift) ; return (($l eq 'true') or ($l eq 'false') or ($l eq '0') or ($l eq '1')) };
my $chartest = sub { return (length(shift) eq 1) };

my %testopts = (
	attribute => $stringtest,
	char => $chartest,
	char1 => $chartest,
	column => sub { return (shift =~ /^\d+$/)},
	context => $stringtest,
	dynamic => $booltest,
	firstNonSpace =>$booltest,
	insensitive => $booltest,
	lookAhead => $booltest,
	minimal => $booltest,
	String => $stringtest,
);

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;

	my $self = {
		indent => 0,
		indentchar => '   ',
		curlang => '',
		curcontext => '',
		guiadd => sub {  },
		logcmd => sub { warn shift },
		outcmd => sub { print shift },
		policy => 'abort',
		polcmd => sub { return 0 },
		reportdata => [],
		registered => {},
		runtestspace => '',
		verbose => 1,
		version => '0.01',
	};
	bless ($self, $class);
	return $self;
}


sub booleanize {
	my ($self, $d) = @_;
	if (lc($d) eq 'true') { $d = 1 };
	if (lc($d) eq 'false') { $d = 0 };
	if (($d ne 0) and ($d ne 1)) { return undef };
	return $d;
}

sub checkIntegrity {
	my $self = shift;
	my @l = @_;
	unless (@l) { @l = $self->registered };
	while (@l) {
		my $lang = shift @l;
		$self->curlang($lang);
		$self->indent(0);
		my $xml = $self->xmldata($lang);
		if (defined($xml)) {
			my $ctx = $xml->contexts;
			foreach my $k (sort keys %$ctx) {
				$self->curcontext($k);
				$self->lprint("checking context $k");
				$self->indentUp;
				my $itl = $ctx->{$k}->{'items'};
				$self->testContextItems(@$itl);
				$self->indentDown;
			}
		} else {
			$self->log("could not retrieve data for $lang");
		}
	}
}

sub curcontext {
	my $self = shift;
	if (@_) { $self->{'curcontext'} = shift; };
	return $self->{'curcontext'};
}

sub curlang {
	my $self = shift;
	if (@_) { $self->{'curlang'} = shift; };
	return $self->{'curlang'};
}

sub guiadd {
	my $self = shift;
	if (@_) { $self->{'guiadd'} = shift; };
	return $self->{'guiadd'};
}

sub indent {
	my $self = shift;
	if (@_) { $self->{'indent'} = shift; };
	return $self->{'indent'};
}

sub indentchar {
	my $self = shift;
	if (@_) { $self->{'indentchar'} = shift; };
	return $self->{'indentchar'};
}

sub indentDown {
	my $self = shift;
	if ($self->indent > 0) {
		$self->indent($self->indent - 1);
	} else {
		$self->log("indentation already 0\n");
	}
}

sub indentUp {
	my $self = shift;
	$self->indent($self->indent + 1);
}

sub log {
	my ($self, $msg) = @_;
	my $c = $self->logcmd;
	&$c($msg);
}

sub logcmd {
	my $self = shift;
	if (@_) { $self->{'logcmd'} = shift; };
	return $self->{'logcmd'};
}

sub lprint {
	my ($self, $txt) = @_;
	if (defined($txt)) { #check if only a newline should be given
		if ($txt ne '') { #do not indent empty lines
			my $c = 0;
			while ($c < $self->{'indent'}) {
				$txt = $self->indentchar . $txt;
				$c ++;
			}
		}
	} else {
		$txt = '';
	}
	my $c = $self->outcmd;
	&$c("$txt\n");
}

sub moduleName {
	my ($self, $name) = @_;
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

sub outcmd {
	my $self = shift;
	if (@_) { $self->{'outcmd'} = shift; };
	return $self->{'outcmd'};
}


sub pmGenerate {
	my $self = shift;
	my @l = @_;
	unless (@l) { @l = $self->registered };
	while (@l) {
		my $lang = shift @l;
		my $vbck = $self->verbose;
		$self->verbose(0);
		$self->indent(0);
		$self->curlang($lang);
		my $xml = $self->xmldata($lang);
		my $file = basename($xml->filename);
		my $lh = $xml->language;
		my $name = $self->moduleName($lang);
		my $i = $xml->itemdata;
		my %itemdata = %$i;
		my $l = $xml->lists;
		my %lists = %$l;
		my $c = $xml->contexts;
		my %contexts = %$c;

		$self->lprint("# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.");
		$self->lprint("# This program is free software; you can redistribute it and/or");
		$self->lprint("# modify it under the same terms as Perl itself.");
		$self->lprint;
		$self->lprint("# This file was generated from the '$file' file of the syntax highlight");
		$self->lprint("# engine of the kate text editor (http://www.kate-editor.org");
		$self->lprint;
		if (exists $lh->{'version'}) {
			$self->lprint("#kate xml version " . $lh->{'version'});
		}
		if (exists $lh->{'kateversion'}) {
			$self->lprint("#kate version " . $lh->{"kateversion"});
		}
		if (exists $lh->{'author'}) {
			$self->lprint("#kate author " . $lh->{"author"});
		}
		my $time = localtime;
		$self->lprint("#generated: $time, localtime");
		$self->lprint;
		$self->lprint("package Syntax::Highlight::Engine::Kate::$name;");
		$self->lprint;
		$self->lprint("use vars qw(\$VERSION);");
		$self->lprint("\$VERSION = '" . $self->version . "';");
		$self->lprint;
		$self->lprint("use strict;");
		$self->lprint("use warnings;");
		$self->lprint("use base('Syntax::Highlight::Engine::Kate::Template');");
		$self->lprint;
		$self->lprint("sub new {");
		$self->indentUp;
		$self->lprint("my \$proto = shift;");
		$self->lprint("my \$class = ref(\$proto) || \$proto;");
		$self->lprint("my \$self = \$class->SUPER::new(\@_);");
		if (%itemdata) {
			$self->lprint("\$self->attributes({");
			$self->indentUp;
			foreach my $at (sort keys %itemdata) {
				my $v = $itemdata{$at};
				$self->lprint("'$at' => '$v',");
			}
			$self->indentDown;
			$self->lprint("});");
		}
		if  (%lists) {
			foreach my $k (sort keys %lists) {
				$self->lprint("\$self->listAdd('$k',");
				$self->indentUp;
				my $il = $lists{$k};
				foreach my $i (sort @$il) {
					$i =~ s/\\/\\\\/g;
					$i =~ s/\'/\\'/g;
					$self->lprint($self->stringalize($i) . ",");
				}
				$self->indentDown;
				$self->lprint(");");
			}
		}
		$self->lprint("\$self->contextdata({");
		$self->indentUp;
		foreach my $ctx (sort keys %contexts) {
			my $p = $contexts{$ctx};
			$self->lprint("'$ctx' => {");
			$self->indentUp;
			$self->lprint("callback => \\&" . $self->pmMethodName($ctx) . ",");
			if (exists $p->{'attribute'}) {
				my $coi = $p->{'attribute'};
				$self->lprint("attribute => '$coi',");
			}
			if (exists $p->{'lineEndContext'}) {
				my $e = $p->{'lineEndContext'};
				unless ($e eq '#stay') {
					$self->lprint("lineending => '$e',");
				}
			}
			if (exists $p->{'lineBeginContext'}) {
				my $e = $p->{'lineBeginContext'};
				unless ($e eq '#stay') {
					$self->lprint("linebeginning => '$e',");
				}
			}
			if (exists $p->{'fallthrough'}) {
				my $e = $p->{'fallthrough'};
				if ($e eq 'true') {
					if (exists $p->{'fallthroughContext'}) {
						my $e = $p->{'fallthroughContext'};
						$self->lprint("fallthrough => '$e',");
					}
				}
			}
			if (exists $p->{'dynamic'}) {
				my $e = $p->{'dynamic'};
				if ($e eq 'true') {
					$self->lprint("dynamic => 1,");
				}
			}
			$self->indentDown;
			$self->lprint("},");
		}
		$self->indentDown;
		$self->lprint("});");

		my $deliminators = ".():!+,-<=>%&*/;?[]^{|}~\\";
		my $wdelim = $xml->weakDeliminator;
		while ($wdelim ne '') {
			$wdelim =~ s/^(.)//;
			my $wd = $1;
			if (index($regchars, $wd) >= 0) { $wd = "\\$wd" };
			$deliminators =~ s/$wd//;
		}
		my $adelim = $xml->additionalDeliminator;
		$deliminators = $deliminators . $adelim;
		my @delimchars = split //, $deliminators;
		my $tmp = '';
		for (@delimchars) {
			my $dc = $_;
			if (index($regchars, $dc ) >= 0) { $dc = "\\$dc" };
			$tmp = "$tmp|$dc";
		}
		$tmp = '\\s|' . $tmp;
		$self->lprint("\$self->deliminators(" . $self->stringalize($tmp) . ");");
		$self->lprint("\$self->basecontext(" . $self->stringalize($xml->basecontext) . ");");
		$self->lprint("\$self->keywordscase(" . $xml->keywordscase . ");");
		$self->lprint("\$self->initialize;");
		$self->lprint("bless (\$self, \$class);");
		$self->lprint("return \$self;");
		$self->indentDown;
		$self->lprint("}");
		$self->lprint;
		$self->lprint("sub language {");
		$self->indentUp;
		$self->lprint("return " . $self->stringalize($lang) . ";");
		$self->indentDown;
		$self->lprint("}");
		$self->lprint;

		foreach my $ctxt (sort keys %contexts) {
			$self->curcontext($ctxt);
			$self->lprint("sub " . $self->pmMethodName($ctxt) . " {");
			$self->indentUp;
			$self->lprint("my (\$self, \$text) = \@_;");
			my $c = $contexts{$ctxt};
			my $it = $c->{'items'};
			$self->pmParseRules(@$it);
		#	$self->indentDown;
		#	$self->lprint("}\n\n");
			$self->lprint("return 0;");
			$self->indentDown;
			$self->lprint("};");
			$self->lprint;
		}

		$self->lprint;
		$self->lprint("1;");
		$self->lprint;
		$self->lprint("__END__");
		$self->lprint;
		$self->lprint("=head1 NAME");
		$self->lprint;
		$self->lprint("Syntax::Highlight::Engine::Kate::$name - a Plugin for $lang syntax highlighting");
		$self->lprint;
		$self->lprint("=head1 SYNOPSIS");
		$self->lprint;
		$self->lprint(" require Syntax::Highlight::Engine::Kate::$name;");
		$self->lprint(" my \$sh = new Syntax::Highlight::Engine::Kate::$name([");
			#todotodotodotodo
		$self->lprint(" ]);");
		$self->lprint;
		$self->lprint("=head1 DESCRIPTION");
		$self->lprint;
		$self->lprint("Syntax::Highlight::Engine::Kate::$name is a  plugin module that provides syntax highlighting");
		$self->lprint("for $lang to the Syntax::Haghlight::Engine::Kate highlighting engine.");
		$self->lprint;
		$self->lprint("This code is generated from the syntax definition files used");
		$self->lprint("by the Kate project.");
		$self->lprint("It works quite fine, but can use refinement and optimization.");
		$self->lprint;
		$self->lprint("It inherits Syntax::Higlight::Engine::Kate::Template. See also there.");
		$self->lprint;
		$self->lprint("=cut");
		$self->lprint;
		$self->lprint("=head1 AUTHOR");
		$self->lprint;
		$self->lprint("Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)");
		$self->lprint;
		$self->lprint("=cut");
		$self->lprint;
		$self->lprint("=head1 BUGS");
		$self->lprint;
		$self->lprint("Unknown. If you find any, please contact the author");
		$self->lprint;
		$self->lprint("=cut");
		$self->lprint;

		$self->verbose($vbck);
	}
}

sub pmMethodName {
	my ($self, $in) = @_;
	$in =~ s/\(/Bo/g;
	$in =~ s/\)/Bc/g;
	$in =~ s/\{/Co/g;
	$in =~ s/\}/Cc/g;
	$in =~ s/\[/So/g;
	$in =~ s/\]/Sc/g;
	$in =~ s/([^A-za-z0-9_])//g;
	return "parse$in";
}

sub pmParseRules {
	my $self = shift;
	for (@_) {
		my $rule = $_;
		foreach my $k (sort keys %$rule) {
			$self->lprint("# $k => '" . $rule->{$k} . "'");
		}
		my $test = $tests{$rule->{'type'}};
		if (&$test($self, $rule)) {
			my $call = $parses{$rule->{'type'}};
			&$call($self, $rule);
		} else {
			$self->lprint("#This rule is buggy, not sending it to output");
		}
	}
}

sub pmParseRuleFinish {
	my ($self, $rule) = @_;
	$self->indentUp;
	if (exists $rule->{'items'}) {
		my $i = $rule->{'items'};
		$self->pmParseRules(@$i); #recursive;
	} else {
		$self->lprint("return 1");
	}
	$self->indentDown;
	$self->lprint("}");

}

sub pmParseRuleConvertArgs {
	my $self = shift;
	my $rule = shift;
	my $r = "";
	my %default = (
		lookAhead => 0,
		insensitive => 0,
		minimal => 0,
		dynamic => 0,
		context => '#stay',
		firstNonSpace => 0,
	);
	while (@_) {
		my $n = shift;
		my $d;
		if (exists($rule->{$n})) {
			$d = $rule->{$n};
		} elsif (exists($default{$n})) {
			$d = $default{$n};
		} else {
			$d = undef;
		}
		if (defined($d)) {
			my @boole = qw(insensitive dynamic firstNonSpace lookAhead minimal);
			my @str = qw(String char char1 context attribute);
			if ($n eq 'String') {
				$d = $self->stringalize($d);
			} elsif (grep {$n eq $_} @boole) {
				$d = $self->booleanize($d);
			} elsif (grep {$n eq $_} @str) {
				$d = $self->stringalize($d);
			}
		} else {
			$d = "undef"
		}
		if ($r ne '') {
			$r	= $r . ', '
		}
		$r = $r . $d;
	}
	return $r
}

sub pmRuleAnyChar {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, qw/String insensitive/, @stdoptions);
	$self->lprint("if (\$self->testAnyChar(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleDetectChar {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, qw/char insensitive dynamic/, @stdoptions);
	$self->lprint("if (\$self->testDetectChar(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleDetect2Chars {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, qw/char char1 insensitive dynamic/, @stdoptions);
	$self->lprint("if (\$self->testDetect2Chars(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleDetectIdentifier {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testDetectIdentifier(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleDetectSpaces {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testDetectSpaces(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleFloat {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testFloat(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleHlCChar {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testHlCChar(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleHlCHex {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testHlCHex(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleHlCOct {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testHlCOct(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleHlCStringChar {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testHlCStringChar(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleIncludeRules {
	my ($self, $rule) = @_;
	my $context = $self->stringalize($rule->{'context'});
	my $ed;
	if ($context =~ s/^(')##/$1/) {
		$ed = "includePlugin";
	} else {
		$ed = "includeRules";
	}
	$self->lprint("if (\$self->$ed($context, \$text)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleInt {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testInt(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleKeyword {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, 'String', @stdoptions);
	$self->lprint("if (\$self->testKeyword(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleLineContinue {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, @stdoptions);
	$self->lprint("if (\$self->testLineContinue(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleRangeDetect {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, qw/char char1 insensitive/, @stdoptions);
	$self->lprint("if (\$self->testRangeDetect(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleRegExpr {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, qw/insensitive dynamic/, @stdoptions);
	my $string = $rule->{'String'};
	my $minimal = $rule->{'minimal'};
	unless (defined($minimal)) { $minimal = 0 }
	$minimal = $self->booleanize($minimal);
	my $reg = '';
	if ($minimal) {
		my $lastchar = '';
		while ($string ne '') {
			if ($string =~ s/^(\*|\+)//) {
				$reg = "$reg$1";
				if ($lastchar ne "\\") {
					$reg = "$reg?";
				}
				$lastchar = $1;
			} else {
				$string =~ s/^(.)//;
				$reg = "$reg$1";
				$lastchar = $1;
			}
		}
	} else {
		$reg = $string;
	}
	$reg = $self->stringalize($reg);
	$self->lprint("if (\$self->testRegExpr(\$text, $reg, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub pmRuleStringDetect {
	my ($self, $rule) = @_;
	my $optxt = $self->pmParseRuleConvertArgs($rule, qw/String insensitive dynamic/, @stdoptions);
	$self->lprint("if (\$self->testStringDetect(\$text, $optxt)) {");
	$self->pmParseRuleFinish($rule);
}

sub policy {
	my $self = shift;
	if (@_) { $self->{'policy'} = shift; };
	return $self->{'policy'};
}

sub register {
	my ($self, $new) = @_;
	my $reg = $self->{'registered'};
	my $k = new Syntax::Highlight::Engine::Kate::Convert::XMLData($new);
	if (defined($k)) {
		my $name = $k->language->{'name'};
		if (exists $reg->{$name}) {
			$self->log("language $name already registered, aborting");
		} else {
			$reg->{$name} = $k;
			my $cmd = $self->guiadd;
			&$cmd($name);
			return $name;
		}
	} else {
		$self->log("cannot load $new");
	}
	return undef
}

sub registered {
	my $self = shift;
	my $reg = $self->{'registered'};
	return sort {uc($a) cmp uc($b)} keys %$reg;
}


sub registryLoad {
	my $self = shift;
	unless (-e $regfile) { return };
	my $dump = new XML::Dumper;
	my $h = $dump->xml2pl($regfile);
	foreach my $k (sort keys %$h) {
		my $n = $self->register($k);
		my $x = $self->xmldata($n);
		my $m = $h->{$k};
		foreach my $l (keys %$m) {
			$x->metadata($l, $m->{$l});
		}
	}
}

sub registrySave {
	my $self = shift;
	my @keys = $self->registered;
	my %h = ();
	foreach my $k (@keys) {
		my $x = $self->xmldata($k);
		$h{$x->filename} = $x->metadataBackup;
	}
	my $dump = new XML::Dumper;
	$dump->pl2xml(\%h, $regfile);
}

sub reportAdd {
	my ($self, $status, $rule, $msg) = @_;
	if ($self->verbose) {
		my $st = 'OK ';
		unless ($status) { $st = 'ERROR ' };
		$self->lprint($st . $msg);
	}
	my $lang = $self->curlang;
	my $context = $self->curcontext;
	my $log = $self->reportdata;
	push @$log, [$status, $lang, $context, $rule, $msg];
}

sub reportClear {
	my $self = shift;
	$self->reportdata([]);
}

sub reportdata {
	my $self = shift;
	if (@_) { $self->{'reportdata'} = shift; };
	return $self->{'reportdata'};
}

sub reportGenerate {
	my ($self, $status) = @_;
	unless (defined($status)) { $status = -1 };
	my @pos = ('Fail', 'Pass');
	my @items = ();
	my $l = $self->reportdata;
	if ($status ne -1) {
		foreach my $t (@$l) {
			if ($t->[0] eq $status) {
				push @items, $t;
			}
		}
	} else {
		@items = @$l
	}
	foreach my $i (@items) {
		my $txt = $pos[$i->[0]] . " ";
		$txt = $txt . $self->textLength($i->[1], 16);
		$txt = $txt . $self->textLength($i->[2], 30);
		$txt = $txt . $self->textLength($i->[3], 14);
		$self->lprint($txt . " : " . $i->[4]);
	}
}


#sub runtestLoad {
#	(my $self, $code) = @_;
#	my $sp = new Safe('MySafe');
#	$sp->reval($code);
#	if ($@) { $self->log(%@) }
#	my $name = $self->moduleName($self->xmldata($curentry)->language->{'name'});
#	my $mod = "MySafe::Syntax::Highlight::Engine::Kate::$name";
#	$sp->share('&' . $mod . '::highlight');
#	$sp->share('&' . $mod . '::reset');
#	my $p;
#	eval ('$p = new ' . $mod);
#	if ($@) { $self->log(%@) }
#	if (defined($p)) {
#		$self->runtest($p)
#	} else {
#		$self->runtest('');
#	}
#}
#
sub runtest {
	my $self = shift;
	if (@_) { $self->{'runtest'} = shift; };
	return $self->{'runtest'};
}

sub stringalize {
	my ($self, $in) = @_;
	$in =~ s/\\/\\\\/g;
	$in =~ s/\'/\\'/g;
#	$in =~ s/\$/\\\$/g;
	$in = "'$in'";
	return $in;
}

sub testContextItems {
	my $self = shift;
	my @test = sort keys %testopts;
	while (@_) {
		my $item = shift;
		my $type = $item->{'type'};
		$self->lprint("testing rule $type");
		$self->indentUp;
		if (exists $tests{$type}) {
			my $c = $tests{$type};
			&$c($self, $item);
		} else {
			$self->reportType(0, $type, "rule type $type does NOT exist");
		}
		if (exists $item->{'items'}) {
			my $i = $item->{'items'};
			$self->lprint("testing sub rules");
			$self->indentUp;
			$self->testContextItems(@$i); #recursive
			$self->indentDown;
		}
		$self->indentDown;
	}
}

sub testRuleOptions {
	my ($self, $item) = @_;
	my @test = sort keys %testopts;
	my $type = $item->{'type'};
	my $result = 1;
	#test the options to the rule
	foreach my $t (@test) {
		my $o = $item->{$t};
		if (defined($o)) {
			my $c = $testopts{$t};
			if (&$c($o)) {
				$self->reportAdd(1, $type, "option '$t' with value '$o' is valid");
			} else {
				$self->reportAdd(0, $type, "option '$t', value '$o' is NOT valid");
				$result = 0;
			}
		}
	}
	#test if attribute points to something defined
	if (exists($item->{'attribute'})) {
		my $att = $item->{'attribute'};
		if (exists $self->xmldata($self->curlang)->itemdata->{$att}) {
			$self->reportAdd(1, $type, "attribute '$att' is defined in itemdata");
		} else {
			$self->reportAdd(0, $type, "attribute '$att' is NOT defined in itemdata");
			$result = 0;
		}
	}
	#test if context points to something defined
	if (exists($item->{'context'})) {
		my $ctx = $item->{'context'};
		if ($ctx eq '#stay') {
			$self->reportAdd(1, $type, "context '$ctx' recognized");
		} elsif ($ctx =~ /^##(.+)/) {
			my $x = $self->xmldata($1);
			if (defined($1)) {
				$self->reportAdd(1, $type, "context '$ctx' refers to language '$1'");
			} else {
				$self->reportAdd(0, $type, "context '$ctx' refers to undefined language '$1'");
				$result = 0;
			}
		} elsif ($ctx =~ /^[#pop]+$/) {
			$self->reportAdd(1, $type, "context '$ctx' recognized");
		} elsif (exists $self->xmldata($self->curlang)->contexts->{$ctx}) {
			$self->reportAdd(1, $type, "context '$ctx' is defined in contexts");
		} else {
			$self->reportAdd(0, $type, "context '$ctx' is NOT defined in contexts");
			$result = 0;
		}
	}
	return $result;
}

sub testRuleAnyChar {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleDetectChar {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleDetect2Chars {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleDetectIdentifier {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleDetectSpaces {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleFloat {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleHlCChar {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleHlCHex {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleHlCOct {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleHlCStringChar {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleIncludeRules {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleInt {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleKeyword {
	my ($self, $item) = @_;
	my $s = $item->{'String'};
	my $l = $self->xmldata($self->curlang)->lists->{$s};
	my $val = 0;
	if (defined($l) ) {
		$self->reportAdd(1, $item->{'type'}, "$s refers to an existing list");
		$val = 1;
	} else {
		$self->reportAdd(0, $item->{'type'}, "$s does not refer to an existing list");
	}
	return $val;
}

sub testRuleLineContinue {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleRangeDetect {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub testRuleRegExpr {
	my ($self, $item) = @_;
	my $s = $item->{'String'};
	my $res = "regex test '$s'";
	my $stub = "stubtext";
	eval "\$stub =~ /\$s/";
	my $val = 0;
	if ($@) {
		my $bck = $@;
		chomp $bck;
		$self->reportAdd(0, $item->{'type'}, "$res : $bck");
	} else {
		$self->reportAdd(1, $item->{'type'}, $res);
		$val = 1;
	}
#	$self->lprint($res);
	return $val;
}


sub testRuleStringDetect {
	my ($self, $item) = @_;
	my $result = 1;
	unless ($self->testRuleOptions($item)) { $result = 0 };
	return $result;
}

sub textLength {
	my ($cw, $txt, $length) = @_;
	while (length($txt) < $length) { $txt = $txt . " " }
	return $txt;
}


sub verbose {
	my $self = shift;
	if (@_) { $self->{'verbose'} = shift; };
	return $self->{'verbose'};
}

sub version {
	my $self = shift;
	if (@_) { $self->{'version'} = shift; };
	return $self->{'version'};
}

sub xmldata {
	my ($self, $lang) = @_;
	if (defined($lang)) {
		my $r = $self->{'registered'};
		unless (exists $r->{$lang}) { return undef }
		return $r->{$lang}
	} else {
		$self->log("language not specified, cannot return xmldata object");
		return undef;
	}
}


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Convert::ToolKit - helper routines,
especially for generating highlight definitions from Kate's originals.

=head1 SYNOPSIS

  use Syntax::Highlight::Engine::Kate::Convert::ToolKit;

  $hlfile = "/some/path/some-lang.xml";
  $toolkit = new Syntax::Highlight::Engine::Kate::Convert::ToolKit();
  # $toolkit->outcmd = sub { ... };  # optionally redefine bare output
  $outfile = $toolkit->register($hlfile);
  $toolkit->pmGenerate($outfile);

=head1 DESCRIPTION

ToolKit module carries helper routines, notably conversion from native
highlight definitions of Kate to the ones as used by
Syntax::Highlight::Engine::Kate.

For convenience, such conversion process is wrapped into provided
C<hl-kate-convert> script.
