# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'clipper.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.05
#kate version 2.3
#kate author Andrey Cherepanov (sibskull@mail.ru)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Clipper;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Command' => 'DataType',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Eval Block' => 'Others',
      'Function' => 'Function',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Prep. Lib' => 'Others',
      'Preprocessor' => 'Others',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('commands',
      '?',
      '??',
      '@',
      'accept',
      'all',
      'alternate',
      'append',
      'ascending',
      'average',
      'bell',
      'blank',
      'box',
      'century',
      'clear',
      'close',
      'coclor',
      'color',
      'commit',
      'confirm',
      'console',
      'continue',
      'copy',
      'count',
      'create',
      'cursor',
      'date',
      'decimals',
      'default',
      'delete',
      'deleted',
      'delimiters',
      'descending',
      'device',
      'display',
      'do',
      'eject',
      'epoch',
      'erase',
      'escape',
      'eval',
      'every',
      'exact',
      'extended',
      'file',
      'filter',
      'fixed',
      'form',
      'from',
      'get',
      'gets',
      'go',
      'goto',
      'index',
      'input',
      'intensity',
      'join',
      'key',
      'keyboard',
      'label',
      'list',
      'locate',
      'margin',
      'memory',
      'menu',
      'message',
      'new',
      'on',
      'order',
      'pack',
      'path',
      'pict',
      'printer',
      'prompt',
      'quit',
      'range',
      'read',
      'recall',
      'record',
      'reindex',
      'relation',
      'release',
      'rename',
      'replace',
      'report',
      'rest',
      'restore',
      'run',
      'save',
      'say',
      'scoreboard',
      'seek',
      'select',
      'set',
      'skip',
      'softseek',
      'sort',
      'structure',
      'sum',
      'tag',
      'to',
      'total',
      'type',
      'typeahead',
      'unique',
      'unlock',
      'update',
      'use',
      'valid',
      'wait',
      'when',
      'with',
      'wrap',
      'zap',
   );
   $self->listAdd('functions',
      'aadd',
      'abs',
      'achoice',
      'aclone',
      'acopy',
      'adel',
      'aeval',
      'afill',
      'ains',
      'alert',
      'alias',
      'alltrim',
      'altd',
      'array',
      'ascan',
      'asize',
      'asort',
      'at',
      'atail',
      'bin2i',
      'bin2l',
      'bin2w',
      'bof',
      'break',
      'browse',
      'cdowchr',
      'chr',
      'cmonth',
      'col',
      'colorselect',
      'ctod',
      'curdir',
      'date',
      'day',
      'dbappend',
      'dbclearall',
      'dbclearfilter',
      'dbclearindex',
      'dbclearrelation',
      'dbcloseall',
      'dbclosearea',
      'dbcommit',
      'dbcommitall',
      'dbcreate',
      'dbcreateindex',
      'dbdelete',
      'dbedit',
      'dbeval',
      'dbf',
      'dbfilter',
      'dbgobottom',
      'dbgoto',
      'dbgotop',
      'dbrecall',
      'dbreindex',
      'dbrelation',
      'dbrlock',
      'dbrlocklist',
      'dbrselect',
      'dbrunlock',
      'dbseek',
      'dbselectarea',
      'dbsetfilter',
      'dbsetindex',
      'dbsetorder',
      'dbsetrelation',
      'dbskip',
      'dbstruct',
      'dbunlock',
      'dbunlockall',
      'dbusearea',
      'deleted',
      'descend',
      'devout',
      'devpos',
      'directory',
      'dispbegin',
      'dispbox',
      'dispcount',
      'dispend',
      'dispout',
      'dispspace',
      'doserror',
      'dow',
      'dtoc',
      'dtos',
      'empty',
      'eof',
      'errorblock',
      'errorinhandler',
      'errorlevel',
      'eval',
      'exp',
      'fclose',
      'fcount',
      'fcreate',
      'ferase',
      'ferror',
      'field',
      'fieldblock',
      'fieldget',
      'fieldname',
      'fieldpos',
      'fieldput',
      'fieldwblock',
      'file',
      'flock',
      'fopen',
      'found',
      'fread',
      'freadstr',
      'frename',
      'fseek',
      'fwrite',
      'getactive',
      'getenv',
      'hardcr',
      'header',
      'i2bin',
      'iif',
      'indexext',
      'indexkey',
      'indexord',
      'inkey',
      'int',
      'isalpha',
      'iscolor',
      'isdigit',
      'islower',
      'isprinter',
      'isupper',
      'l2bin',
      'lastkey',
      'lastrec',
      'left',
      'len',
      'lock',
      'log',
      'lower',
      'ltrim',
      'lupdate',
      'max',
      'maxcol',
      'maxrow',
      'memoedit',
      'memoline',
      'memoread',
      'memory',
      'memotran',
      'memowrit',
      'memvarblock',
      'min',
      'mlcount',
      'mlctopos',
      'mlpos',
      'mod',
      'month',
      'mpostolc',
      'neterr',
      'netname',
      'nextkey',
      'nosnow',
      'ordbagext',
      'ordbagname',
      'ordcreate',
      'orddestroy',
      'ordfor',
      'ordkey',
      'ordlistadd',
      'ordlistclear',
      'ordlistrebuild',
      'ordname',
      'ordnumber',
      'ordsetfocus',
      'os',
      'outerr',
      'outstd',
      'padc',
      'padl',
      'padr',
      'pcol',
      'pcount',
      'proclineprocname',
      'prow',
      'qout',
      'qqout',
      'rat',
      'rddlist',
      'rddname',
      'rddsetdefault',
      'readexit',
      'readinsert',
      'readmodal',
      'readvar',
      'reccount',
      'recno',
      'recsize',
      'replicate',
      'restscreen',
      'right',
      'rlock',
      'round',
      'row',
      'rtrim',
      'savesreen',
      'scroll',
      'seconds',
      'select',
      'setblink',
      'setcancel',
      'setcolor',
      'setcursor',
      'setkey',
      'setmode',
      'setpos',
      'setprc',
      'soundex',
      'space',
      'sqrt',
      'str',
      'strtran',
      'stuff',
      'substr',
      'time',
      'tone',
      'transform',
      'trim',
      'updated',
      'upper',
      'used',
      'val',
      'valtype',
      'version',
   );
   $self->listAdd('keywords',
      '.and.',
      '.f.',
      '.not.',
      '.or.',
      '.t.',
      'announce',
      'begin',
      'case',
      'command',
      'define',
      'do',
      'else',
      'elseif',
      'endcase',
      'enddo',
      'endif',
      'error',
      'exit',
      'field',
      'for',
      'function',
      'if',
      'ifdef',
      'include',
      'init',
      'inndef',
      'local',
      'memvar',
      'next',
      'nil',
      'other',
      'parameters',
      'private',
      'procedure',
      'public',
      'request',
      'return',
      'sequence',
      'static',
      'stdout',
      'traslate',
      'undef',
      'while',
      'xcommand',
      'xtranslate',
   );
   $self->contextdata({
      'BlockComment' => {
         callback => \&parseBlockComment,
         attribute => 'Comment',
      },
      'EvalBlock' => {
         callback => \&parseEvalBlock,
         attribute => 'Eval Block',
      },
      'LineComment' => {
         callback => \&parseLineComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
      },
      'String2' => {
         callback => \&parseString2,
         attribute => 'String',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|\\?|\\.');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Clipper';
}

sub parseBlockComment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'Comment2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # String => '(FIXME|TODO|NOT(IC)?E)'
   # attribute => 'Command'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(FIXME|TODO|NOT(IC)?E)', 0, 0, 0, undef, 0, '#stay', 'Command')) {
      return 1
   }
   return 0;
};

