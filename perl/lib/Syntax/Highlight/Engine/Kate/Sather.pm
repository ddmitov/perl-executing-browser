# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'sather.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.1
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Sather;

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
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Features' => 'Others',
      'Float' => 'Float',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
   });
   $self->listAdd('features',
      'aget',
      'aset',
      'create',
      'div',
      'invariant',
      'is_eq',
      'is_geq',
      'is_gt',
      'is_leq',
      'is_lt',
      'is_neq',
      'main',
      'minus',
      'mod',
      'negate',
      'not',
      'plus',
      'pow',
      'times',
   );
   $self->listAdd('keywords',
      'ITER',
      'ROUT',
      'SAME',
      'abstract',
      'and',
      'any',
      'assert',
      'attr',
      'bind',
      'break!',
      'case',
      'class',
      'const',
      'else',
      'elsif',
      'end',
      'exception',
      'external',
      'false',
      'fork',
      'guard',
      'if',
      'immutable',
      'in',
      'include',
      'initial',
      'inout',
      'is',
      'lock',
      'loop',
      'new',
      'once',
      'or',
      'out',
      'par',
      'parloop',
      'partial',
      'post',
      'pre',
      'private',
      'protect',
      'quit',
      'raise',
      'readonly',
      'result',
      'return',
      'self',
      'shared',
      'spread',
      'stub',
      'then',
      'true',
      'type',
      'typecase',
      'until!',
      'value',
      'void',
      'when',
      'while!',
      'yield',
   );
   $self->listAdd('types',
      '$OB',
      '$REHASH',
      'AREF',
      'ARRAY',
      'AVAL',
      'BOOL',
      'CHAR',
      'EXT_OB',
      'FLT',
      'FLTD',
      'FLTDX',
      'FLTI',
      'FLTX',
      'INT',
      'INTI',
      'STR',
      'SYS',
   );
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
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
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|\\$|\\!');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Sather';
}

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
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
   # String => 'features'
   # attribute => 'Features'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'features', 0, undef, 0, '#stay', 'Features')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => ''.''
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'.\'', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
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

Syntax::Highlight::Engine::Kate::Sather - a Plugin for Sather syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Sather;
 my $sh = new Syntax::Highlight::Engine::Kate::Sather([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Sather is a  plugin module that provides syntax highlighting
for Sather to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author