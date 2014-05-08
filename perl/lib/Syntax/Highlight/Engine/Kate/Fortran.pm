# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'fortran.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.11
#kate version 2.4
#kate author Franchin Matteo (fnch@libero.it)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Fortran;

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
      'Elemental Procedure' => 'BString',
      'Float' => 'Float',
      'IO Function' => 'Function',
      'Inquiry Function' => 'Function',
      'Keyword' => 'Keyword',
      'Logical' => 'Reserved',
      'Non elemental subroutine' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operator' => 'Operator',
      'Preprocessor' => 'Others',
      'String' => 'String',
      'Symbol' => 'Normal',
      'Transformational Function' => 'Variable',
   });
   $self->listAdd('elemental_procs',
      'abs',
      'achar',
      'acos',
      'adjustl',
      'adjustr',
      'aimag',
      'aint',
      'alog',
      'alog10',
      'amax0',
      'amax1',
      'amin0',
      'amin1',
      'amod',
      'anint',
      'aprime',
      'asin',
      'atan',
      'atan2',
      'btest',
      'cabs',
      'ccos',
      'ceiling',
      'cexp',
      'char',
      'clog',
      'cmplx',
      'conjg',
      'cos',
      'cosh',
      'csin',
      'csqrt',
      'dabs',
      'dacos',
      'dasin',
      'datan',
      'datan2',
      'dble',
      'dcmplx',
      'dconjg',
      'dcos',
      'dcosh',
      'ddim',
      'ddmim',
      'dexp',
      'dfloat',
      'dim',
      'dimag',
      'dint',
      'dlog',
      'dlog10',
      'dmax1',
      'dmin1',
      'dmod',
      'dnint',
      'dprod',
      'dreal',
      'dsign',
      'dsin',
      'dsinh',
      'dsqrt',
      'dtan',
      'dtanh',
      'exp',
      'exponent',
      'float',
      'floor',
      'fraction',
      'iabs',
      'iachar',
      'iand',
      'ibclr',
      'ibits',
      'ibset',
      'ichar',
      'idim',
      'idint',
      'idnint',
      'ieor',
      'ifix',
      'index',
      'int',
      'ior',
      'ishft',
      'ishftc',
      'isign',
      'len_trim',
      'lge',
      'lgt',
      'lle',
      'llt',
      'log',
      'log10',
      'logical',
      'max',
      'max0',
      'max1',
      'merge',
      'min',
      'min0',
      'min1',
      'mod',
      'modulo',
      'mvbits',
      'nearest',
      'nint',
      'not',
      'rand',
      'real',
      'rrspacing',
      'scale',
      'scan',
      'set_exponent',
      'sign',
      'sin',
      'sinh',
      'sngl',
      'spacing',
      'sqrt',
      'tan',
      'tanh',
      'verify',
   );
   $self->listAdd('inquire_keywords',
      'access',
      'action',
      'blank',
      'delim',
      'direct',
      'err',
      'exist',
      'file',
      'form',
      'formatted',
      'iostat',
      'name',
      'named',
      'nextrec',
      'number',
      'opened',
      'pad',
      'position',
      'read',
      'readwrite',
      'recl',
      'sequential',
      'unformatted',
      'unit',
      'write',
   );
   $self->listAdd('inquiry_fn',
      'allocated',
      'associated',
      'bit_size',
      'digits',
      'epsilon',
      'huge',
      'kind',
      'lbound',
      'len',
      'maxexponent',
      'minexponent',
      'precision',
      'present',
      'radix',
      'range',
      'shape',
      'size',
      'tiny',
      'ubound',
   );
   $self->listAdd('io_functions',
      'access',
      'backspace',
      'close',
      'format',
      'inquire',
      'open',
      'print',
      'read',
      'rewind',
      'write',
   );
   $self->listAdd('io_keywords',
      'advance',
      'end',
      'eor',
      'err',
      'fmt',
      'iostat',
      'size',
      'status',
      'unit',
   );
   $self->listAdd('keywords',
      'allocate',
      'assignment',
      'break',
      'call',
      'case',
      'common',
      'contains',
      'continue',
      'cycle',
      'deallocate',
      'default',
      'do',
      'elemental',
      'else',
      'elseif',
      'elsewhere',
      'entry',
      'equivalence',
      'exit',
      'external',
      'for',
      'forall',
      'go',
      'goto',
      'if',
      'implicit',
      'include',
      'interface',
      'intrinsic',
      'namelist',
      'none',
      'nullify',
      'only',
      'operator',
      'pause',
      'procedure',
      'pure',
      'record',
      'recursive',
      'result',
      'return',
      'select',
      'selectcase',
      'stop',
      'then',
      'to',
      'use',
      'where',
      'while',
   );
   $self->listAdd('non_elem_subr',
      'date_and_time',
      'random_number',
      'random_seed',
      'system_clock',
   );
   $self->listAdd('open_keywords',
      'access',
      'action',
      'blank',
      'delim',
      'err',
      'file',
      'form',
      'iostat',
      'pad',
      'position',
      'recl',
      'status',
      'unit',
   );
   $self->listAdd('transform_fn',
      'all',
      'any',
      'count',
      'cshift',
      'dot_product',
      'eoshift',
      'matmul',
      'maxloc',
      'maxval',
      'minloc',
      'minval',
      'pack',
      'product',
      'repeat',
      'reshape',
      'selected_int_kind',
      'selected_real_kind',
      'spread',
      'sum',
      'transfer',
      'transpose',
      'trim',
      'unpack',
   );
   $self->listAdd('types',
      'allocatable',
      'double',
      'optional',
      'parameter',
      'pointer',
      'precision',
      'private',
      'public',
      'save',
      'sequence',
      'target',
   );
   $self->contextdata({
      'default' => {
         callback => \&parsedefault,
         attribute => 'Normal Text',
      },
      'end_of_string' => {
         callback => \&parseend_of_string,
         attribute => 'String',
         fallthrough => '#pop#pop',
      },
      'find_begin_stmnts' => {
         callback => \&parsefind_begin_stmnts,
         attribute => 'Normal Text',
      },
      'find_comments' => {
         callback => \&parsefind_comments,
         attribute => 'Normal Text',
      },
      'find_decls' => {
         callback => \&parsefind_decls,
         attribute => 'Normal Text',
      },
      'find_end_stmnts' => {
         callback => \&parsefind_end_stmnts,
         attribute => 'Normal Text',
      },
      'find_intrinsics' => {
         callback => \&parsefind_intrinsics,
         attribute => 'Normal Text',
      },
      'find_io_paren' => {
         callback => \&parsefind_io_paren,
         attribute => 'Normal Text',
      },
      'find_io_stmnts' => {
         callback => \&parsefind_io_stmnts,
         attribute => 'Normal Text',
      },
      'find_numbers' => {
         callback => \&parsefind_numbers,
         attribute => 'Normal Text',
      },
      'find_op_and_log' => {
         callback => \&parsefind_op_and_log,
         attribute => 'Normal Text',
      },
      'find_paren' => {
         callback => \&parsefind_paren,
         attribute => 'Data Type',
         lineending => '#pop',
      },
      'find_preprocessor' => {
         callback => \&parsefind_preprocessor,
         attribute => 'Normal Text',
      },
      'find_strings' => {
         callback => \&parsefind_strings,
         attribute => 'String',
      },
      'find_symbols' => {
         callback => \&parsefind_symbols,
         attribute => 'Normal Text',
      },
      'format_stmnt' => {
         callback => \&parseformat_stmnt,
         attribute => 'Normal Text',
      },
      'inside_func_paren' => {
         callback => \&parseinside_func_paren,
         attribute => 'Normal Text',
      },
      'string_1' => {
         callback => \&parsestring_1,
         attribute => 'String',
         fallthrough => '#pop',
      },
      'string_2' => {
         callback => \&parsestring_2,
         attribute => 'String',
         fallthrough => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('default');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Fortran';
}

sub parsedefault {
   my ($self, $text) = @_;
   # context => 'find_strings'
   # type => 'IncludeRules'
   if ($self->includeRules('find_strings', $text)) {
      return 1
   }
   # context => 'find_decls'
   # type => 'IncludeRules'
   if ($self->includeRules('find_decls', $text)) {
      return 1
   }
   # context => 'find_intrinsics'
   # type => 'IncludeRules'
   if ($self->includeRules('find_intrinsics', $text)) {
      return 1
   }
   # context => 'find_io_stmnts'
   # type => 'IncludeRules'
   if ($self->includeRules('find_io_stmnts', $text)) {
      return 1
   }
   # context => 'find_op_and_log'
   # type => 'IncludeRules'
   if ($self->includeRules('find_op_and_log', $text)) {
      return 1
   }
   # context => 'find_numbers'
   # type => 'IncludeRules'
   if ($self->includeRules('find_numbers', $text)) {
      return 1
   }
   # context => 'find_preprocessor'
   # type => 'IncludeRules'
   if ($self->includeRules('find_preprocessor', $text)) {
      return 1
   }
   # context => 'find_comments'
   # type => 'IncludeRules'
   if ($self->includeRules('find_comments', $text)) {
      return 1
   }
   # context => 'find_symbols'
   # type => 'IncludeRules'
   if ($self->includeRules('find_symbols', $text)) {
      return 1
   }
   # context => 'find_end_stmnts'
   # type => 'IncludeRules'
   if ($self->includeRules('find_end_stmnts', $text)) {
      return 1
   }
   # context => 'find_begin_stmnts'
   # type => 'IncludeRules'
   if ($self->includeRules('find_begin_stmnts', $text)) {
      return 1
   }
   return 0;
};

sub parseend_of_string {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '&\s*$'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&\\s*$', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '&'
   # context => '#pop'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 1, '#pop', 'Keyword')) {
      return 1
   }
   # String => '(!.*)?$'
   # attribute => 'Comment'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(!.*)?$', 0, 0, 0, undef, 1, '#stay', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsefind_begin_stmnts {
   my ($self, $text) = @_;
   # String => '\bmodule\s+procedure\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bmodule\\s+procedure\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(program|subroutine|function|module|block\s*data)\b'
   # attribute => 'Keyword'
   # beginRegion => 'Unit'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(program|subroutine|function|module|block\\s*data)\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parsefind_comments {
   my ($self, $text) = @_;
   # String => '[cC\*].*$'
   # attribute => 'Comment'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[cC\\*].*$', 0, 0, 0, 0, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '!.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '!.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsefind_decls {
   my ($self, $text) = @_;
   # String => '\binteger[\*]\d{1,2}'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\binteger[\\*]\\d{1,2}', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\breal[\*]\d{1,2}'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\breal[\\*]\\d{1,2}', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\bcomplex[\*]\d{1,2}'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bcomplex[\\*]\\d{1,2}', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\bend\s*type\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s*type\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '^\s*data\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*data\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '^\s*real\s*[(]'
   # attribute => 'Data Type'
   # context => 'find_paren'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*real\\s*[(]', 1, 0, 0, undef, 0, 'find_paren', 'Data Type')) {
      return 1
   }
   # String => '^\s*real(?![\w\*])'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*real(?![\\w\\*])', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\bcharacter[*][0-9]+\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bcharacter[*][0-9]+\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\b(type|integer|complex|character|logical|intent|dimension)\b\s*[(]'
   # attribute => 'Data Type'
   # context => 'find_paren'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(type|integer|complex|character|logical|intent|dimension)\\b\\s*[(]', 1, 0, 0, undef, 0, 'find_paren', 'Data Type')) {
      return 1
   }
   # String => '\b(type|integer|complex|character|logical|intent|dimension)\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(type|integer|complex|character|logical|intent|dimension)\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # attribute => 'Data Type'
   # char => ':'
   # char1 => ':'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, ':', ':', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parsefind_end_stmnts {
   my ($self, $text) = @_;
   # String => '\bend\s*(program|subroutine|function|module|block\s*data)\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'Unit'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s*(program|subroutine|function|module|block\\s*data)\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\s*(do|if|select|where|forall|interface)\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s*(do|if|select|where|forall|interface)\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'Unit'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parsefind_intrinsics {
   my ($self, $text) = @_;
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'elemental_procs'
   # attribute => 'Elemental Procedure'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'elemental_procs', 0, undef, 0, '#stay', 'Elemental Procedure')) {
      return 1
   }
   # String => 'inquiry_fn'
   # attribute => 'Inquiry Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'inquiry_fn', 0, undef, 0, '#stay', 'Inquiry Function')) {
      return 1
   }
   # String => 'transform_fn'
   # attribute => 'Transformational Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'transform_fn', 0, undef, 0, '#stay', 'Transformational Function')) {
      return 1
   }
   # String => 'non_elem_subr'
   # attribute => 'Non elemental subroutine'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'non_elem_subr', 0, undef, 0, '#stay', 'Non elemental subroutine')) {
      return 1
   }
   return 0;
};

