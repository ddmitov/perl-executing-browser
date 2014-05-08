# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'coldfusion.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.3
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::ColdFusion;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Anchor Tags' => 'Float',
      'Attribute Values' => 'BaseN',
      'Brackets' => 'Reserved',
      'CF Comment' => 'Comment',
      'CF Tags' => 'Float',
      'CFX Tags' => 'Float',
      'Custom Tags' => 'BString',
      'HTML Comment' => 'Comment',
      'HTML Entities' => 'Char',
      'Image Tags' => 'Operator',
      'Normal Text' => 'Normal',
      'Numbers' => 'BaseN',
      'Script Comment' => 'Comment',
      'Script Functions' => 'Function',
      'Script Keywords' => 'Keyword',
      'Script Numbers' => 'Char',
      'Script Objects' => 'DecVal',
      'Script Operators' => 'BaseN',
      'Script Strings' => 'Keyword',
      'Script Tags' => 'Float',
      'Style Properties' => 'Others',
      'Style Selectors' => 'Char',
      'Style Tags' => 'Operator',
      'Style Values' => 'String',
      'Table Tags' => 'Keyword',
      'Tags' => 'Others',
   });
   $self->listAdd('CFSCRIPT Functions',
      'ACos',
      'ASin',
      'Abs',
      'ArrayAppend',
      'ArrayAvg',
      'ArrayClear',
      'ArrayDeleteAt',
      'ArrayInsertAt',
      'ArrayIsEmpty',
      'ArrayLen',
      'ArrayMax',
      'ArrayMin',
      'ArrayNew',
      'ArrayPrepend',
      'ArrayResize',
      'ArraySet',
      'ArraySort',
      'ArraySum',
      'ArraySwap',
      'ArrayToList',
      'Asc',
      'Atn',
      'BitAnd',
      'BitMaskClear',
      'BitMaskRead',
      'BitMaskSet',
      'BitNot',
      'BitOr',
      'BitSHLN',
      'BitSHRN',
      'BitXor',
      'CJustify',
      'Ceiling',
      'Chr',
      'Compare',
      'CompareNoCase',
      'Cos',
      'CreateDate',
      'CreateDateTime',
      'CreateODBCDate',
      'CreateODBCDateTime',
      'CreateODBCTime',
      'CreateObject',
      'CreateTime',
      'CreateTimeSpan',
      'CreateUUID',
      'DE',
      'DateAdd',
      'DateCompare',
      'DateConvert',
      'DateDiff',
      'DateFormat',
      'DatePart',
      'Day',
      'DayOfWeek',
      'DayOfWeekAsString',
      'DayOfYear',
      'DaysInMonth',
      'DaysInYear',
      'DecimalFormat',
      'DecrementValue',
      'Decrypt',
      'DeleteClientVariable',
      'DirectoryExists',
      'DollarFormat',
      'Duplicate',
      'Encrypt',
      'Evaluate',
      'Exp',
      'ExpandPath',
      'FileExists',
      'Find',
      'FindNoCase',
      'FindOneOf',
      'FirstDayOfMonth',
      'Fix',
      'FormatBaseN',
      'GetAuthUser',
      'GetBaseTagData',
      'GetBaseTagList',
      'GetBaseTemplatePath',
      'GetClientVariablesList',
      'GetCurrentTemplatePath',
      'GetDirectoryFromPath',
      'GetException',
      'GetFileFromPath',
      'GetFunctionList',
      'GetHttpRequestData',
      'GetHttpTimeString',
      'GetK2ServerDocCount',
      'GetK2ServerDocCountLimit',
      'GetLocale',
      'GetMetaData',
      'GetMetricData',
      'GetPageContext',
      'GetProfileSections',
      'GetProfileString',
      'GetServiceSettings',
      'GetTempDirectory',
      'GetTempFile',
      'GetTemplatePath',
      'GetTickCount',
      'GetTimeZoneInfo',
      'GetToken',
      'HTMLCodeFormat',
      'HTMLEditFormat',
      'Hash',
      'Hour',
      'IIf',
      'IncrementValue',
      'InputBaseN',
      'Insert',
      'Int',
      'IsArray',
      'IsBinary',
      'IsBoolean',
      'IsCustomFunction',
      'IsDate',
      'IsDebugMode',
      'IsDefined',
      'IsK2ServerABroker',
      'IsK2ServerDocCountExceeded',
      'IsK2ServerOnline',
      'IsLeapYear',
      'IsNumeric',
      'IsNumericDate',
      'IsObject',
      'IsQuery',
      'IsSimpleValue',
      'IsStruct',
      'IsUserInRole',
      'IsWDDX',
      'IsXmlDoc',
      'IsXmlElement',
      'IsXmlRoot',
      'JSStringFormat',
      'JavaCast',
      'LCase',
      'LJustify',
      'LSCurrencyFormat',
      'LSDateFormat',
      'LSEuroCurrencyFormat',
      'LSIsCurrency',
      'LSIsDate',
      'LSIsNumeric',
      'LSNumberFormat',
      'LSParseCurrency',
      'LSParseDateTime',
      'LSParseEuroCurrency',
      'LSParseNumber',
      'LSTimeFormat',
      'LTrim',
      'Left',
      'Len',
      'ListAppend',
      'ListChangeDelims',
      'ListContains',
      'ListContainsNoCase',
      'ListDeleteAt',
      'ListFind',
      'ListFindNoCase',
      'ListFirst',
      'ListGetAt',
      'ListInsertAt',
      'ListLast',
      'ListLen',
      'ListPrepend',
      'ListQualify',
      'ListRest',
      'ListSetAt',
      'ListSort',
      'ListToArray',
      'ListValueCount',
      'ListValueCountNoCase',
      'Log',
      'Log10',
      'Max',
      'Mid',
      'Min',
      'Minute',
      'Month',
      'MonthAsString',
      'Now',
      'NumberFormat',
      'ParagraphFormat',
      'ParameterExists',
      'ParseDateTime',
      'Pi',
      'PreserveSingleQuotes',
      'Quarter',
      'QueryAddColumn',
      'QueryAddRow',
      'QueryNew',
      'QuerySetCell',
      'QuotedValueList',
      'REFind',
      'REFindNoCase',
      'REReplace',
      'REReplaceNoCase',
      'RJustify',
      'RTrim',
      'Rand',
      'RandRange',
      'Randomize',
      'RemoveChars',
      'RepeatString',
      'Replace',
      'ReplaceList',
      'ReplaceNoCase',
      'Reverse',
      'Right',
      'Round',
      'Second',
      'SetEncoding',
      'SetLocale',
      'SetProfileString',
      'SetVariable',
      'Sgn',
      'Sin',
      'SpanExcluding',
      'SpanIncluding',
      'Sqr',
      'StripCR',
      'StructAppend',
      'StructClear',
      'StructCopy',
      'StructCount',
      'StructDelete',
      'StructFind',
      'StructFindKey',
      'StructFindValue',
      'StructGet',
      'StructInsert',
      'StructIsEmpty',
      'StructKeyArray',
      'StructKeyExists',
      'StructKeyList',
      'StructNew',
      'StructSort',
      'StructUpdate',
      'Tan',
      'TimeFormat',
      'ToBase64',
      'ToBinary',
      'ToString',
      'Trim',
      'UCase',
      'URLDecode',
      'URLEncodedFormat',
      'URLSessionFormat',
      'Val',
      'ValueList',
      'Week',
      'WriteOutput',
      'XmlChildPos',
      'XmlElemNew',
      'XmlFormat',
      'XmlNew',
      'XmlParse',
      'XmlSearch',
      'XmlTransform',
      'Year',
      'YesNoFormat',
   );
   $self->listAdd('CFSCRIPT Keywords',
      'break',
      'case',
      'catch',
      'continue',
      'default',
      'do',
      'else',
      'for',
      'function',
      'if',
      'in',
      'return',
      'switch',
      'try',
      'var',
      'while',
   );
   $self->listAdd('Script Keywords',
      'break',
      'case',
      'catch',
      'const',
      'continue',
      'default',
      'delete',
      'do',
      'else',
      'false',
      'for',
      'function',
      'if',
      'in',
      'new',
      'return',
      'switch',
      'this',
      'throw',
      'true',
      'try',
      'typeof',
      'var',
      'void',
      'while',
      'with',
   );
   $self->listAdd('Script Methods',
      'String formatting',
      'UTC',
      'abs',
      'acos',
      'alert',
      'anchor',
      'apply',
      'asin',
      'atan',
      'atan2',
      'back',
      'blur',
      'call',
      'captureEvents',
      'ceil',
      'charAt',
      'charCodeAt',
      'clearInterval',
      'clearTimeout',
      'click',
      'close',
      'compile',
      'concat',
      'confirm',
      'cos',
      'disableExternalCapture',
      'enableExternalCapture',
      'eval',
      'exec',
      'exp',
      'find',
      'floor',
      'focus',
      'forward',
      'fromCharCode',
      'getDate',
      'getDay',
      'getFullYear',
      'getHours',
      'getMilliseconds',
      'getMinutes',
      'getMonth',
      'getSeconds',
      'getSelection',
      'getTime',
      'getTimezoneOffset',
      'getUTCDate',
      'getUTCDay',
      'getUTCFullYear',
      'getUTCHours',
      'getUTCMilliseconds',
      'getUTCMinutes',
      'getUTCMonth',
      'getUTCSeconds',
      'go',
      'handleEvent',
      'home',
      'indexOf',
      'javaEnabled',
      'join',
      'lastIndexOf',
      'link',
      'load',
      'log',
      'match',
      'max',
      'min',
      'moveAbove',
      'moveBelow',
      'moveBy',
      'moveTo',
      'moveToAbsolute',
      'open',
      'parse',
      'plugins.refresh',
      'pop',
      'pow',
      'preference',
      'print',
      'prompt',
      'push',
      'random',
      'releaseEvents',
      'reload',
      'replace',
      'reset',
      'resizeBy',
      'resizeTo',
      'reverse',
      'round',
      'routeEvent',
      'scrollBy',
      'scrollTo',
      'search',
      'select',
      'setDate',
      'setFullYear',
      'setHours',
      'setInterval',
      'setMilliseconds',
      'setMinutes',
      'setMonth',
      'setSeconds',
      'setTime',
      'setTimeout',
      'setUTCDate',
      'setUTCFullYear',
      'setUTCHours',
      'setUTCMilliseconds',
      'setUTCMinutes',
      'setUTCMonth',
      'setUTCSeconds',
      'shift',
      'sin',
      'slice',
      'sort',
      'splice',
      'split',
      'sqrt',
      'stop',
      'submit',
      'substr',
      'substring',
      'taintEnabled',
      'tan',
      'test',
      'toLocaleString',
      'toLowerCase',
      'toSource',
      'toString',
      'toUTCString',
      'toUpperCase',
      'unshift',
      'unwatch',
      'valueOf',
      'watch',
      'write',
      'writeln',
   );
   $self->listAdd('Script Objects',
      'Anchor',
      'Applet',
      'Area',
      'Array',
      'Boolean',
      'Button',
      'Checkbox',
      'Date',
      'Document',
      'Event',
      'FileUpload',
      'Form',
      'Frame',
      'Function',
      'Hidden',
      'History',
      'Image',
      'Layer',
      'Linke',
      'Location',
      'Math',
      'Navigator',
      'Number',
      'Object',
      'Option',
      'Password',
      'Radio',
      'RegExp',
      'Reset',
      'Screen',
      'Select',
      'String',
      'Submit',
      'Text',
      'Textarea',
      'Window',
   );
   $self->contextdata({
      'Normal Text' => {
         callback => \&parseNormalText,
         attribute => 'Normal Text',
      },
      'ctxAnchor Tag' => {
         callback => \&parsectxAnchorTag,
         attribute => 'Anchor Tags',
      },
      'ctxC Style Comment' => {
         callback => \&parsectxCStyleComment,
         attribute => 'Script Comment',
      },
      'ctxCF Comment' => {
         callback => \&parsectxCFComment,
         attribute => 'CF Comment',
      },
      'ctxCF Tag' => {
         callback => \&parsectxCFTag,
         attribute => 'CF Tags',
      },
      'ctxCFSCRIPT Block' => {
         callback => \&parsectxCFSCRIPTBlock,
         attribute => 'Normal Text',
      },
      'ctxCFSCRIPT Tag' => {
         callback => \&parsectxCFSCRIPTTag,
         attribute => 'Script Tags',
      },
      'ctxCFX Tag' => {
         callback => \&parsectxCFXTag,
         attribute => 'CFX Tags',
      },
      'ctxCustom Tag' => {
         callback => \&parsectxCustomTag,
         attribute => 'Custom Tags',
      },
      'ctxHTML Comment' => {
         callback => \&parsectxHTMLComment,
         attribute => 'HTML Comment',
      },
      'ctxHTML Entities' => {
         callback => \&parsectxHTMLEntities,
         attribute => 'HTML Entities',
         lineending => '#pop',
      },
      'ctxImage Tag' => {
         callback => \&parsectxImageTag,
         attribute => 'Image Tags',
      },
      'ctxOne Line Comment' => {
         callback => \&parsectxOneLineComment,
         attribute => 'Script Comment',
         lineending => '#pop',
      },
      'ctxSCRIPT Block' => {
         callback => \&parsectxSCRIPTBlock,
         attribute => 'Normal Text',
      },
      'ctxSCRIPT Tag' => {
         callback => \&parsectxSCRIPTTag,
         attribute => 'Script Tags',
      },
      'ctxSTYLE Block' => {
         callback => \&parsectxSTYLEBlock,
         attribute => 'Style Selectors',
      },
      'ctxSTYLE Tag' => {
         callback => \&parsectxSTYLETag,
         attribute => 'Style Tags',
      },
      'ctxStyle Properties' => {
         callback => \&parsectxStyleProperties,
         attribute => 'Style Properties',
      },
      'ctxStyle Values' => {
         callback => \&parsectxStyleValues,
         attribute => 'Style Values',
         lineending => '#pop',
      },
      'ctxTable Tag' => {
         callback => \&parsectxTableTag,
         attribute => 'Table Tags',
      },
      'ctxTag' => {
         callback => \&parsectxTag,
         attribute => 'Tags',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|-');
   $self->basecontext('Normal Text');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'ColdFusion';
}

sub parseNormalText {
   my ($self, $text) = @_;
   # String => '<!---'
   # attribute => 'CF Comment'
   # context => 'ctxCF Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!---', 0, 0, 0, undef, 0, 'ctxCF Comment', 'CF Comment')) {
      return 1
   }
   # String => '<!--'
   # attribute => 'HTML Comment'
   # context => 'ctxHTML Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'ctxHTML Comment', 'HTML Comment')) {
      return 1
   }
   # String => '<[cC][fF][sS][cC][rR][iI][pP][tT]'
   # attribute => 'Script Tags'
   # context => 'ctxCFSCRIPT Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<[cC][fF][sS][cC][rR][iI][pP][tT]', 0, 0, 0, undef, 0, 'ctxCFSCRIPT Tag', 'Script Tags')) {
      return 1
   }
   # String => '<[sS][cC][rR][iI][pP][tT]'
   # attribute => 'Script Tags'
   # context => 'ctxSCRIPT Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<[sS][cC][rR][iI][pP][tT]', 0, 0, 0, undef, 0, 'ctxSCRIPT Tag', 'Script Tags')) {
      return 1
   }
   # String => '<[sS][tT][yY][lL][eE]'
   # attribute => 'Style Tags'
   # context => 'ctxSTYLE Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<[sS][tT][yY][lL][eE]', 0, 0, 0, undef, 0, 'ctxSTYLE Tag', 'Style Tags')) {
      return 1
   }
   # attribute => 'HTML Entities'
   # char => '&'
   # context => 'ctxHTML Entities'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, 'ctxHTML Entities', 'HTML Entities')) {
      return 1
   }
   # String => '<\/?[cC][fF]_'
   # attribute => 'Custom Tags'
   # context => 'ctxCustom Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\/?[cC][fF]_', 0, 0, 0, undef, 0, 'ctxCustom Tag', 'Custom Tags')) {
      return 1
   }
   # String => '<\/?[cC][fF][xX]_'
   # attribute => 'CFX Tags'
   # context => 'ctxCFX Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\/?[cC][fF][xX]_', 0, 0, 0, undef, 0, 'ctxCFX Tag', 'CFX Tags')) {
      return 1
   }
   # String => '<\/?[cC][fF]'
   # attribute => 'CF Tags'
   # context => 'ctxCF Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\/?[cC][fF]', 0, 0, 0, undef, 0, 'ctxCF Tag', 'CF Tags')) {
      return 1
   }
   # String => '<\/?([tT][aAhHbBfFrRdD])|([cC][aA][pP][tT])'
   # attribute => 'Table Tags'
   # context => 'ctxTable Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\/?([tT][aAhHbBfFrRdD])|([cC][aA][pP][tT])', 0, 0, 0, undef, 0, 'ctxTable Tag', 'Table Tags')) {
      return 1
   }
   # String => '<\/?[aA] '
   # attribute => 'Anchor Tags'
   # context => 'ctxAnchor Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\/?[aA] ', 0, 0, 0, undef, 0, 'ctxAnchor Tag', 'Anchor Tags')) {
      return 1
   }
   # String => '<\/?[iI][mM][gG] '
   # attribute => 'Image Tags'
   # context => 'ctxImage Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\/?[iI][mM][gG] ', 0, 0, 0, undef, 0, 'ctxImage Tag', 'Image Tags')) {
      return 1
   }
   # String => '<!?\/?[a-zA-Z0-9_]+'
   # attribute => 'Tags'
   # context => 'ctxTag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<!?\\/?[a-zA-Z0-9_]+', 0, 0, 0, undef, 0, 'ctxTag', 'Tags')) {
      return 1
   }
   return 0;
};

