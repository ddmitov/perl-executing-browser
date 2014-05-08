# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'sml.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.06
#kate version 2.1
#kate author Christoph Cullmann (cullmann@kde.org)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::SML;

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
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Notice' => 'String',
      'String' => 'String',
      'String Char' => 'Char',
   });
   $self->listAdd('keywords',
      'abstype',
      'and',
      'andalso',
      'as',
      'case',
      'datatype',
      'do',
      'else',
      'end',
      'eqtype',
      'exception',
      'false',
      'fn',
      'fun',
      'functor',
      'handle',
      'if',
      'in',
      'include',
      'infix',
      'infixr',
      'let',
      'local',
      'nonfix',
      'of',
      'op',
      'open',
      'orelse',
      'raise',
      'rec',
      'sharing',
      'sig',
      'signature',
      'struct',
      'structure',
      'then',
      'true',
      'type',
      'val',
      'where',
      'while',
      'with',
      'withtype',
   );
   $self->listAdd('types',
      'array',
      'bool',
      'char',
      'int',
      'list',
      'option',
      'order',
      'real',
      'ref',
      'string',
      'substring',
      'unit',
      'vector',
      'word',
   );
   $self->contextdata({
      'Multiline/Inline Comment' => {
         callback => \&parseMultilineInlineComment,
         attribute => 'Comment',
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
   return 'SML';
}

sub parseMultilineInlineComment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => ')'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', ')', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '('
   # char1 => '*'
   # context => 'Multiline/Inline Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'Multiline/Inline Comment', 'Comment')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # items => 'ARRAY(0x18342d0)'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      # String => 'fF'
      # attribute => 'Float'
      # context => '#stay'
      # type => 'AnyChar'
      if ($self->testAnyChar($text, 'fF', 0, 0, undef, 0, '#stay', 'Float')) {
         return 1
      }
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
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

Syntax::Highlight::Engine::Kate::SML - a Plugin for SML syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::SML;
 my $sh = new Syntax::Highlight::Engine::Kate::SML([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::SML is a  plugin module that provides syntax highlighting
for SML to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author