sub parsefind_io_paren {
   my ($self, $text) = @_;
   # attribute => 'IO Function'
   # char => '*'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '*', 0, 0, 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '('
   # context => 'inside_func_paren'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'inside_func_paren', 'Normal Text')) {
      return 1
   }
   # attribute => 'IO Function'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'IO Function')) {
      return 1
   }
   # String => 'io_keywords'
   # attribute => 'IO Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'io_keywords', 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   # String => 'inquire_keywords'
   # attribute => 'IO Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'inquire_keywords', 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   # String => 'open_keywords'
   # attribute => 'IO Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'open_keywords', 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   # context => 'find_strings'
   # type => 'IncludeRules'
   if ($self->includeRules('find_strings', $text)) {
      return 1
   }
   # context => 'find_intrinsics'
   # type => 'IncludeRules'
   if ($self->includeRules('find_intrinsics', $text)) {
      return 1
   }
   # context => 'find_numbers'
   # type => 'IncludeRules'
   if ($self->includeRules('find_numbers', $text)) {
      return 1
   }
   # context => 'find_symbols'
   # type => 'IncludeRules'
   if ($self->includeRules('find_symbols', $text)) {
      return 1
   }
   return 0;
};

sub parsefind_io_stmnts {
   my ($self, $text) = @_;
   # String => '\b(read|write|backspace|rewind|end\s*file|close)\s*[(]'
   # attribute => 'IO Function'
   # context => 'find_io_paren'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(read|write|backspace|rewind|end\\s*file|close)\\s*[(]', 1, 0, 0, undef, 0, 'find_io_paren', 'IO Function')) {
      return 1
   }
   # String => '\bopen\s*[(]'
   # attribute => 'IO Function'
   # context => 'find_io_paren'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bopen\\s*[(]', 1, 0, 0, undef, 0, 'find_io_paren', 'IO Function')) {
      return 1
   }
   # String => '\binquire\s*[(]'
   # attribute => 'IO Function'
   # context => 'find_io_paren'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\binquire\\s*[(]', 1, 0, 0, undef, 0, 'find_io_paren', 'IO Function')) {
      return 1
   }
   # String => '\bformat\s*[(]'
   # attribute => 'IO Function'
   # context => 'format_stmnt'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bformat\\s*[(]', 1, 0, 0, undef, 0, 'format_stmnt', 'IO Function')) {
      return 1
   }
   # String => '\bend\s*file\b'
   # attribute => 'IO Function'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s*file\\b', 1, 0, 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   # String => 'io_functions'
   # attribute => 'IO Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'io_functions', 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   return 0;
};

