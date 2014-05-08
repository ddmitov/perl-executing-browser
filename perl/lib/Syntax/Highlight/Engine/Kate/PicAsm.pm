# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'picsrc.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.07
#kate version 2.3
#kate author Alain GIBAUD (alain.gibaud@univ-valenciennes.fr)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::PicAsm;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Alert' => 'Alert',
      'Based Numbers' => 'BaseN',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Directives' => 'Others',
      'Error' => 'Error',
      'GPASM-macros' => 'BString',
      'InstructionAttr' => 'Operator',
      'Instructions' => 'Keyword',
      'Normal Text' => 'Normal',
      'Prep. Lib' => 'Others',
      'Preprocessor' => 'Others',
      'String' => 'String',
      'Symbol' => 'Variable',
      'Unbased Numbers' => 'DecVal',
   });
   $self->listAdd('conditional',
      'else',
      'endif',
      'endw',
      'idef',
      'if',
      'ifndef',
      'include',
      'while',
      '{',
      '}',
   );
   $self->listAdd('directives',
      'CBLOCK',
      'CONSTANT',
      'DA',
      'DATA',
      'DB',
      'DE',
      'DT',
      'DW',
      'END',
      'ENDC',
      'ENDM',
      'EQU',
      'ERROR',
      'ERRORLEVEL',
      'EXITM',
      'FILL',
      'LIST',
      'LOCAL',
      'MACRO',
      'MESSG',
      'NOEXPAND',
      'NOLIST',
      'ORG',
      'PAGE',
      'PROCESSOR',
      'RADIX',
      'RES',
      'SET',
      'SPACE',
      'SUBTITLE',
      'TITLE',
      'VARIABLE',
      '__BADRAM',
      '__CONFIG',
      '__IDLOCS',
      '__MAXRAM',
      'cblock',
      'constant',
      'da',
      'data',
      'db',
      'de',
      'dt',
      'dw',
      'end',
      'endc',
      'endm',
      'equ',
      'error',
      'errorlevel',
      'exitm',
      'fill',
      'list',
      'local',
      'macro',
      'messg',
      'noexpand',
      'nolist',
      'org',
      'page',
      'processor',
      'radix',
      'res',
      'set',
      'space',
      'subtitle',
      'title',
      'variable',
   );
   $self->listAdd('gpasm_macro',
      'ADDCF',
      'B',
      'CLRC',
      'CLRZ',
      'MOVFW',
      'SETC',
      'SETZ',
      'SKPC',
      'SKPNC',
      'SKPNZ',
      'SKPZ',
      'SUBCF',
      'TSTF',
      'addcf',
      'b',
      'clrc',
      'clrz',
      'movfw',
      'setc',
      'setz',
      'skpc',
      'skpnc',
      'skpnz',
      'skpz',
      'subcf',
      'tstf',
   );
   $self->listAdd('instruction_attr',
      'A',
      'ACCESS',
      'BANKED',
      'F',
      'W',
   );
   $self->listAdd('instructions',
      'ADDLW',
      'ADDWF',
      'ADDWFC',
      'ANDLW',
      'ANDWF',
      'BC',
      'BCF',
      'BN',
      'BNC',
      'BNOV',
      'BNZ',
      'BOV',
      'BRA',
      'BSF',
      'BTFSC',
      'BTFSS',
      'BTG',
      'BZ',
      'CALL',
      'CLRF',
      'CLRW',
      'CLRWDT',
      'COMF',
      'CPFSEQ',
      'CPFSGT',
      'CPFSLT',
      'DAW',
      'DCFSNZ',
      'DECF',
      'DECFSZ',
      'GOTO',
      'INCF',
      'INCFSZ',
      'INFSNZ',
      'IORLW',
      'IORWF',
      'LFSR',
      'MOVF',
      'MOVFF',
      'MOVLB',
      'MOVLW',
      'MOVWF',
      'MULLW',
      'MULWF',
      'NEGF',
      'NOP',
      'OPTION',
      'POP',
      'PUSH',
      'RCALL',
      'RESET',
      'RETFIE',
      'RETLW',
      'RETURN',
      'RLCF',
      'RLF',
      'RLNCF',
      'RRCF',
      'RRF',
      'RRNCF',
      'SETF',
      'SLEEP',
      'SUBFWB',
      'SUBLW',
      'SUBWF',
      'SUBWFB',
      'SWAPF',
      'TBLRD',
      'TBLWT',
      'TSTFSZ',
      'XORLW',
      'XORWF',
      'addlw',
      'addwf',
      'addwfc',
      'andlw',
      'andwf',
      'bc',
      'bcf',
      'bn',
      'bnc',
      'bnov',
      'bnz',
      'bov',
      'bra',
      'bsf',
      'btfsc',
      'btfss',
      'btg',
      'bz',
      'call',
      'clrf',
      'clrw',
      'clrwdt',
      'comf',
      'cpfseq',
      'cpfsgt',
      'cpfslt',
      'daw',
      'dcfsnz',
      'decf',
      'decfsz',
      'goto',
      'incf',
      'incfsz',
      'infsnz',
      'iorlw',
      'iorwf',
      'lfsr',
      'movf',
      'movff',
      'movlb',
      'movlw',
      'movwf',
      'mullw',
      'mulwf',
      'negf',
      'nop',
      'option',
      'pop',
      'push',
      'rcall',
      'reset',
      'retfie',
      'retlw',
      'return',
      'rlcf',
      'rlf',
      'rlncf',
      'rrcf',
      'rrf',
      'rrncf',
      'setf',
      'sleep',
      'subfwb',
      'sublw',
      'subwf',
      'subwfb',
      'swapf',
      'tblrd',
      'tblwt',
      'tstfsz',
      'xorlw',
      'xorwf',
   );
   $self->contextdata({
      'ASCIIChar' => {
         callback => \&parseASCIIChar,
         attribute => 'Char',
         lineending => '#pop',
      },
      'QuotedNumError' => {
         callback => \&parseQuotedNumError,
         attribute => 'Error',
         lineending => '#pop#pop',
      },
      'binaryDigits' => {
         callback => \&parsebinaryDigits,
         attribute => 'Based Numbers',
         lineending => '#pop',
      },
      'comment' => {
         callback => \&parsecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'decimalDigits' => {
         callback => \&parsedecimalDigits,
         attribute => 'Based Numbers',
         lineending => '#pop',
      },
      'hexDigits' => {
         callback => \&parsehexDigits,
         attribute => 'Based Numbers',
         lineending => '#pop',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal Text',
      },
      'octDigits' => {
         callback => \&parseoctDigits,
         attribute => 'Based Numbers',
         lineending => '#pop',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
         lineending => '#pop',
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
   return 'PicAsm';
}

sub parseASCIIChar {
   my ($self, $text) = @_;
   # attribute => 'Char'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Char')) {
      return 1
   }
   # String => '.[^']'
   # attribute => 'Error'
   # context => 'QuotedNumError'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.[^\']', 0, 0, 0, undef, 0, 'QuotedNumError', 'Error')) {
      return 1
   }
   return 0;
};

sub parseQuotedNumError {
   my ($self, $text) = @_;
   # attribute => 'Error'
   # char => '''
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop', 'Error')) {
      return 1
   }
   return 0;
};