sub parsectxAnchorTag {
   my ($self, $text) = @_;
   # attribute => 'Anchor Tags'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Anchor Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxCStyleComment {
   my ($self, $text) = @_;
   # attribute => 'Script Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Script Comment')) {
      return 1
   }
   return 0;
};

sub parsectxCFComment {
   my ($self, $text) = @_;
   # String => '--->'
   # attribute => 'CF Comment'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '--->', 0, 0, 0, undef, 0, '#pop', 'CF Comment')) {
      return 1
   }
   return 0;
};

sub parsectxCFTag {
   my ($self, $text) = @_;
   # attribute => 'CF Tags'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'CF Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxCFSCRIPTBlock {
   my ($self, $text) = @_;
   # attribute => 'Script Comment'
   # char => '/'
   # char1 => '*'
   # context => 'ctxC Style Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'ctxC Style Comment', 'Script Comment')) {
      return 1
   }
   # attribute => 'Script Comment'
   # char => '/'
   # char1 => '/'
   # context => 'ctxOne Line Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'ctxOne Line Comment', 'Script Comment')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Script Strings'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Script Strings')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Script Strings'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Script Strings')) {
      return 1
   }
   # attribute => 'Script Numbers'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Script Numbers')) {
      return 1
   }
   # attribute => 'Script Numbers'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Script Numbers')) {
      return 1
   }
   # String => '[()[\]=+-*/]+'
   # attribute => 'Script Operators'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '[()[\\]=+-*/]+', 0, 0, undef, 0, '#stay', 'Script Operators')) {
      return 1
   }
   # String => '{}'
   # attribute => 'Brackets'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '{}', 0, 0, undef, 0, '#stay', 'Brackets')) {
      return 1
   }
   # String => 'CFSCRIPT Keywords'
   # attribute => 'Script Keywords'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'CFSCRIPT Keywords', 0, undef, 0, '#stay', 'Script Keywords')) {
      return 1
   }
   # String => 'CFSCRIPT Functions'
   # attribute => 'Script Functions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'CFSCRIPT Functions', 0, undef, 0, '#stay', 'Script Functions')) {
      return 1
   }
   # String => '</[cC][fF][sS][cC][rR][iI][pP][tT]>'
   # attribute => 'Script Tags'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '</[cC][fF][sS][cC][rR][iI][pP][tT]>', 0, 0, 0, undef, 0, '#pop#pop', 'Script Tags')) {
      return 1
   }
   return 0;
};

