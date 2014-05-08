# Copyright (c) 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

package Syntax::Highlight::Engine::Kate::Convert::XMLData;

use strict;
use warnings;
use XML::TokeParser;
use Data::Dumper;

our $VERSION = '0.07';

my $regchars = "\\^.\$|()[]{}*+?~!%^&/";

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;

	my $file = shift @_;
	unless (defined($file)) { $file = ''; }
	my $self = {
		basecontext => '',
		contexts => {},
		adddeliminators => '',
		weakdeliminators => '',
		filename => '',
		itemdata => {},
		keywordscase => 1,
		language => {},
		lists => {},
		metadata =>{},
	};
	bless ($self, $class);
	if (defined($file)) {
		$self->loadXML($file)
	}
	return $self;
}


sub basecontext {
	my $self = shift;
	if (@_) { $self->{'basecontext'} = shift }
	return $self->{'basecontext'}
}

sub contexts {
	my $self = shift;
	if (@_) { $self->{'contexts'} = shift }
	return $self->{'contexts'}
}

sub additionalDeliminator {
	my $self = shift;
	if (@_) { $self->{'adddeliminators'} = shift }
	return $self->{'adddeliminators'}
}

sub weakDeliminator {
	my $self = shift;
	if (@_) { $self->{'weakdeliminators'} = shift }
	return $self->{'weakdeliminators'}
}

sub filename {
	my $self = shift;
	if (@_) { $self->{'filename'} = shift }
	return $self->{'filename'}
}

sub getItems {
	my ($self, $parser) = @_;
	my @list = ();
	while (my $token = $parser->get_token) {
		if ($token->[0] eq 'S') {
			my $t = $token->[2];
			$t->{'type'} = $token->[1];
			my @items = $self->getItems($parser);
			if (@items) {
				$t->{'items'} = \@items
			}
			push @list, $t;
		} elsif ($token->[0] eq 'E') {
			return @list;
		}
	}
}

sub itemdata {
	my $self = shift;
	if (@_) { $self->{'itemdata'} = shift }
	return $self->{'itemdata'}
}

sub keywordscase {
	my $self = shift;
	if (@_) { $self->{'keywordscase'} = shift }
	return $self->{'keywordscase'}
}

sub loadXML {
	my ($self, $file) = @_;
	unless (open KATE, "<$file") { die "cannot open $file"; };
	print "loading $file\n";
	my $parser = new XML::TokeParser(\*KATE, Noempty => 1);
	my %curargs = ();
	my @curlist = ();
	my $curitem = '';
	my $mode = 'base';
	while (my $token = $parser->get_token) {
		if ($mode eq 'base') {
			if ($token->[0] eq 'S') {
				if ($token->[1] eq 'language') {
					my $args = $token->[2];
					$self->language($args);
				} elsif ($token->[1] eq 'list') {
					$curitem = $token->[2]->{'name'};
	#				print "current list '$curitem'\n";
					$mode = 'list';
				} elsif ($token->[1]  eq 'context') {
					my $ctx = delete $token->[2]->{'name'};
					unless (defined($ctx)) { $ctx ='noname' };
	#				print "current context '$ctx'\n";
					my $ar = $token->[2];
					my %args = %$ar;
					if ($self->basecontext eq '') {
						$self->basecontext($ctx);
					}
					my @items = $self->getItems($parser);
					if (@items) { $args{'items'} = \@items };
					$self->contexts->{$ctx} = \%args;
				} elsif ($token->[1] eq 'itemData') {
					my $style = $token->[2]->{'defStyleNum'};
					unless (defined($style)) { $style = '';};
					$style =~ s/^ds//;
					$self->itemdata->{$token->[2]->{'name'}} =  $style;
				} elsif ($token->[1] eq 'keywords') {
					my $case = delete $token->[2]->{'casesensitive'};
					if (defined($case)) {
						if (lc($case) eq 'true') {
							$self->keywordscase(1);
						} else {
							$self->keywordscase(0);
						}
					}
					my $wdelim = delete $token->[2]->{'weakDeliminator'};
					if (defined($wdelim)) {
						$self->weakDeliminator($wdelim)
					}
					my $adelim = delete $token->[2]->{'additionalDeliminator'};
					if (defined($wdelim)) {
						$self->additionalDeliminator($wdelim)
					}
				}
			}
		} elsif ($mode eq 'list') {
			if ($token->[0] eq 'T') {
				my $tx = $token->[1];
				$tx =~ s/^\s+//;
				$tx =~ s/\s+$//;
				push @curlist, $tx;
			} elsif ($token->[0] eq 'E') {
				if ($token->[1] eq 'list') {
					$self->lists->{$curitem} = [ @curlist ];
					$mode = 'base';
					@curlist = ();
					$curitem = '';
				}
			}
		}
	}
	close KATE;
	$self->filename($file);
}

sub language {
	my $self = shift;
	if (@_) { $self->{'language'} = shift }
	return $self->{'language'}
}

sub lists {
	my $self = shift;
	if (@_) { $self->{'lists'} = shift }
	return $self->{'lists'}
}

sub metadata {
	my $self = shift;
	my $key = shift;
	my $m = $self->{'metadata'};
	if (@_) {
		$m->{$key} = shift;
	}
	my $res = '';
	if (exists $m->{$key}) {
		$res = $m->{$key}
	}
	return $res;
}

sub metadataBackup {
	my $self = shift;
	my $m = $self->{'metadata'};
	my $dstr = Dumper($m);
	my $VAR1;
	eval $dstr;
	return $VAR1;
}

sub samplefile {
	my $self = shift;
	if (@_) { $self->{'samplefile'} = shift }
	return $self->{'samplefile'};
}


1;
