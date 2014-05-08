# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'gettext.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.4
#kate author Dominik Haumann (dhdev@gmx.de)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::GNU_Gettext;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Automatic Comment' => 'Comment',
      'Char' => 'Char',
      'Flag' => 'Comment',
      'Index' => 'DecVal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Reference' => 'Comment',
      'String' => 'String',
      'Translator Comment' => 'Comment',
   });
   $self->contextdata({
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
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
   return 'GNU Gettext';
}

sub parseNormal {
   my ($self, $text) = @_;
   # String => '^(msgid_plural|msgid|msgstr|msgctxt)'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^(msgid_plural|msgid|msgstr|msgctxt)', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '#\..*$'
   # attribute => 'Automatic Comment'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\..*$', 0, 0, 0, undef, 1, '#stay', 'Automatic Comment')) {
      return 1
   }
   # String => '#:.*$'
   # attribute => 'Reference'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#:.*$', 0, 0, 0, undef, 1, '#stay', 'Reference')) {
      return 1
   }
   # String => '#,.*$'
   # attribute => 'Flag'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#,.*$', 0, 0, 0, undef, 1, '#stay', 'Flag')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Translator Comment'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 1, '#stay', 'Translator Comment')) {
      return 1
   }
   # String => '\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '\[\d+\]'
   # attribute => 'Index'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\[\\d+\\]', 0, 0, 0, undef, 0, '#stay', 'Index')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::GNU_Gettext - a Plugin for GNU Gettext syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::GNU_Gettext;
 my $sh = new Syntax::Highlight::Engine::Kate::GNU_Gettext([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::GNU_Gettext is a  plugin module that provides syntax highlighting
for GNU Gettext to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author