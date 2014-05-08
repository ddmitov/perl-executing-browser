# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'asp.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.1
#kate author Antonio Salazar (savedfastcool@gmail.com)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::ASP;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'ASP Text' => 'Normal',
      'Comment' => 'Comment',
      'Control Structures' => 'Operator',
      'Decimal' => 'DecVal',
      'Escape Code' => 'Char',
      'Float' => 'Float',
      'Function' => 'Function',
      'HTML Comment' => 'Comment',
      'HTML Tag' => 'BString',
      'Hex' => 'BaseN',
      'Identifier' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Other' => 'Others',
      'String' => 'String',
      'Types' => 'DataType',
      'Variable' => 'Variable',
   });
   $self->listAdd('control structures',
      'case',
      'continue',
      'do',
      'each',
      'else',
      'elseif',
      'end if',
      'end select',
      'exit',
      'for',
      'if',
      'in',
      'loop',
      'next',
      'select',
      'then',
      'to',
      'until',
      'wend',
      'while',
   );
   $self->listAdd('functions',
      'Add',
      'AddFolders',
      'BuildPath',
      'Clear',
      'Close',
      'Copy',
      'CopyFile',
      'CopyFolder',
      'CreateFolder',
      'CreateTextFile',
      'Date',
      'DateDiff',
      'DatePart',
      'DateSerial',
      'DateValue',
      'Day',
      'Delete',
      'DeleteFile',
      'DeleteFolder',
      'DriveExists',
      'Exists',
      'Exp',
      'FileExists',
      'Filter',
      'Fix',
      'FolderExists',
      'FormatCurrency',
      'FormatDateTime',
      'FormatNumber',
      'FormatPercent',
      'GetAbsolutePathName',
      'GetBaseName',
      'GetDrive',
      'GetDriveName',
      'GetExtensionName',
      'GetFile',
      'GetFileName',
      'GetFolder',
      'GetObject',
      'GetParentFolderName',
      'GetSpecialFolder',
      'GetTempName',
      'Hex',
      'Hour',
      'InStr',
      'InStrRev',
      'InputBox',
      'Int',
      'IsArray',
      'IsDate',
      'IsEmpty',
      'IsNull',
      'IsNumeric',
      'IsObject',
      'Items',
      'Join',
      'Keys',
      'LBound',
      'LCase',
      'LTrim',
      'Left',
      'Len',
      'LoadPicture',
      'Log',
      'Mid',
      'Minute',
      'Month',
      'MonthName',
      'Move',
      'MoveFile',
      'MoveFolder',
      'MsgBox',
      'Now',
      'Oct',
      'OpenAsTextStream',
      'OpenTextFile',
      'RGB',
      'RTrim',
      'Raise',
      'Read',
      'ReadAll',
      'ReadLine',
      'Remove',
      'RemoveAll',
      'Replace',
      'Right',
      'Rnd',
      'Round',
      'ScriptEngine',
      'ScriptEngineBuildVersion',
      'ScriptEngineMajorVersion',
      'ScriptEngineMinorVersion',
      'Second',
      'Sgn',
      'Sin',
      'Skip',
      'SkipLine',
      'Space',
      'Split',
      'Sqr',
      'StrComp',
      'StrReverse',
      'String',
      'Tan',
      'Time',
      'TimeSerial',
      'TimeValue',
      'Timer',
      'Trim',
      'TypeName',
      'UBound',
      'UCase',
      'VarType',
      'Weekday',
      'WeekdayName',
      'Write',
      'WriteBlankLines',
      'WriteLine',
      'Year',
      'abs',
      'array',
      'asc',
      'atn',
      'cbool',
      'cbyte',
      'ccur',
      'cdate',
      'cdbl',
      'chr',
      'cint',
      'clng',
      'cookies',
      'cos',
      'createobject',
      'csng',
      'cstr',
      'date',
      'dateadd',
      'end',
      'form',
      'item',
      'querystring',
      'redirect',
      'request',
      'response',
      'server',
      'servervariables',
      'session',
      'write',
   );
   $self->listAdd('keywords',
      'and',
      'call',
      'class',
      'close',
      'const',
      'dim',
      'eof',
      'erase',
      'execute',
      'false',
      'function',
      'me',
      'movenext',
      'new',
      'not',
      'nothing',
      'open',
      'or',
      'preserve',
      'private',
      'public',
      'randomize',
      'redim',
      'set',
      'sub',
      'true',
      'with',
      'xor',
   );
   $self->contextdata({
      'asp_onelinecomment' => {
         callback => \&parseasp_onelinecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'aspsource' => {
         callback => \&parseaspsource,
         attribute => 'ASP Text',
      },
      'doublequotestring' => {
         callback => \&parsedoublequotestring,
         attribute => 'String',
      },
      'htmlcomment' => {
         callback => \&parsehtmlcomment,
         attribute => 'HTML Comment',
      },
      'htmltag' => {
         callback => \&parsehtmltag,
         attribute => 'Identifier',
      },
      'identifiers' => {
         callback => \&parseidentifiers,
         attribute => 'Identifier',
      },
      'nosource' => {
         callback => \&parsenosource,
         attribute => 'Normal Text',
      },
      'scripts' => {
         callback => \&parsescripts,
         attribute => 'Normal Text',
      },
      'scripts_onelinecomment' => {
         callback => \&parsescripts_onelinecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'singlequotestring' => {
         callback => \&parsesinglequotestring,
         attribute => 'String',
      },
      'twolinecomment' => {
         callback => \&parsetwolinecomment,
         attribute => 'Comment',
      },
      'types1' => {
         callback => \&parsetypes1,
         attribute => 'Types',
      },
      'types2' => {
         callback => \&parsetypes2,
         attribute => 'Types',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('nosource');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'ASP';
}

sub parseasp_onelinecomment {
   my ($self, $text) = @_;
   # String => '%>'
   # attribute => 'Keyword'
   # context => '#pop#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '%>', 0, 0, 0, undef, 0, '#pop#pop', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseaspsource {
   my ($self, $text) = @_;
   # String => '%>'
   # attribute => 'Keyword'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '%>', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '''
   # context => 'asp_onelinecomment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'asp_onelinecomment', 'Comment')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'doublequotestring'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'doublequotestring', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'singlequotestring'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'singlequotestring', 'String')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '&'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => ''
   # attribute => 'String'
   # context => ''
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '', 0, 0, 0, undef, 0, '', 'String')) {
      return 1
   }
   # String => '[0123456789]*\.\.\.[0123456789]*'
   # attribute => 'String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0123456789]*\\.\\.\\.[0123456789]*', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Hex')) {
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
   # String => ';()}{:,[]'
   # attribute => 'Other'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ';()}{:,[]', 0, 0, undef, 0, '#stay', 'Other')) {
      return 1
   }
   # String => '\belseif\b'
   # attribute => 'Control Structures'
   # beginRegion => 'iffi1'
   # context => '#stay'
   # endRegion => 'iffi1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\belseif\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\belse\b'
   # attribute => 'Control Structures'
   # beginRegion => 'iffi1'
   # context => '#stay'
   # endRegion => 'iffi1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\belse\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bif\b'
   # attribute => 'Control Structures'
   # beginRegion => 'iffi1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bif\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bend if\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # endRegion => 'iffi1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend if\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bexit function\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bexit function\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bfunction\b'
   # attribute => 'Keyword'
   # beginRegion => 'funendfun1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfunction\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend function\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'funendfun1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend function\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bexit sub\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bexit sub\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bsub\b'
   # attribute => 'Keyword'
   # beginRegion => 'subendsub1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bsub\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend sub\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'subendsub1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend sub\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bclass\b'
   # attribute => 'Keyword'
   # beginRegion => 'classendclass1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bclass\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend class\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'classendclass1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend class\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bexit do\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bexit do\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bdo\b'
   # attribute => 'Control Structures'
   # beginRegion => 'doloop1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdo\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bloop\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # endRegion => 'doloop1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bloop\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bexit while\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bexit while\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bwhile\b'
   # attribute => 'Control Structures'
   # beginRegion => 'whilewend1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bwhile\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bwend\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # endRegion => 'whilewend1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bwend\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bexit for\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bexit for\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bfor\b'
   # attribute => 'Control Structures'
   # beginRegion => 'fornext1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfor\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bnext\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # endRegion => 'fornext1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bnext\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bselect case\b'
   # attribute => 'Control Structures'
   # beginRegion => 'selcase1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bselect case\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => '\bend select\b'
   # attribute => 'Control Structures'
   # context => '#stay'
   # endRegion => 'selcase1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend select\\b', 1, 0, 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'control structures'
   # attribute => 'Control Structures'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'control structures', 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   return 0;
};

sub parsedoublequotestring {
   my ($self, $text) = @_;
   # attribute => 'Escape Code'
   # char => '"'
   # char1 => '"'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '"', '"', 0, 0, 0, undef, 0, '#stay', 'Escape Code')) {
      return 1
   }
   # String => '\\[0-7]{1,3}'
   # attribute => 'Escape Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[0-7]{1,3}', 0, 0, 0, undef, 0, '#stay', 'Escape Code')) {
      return 1
   }
   # String => '\\x[0-9A-Fa-f]{1,2}'
   # attribute => 'Escape Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\x[0-9A-Fa-f]{1,2}', 0, 0, 0, undef, 0, '#stay', 'Escape Code')) {
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