sub parsectxCFSCRIPTTag {
   my ($self, $text) = @_;
   # attribute => 'Script Tags'
   # char => '>'
   # context => 'ctxCFSCRIPT Block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, 'ctxCFSCRIPT Block', 'Script Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxCFXTag {
   my ($self, $text) = @_;
   # attribute => 'CFX Tags'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'CFX Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxCustomTag {
   my ($self, $text) = @_;
   # attribute => 'Custom Tags'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Custom Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxHTMLComment {
   my ($self, $text) = @_;
   # String => '<!---'
   # attribute => 'CF Comment'
   # context => 'ctxCF Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!---', 0, 0, 0, undef, 0, 'ctxCF Comment', 'CF Comment')) {
      return 1
   }
   # String => '-->'
   # attribute => 'HTML Comment'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '-->', 0, 0, 0, undef, 0, '#pop', 'HTML Comment')) {
      return 1
   }
   return 0;
};

sub parsectxHTMLEntities {
   my ($self, $text) = @_;
   # attribute => 'HTML Entities'
   # char => ';'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'HTML Entities')) {
      return 1
   }
   return 0;
};

sub parsectxImageTag {
   my ($self, $text) = @_;
   # attribute => 'Image Tags'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Image Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxOneLineComment {
   my ($self, $text) = @_;
   return 0;
};

