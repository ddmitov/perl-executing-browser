# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'vhdl.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.1
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::VHDL;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Attribute' => 'BaseN',
      'Bit' => 'Char',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Integer' => 'DecVal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operator' => 'Others',
      'Vector' => 'String',
   });
   $self->listAdd('keywords',
      'ACCESS',
      'AFTER',
      'ALIAS',
      'ALL',
      'AND',
      'ARCHITECTURE',
      'ASSERT',
      'BEGIN',
      'BLOCK',
      'BODY',
      'BUFFER',
      'BUS',
      'CASE',
      'COMPONENT',
      'CONFIGURATION',
      'CONSTANT',
      'DISCONNECT',
      'DOWNTO',
      'ELSE',
      'ELSIF',
      'END',
      'ENTITY',
      'ERROR',
      'EXIT',
      'FAILURE',
      'FILE',
      'FOR',
      'FUNCTION',
      'GENERATE',
      'GENERIC',
      'GROUP',
      'GUARDED',
      'IF',
      'IMPURE',
      'IN',
      'INERTIAL',
      'INOUT',
      'IS',
      'LABEL',
      'LIBRARY',
      'LINKAGE',
      'LITERAL',
      'LOOP',
      'MAP',
      'NEW',
      'NEXT',
      'NOT',
      'NOTE',
      'NULL',
      'OF',
      'ON',
      'OPEN',
      'OR',
      'OTHERS',
      'OUT',
      'PACKAGE',
      'PORT',
      'POSTPONED',
      'PROCEDURE',
      'PROCESS',
      'PURE',
      'RANGE',
      'RECORD',
      'REGISTER',
      'REJECT',
      'REPORT',
      'RETURN',
      'SELECT',
      'SEVERITY',
      'SHARED',
      'SIGNAL',
      'SUBTYPE',
      'THEN',
      'TO',
      'TRANSPORT',
      'TYPE',
      'UNAFFECTED',
      'UNITS',
      'UNTIL',
      'USE',
      'VARIABLE',
      'WAIT',
      'WARNING',
      'WHEN',
      'WHILE',
      'WITH',
      'XOR',
      'access',
      'after',
      'alias',
      'all',
      'and',
      'architecture',
      'assert',
      'begin',
      'block',
      'body',
      'buffer',
      'bus',
      'case',
      'component',
      'configuration',
      'constant',
      'disconnect',
      'downto',
      'else',
      'elsif',
      'end',
      'entity',
      'error',
      'exit',
      'failure',
      'file',
      'for',
      'function',
      'generate',
      'generic',
      'group',
      'guarded',
      'if',
      'impure',
      'in',
      'inertial',
      'inout',
      'is',
      'label',
      'library',
      'linkage',
      'literal',
      'loop',
      'map',
      'new',
      'next',
      'not',
      'note',
      'null',
      'of',
      'on',
      'open',
      'or',
      'others',
      'out',
      'package',
      'port',
      'postponed',
      'procedure',
      'process',
      'pure',
      'range',
      'record',
      'register',
      'reject',
      'report',
      'return',
      'select',
      'severity',
      'shared',
      'signal',
      'subtype',
      'then',
      'to',
      'transport',
      'type',
      'unaffected',
      'units',
      'until',
      'use',
      'variable',
      'wait',
      'warning',
      'when',
      'while',
      'with',
      'xor',
   );
   $self->listAdd('types',
      'BIT',
      'BIT_VECTOR',
      'BOOLEAN',
      'CHARACTER',
      'INTEGER',
      'LINE',
      'MUX_BIT',
      'MUX_VECTOR',
      'NATURAL',
      'POSITIVE',
      'QSIM_12STATE',
      'QSIM_12STATE_VECTOR',
      'QSIM_STATE',
      'QSIM_STATE_VECTOR',
      'QSIM_STRENGTH',
      'REAL',
      'REG_BIT',
      'REG_VECTOR',
      'SEVERITY_LEVEL',
      'SIGNED',
      'STD_LOGIC',
      'STD_LOGIC_VECTOR',
      'STD_ULOGIC',
      'STD_ULOGIC_VECTOR',
      'STRING',
      'TEXT',
      'TIME',
      'UNSIGNED',
      'WOR_BIT',
      'WOR_VECTOR',
      'bit',
      'bit_vector',
      'boolean',
      'character',
      'integer',
      'line',
      'mux_bit',
      'mux_vector',
      'natural',
      'positive',
      'qsim_12state',
      'qsim_12state_vector',
      'qsim_state',
      'qsim_state_vector',
      'qsim_strength',
      'real',
      'reg_bit',
      'reg_vector',
      'severity_level',
      'signed',
      'std_logic',
      'std_logic_vector',
      'std_ulogic',
      'std_ulogic_vector',
      'string',
      'text',
      'time',
      'unsigned',
      'wor_bit',
      'wor_vector',
   );
   $self->contextdata({
      'attribute' => {
         callback => \&parseattribute,
         attribute => 'Attribute',
         lineending => '#pop',
      },
      'comment' => {
         callback => \&parsecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal Text',
      },
      'quot in att' => {
         callback => \&parsequotinatt,
         attribute => 'Attribute',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'Vector',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'VHDL';
}

sub parseattribute {
   my ($self, $text) = @_;
   # attribute => 'Attribute'
   # char => '"'
   # context => 'quot in att'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'quot in att', 'Attribute')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ' '
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ' ', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # String => ')=<>'
   # attribute => 'Attribute'
   # context => '#pop'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ')=<>', 0, 0, undef, 0, '#pop', 'Attribute')) {
      return 1
   }
   return 0;
};

sub parsecomment {
   my ($self, $text) = @_;
   return 0;
};

sub parsenormal {
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
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'Bit'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Bit')) {
      return 1
   }
   # attribute => 'Vector'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'Vector')) {
      return 1
   }
   # String => '[&><=:+\-*\/|]().,;'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '[&><=:+\\-*\\/|]().,;', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Attribute'
   # char => '''
   # context => 'attribute'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'attribute', 'Attribute')) {
      return 1
   }
   return 0;
};

sub parsequotinatt {
   my ($self, $text) = @_;
   # attribute => 'Attribute'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Attribute')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # attribute => 'Vector'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Vector')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::VHDL - a Plugin for VHDL syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::VHDL;
 my $sh = new Syntax::Highlight::Engine::Kate::VHDL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::VHDL is a  plugin module that provides syntax highlighting
for VHDL to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author