# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'freebasic.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.14
#kate version 2.3
#kate author Chris Neugebauer (chrisjrn@gmail.com)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::FreeBASIC;

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
      'Constant' => 'BaseN',
      'Data Types' => 'DataType',
      'Functions' => 'Function',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Number' => 'DecVal',
      'Preprocessor' => 'Operator',
      'Region Marker ' => 'RegionMarker',
      'String' => 'String',
   });
   $self->listAdd('Assembly Operators',
      'AH',
      'AL',
      'AX',
      'BH',
      'BL',
      'BP',
      'BX',
      'CH',
      'CL',
      'CS',
      'CX',
      'DH',
      'DI',
      'DL',
      'DS',
      'DX',
      'EAX',
      'EBP',
      'EBX',
      'ECX',
      'EDI',
      'EDX',
      'ES',
      'ESI',
      'ESP',
      'FS',
      'GS',
      'SI',
      'SP',
      'SS',
   );
   $self->listAdd('Data Types',
      'Byte PTR',
      'Double',
      'Dword PTR',
      'Integer',
      'Long',
      'Qword PTR',
      'Single',
      'String',
      'Word PTR',
   );
   $self->listAdd('functions',
      'AAA',
      'AAD',
      'AAM',
      'AAS',
      'ABS',
      'ACOS',
      'ADC',
      'ADD',
      'ALLOCATE',
      'AND',
      'AND',
      'ARPL',
      'ASC',
      'ASIN',
      'ASM',
      'ATAN2',
      'ATN',
      'BEEP',
      'BIN$',
      'BLOAD',
      'BOUND',
      'BREAK',
      'BSAVE',
      'BSF',
      'BSR',
      'BSWAP',
      'BT',
      'BTC',
      'BTR',
      'BTS',
      'BYREF',
      'CALL',
      'CALLOCATE',
      'CALLS',
      'CBW',
      'CBYTE',
      'CDBL',
      'CDQ',
      'CHAIN',
      'CHDIR',
      'CHR$',
      'CINT',
      'CIRCLE',
      'CLC',
      'CLD',
      'CLEAR',
      'CLI',
      'CLNG',
      'CLOSE',
      'CLTS',
      'CMC',
      'CMP',
      'CMPS',
      'CMPSB',
      'CMPSD',
      'CMPSW',
      'CMPXCHG',
      'COLOR',
      'COMMAND$',
      'COMMON',
      'CONST',
      'CONTINUE',
      'COS',
      'CSHORT',
      'CSIGN',
      'CSNG',
      'CUNSG',
      'CURDIR$',
      'CVD',
      'CVI',
      'CVL',
      'CVS',
      'CWD',
      'CWDE',
      'DAA',
      'DAS',
      'DATA',
      'DATE$',
      'DEALLOCATE',
      'DEC',
      'DIM',
      'DIR$',
      'DIV',
      'DRAW',
      'END',
      'ENTER',
      'ENUM',
      'ENVIRON',
      'ENVIRON$',
      'EOF',
      'EQV',
      'ERASE',
      'EXEC',
      'EXEPATH',
      'EXP',
      'FIX',
      'FLIP',
      'FRE',
      'FREEFILE',
      'GET',
      'GETKEY',
      'GETMOUSE',
      'HEX$',
      'HLT',
      'IDIV',
      'IMP',
      'IMUL',
      'IN',
      'INC',
      'INKEY$',
      'INP',
      'INPUT',
      'INPUT$',
      'INS',
      'INSB',
      'INSD',
      'INSTR',
      'INT',
      'INT',
      'INTO',
      'INVD',
      'INVLPG',
      'IRET',
      'IRETD',
      'JA',
      'JAE',
      'JB',
      'JBE',
      'JC',
      'JCXZ',
      'JE',
      'JECXZ',
      'JG',
      'JGE',
      'JL',
      'JLE',
      'JMP',
      'JNA',
      'JNAE',
      'JNB',
      'JNBE',
      'JNC',
      'JNE',
      'JNG',
      'JNGE',
      'JNL',
      'JNLE',
      'JNO',
      'JNP',
      'JNS',
      'JNZ',
      'JO',
      'JP',
      'JPE',
      'JPO',
      'JS',
      'JUMP',
      'JZ',
      'KILL',
      'LAHF',
      'LAR',
      'LBOUND',
      'LCASE$',
      'LDS',
      'LEA',
      'LEAVE',
      'LEAVED',
      'LEAVEW',
      'LEFT$',
      'LEN',
      'LES',
      'LET',
      'LFS',
      'LGDT',
      'LGS',
      'LIB',
      'LIDT',
      'LINE',
      'LLDT',
      'LMSW',
      'LOC',
      'LOCK',
      'LOCK',
      'LODS',
      'LODSB',
      'LODSD',
      'LODSW',
      'LOF',
      'LOG',
      'LOOPD',
      'LOOPDE',
      'LOOPDNE',
      'LOOPDNZ',
      'LOOPDZ',
      'LOOPE',
      'LOOPNE',
      'LOOPNZ',
      'LOOPW',
      'LOOPWE',
      'LOOPWNE',
      'LOOPWNZ',
      'LOOPWZ',
      'LOOPZ',
      'LSET',
      'LSL',
      'LSS',
      'LTR',
      'LTRIM$',
      'MID$',
      'MKD$',
      'MKDIR',
      'MKI$',
      'MKL$',
      'MKS$',
      'MOD',
      'MOV',
      'MOVS',
      'MOVSB',
      'MOVSD',
      'MOVSW',
      'MOVSX',
      'MOVZX',
      'MUL',
      'MULTIKEY',
      'NAME',
      'NEG',
      'NOP',
      'NOT',
      'NOTHING',
      'OCT$',
      'OPTION BASE',
      'OPTION PRIVATE',
      'OR',
      'OUT',
      'OUTS',
      'OUTSB',
      'OUTSD',
      'OUTSW',
      'PAINT',
      'PALETTE',
      'PCOPY',
      'PEEK',
      'PEEKI',
      'PEEKS',
      'PMAP',
      'POINT',
      'POKE',
      'POKEI',
      'POKES',
      'POP',
      'POPA',
      'POPAD',
      'POPF',
      'POPFD',
      'POS',
      'PRESERVE',
      'PRESET',
      'PRINT',
      'PRIVATE',
      'PROCPTR',
      'PSET',
      'PTR',
      'PUBLIC',
      'PUSH',
      'PUSHA',
      'PUSHAD',
      'PUSHF',
      'PUSHFD',
      'PUT',
      'RANDOMIZE',
      'RCL',
      'RCR',
      'REALLOCATE',
      'REDIM',
      'REM',
      'REP',
      'REPE',
      'REPNE',
      'REPNZ',
      'REPZ',
      'RESET',
      'RET',
      'RETURN',
      'RGB',
      'RIGHT$',
      'RMDIR',
      'RND',
      'ROL',
      'ROR',
      'RSET',
      'RTRIM$',
      'RUN',
      'SADD',
      'SAHF',
      'SAL',
      'SAR',
      'SBB',
      'SCAS',
      'SCASB',
      'SCASD',
      'SCASW',
      'SCREEN',
      'SCREENCOPY',
      'SCREENINFO',
      'SCREENLOCK',
      'SCREENPTR',
      'SCREENSET',
      'SCREENUNLOCK',
      'SEEK',
      'SETA',
      'SETAE',
      'SETB',
      'SETBE',
      'SETC',
      'SETDATE',
      'SETE',
      'SETENVIRON',
      'SETG',
      'SETGE',
      'SETL',
      'SETLE',
      'SETNA',
      'SETNAE',
      'SETNB',
      'SETNBE',
      'SETNC',
      'SETNE',
      'SETNG',
      'SETNGE',
      'SETNL',
      'SETNLE',
      'SETNO',
      'SETNP',
      'SETNS',
      'SETNZ',
      'SETO',
      'SETP',
      'SETPE',
      'SETPO',
      'SETS',
      'SETZ',
      'SGDT',
      'SGN',
      'SHARED',
      'SHELL',
      'SHL',
      'SHLD',
      'SHR',
      'SHRD',
      'SIDT',
      'SIN',
      'SLDT',
      'SLEEP',
      'SMSW',
      'SPACE$',
      'SQR',
      'STATIC',
      'STC',
      'STD',
      'STI',
      'STOP',
      'STOS',
      'STOSB',
      'STOSD',
      'STOSW',
      'STR',
      'STR$',
      'STRING$',
      'SWAP',
      'TAN',
      'TEST',
      'TIME$',
      'TIMER',
      'TRIM$',
      'TYPE',
      'UBOUND',
      'UCASE$',
      'UNION',
      'UNLOCK',
      'VAL',
      'VARPTR',
      'VERR',
      'VERW',
      'VIEW',
      'WAIT',
      'WINDOWTITLE',
      'WRITE',
      'XADD',
      'XCHG',
      'XLAT',
      'XLATB',
      'XOR',
   );
   $self->listAdd('keywords',
      'As',
      'Break',
      'Case',
      'Close',
      'DEFBYTE',
      'DEFDBL',
      'DEFINT',
      'DEFLNG',
      'DEFSHORT',
      'DEFSNG',
      'DEFSTR',
      'DEFUBYTE',
      'DEFUINT',
      'DEFUSHORT',
      'Data',
      'Declare',
      'Declare',
      'DefType',
      'Default',
      'Dim',
      'Do',
      'Else',
      'End',
      'EndSelect',
      'Exit',
      'For',
      'For Binary',
      'For Input',
      'For Output',
      'For Random',
      'Function',
      'Global',
      'Gosub',
      'Goto',
      'If',
      'Loop',
      'Next',
      'Open',
      'Protected',
      'Read',
      'Restore',
      'Return',
      'Select',
      'Shared',
      'Static',
      'Step',
      'Sub',
      'System',
      'Then',
      'To',
      'Type',
      'Unsigned',
      'Until',
      'Wend',
      'While',
   );
   $self->listAdd('preproc',
      '#DEFINE',
      '#ELSE',
      '#ELSEIF',
      '#ENDIF',
      '#IF',
      '#IFDEF',
      '#IFNDEF',
      '#UNDEF',
      '$DYNAMIC',
      '$INCLIB',
      '$INCLUDE',
      '$STATIC',
   );
   $self->contextdata({
      'Comment1' => {
         callback => \&parseComment1,
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
   return 'FreeBASIC';
}

sub parseComment1 {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '\b(exit (function|sub|for|do|while|type|select))([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(exit (function|sub|for|do|while|type|select))([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(declare (function|sub))([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(declare (function|sub))([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(while)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'WhileRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(while)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(wend)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'WhileRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(wend)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(do)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'DoRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(do)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(loop)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'DoRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(loop)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(select)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'SelectRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(select)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(end select)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'SelectRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(end select)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(for (input|output|binary|random))([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(for (input|output|binary|random))([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(for)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'ForRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(for)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(next)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'ForRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(next)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(function)([.\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'fProcedureRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(function)([.\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(end function)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'fProcedureRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(end function)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(sub)([.\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'sProcedureRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(sub)([.\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(end sub)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'sProcedureRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(end sub)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(type)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'StructureRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(type)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(end type)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'StructureRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(end type)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(if)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'IfRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(if)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(then )[a-zA-Z_\x7f-\xff].'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'IfRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(then )[a-zA-Z_\\x7f-\\xff].', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(end if)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'IfRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(end if)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'Data Types'
   # attribute => 'Data Types'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Data Types', 0, undef, 0, '#stay', 'Data Types')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Functions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Functions')) {
      return 1
   }
   # String => '\#+[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*'
   # attribute => 'Constant'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\#+[a-zA-Z_\\x7f-\\xff][a-zA-Z0-9_\\x7f-\\xff]*', 0, 0, 0, undef, 0, '#stay', 'Constant')) {
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
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '^\s*;+\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'marker'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*;+\\s*BEGIN.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '^\s*;+\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'marker'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*;+\\s*END.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '''
   # context => 'Comment1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Comment1', 'Comment')) {
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

Syntax::Highlight::Engine::Kate::FreeBASIC - a Plugin for FreeBASIC syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::FreeBASIC;
 my $sh = new Syntax::Highlight::Engine::Kate::FreeBASIC([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::FreeBASIC is a  plugin module that provides syntax highlighting
for FreeBASIC to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author