sub parsectxSCRIPTBlock {
   my ($self, $text) = @_;
   # attribute => 'Script Comment'
   # char => '/'
   # char1 => '*'
   # context => 'ctxC Style Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'ctxC Style Comment', 'Script Comment')) {
      return 1
   }
   # attribute => 'Script Comment'
   # char => '/'
   # char1 => '/'
   # context => 'ctxOne Line Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'ctxOne Line Comment', 'Script Comment')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Script Strings'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Script Strings')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Script Strings'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Script Strings')) {
      return 1
   }
   # attribute => 'Script Numbers'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Script Numbers')) {
      return 1
   }
   # attribute => 'Script Numbers'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Script Numbers')) {
      return 1
   }
   # String => '[()[\]=+-*/]+'
   # attribute => 'Script Operators'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '[()[\\]=+-*/]+', 0, 0, undef, 0, '#stay', 'Script Operators')) {
      return 1
   }
   # String => '{}'
   # attribute => 'Brackets'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '{}', 0, 0, undef, 0, '#stay', 'Brackets')) {
      return 1
   }
   # String => 'Script Keywords'
   # attribute => 'Script Keywords'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Script Keywords', 0, undef, 0, '#stay', 'Script Keywords')) {
      return 1
   }
   # String => 'Script Objects'
   # attribute => 'Script Objects'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Script Objects', 0, undef, 0, '#stay', 'Script Objects')) {
      return 1
   }
   # String => 'Script Methods'
   # attribute => 'Script Functions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Script Methods', 0, undef, 0, '#stay', 'Script Functions')) {
      return 1
   }
   # String => '</[sS][cC][rR][iI][pP][tT]>'
   # attribute => 'Script Tags'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '</[sS][cC][rR][iI][pP][tT]>', 0, 0, 0, undef, 0, '#pop#pop', 'Script Tags')) {
      return 1
   }
   return 0;
};

