# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'changelog.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.4
#kate author Dominik Haumann (dhdev@gmx.de)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::ChangeLog;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Date' => 'DataType',
      'E-Mail' => 'Others',
      'Entry' => 'DecVal',
      'Name' => 'Keyword',
      'Normal Text' => 'Normal',
   });
   $self->contextdata({
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'entry' => {
         callback => \&parseentry,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'line' => {
         callback => \&parseline,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'ChangeLog';
}

sub parseNormal {
   my ($self, $text) = @_;
   # attribute => 'Entry'
   # char => '*'
   # context => 'entry'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '*', 0, 0, 0, undef, 1, 'entry', 'Entry')) {
      return 1
   }
   # String => '\d\d\d\d\s*-\s*\d\d\s*-\s*\d\d\s*'
   # attribute => 'Date'
   # column => '0'
   # context => 'line'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\d\\d\\d\\d\\s*-\\s*\\d\\d\\s*-\\s*\\d\\d\\s*', 0, 0, 0, 0, 0, 'line', 'Date')) {
      return 1
   }
   return 0;
};

sub parseentry {
   my ($self, $text) = @_;
   # String => '.*:'
   # attribute => 'Entry'
   # context => '#pop'
   # minimal => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.*?:', 0, 0, 0, undef, 0, '#pop', 'Entry')) {
      return 1
   }
   return 0;
};

sub parseline {
   my ($self, $text) = @_;
   # String => '(\w\s*)+'
   # attribute => 'Name'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\w\\s*)+', 0, 0, 0, undef, 0, '#stay', 'Name')) {
      return 1
   }
   # String => '<.*>\s*$'
   # attribute => 'E-Mail'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<.*>\\s*$', 0, 0, 0, undef, 0, '#pop', 'E-Mail')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::ChangeLog - a Plugin for ChangeLog syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::ChangeLog;
 my $sh = new Syntax::Highlight::Engine::Kate::ChangeLog([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::ChangeLog is a  plugin module that provides syntax highlighting
for ChangeLog to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author