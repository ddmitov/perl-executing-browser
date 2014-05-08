# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'component-pascal.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.05
#kate version 2.1
#kate author Werner Braun (wb@o3-software.de)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::ComponentminusPascal;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Attribute' => 'Others',
      'Builtin' => 'Normal',
      'Char' => 'Char',
      'CommentMaior' => 'Comment',
      'CommentMinor' => 'Comment',
      'Exit' => 'Keyword',
      'ExportFull' => 'Others',
      'ExportReadOnly' => 'Others',
      'Float' => 'Float',
      'Integer' => 'BaseN',
      'Keyword' => 'Keyword',
      'MemAlloc' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operator' => 'Normal',
      'Relation' => 'Normal',
      'SpecialValues' => 'DecVal',
      'String' => 'String',
      'Type' => 'DataType',
   });
   $self->listAdd('attributes',
      'ABSTRACT',
      'EMPTY',
      'EXTENSIBLE',
      'LIMITED',
   );
   $self->listAdd('builtins',
      'ABS',
      'ASH',
      'BITS',
      'CAP',
      'CHR',
      'DEC',
      'ENTIER',
      'EXCL',
      'INC',
      'INCL',
      'LEN',
      'LONG',
      'MAX',
      'MIN',
      'ODD',
      'ORD',
      'SHORT',
      'SIZE',
   );
   $self->listAdd('exits',
      'ASSERT',
      'EXIT',
      'HALT',
      'RETURN',
   );
   $self->listAdd('keywords',
      'BEGIN',
      'BY',
      'CASE',
      'CLOSE',
      'CONST',
      'DO',
      'ELSE',
      'ELSIF',
      'END',
      'FOR',
      'IF',
      'IMPORT',
      'LOOP',
      'MODULE',
      'NEW',
      'OF',
      'OUT',
      'PROCEDURE',
      'REPEAT',
      'THEN',
      'TO',
      'TYPE',
      'UNTIL',
      'VAR',
      'WHILE',
      'WITH',
   );
   $self->listAdd('specials',
      'FALSE',
      'INF',
      'NIL',
      'TRUE',
   );
   $self->listAdd('types',
      'ANYPTR',
      'ANYREC',
      'ARRAY',
      'BOOLEAN',
      'BYTE',
      'CHAR',
      'INTEGER',
      'LONGINT',
      'POINTER',
      'REAL',
      'RECORD',
      'SET',
      'SHORTCHAR',
      'SHORTINT',
      'SHORTREAL',
   );
   $self->contextdata({
      'Comment1' => {
         callback => \&parseComment1,
         attribute => 'CommentMaior',
      },
      'Comment2' => {
         callback => \&parseComment2,
         attribute => 'CommentMinor',
      },
      'CommentN' => {
         callback => \&parseCommentN,
         attribute => 'CommentMinor',
      },
      'CommentN2' => {
         callback => \&parseCommentN2,
         attribute => 'CommentMinor',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String1' => {
         callback => \&parseString1,
         attribute => 'String',
      },
      'String2' => {
         callback => \&parseString2,
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
   return 'Component-Pascal';
}

sub parseComment1 {
   my ($self, $text) = @_;
   # attribute => 'CommentMaior'
   # char => '*'
   # char1 => ')'
   # context => '#pop'
   # endRegion => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', ')', 0, 0, 0, undef, 0, '#pop', 'CommentMaior')) {
      return 1
   }
   # attribute => 'CommentMinor'
   # char => '('
   # char1 => '*'
   # context => 'CommentN'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'CommentN', 'CommentMinor')) {
      return 1
   }
   return 0;
};

sub parseComment2 {
   my ($self, $text) = @_;
   # attribute => 'CommentMinor'
   # char => '*'
   # char1 => ')'
   # context => '#pop'
   # endRegion => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', ')', 0, 0, 0, undef, 0, '#pop', 'CommentMinor')) {
      return 1
   }
   # attribute => 'CommentMinor'
   # char => '('
   # char1 => '*'
   # context => 'CommentN'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'CommentN', 'CommentMinor')) {
      return 1
   }
   return 0;
};