sub parsebinaryDigits {
   my ($self, $text) = @_;
   # attribute => 'Based Numbers'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Based Numbers')) {
      return 1
   }
   # String => '[^0-1]'
   # attribute => 'Error'
   # context => 'QuotedNumError'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^0-1]', 0, 0, 0, undef, 0, 'QuotedNumError', 'Error')) {
      return 1
   }
   return 0;
};

sub parsecomment {
   my ($self, $text) = @_;
   # String => '(INPUT|OUTPUT|PARAMETERS|AUTHOR|EMAIL)'
   # attribute => 'Instructions'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(INPUT|OUTPUT|PARAMETERS|AUTHOR|EMAIL)', 0, 0, 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # String => '(FIXME|TODO)'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(FIXME|TODO)', 0, 0, 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   return 0;
};

sub parsedecimalDigits {
   my ($self, $text) = @_;
   # attribute => 'Based Numbers'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Based Numbers')) {
      return 1
   }
   # String => '\D'
   # attribute => 'Error'
   # context => 'QuotedNumError'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\D', 0, 0, 0, undef, 0, 'QuotedNumError', 'Error')) {
      return 1
   }
   return 0;
};

sub parsehexDigits {
   my ($self, $text) = @_;
   # attribute => 'Based Numbers'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Based Numbers')) {
      return 1
   }
   # String => '[^0-9A-Fa-f]'
   # attribute => 'Error'
   # context => 'QuotedNumError'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^0-9A-Fa-f]', 0, 0, 0, undef, 0, 'QuotedNumError', 'Error')) {
      return 1
   }
   return 0;
};

