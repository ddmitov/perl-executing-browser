# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'modula-2.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.1
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Modulaminus2;

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
      'Directive' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Number' => 'DecVal',
      'String' => 'String',
      'Type' => 'DataType',
   });
   $self->listAdd('directives',
      'ALLOCATE',
      'ASSEMBLER',
      'Accessible',
      'Append',
      'Assign',
      'CAPS',
      'Close',
      'Concat',
      'Copy',
      'DEALLOCATE',
      'Delete',
      'Done',
      'EOF',
      'EmptyString',
      'Erase',
      'GetArgs',
      'GetCard',
      'GetChar',
      'GetEnv',
      'GetInt',
      'GetLongReal',
      'GetReal',
      'GetString',
      'Insert',
      'Length',
      'Open',
      'OpenInput',
      'OpenOutput',
      'PutBf',
      'PutCard',
      'PutChar',
      'PutInt',
      'PutLn',
      'PutLongReal',
      'PutReal',
      'PutString',
      'Read',
      'ReadCard',
      'ReadInt',
      'ReadLongReal',
      'ReadReal',
      'ReadString',
      'ResetClock',
      'SIZE',
      'StrEq',
      'SystemTime',
      'UserTime',
      'Write',
      'WriteBf',
      'WriteCard',
      'WriteInt',
      'WriteLn',
      'WriteLongReal',
      'WriteReal',
      'WriteString',
      'compare',
      'pos',
   );
   $self->listAdd('keywords',
      'ABS',
      'AND',
      'ARRAY',
      'ASM',
      'BEGIN',
      'BITSET',
      'BY',
      'CAP',
      'CASE',
      'CHR',
      'CONST',
      'DEC',
      'DEFINITION',
      'DIV',
      'DO',
      'ELSE',
      'ELSIF',
      'END',
      'EXCL',
      'EXIT',
      'EXPORT',
      'FALSE',
      'FOR',
      'FOREIGN',
      'FROM',
      'HALT',
      'HIGH',
      'IF',
      'IMPLEMENTATION',
      'IMPORT',
      'IN',
      'INC',
      'INCL',
      'IOTRANSFER',
      'LOOP',
      'MAX',
      'MIN',
      'MOD',
      'MODULE',
      'NEWPROCESS',
      'NIL',
      'NOT',
      'ODD',
      'OF',
      'OR',
      'ORD',
      'PROC',
      'PROCEDURE',
      'QUALIFIED',
      'RECORD',
      'REPEAT',
      'RETURN',
      'SET',
      'THEN',
      'TO',
      'TRANSFER',
      'TRUE',
      'TRUNC',
      'TYPE',
      'UNTIL',
      'VAL',
      'VAR',
      'WHILE',
      'WITH',
   );
   $self->listAdd('types',
      'ADDRESS',
      'ADR',
      'BOOLEAN',
      'CARDINAL',
      'CHAR',
      'File',
      'INTEGER',
      'LONGINT',
      'LONGREAL',
      'POINTER',
      'REAL',
      'SHORTCARD',
      'SHORTINT',
   );
   $self->contextdata({
      'Comment2' => {
         callback => \&parseComment2,
         attribute => 'Comment',
      },
      'Comment3' => {
         callback => \&parseComment3,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Prep1' => {
         callback => \&parsePrep1,
         attribute => 'Directive',
      },
      'String1' => {
         callback => \&parseString1,
         attribute => 'String',
         lineending => '#pop',
      },
      'String2' => {
         callback => \&parseString2,
         attribute => 'String',
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
   return 'Modula-2';
}

sub parseComment2 {
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

sub parseComment3 {
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
   # String => 'directives'
   # attribute => 'Directive'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'directives', 0, undef, 0, '#stay', 'Directive')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Type')) {
      return 1
   }
   # attribute => 'Number'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # attribute => 'Number'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Number')) {
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
   # String => '(*$'
   # attribute => 'Directive'
   # context => 'Prep1'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '(*$', 0, 0, 0, undef, 0, 'Prep1', 'Directive')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '('
   # char1 => '*'
   # context => 'Comment2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'Comment2', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsePrep1 {
   my ($self, $text) = @_;
   # String => '$*)'
   # attribute => 'Directive'
   # context => 'Prep1'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '$*)', 0, 0, 0, undef, 0, 'Prep1', 'Directive')) {
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

Syntax::Highlight::Engine::Kate::Modulaminus2 - a Plugin for Modula-2 syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Modulaminus2;
 my $sh = new Syntax::Highlight::Engine::Kate::Modulaminus2([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Modulaminus2 is a  plugin module that provides syntax highlighting
for Modula-2 to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author