sub parseCommentN {
   my ($self, $text) = @_;
   # attribute => 'CommentMinor'
   # char => '*'
   # char1 => ')'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', ')', 0, 0, 0, undef, 0, '#pop', 'CommentMinor')) {
      return 1
   }
   # attribute => 'CommentMinor'
   # char => '('
   # char1 => '*'
   # context => 'CommentN2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'CommentN2', 'CommentMinor')) {
      return 1
   }
   return 0;
};

sub parseCommentN2 {
   my ($self, $text) = @_;
   # attribute => 'CommentMinor'
   # char => '*'
   # char1 => ')'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', ')', 0, 0, 0, undef, 0, '#pop', 'CommentMinor')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '(**'
   # attribute => 'CommentMaior'
   # beginRegion => 'Comment'
   # context => 'Comment1'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '(**', 0, 0, 0, undef, 0, 'Comment1', 'CommentMaior')) {
      return 1
   }
   # attribute => 'CommentMinor'
   # beginRegion => 'Comment'
   # char => '('
   # char1 => '*'
   # context => 'Comment2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'Comment2', 'CommentMinor')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String1', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'String2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String2', 'String')) {
      return 1
   }
   # String => 'PROCEDURE\s'
   # attribute => 'Keyword'
   # beginRegion => 'Proc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'PROCEDURE\\s', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'ABSTRACT;|EMPTY;|END\s*[A-Za-z][A-Za-z0-9_]*\;'
   # attribute => 'Normal Text'
   # context => '#stay'
   # endRegion => 'Proc'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'ABSTRACT;|EMPTY;|END\\s*[A-Za-z][A-Za-z0-9_]*\\;', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => 'RECORD'
   # attribute => 'Type'
   # beginRegion => 'Rec'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'RECORD', 0, 0, 0, undef, 0, '#stay', 'Type')) {
      return 1
   }
   # String => 'END'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'Rec'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'END', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'NEW'
   # attribute => 'MemAlloc'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'NEW', 0, 0, 0, undef, 0, '#stay', 'MemAlloc')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'exits'
   # attribute => 'Exit'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'exits', 0, undef, 0, '#stay', 'Exit')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Type')) {
      return 1
   }
   # String => 'attributes'
   # attribute => 'Attribute'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attributes', 0, undef, 0, '#stay', 'Attribute')) {
      return 1
   }
   # String => 'builtins'
   # attribute => 'Builtin'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'builtins', 0, undef, 0, '#stay', 'Builtin')) {
      return 1
   }
   # String => 'specials'
   # attribute => 'SpecialValues'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'specials', 0, undef, 0, '#stay', 'SpecialValues')) {
      return 1
   }
   # String => '\s[\+|\-]{0,1}[0-9]([0-9]*|[0-9A-F]*(H|L))'
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s[\\+|\\-]{0,1}[0-9]([0-9]*|[0-9A-F]*(H|L))', 0, 0, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '\s[0-9][0-9A-F]*X'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s[0-9][0-9A-F]*X', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '[A-Za-z][A-Za-z0-9_]*\*'
   # attribute => 'ExportFull'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z][A-Za-z0-9_]*\\*', 0, 0, 0, undef, 0, '#stay', 'ExportFull')) {
      return 1
   }
   # String => '[A-Za-z][A-Za-z0-9_]*\-'
   # attribute => 'ExportReadOnly'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z][A-Za-z0-9_]*\\-', 0, 0, 0, undef, 0, '#stay', 'ExportReadOnly')) {
      return 1
   }
   # String => '\s(=|#|<|<=|>|>=|IN\s|IS)'
   # attribute => 'Relation'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s(=|#|<|<=|>|>=|IN\\s|IS)', 0, 0, 0, undef, 0, '#stay', 'Relation')) {
      return 1
   }
   # String => '\s(\+|\-|OR|\*|/|DIV|MOD|\&)'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s(\\+|\\-|OR|\\*|/|DIV|MOD|\\&)', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   return 0;
};

sub parseString1 {
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

sub parseString2 {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::ComponentminusPascal - a Plugin for Component-Pascal syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::ComponentminusPascal;
 my $sh = new Syntax::Highlight::Engine::Kate::ComponentminusPascal([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::ComponentminusPascal is a  plugin module that provides syntax highlighting
for Component-Pascal to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author