sub parsectxSCRIPTTag {
   my ($self, $text) = @_;
   # attribute => 'Script Tags'
   # char => '>'
   # context => 'ctxSCRIPT Block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, 'ctxSCRIPT Block', 'Script Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxSTYLEBlock {
   my ($self, $text) = @_;
   # attribute => 'Script Comment'
   # char => '/'
   # char1 => '*'
   # context => 'ctxC Style Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'ctxC Style Comment', 'Script Comment')) {
      return 1
   }
   # attribute => 'Brackets'
   # char => '{'
   # context => 'ctxStyle Properties'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'ctxStyle Properties', 'Brackets')) {
      return 1
   }
   # String => '</[sS][tT][yY][lL][eE]>'
   # attribute => 'Style Tags'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '</[sS][tT][yY][lL][eE]>', 0, 0, 0, undef, 0, '#pop#pop', 'Style Tags')) {
      return 1
   }
   return 0;
};

sub parsectxSTYLETag {
   my ($self, $text) = @_;
   # attribute => 'Style Tags'
   # char => '>'
   # context => 'ctxSTYLE Block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, 'ctxSTYLE Block', 'Style Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxStyleProperties {
   my ($self, $text) = @_;
   # attribute => 'Brackets'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Brackets')) {
      return 1
   }
   # attribute => 'Script Comment'
   # char => '/'
   # char1 => '*'
   # context => 'ctxC Style Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'ctxC Style Comment', 'Script Comment')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ':'
   # context => 'ctxStyle Values'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ':', 0, 0, 0, undef, 0, 'ctxStyle Values', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parsectxStyleValues {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => ';'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ','
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ',', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Numbers'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Numbers')) {
      return 1
   }
   # attribute => 'Numbers'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Numbers')) {
      return 1
   }
   # String => '#([0-9a-fA-F]{3})|([0-9a-fA-F]{6})'
   # attribute => 'Numbers'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#([0-9a-fA-F]{3})|([0-9a-fA-F]{6})', 0, 0, 0, undef, 0, '#stay', 'Numbers')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxTableTag {
   my ($self, $text) = @_;
   # attribute => 'Table Tags'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Table Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};

sub parsectxTag {
   my ($self, $text) = @_;
   # attribute => 'Tags'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Tags')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'Attribute Values'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'Attribute Values')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::ColdFusion - a Plugin for ColdFusion syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::ColdFusion;
 my $sh = new Syntax::Highlight::Engine::Kate::ColdFusion([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::ColdFusion is a  plugin module that provides syntax highlighting
for ColdFusion to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author