sub parsefind_numbers {
   my ($self, $text) = @_;
   # String => '[0-9]*\.[0-9]+([de][+-]?[0-9]+)?([_]([0-9]+|[a-z][\w_]*))?'
   # attribute => 'Float'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9]*\\.[0-9]+([de][+-]?[0-9]+)?([_]([0-9]+|[a-z][\\w_]*))?', 1, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '\b[0-9]+\.[0-9]*([de][+-]?[0-9]+)?([_]([0-9]+|[a-z][\w_]*))?(?![a-z])'
   # attribute => 'Float'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[0-9]+\\.[0-9]*([de][+-]?[0-9]+)?([_]([0-9]+|[a-z][\\w_]*))?(?![a-z])', 1, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '\b[0-9]+[de][+-]?[0-9]+([_]([0-9]+|[a-z][\w_]*))?'
   # attribute => 'Float'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[0-9]+[de][+-]?[0-9]+([_]([0-9]+|[a-z][\\w_]*))?', 1, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '\b[0-9]+([_]([0-9]+|[a-zA-Z][\w_]*))?'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[0-9]+([_]([0-9]+|[a-zA-Z][\\w_]*))?', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => '\b[bozx](['][0-9a-f]+[']|["][0-9a-f]+["])'
   # attribute => 'Decimal'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[bozx]([\'][0-9a-f]+[\']|["][0-9a-f]+["])', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   return 0;
};