sub parsehtmlcomment {
   my ($self, $text) = @_;
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '-->'
   # attribute => 'HTML Comment'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '-->', 0, 0, 0, undef, 0, '#pop', 'HTML Comment')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Normal Text'
   # context => 'identifiers'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'identifiers', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parsehtmltag {
   my ($self, $text) = @_;
   # attribute => 'HTML Tag'
   # char => '/'
   # char1 => '>'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop', 'HTML Tag')) {
      return 1
   }
   # attribute => 'HTML Tag'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'HTML Tag')) {
      return 1
   }
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Identifier'
   # context => 'identifiers'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'identifiers', 'Identifier')) {
      return 1
   }
   return 0;
};

sub parseidentifiers {
   my ($self, $text) = @_;
   # String => '\s*#?[a-zA-Z0-9]*'
   # attribute => 'String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*#?[a-zA-Z0-9]*', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # attribute => 'Types'
   # char => '''
   # context => 'types1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'types1', 'Types')) {
      return 1
   }
   # attribute => 'Types'
   # char => '"'
   # context => 'types2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'types2', 'Types')) {
      return 1
   }
   return 0;
};

sub parsenosource {
   my ($self, $text) = @_;
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '<\s*script(\s|>)'
   # attribute => 'HTML Tag'
   # context => 'scripts'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*script(\\s|>)', 1, 0, 0, undef, 0, 'scripts', 'HTML Tag')) {
      return 1
   }
   # String => '<\s*\/?\s*[a-zA-Z_:][a-zA-Z0-9._:-]*'
   # attribute => 'HTML Tag'
   # context => 'htmltag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*[a-zA-Z_:][a-zA-Z0-9._:-]*', 0, 0, 0, undef, 0, 'htmltag', 'HTML Tag')) {
      return 1
   }
   # String => '<!--'
   # attribute => 'HTML Comment'
   # context => 'htmlcomment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'htmlcomment', 'HTML Comment')) {
      return 1
   }
   return 0;
};

