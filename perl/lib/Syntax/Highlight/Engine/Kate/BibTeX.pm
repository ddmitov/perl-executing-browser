# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'bibtex.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.13
#kate version 2.4
#kate author Jeroen Wijnhout (Jeroen.Wijnhout@kdemail.net)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::BibTeX;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Char' => 'Char',
      'Command' => 'Function',
      'Entry' => 'Keyword',
      'Field' => 'DataType',
      'Normal Text' => 'Normal',
      'Ref Key' => 'Others',
      'String' => 'String',
   });
   $self->listAdd('kw_command',
      '@comment',
      '@preamble',
      '@string',
   );
   $self->listAdd('kw_entry',
      '@article',
      '@book',
      '@booklet',
      '@collection',
      '@conference',
      '@inbook',
      '@incollection',
      '@inproceedings',
      '@manual',
      '@mastersthesis',
      '@misc',
      '@patent',
      '@phdthesis',
      '@proceedings',
      '@techreport',
      '@unpublished',
   );
   $self->contextdata({
      'Entry' => {
         callback => \&parseEntry,
         attribute => 'Ref Key',
      },
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
   return 'BibTeX';
}

sub parseEntry {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => ','
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ',', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'block'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '\\([a-zA-Z]+|.)'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\([a-zA-Z]+|.)', 0, 0, 0, undef, 0, '#stay', 'Char')) {
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

sub parseNormal {
   my ($self, $text) = @_;
   # String => '([a-zA-Z]+)\s*='
   # attribute => 'Field'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([a-zA-Z]+)\\s*=', 0, 0, 0, undef, 1, '#stay', 'Field')) {
      return 1
   }
   # String => 'kw_entry'
   # attribute => 'Entry'
   # context => 'Entry'
   # type => 'keyword'
   if ($self->testKeyword($text, 'kw_entry', 0, undef, 0, 'Entry', 'Entry')) {
      return 1
   }
   # String => 'kw_command'
   # attribute => 'Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'kw_command', 0, undef, 0, '#stay', 'Command')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'block'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '\\([a-zA-Z]+|.)'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\([a-zA-Z]+|.)', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # String => '\\([a-zA-Z]+|.)'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\([a-zA-Z]+|.)', 0, 0, 0, undef, 0, '#stay', 'Char')) {
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

Syntax::Highlight::Engine::Kate::BibTeX - a Plugin for BibTeX syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::BibTeX;
 my $sh = new Syntax::Highlight::Engine::Kate::BibTeX([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::BibTeX is a  plugin module that provides syntax highlighting
for BibTeX to the Syntax::Highlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author