sub parsefind_op_and_log {
   my ($self, $text) = @_;
   # String => '\.(true|false)\.'
   # attribute => 'Logical'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.(true|false)\\.', 1, 0, 0, undef, 0, '#stay', 'Logical')) {
      return 1
   }
   # String => '\.[A-Za-z]+\.'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.[A-Za-z]+\\.', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '(==|/=|<|<=|>|>=)'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(==|/=|<|<=|>|>=)', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   return 0;
};

sub parsefind_paren {
   my ($self, $text) = @_;
   # attribute => 'Data Type'
   # char => '('
   # context => 'find_paren'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'find_paren', 'Data Type')) {
      return 1
   }
   # attribute => 'Data Type'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parsefind_preprocessor {
   my ($self, $text) = @_;
   # String => '(#|cDEC\$|CDEC\$).*$'
   # attribute => 'Preprocessor'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(#|cDEC\\$|CDEC\\$).*$', 0, 0, 0, 0, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parsefind_strings {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '''
   # context => 'string_1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'string_1', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'string_2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string_2', 'String')) {
      return 1
   }
   return 0;
};

sub parsefind_symbols {
   my ($self, $text) = @_;
   # attribute => 'Keyword'
   # char => '*'
   # char1 => '*'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '*', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '('
   # char1 => '/'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '/', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '/'
   # char1 => ')'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', ')', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '&+-*/=?[]^{|}~'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '&+-*/=?[]^{|}~', 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '(),'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '(),', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseformat_stmnt {
   my ($self, $text) = @_;
   # attribute => 'IO Function'
   # char => '('
   # context => 'format_stmnt'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'format_stmnt', 'IO Function')) {
      return 1
   }
   # attribute => 'IO Function'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'IO Function')) {
      return 1
   }
   # String => '[0-9]*/'
   # attribute => 'IO Function'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9]*/', 1, 0, 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   # String => ':'
   # attribute => 'IO Function'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':', 0, 0, undef, 0, '#stay', 'IO Function')) {
      return 1
   }
   # context => 'find_strings'
   # type => 'IncludeRules'
   if ($self->includeRules('find_strings', $text)) {
      return 1
   }
   # context => 'find_symbols'
   # type => 'IncludeRules'
   if ($self->includeRules('find_symbols', $text)) {
      return 1
   }
   return 0;
};