sub parsenormal {
   my ($self, $text) = @_;
   # String => 'directives'
   # attribute => 'Directives'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'directives', 0, undef, 0, '#stay', 'Directives')) {
      return 1
   }
   # String => 'instructions'
   # attribute => 'Instructions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'instructions', 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # String => 'instruction_attr'
   # attribute => 'InstructionAttr'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'instruction_attr', 0, undef, 0, '#stay', 'InstructionAttr')) {
      return 1
   }
   # String => 'conditional'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'conditional', 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # String => 'gpasm_macro'
   # attribute => 'GPASM-macros'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'gpasm_macro', 0, undef, 0, '#stay', 'GPASM-macros')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Based Numbers')) {
      return 1
   }
   # String => '([ \t,][0-9A-F]+H[ \t,])'
   # attribute => 'Based Numbers'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([ \\t,][0-9A-F]+H[ \\t,])', 1, 0, 0, undef, 0, '#stay', 'Based Numbers')) {
      return 1
   }
   # String => '([ \t,][0-9A-F]+H)$'
   # attribute => 'Based Numbers'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([ \\t,][0-9A-F]+H)$', 1, 0, 0, undef, 0, '#stay', 'Based Numbers')) {
      return 1
   }
   # String => '([ \t,][0-9]+D)'
   # attribute => 'Based Numbers'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([ \\t,][0-9]+D)', 1, 0, 0, undef, 0, '#stay', 'Based Numbers')) {
      return 1
   }
   # String => '([ \t,][0-7]+O)'
   # attribute => 'Based Numbers'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([ \\t,][0-7]+O)', 1, 0, 0, undef, 0, '#stay', 'Based Numbers')) {
      return 1
   }
   # String => '([ \t,][0-1]+B)'
   # attribute => 'Based Numbers'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([ \\t,][0-1]+B)', 1, 0, 0, undef, 0, '#stay', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Unbased Numbers'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Unbased Numbers')) {
      return 1
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => 'A'
   # char1 => '''
   # context => 'ASCIIChar'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'A', '\'', 0, 0, 0, undef, 0, 'ASCIIChar', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => 'a'
   # char1 => '''
   # context => 'ASCIIChar'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'a', '\'', 0, 0, 0, undef, 0, 'ASCIIChar', 'Char')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'B'
   # char1 => '''
   # context => 'binaryDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'B', '\'', 0, 0, 0, undef, 0, 'binaryDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'b'
   # char1 => '''
   # context => 'binaryDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'b', '\'', 0, 0, 0, undef, 0, 'binaryDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'H'
   # char1 => '''
   # context => 'hexDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'H', '\'', 0, 0, 0, undef, 0, 'hexDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'h'
   # char1 => '''
   # context => 'hexDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'h', '\'', 0, 0, 0, undef, 0, 'hexDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'O'
   # char1 => '''
   # context => 'octDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'O', '\'', 0, 0, 0, undef, 0, 'octDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'o'
   # char1 => '''
   # context => 'octDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'o', '\'', 0, 0, 0, undef, 0, 'octDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'D'
   # char1 => '''
   # context => 'decimalDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'D', '\'', 0, 0, 0, undef, 0, 'decimalDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'Based Numbers'
   # char => 'd'
   # char1 => '''
   # context => 'decimalDigits'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'd', '\'', 0, 0, 0, undef, 0, 'decimalDigits', 'Based Numbers')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => ';'
   # context => 'comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # String => '-/*%+=><&|^!~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '-/*%+=><&|^!~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '#define'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#define', 0, 0, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # String => '#undefine'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#undefine', 0, 0, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # String => '#v'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#v', 0, 0, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parseoctDigits {
   my ($self, $text) = @_;
   # attribute => 'Based Numbers'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Based Numbers')) {
      return 1
   }
   # String => '[^0-7]'
   # attribute => 'Error'
   # context => 'QuotedNumError'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^0-7]', 0, 0, 0, undef, 0, 'QuotedNumError', 'Error')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'Char')) {
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

Syntax::Highlight::Engine::Kate::PicAsm - a Plugin for PicAsm syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::PicAsm;
 my $sh = new Syntax::Highlight::Engine::Kate::PicAsm([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::PicAsm is a  plugin module that provides syntax highlighting
for PicAsm to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author