sub parseEvalBlock {
   my ($self, $text) = @_;
   # attribute => 'Eval Block'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Eval Block')) {
      return 1
   }
   # attribute => 'Eval Block'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Eval Block')) {
      return 1
   }
   return 0;
};

sub parseLineComment {
   my ($self, $text) = @_;
   # String => '(FIXME|TODO|NOT(IC)?E)'
   # attribute => 'Command'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(FIXME|TODO|NOT(IC)?E)', 0, 0, 0, undef, 0, '#stay', 'Command')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '\bfunction\b'
   # attribute => 'Keyword'
   # beginRegion => 'regFunction'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfunction\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '^return\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regFunction'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^return\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bbegin\s+sequence\b'
   # attribute => 'Keyword'
   # beginRegion => 'regSequence'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bbegin\\s+sequence\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\s+sequence\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regSequence'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s+sequence\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bdo\s+case\b'
   # attribute => 'Keyword'
   # beginRegion => 'regDoCase'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdo\\s+case\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bendcase\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regDoCase'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bendcase\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bdo\s+while\b'
   # attribute => 'Keyword'
   # beginRegion => 'regDoWhile'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdo\\s+while\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\benddo\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regDoWhile'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\benddo\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bfor\b'
   # attribute => 'Keyword'
   # beginRegion => 'regFor'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfor\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bnext\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regFor'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bnext\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bif\b'
   # attribute => 'Keyword'
   # beginRegion => 'regIf'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bif\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\belseif\b'
   # attribute => 'Keyword'
   # beginRegion => 'regIf'
   # context => '#stay'
   # endRegion => 'regIf'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\belseif\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\belse\b'
   # attribute => 'Keyword'
   # beginRegion => 'regIf'
   # context => '#stay'
   # endRegion => 'regIf'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\belse\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bendif\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regIf'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bendif\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bswitch\b'
   # attribute => 'Keyword'
   # beginRegion => 'regSwitch'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bswitch\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bendswitch\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regSwitch'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bendswitch\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'commands'
   # attribute => 'Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'commands', 0, undef, 0, '#stay', 'Command')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '//\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'regMarker'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*BEGIN.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '//\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'regMarker'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*END.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'LineComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'LineComment', 'Comment')) {
      return 1
   }
   # String => '^\s*\*.*$'
   # attribute => 'Comment'
   # context => 'LineComment'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*\\*.*$', 0, 0, 0, undef, 0, 'LineComment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment2'
   # char => '/'
   # char1 => '*'
   # context => 'BlockComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'BlockComment', 'Comment')) {
      return 1
   }
   # String => '!%&()+,-<:=>[]^~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!%&()+,-<:=>[]^~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '#'
   # attribute => 'Preprocessor'
   # context => 'Preprocessor'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#', 0, 0, 0, undef, 0, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   # attribute => 'Eval Block'
   # char => '{'
   # char1 => '|'
   # context => 'EvalBlock'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '{', '|', 0, 0, 0, undef, 0, 'EvalBlock', 'Eval Block')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'String2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String2', 'String')) {
      return 1
   }
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # attribute => 'Prep. Lib'
   # char => '"'
   # char1 => '"'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, '#stay', 'Prep. Lib')) {
      return 1
   }
   # attribute => 'Prep. Lib'
   # char => '<'
   # char1 => '>'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '<', '>', 0, 0, undef, 0, '#stay', 'Prep. Lib')) {
      return 1
   }
   # String => '//\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'regMarker'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*BEGIN.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '//\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'regMarker'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*END.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'LineComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'LineComment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment2'
   # char => '/'
   # char1 => '*'
   # context => 'BlockComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'BlockComment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
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

sub parseString2 {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
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

Syntax::Highlight::Engine::Kate::Clipper - a Plugin for Clipper syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Clipper;
 my $sh = new Syntax::Highlight::Engine::Kate::Clipper([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Clipper is a  plugin module that provides syntax highlighting
for Clipper to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author