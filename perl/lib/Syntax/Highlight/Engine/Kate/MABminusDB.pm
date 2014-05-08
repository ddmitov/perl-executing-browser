# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'mab.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.4
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::MABminusDB;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Comment' => 'Comment',
      'Database Header' => 'Operator',
      'Header Medium' => 'Reserved',
      'Header Piece' => 'Keyword',
      'Mab Comment Description' => 'Others',
      'Mab Comment Type' => 'Alert',
      'Mab I Field' => 'DecVal',
      'Mab M Field' => 'Float',
      'Normal Text' => 'Normal',
   });
   $self->contextdata({
      'Section' => {
         callback => \&parseSection,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Section');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'MAB-DB';
}

sub parseSection {
   my ($self, $text) = @_;
   # String => '\*I [a-zA-Z0-9]* '
   # attribute => 'Mab I Field'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*I [a-zA-Z0-9]* ', 0, 0, 0, 0, 0, '#stay', 'Mab I Field')) {
      return 1
   }
   # String => '\*\*\*\**E.*'
   # attribute => 'Header Piece'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*\\*\\*\\**E.*', 0, 0, 0, 0, 0, '#stay', 'Header Piece')) {
      return 1
   }
   # String => '\*\*\*\**M.*'
   # attribute => 'Header Medium'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*\\*\\*\\**M.*', 0, 0, 0, 0, 0, '#stay', 'Header Medium')) {
      return 1
   }
   # String => '\*\*\*\* BIBLIOTHECA.*'
   # attribute => 'Database Header'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*\\*\\*\\* BIBLIOTHECA.*', 0, 0, 0, 0, 0, '#stay', 'Database Header')) {
      return 1
   }
   # String => '\*M [a-zA-Z0-9]* '
   # attribute => 'Mab M Field'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*M [a-zA-Z0-9]* ', 0, 0, 0, 0, 0, '#stay', 'Mab M Field')) {
      return 1
   }
   # String => '\*X TYP .*'
   # attribute => 'Mab Comment Description'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*X TYP .*', 0, 0, 0, 0, 0, '#stay', 'Mab Comment Description')) {
      return 1
   }
   # String => '\*X DESC .*'
   # attribute => 'Mab Comment Type'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*X DESC .*', 0, 0, 0, 0, 0, '#stay', 'Mab Comment Type')) {
      return 1
   }
   # String => '\*X .*'
   # attribute => 'Comment'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*X .*', 0, 0, 0, 0, 0, '#stay', 'Comment')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::MABminusDB - a Plugin for MAB-DB syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::MABminusDB;
 my $sh = new Syntax::Highlight::Engine::Kate::MABminusDB([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::MABminusDB is a  plugin module that provides syntax highlighting
for MAB-DB to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author