sub parsescripts {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'scripts_onelinecomment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'scripts_onelinecomment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'twolinecomment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'twolinecomment', 'Comment')) {
      return 1
   }
   # String => 'control structures'
   # attribute => 'Control Structures'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'control structures', 0, undef, 0, '#stay', 'Control Structures')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '<\s*\/\s*script\s*>'
   # attribute => 'HTML Tag'
   # context => '#pop'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/\\s*script\\s*>', 1, 0, 0, undef, 0, '#pop', 'HTML Tag')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'doublequotestring'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'doublequotestring', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'singlequotestring'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'singlequotestring', 'String')) {
      return 1
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Hex')) {
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
   # attribute => 'Normal Text'
   # beginRegion => 'Brace1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => ';()}{:,[]'
   # attribute => 'Other'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ';()}{:,[]', 0, 0, undef, 0, '#stay', 'Other')) {
      return 1
   }
   return 0;
};

sub parsescripts_onelinecomment {
   my ($self, $text) = @_;
   # String => '<\s*\/\s*script\s*>'
   # attribute => 'HTML Tag'
   # context => '#pop#pop'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/\\s*script\\s*>', 1, 0, 0, undef, 0, '#pop#pop', 'HTML Tag')) {
      return 1
   }
   return 0;
};

sub parsesinglequotestring {
   my ($self, $text) = @_;
   # attribute => 'Escape Code'
   # char => '''
   # char1 => '''
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\'', '\'', 0, 0, 0, undef, 0, '#stay', 'Escape Code')) {
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

sub parsetwolinecomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsetypes1 {
   my ($self, $text) = @_;
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # attribute => 'Types'
   # char => '''
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   return 0;
};

sub parsetypes2 {
   my ($self, $text) = @_;
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # String => '<%'
   # attribute => 'Keyword'
   # context => 'aspsource'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%', 0, 0, 0, undef, 0, 'aspsource', 'Keyword')) {
      return 1
   }
   # attribute => 'Types'
   # char => '"'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::ASP - a Plugin for ASP syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::ASP;
 my $sh = new Syntax::Highlight::Engine::Kate::ASP([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::ASP is a  plugin module that provides syntax highlighting
for ASP to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author