sub parseinside_func_paren {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '('
   # context => 'inside_func_paren'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'inside_func_paren', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # context => 'find_strings'
   # type => 'IncludeRules'
   if ($self->includeRules('find_strings', $text)) {
      return 1
   }
   # context => 'find_intrinsics'
   # type => 'IncludeRules'
   if ($self->includeRules('find_intrinsics', $text)) {
      return 1
   }
   # context => 'find_numbers'
   # type => 'IncludeRules'
   if ($self->includeRules('find_numbers', $text)) {
      return 1
   }
   return 0;
};

sub parsestring_1 {
   my ($self, $text) = @_;
   # String => '[^']*''
   # attribute => 'String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^\']*\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # String => '&\s*$'
   # attribute => 'Keyword'
   # context => 'end_of_string'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&\\s*$', 0, 0, 0, undef, 0, 'end_of_string', 'Keyword')) {
      return 1
   }
   # String => '.*(?=&\s*$)'
   # attribute => 'String'
   # context => 'end_of_string'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.*(?=&\\s*$)', 0, 0, 0, undef, 0, 'end_of_string', 'String')) {
      return 1
   }
   return 0;
};

sub parsestring_2 {
   my ($self, $text) = @_;
   # String => '[^"]*"'
   # attribute => 'String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^"]*"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # String => '&\s*$'
   # attribute => 'Keyword'
   # context => 'end_of_string'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&\\s*$', 0, 0, 0, undef, 0, 'end_of_string', 'Keyword')) {
      return 1
   }
   # String => '.*(?=&\s*$)'
   # attribute => 'String'
   # context => 'end_of_string'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.*(?=&\\s*$)', 0, 0, 0, undef, 0, 'end_of_string', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Fortran - a Plugin for Fortran syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Fortran;
 my $sh = new Syntax::Highlight::Engine::Kate::Fortran([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Fortran is a  plugin module that provides syntax highlighting
for Fortran to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author