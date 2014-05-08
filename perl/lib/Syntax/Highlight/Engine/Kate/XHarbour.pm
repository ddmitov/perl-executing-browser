# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'xharbour.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.4
#kate author Giancarlo Niccolai (giancarlo@niccolai.ws)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::XHarbour;

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
      'Function' => 'Function',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Number' => 'DecVal',
      'Operator' => 'BaseN',
      'Preprocessor' => 'Others',
      'String' => 'String',
   });
   $self->listAdd('class_keywords',
      'classdata',
      'data',
      'from',
      'hidden',
      'init',
      'inline',
      'method',
   );
   $self->listAdd('context_beginners',
      'BEGIN',
      'FOR',
      'FUNCTION',
      'IF',
      'METHOD',
      'PROCEDURE',
      'SWITCH',
      'TRY',
      'WHILE',
   );
   $self->listAdd('context_terminators',
      'END',
      'ENDCASE',
      'ENDDO',
      'ENDIF',
      'NEXT',
   );
   $self->listAdd('functions',
      'ABS',
      'ALLTRIM',
      'ASC',
      'AT',
      'CDOW',
      'CHR',
      'CMONTH',
      'CTOD',
      'CURDIR',
      'CreateMutex',
      'DATE',
      'DAY',
      'DAYS',
      'DBAPPEND',
      'DBCLEARFILTER',
      'DBCLOSEALL',
      'DBCLOSEAREA',
      'DBCOMMIT',
      'DBCOMMITALL',
      'DBCREATE',
      'DBDELETE',
      'DBEVAL',
      'DBF',
      'DBFILTER',
      'DBGOBOTTOM',
      'DBGOTO',
      'DBGOTOP',
      'DBRECALL',
      'DBRLOCK',
      'DBRLOCKLIST',
      'DBRUNLOCK',
      'DBSEEK',
      'DBSELECTAREA',
      'DBSETDRIVER',
      'DBSETFILTER',
      'DBSKIP',
      'DBSTRUCT',
      'DBUNLOCK',
      'DBUNLOCKALL',
      'DBUSEAREA',
      'DIRCHANGE',
      'DIRREMOVE',
      'DISKSPACE',
      'DOW',
      'DTOC',
      'DTOS',
      'DestroyMutex',
      'EXP',
      'FCLOSE',
      'FCREATE',
      'FERASE',
      'FERROR',
      'FOPEN',
      'FREAD',
      'FREADSTR',
      'FSEEK',
      'FWRITE',
      'GETENV',
      'HARDCR',
      'HB_ANSITOOEM',
      'HB_DISKSPACE',
      'HB_FEOF',
      'HB_ISBYREF',
      'HB_LANGNAME',
      'HB_LANGSELECT',
      'HB_OEMTOANSI',
      'HB_SETKEYSAVE',
      'HB_SetKeyCheck',
      'HB_SetKeyGet',
      'HB_VALTOSTR',
      'HB_pvalue',
      'INDEXEXT',
      'INDEXKEY',
      'INDEXORD',
      'INT',
      'ISAFFIRM',
      'ISALPHA',
      'ISDIGIT',
      'ISDISK',
      'ISLOWER',
      'ISNEGATIVE',
      'ISUPPER',
      'InetAccept',
      'InetAddress',
      'InetCleanup',
      'InetClearTimeout',
      'InetConnect',
      'InetConnectIP',
      'InetCreate',
      'InetDGram',
      'InetDGramRecv',
      'InetDGramSend',
      'InetDestroy',
      'InetError',
      'InetErrorDesc',
      'InetGetHosts',
      'InetGetTimeout',
      'InetInit',
      'InetPort',
      'InetRecv',
      'InetRecvAll',
      'InetSend',
      'InetSendAll',
      'InetServer',
      'InetSetTimeout',
      'KillAllThreads',
      'LEFT',
      'LEN',
      'LOG',
      'LOWER',
      'LTRIM',
      'MAKEDIR',
      'MAX',
      'MEMOTRAN',
      'MIN',
      'MOD',
      'MONTH',
      'MutexLock',
      'MutexUnlock',
      'NATIONMSG',
      'Notify',
      'NotifyAll',
      'ORDBAGEXT',
      'ORDBAGNAME',
      'ORDCONDSET',
      'ORDCREATE',
      'ORDDESTROY',
      'ORDFOR',
      'ORDKEY',
      'ORDLISTADD',
      'ORDLISTCLEAR',
      'ORDLISTREBUILD',
      'ORDNAME',
      'ORDNUMBER',
      'ORDSETFOCUS',
      'PADC',
      'PADL',
      'PADR',
      'PROCFILE',
      'PROCLINE',
      'PROCNAME',
      'RAT',
      'RDDLIST',
      'RDDNAME',
      'RDDSETDEFAULT',
      'REPLICATE',
      'RIGHT',
      'ROUND',
      'RTRIM',
      'SET',
      'SETKEY',
      'SETMODE',
      'SETTYPEAHEAD',
      'SPACE',
      'SQRT',
      'STR',
      'STRTRAN',
      'STRZERO',
      'SUBSTR',
      'Subscribe',
      'SubscribeNow',
      'TAssociativeArray',
      'TRANSFORM',
      'TRIM',
      'TYPE',
      'ThreadJoin',
      'ThreadKill',
      'ThreadSleep',
      'ThreadStart',
      'ThreadStop',
      'UPPER',
      'VAL',
      'VALTYPE',
      'VERSION',
      'WaitForThreads',
      'YEAR',
      '__DBCONTINUE',
      '__DBZAP',
      '__FLEDIT',
      '__QUIT',
      '__RDDSETDEFAULT',
      '__SETCENTURY',
      '__SetFunction',
      '__WAIT',
      '__atprompt',
      '__dbCopyStruct',
      '__dbCopyXStruct',
      '__dbCreate',
      '__dbStructFilter',
      '__dbdelim',
      '__dbsdf',
      '__dir',
      '__input',
      '__menuto',
      '__nonoallert',
      '__run',
      '__typefile',
      '__xrestscreen',
      '__xsavescreen',
      'aadd',
      'achoice',
      'aclone',
      'adel',
      'adir',
      'aeval',
      'afill',
      'ains',
      'alert',
      'array',
      'ascan',
      'asize',
      'asort',
      'atail',
      'bin21',
      'bin2l',
      'bin2u',
      'bin2w',
      'break',
      'browse',
      'col',
      'dbSkipper',
      'dbedit',
      'descend',
      'devoutpict',
      'do',
      'elaptime',
      'empty',
      'errornew',
      'errorsys',
      'eval',
      'fieldblock',
      'fieldwblock',
      'file',
      'frename',
      'hb_chechsum',
      'hb_class',
      'hb_colorindex',
      'hb_crypt',
      'hb_decrypt',
      'hb_exec',
      'hb_execfromarray',
      'hb_hextonum',
      'hb_keyput',
      'hb_numtohex',
      'hb_osnewline',
      'hb_random',
      'hb_readini',
      'hb_regex',
      'hb_regexcomp',
      'hb_regexmatch',
      'hb_regexsplit',
      'hb_writeini',
      'i2bin',
      'inkey',
      'l2bin',
      'lastkey',
      'maxcol',
      'maxrow',
      'mcol',
      'mrow',
      'nextkey',
      'os',
      'outerr',
      'outstd',
      'pcount',
      'readkey',
      'readvar',
      'row',
      'seconds',
      'secs',
      'throw',
      'time',
      'tone',
      'u2bin',
      'valtoprg',
      'w2bin',
      'word',
   );
   $self->listAdd('keywords',
      '?',
      'alias',
      'all',
      'as',
      'box',
      'case',
      'catch',
      'class',
      'clear',
      'close',
      'color',
      'databases',
      'date',
      'do',
      'each',
      'else',
      'elseif',
      'exit',
      'extern',
      'external',
      'field',
      'get',
      'global',
      'has',
      'in',
      'index',
      'like',
      'local',
      'loop',
      'nil',
      'off',
      'on',
      'otherwise',
      'read',
      'return',
      'say',
      'say',
      'screen',
      'select',
      'self',
      'set',
      'static',
      'super',
      'switch',
      'to',
      'use',
   );
   $self->listAdd('pragma',
      '#define',
      '#else',
      '#endif',
      '#if',
      '#ifdef',
      '#ifndef',
      '#include',
   );
   $self->listAdd('set_commands',
      'ALTERNATE',
      'ALTFILE',
      'AUTOPEN',
      'AUTORDER',
      'AUTOSHARE',
      'BELL',
      'CANCEL',
      'COLOR',
      'CONFIRM',
      'CONSOLE',
      'CURSOR',
      'DATEFORMAT',
      'DEBUG',
      'DECIMALS',
      'DEFAULT',
      'DELETED',
      'DELIMCHARS',
      'DELIMITERS',
      'DEVICE',
      'DIRCASE',
      'DIRSEPARATOR',
      'EPOCH',
      'ESCAPE',
      'EVENTMASK',
      'EXACT',
      'EXCLUSIVE',
      'EXIT',
      'EXTRA',
      'EXTRAFILE',
      'FILECASE',
      'FIXED',
      'IDLEREPEAT',
      'INSERT',
      'INTENSITY',
      'INVALID',
      'LANGUAGE',
      'MARGIN',
      'MBLOCKSIZE',
      'MCENTER',
      'MESSAGE',
      'MFILEEXT',
      'OPTIMIZE',
      'PATH',
      'PRINTER',
      'PRINTFILE',
      'SCOREBOARD',
      'SCROLLBREAK',
      'SOFTSEEK',
      'STRICTREAD',
      'TRACE',
      'TRACEFILE',
      'TRACESTACK',
      'TYPEAHEAD',
      'UNIQUE',
      'VIDEOMODE',
      'WRAP',
   );
   $self->contextdata({
      'ClassContext' => {
         callback => \&parseClassContext,
         attribute => 'Normal Text',
      },
      'TopLevel' => {
         callback => \&parseTopLevel,
         attribute => 'Normal Text',
      },
      'comment' => {
         callback => \&parsecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'logic' => {
         callback => \&parselogic,
         attribute => 'Operator',
         lineending => '#pop',
      },
      'ml_comment' => {
         callback => \&parseml_comment,
         attribute => 'Comment',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
         lineending => '#pop',
      },
      'stringc' => {
         callback => \&parsestringc,
         attribute => 'String',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('TopLevel');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'xHarbour';
}

sub parseClassContext {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # beginRegion => 'comment_region'
   # char => '/'
   # char1 => '*'
   # context => 'ml_comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'ml_comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '*'
   # context => 'comment'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '*', 0, 0, 0, undef, 1, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # String => 'class_keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'class_keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'END(CLASS)? *$'
   # attribute => 'Keyword'
   # context => '#pop'
   # endRegion => 'ClassDeclRegion'
   # firstNonSpace => 'true'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'END(CLASS)? *$', 1, 0, 0, undef, 1, '#pop', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseTopLevel {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # beginRegion => 'comment_region'
   # char => '/'
   # char1 => '*'
   # context => 'ml_comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'ml_comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '*'
   # context => 'comment'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '*', 0, 0, 0, undef, 1, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'stringc'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'stringc', 'String')) {
      return 1
   }
   # String => '.and.'
   # attribute => 'Operator'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.and.', 1, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '.or.'
   # attribute => 'Operator'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.or.', 1, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '.not.'
   # attribute => 'Operator'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.not.', 1, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '.f.'
   # attribute => 'Operator'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.f.', 1, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '.t.'
   # attribute => 'Operator'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.t.', 1, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => ':=!'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':=!', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '@'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '@', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CLASS[\t ]+'
   # attribute => 'Keyword'
   # beginRegion => 'ClassDeclRegion'
   # context => 'ClassContext'
   # firstNonSpace => 'true'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'CLASS[\\t ]+', 1, 0, 0, undef, 1, 'ClassContext', 'Keyword')) {
      return 1
   }
   # String => 'DO[\t ]+CASE[\t ]*$'
   # attribute => 'Keyword'
   # beginRegion => 'IndentRegion'
   # context => '#stay'
   # firstNonSpace => 'true'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'DO[\\t ]+CASE[\\t ]*$', 1, 0, 0, undef, 1, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'context_beginners'
   # attribute => 'Keyword'
   # beginRegion => 'IndentRegion'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'context_beginners', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'context_terminators'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'IndentRegion'
   # type => 'keyword'
   if ($self->testKeyword($text, 'context_terminators', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'return ?'
   # attribute => 'Keyword'
   # column => '0'
   # context => '#stay'
   # endRegion => 'IndentRegion'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'return ?', 1, 0, 0, 0, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'set_commands'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'set_commands', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => 'pragma'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'pragma', 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '-'
   # char1 => '>'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '>', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '\d+'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\d+', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   return 0;
};

sub parsecomment {
   my ($self, $text) = @_;
   return 0;
};

sub parselogic {
   my ($self, $text) = @_;
   # attribute => 'Operator'
   # char => '.'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '.', 0, 0, 0, undef, 0, '#pop', 'Operator')) {
      return 1
   }
   return 0;
};

sub parseml_comment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'comment_region'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsestring {
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

sub parsestringc {
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

Syntax::Highlight::Engine::Kate::XHarbour - a Plugin for xHarbour syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::XHarbour;
 my $sh = new Syntax::Highlight::Engine::Kate::XHarbour([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::XHarbour is a  plugin module that provides syntax highlighting
for xHarbour to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author