# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'javascript-php.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.10
#kate version 2.3
#kate author Anders Lund (anders@alweb.dk), Joseph Wenninger (jowenn@kde.org), Whitehawk Stormchaser (zerokode@gmx.net)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::JavaScript_PHP;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Events' => 'Keyword',
      'Float' => 'Float',
      'Function' => 'Function',
      'Keyword' => 'Keyword',
      'Math' => 'Keyword',
      'Normal Text' => 'Normal',
      'Objects' => 'Keyword',
      'Pattern Character Class' => 'BaseN',
      'Pattern Internal Operator' => 'Float',
      'Region Marker' => 'RegionMarker',
      'Regular Expression' => 'Others',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('events',
      'onAbort',
      'onBlur',
      'onChange',
      'onClick',
      'onError',
      'onFocus',
      'onLoad',
      'onMouseOut',
      'onMouseOver',
      'onReset',
      'onSelect',
      'onSubmit',
      'onUnload',
   );
   $self->listAdd('functions',
      'Number',
      'escape',
      'isFinite',
      'isNaN',
      'parseFloat',
      'parseInt',
      'reload',
      'taint',
      'unescape',
      'untaint',
      'write',
   );
   $self->listAdd('keywords',
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
      'finally',
      'for',
      'function',
      'if',
      'in',
      'new',
      'return',
      'switch',
      'throw',
      'true',
      'try',
      'typeof',
      'var',
      'void',
      'while',
      'with',
   );
   $self->listAdd('math',
      'E',
      'LN10',
      'LN2',
      'LOG10E',
      'LOG2E',
      'PI',
      'SQRT1_2',
      'SQRT2',
      'abs',
      'acos',
      'asin',
      'atan',
      'atan2',
      'ceil',
      'cos',
      'ctg',
      'exp',
      'floor',
      'log',
      'pow',
      'round',
      'sin',
      'sqrt',
      'tan',
   );
   $self->listAdd('methods',
      'MAX_VALUE',
      'MIN_VALUE',
      'NEGATIVE_INFINITY',
      'NaN',
      'POSITIVE_INFINITY',
      'URL',
      'UTC',
      'above',
      'action',
      'alert',
      'alinkColor',
      'anchor',
      'anchors',
      'appCodeName',
      'appName',
      'appVersion',
      'applets',
      'apply',
      'argument',
      'arguments',
      'arity',
      'availHeight',
      'availWidth',
      'back',
      'background',
      'below',
      'bgColor',
      'big',
      'blink',
      'blur',
      'bold',
      'border',
      'border',
      'call',
      'caller',
      'charAt',
      'charCodeAt',
      'checked',
      'clearInterval',
      'clearTimeout',
      'click',
      'clip',
      'close',
      'closed',
      'colorDepth',
      'compile',
      'complete',
      'confirm',
      'constructor',
      'cookie',
      'current',
      'cursor',
      'data',
      'defaultChecked',
      'defaultSelected',
      'defaultStatus',
      'defaultValue',
      'description',
      'disableExternalCapture',
      'domain',
      'elements',
      'embeds',
      'enableExternalCapture',
      'enabledPlugin',
      'encoding',
      'eval',
      'exec',
      'fgColor',
      'filename',
      'find',
      'fixed',
      'focus',
      'fontcolor',
      'fontsize',
      'form',
      'formName',
      'forms',
      'forward',
      'frames',
      'fromCharCode',
      'getDate',
      'getDay',
      'getHours',
      'getMiliseconds',
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
      'getYear',
      'global',
      'go',
      'hash',
      'height',
      'history',
      'home',
      'host',
      'hostname',
      'href',
      'hspace',
      'ignoreCase',
      'images',
      'index',
      'indexOf',
      'innerHeight',
      'innerWidth',
      'input',
      'italics',
      'javaEnabled',
      'join',
      'language',
      'lastIndex',
      'lastIndexOf',
      'lastModified',
      'lastParen',
      'layerX',
      'layerY',
      'layers',
      'left',
      'leftContext',
      'length',
      'link',
      'linkColor',
      'links',
      'load',
      'location',
      'locationbar',
      'lowsrc',
      'match',
      'menubar',
      'method',
      'mimeTypes',
      'modifiers',
      'moveAbove',
      'moveBelow',
      'moveBy',
      'moveTo',
      'moveToAbsolute',
      'multiline',
      'name',
      'negative_infinity',
      'next',
      'open',
      'opener',
      'options',
      'outerHeight',
      'outerWidth',
      'pageX',
      'pageXoffset',
      'pageY',
      'pageYoffset',
      'parent',
      'parse',
      'pathname',
      'personalbar',
      'pixelDepth',
      'platform',
      'plugins',
      'pop',
      'port',
      'positive_infinity',
      'preference',
      'previous',
      'print',
      'prompt',
      'protocol',
      'prototype',
      'push',
      'referrer',
      'refresh',
      'releaseEvents',
      'reload',
      'replace',
      'reset',
      'resizeBy',
      'resizeTo',
      'reverse',
      'rightContext',
      'screenX',
      'screenY',
      'scroll',
      'scrollBy',
      'scrollTo',
      'scrollbar',
      'search',
      'select',
      'selected',
      'selectedIndex',
      'self',
      'setDate',
      'setHours',
      'setMinutes',
      'setMonth',
      'setSeconds',
      'setTime',
      'setTimeout',
      'setUTCDate',
      'setUTCDay',
      'setUTCFullYear',
      'setUTCHours',
      'setUTCMilliseconds',
      'setUTCMinutes',
      'setUTCMonth',
      'setUTCSeconds',
      'setYear',
      'shift',
      'siblingAbove',
      'siblingBelow',
      'small',
      'sort',
      'source',
      'splice',
      'split',
      'src',
      'status',
      'statusbar',
      'strike',
      'sub',
      'submit',
      'substr',
      'substring',
      'suffixes',
      'sup',
      'taintEnabled',
      'target',
      'test',
      'text',
      'title',
      'toGMTString',
      'toLocaleString',
      'toLowerCase',
      'toSource',
      'toString',
      'toUTCString',
      'toUpperCase',
      'toolbar',
      'top',
      'type',
      'unshift',
      'unwatch',
      'userAgent',
      'value',
      'valueOf',
      'visibility',
      'vlinkColor',
      'vspace',
      'watch',
      'which',
      'width',
      'width',
      'write',
      'writeln',
      'x',
      'y',
      'zIndex',
   );
   $self->listAdd('objects',
      'Anchor',
      'Applet',
      'Area',
      'Array',
      'Boolean',
      'Button',
      'Checkbox',
      'Date',
      'FileUpload',
      'Form',
      'Frame',
      'Function',
      'Hidden',
      'Image',
      'Layer',
      'Link',
      'Math',
      'Max',
      'MimeType',
      'Min',
      'Object',
      'Password',
      'Plugin',
      'Radio',
      'RegExp',
      'Reset',
      'Screen',
      'Select',
      'String',
      'Text',
      'Textarea',
      'Window',
      'document',
      'navigator',
      'this',
      'window',
   );
   $self->contextdata({
      '(Internal regex catch)' => {
         callback => \&parseBoInternalregexcatchBc,
         attribute => 'Normal Text',
         fallthrough => '#pop',
      },
      '(charclass caret first check)' => {
         callback => \&parseBocharclasscaretfirstcheckBc,
         attribute => 'Pattern Internal Operator',
         lineending => '#pop',
         fallthrough => 'Regular Expression Character Class',
      },
      '(regex caret first check)' => {
         callback => \&parseBoregexcaretfirstcheckBc,
         attribute => 'Pattern Internal Operator',
         lineending => '#pop',
         fallthrough => 'Regular Expression',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'FindPHP' => {
         callback => \&parseFindPHP,
      },
      'Multi/inline Comment' => {
         callback => \&parseMultiinlineComment,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Regular Expression' => {
         callback => \&parseRegularExpression,
         attribute => 'Regular Expression',
      },
      'Regular Expression Character Class' => {
         callback => \&parseRegularExpressionCharacterClass,
         attribute => 'Pattern Character Class',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
      },
      'String 1' => {
         callback => \&parseString1,
         attribute => 'String Char',
         lineending => '#pop',
      },
      'region_marker' => {
         callback => \&parseregion_marker,
         attribute => 'Region Marker',
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
   return 'JavaScript/PHP';
}

sub parseBoInternalregexcatchBc {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # String => '\s*'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '//(?=;)'
   # attribute => 'Regular Expression'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//(?=;)', 0, 0, 0, undef, 0, '#pop', 'Regular Expression')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Multi/inline Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Multi/inline Comment', 'Comment')) {
      return 1
   }
   # attribute => 'Regular Expression'
   # char => '/'
   # context => '(regex caret first check)'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '/', 0, 0, 0, undef, 0, '(regex caret first check)', 'Regular Expression')) {
      return 1
   }
   return 0;
};

sub parseBocharclasscaretfirstcheckBc {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # attribute => 'Pattern Internal Operator'
   # char => '^'
   # context => 'Regular Expression Character Class'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '^', 0, 0, 0, undef, 0, 'Regular Expression Character Class', 'Pattern Internal Operator')) {
      return 1
   }
   return 0;
};

sub parseBoregexcaretfirstcheckBc {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # attribute => 'Pattern Internal Operator'
   # char => '^'
   # context => 'Regular Expression'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '^', 0, 0, 0, undef, 0, 'Regular Expression', 'Pattern Internal Operator')) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   return 0;
};

sub parseFindPHP {
   my ($self, $text) = @_;
   # String => '<\?(?:=|php)?'
   # context => '##PHP/PHP'
   # lookAhead => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\?(?:=|php)?', 0, 0, 1, undef, 0, '##PHP/PHP', undef)) {
      return 1
   }
   return 0;
};

sub parseMultiinlineComment {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
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

sub parseNormal {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '//BEGIN'
   # attribute => 'Region Marker'
   # beginRegion => 'Region1'
   # context => 'region_marker'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '//BEGIN', 0, 0, 0, undef, 0, 'region_marker', 'Region Marker')) {
      return 1
   }
   # String => '//END'
   # attribute => 'Region Marker'
   # context => 'region_marker'
   # endRegion => 'Region1'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//END', 0, 0, 0, undef, 0, 'region_marker', 'Region Marker')) {
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
   # String => 'objects'
   # attribute => 'Objects'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'objects', 0, undef, 0, '#stay', 'Objects')) {
      return 1
   }
   # String => 'math'
   # attribute => 'Math'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'math', 0, undef, 0, '#stay', 'Math')) {
      return 1
   }
   # String => 'events'
   # attribute => 'Events'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'events', 0, undef, 0, '#stay', 'Events')) {
      return 1
   }
   # String => 'methods'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'methods', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
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
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'String 1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String 1', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Multi/inline Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Multi/inline Comment', 'Comment')) {
      return 1
   }
   # String => '[=?:]'
   # attribute => 'Normal Text'
   # context => '(Internal regex catch)'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[=?:]', 0, 0, 0, undef, 0, '(Internal regex catch)', 'Normal Text')) {
      return 1
   }
   # String => '\('
   # attribute => 'Normal Text'
   # context => '(Internal regex catch)'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\(', 0, 0, 0, undef, 0, '(Internal regex catch)', 'Normal Text')) {
      return 1
   }
   # attribute => 'Symbol'
   # beginRegion => 'Brace1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Symbol'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => ':!%&+,-/.*<=>?[]|~^;'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':!%&+,-/.*<=>?[]|~^;', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseRegularExpression {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # String => '/[ig]{0,2}'
   # attribute => 'Regular Expression'
   # context => '#pop#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '/[ig]{0,2}', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Regular Expression')) {
      return 1
   }
   # String => '\{[\d, ]+\}'
   # attribute => 'Pattern Internal Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\{[\\d, ]+\\}', 0, 0, 0, undef, 0, '#stay', 'Pattern Internal Operator')) {
      return 1
   }
   # String => '\\[bB]'
   # attribute => 'Pattern Internal Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[bB]', 0, 0, 0, undef, 0, '#stay', 'Pattern Internal Operator')) {
      return 1
   }
   # String => '\\[nrtvfDdSsWw]'
   # attribute => 'Pattern Character Class'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[nrtvfDdSsWw]', 0, 0, 0, undef, 0, '#stay', 'Pattern Character Class')) {
      return 1
   }
   # attribute => 'Pattern Character Class'
   # char => '['
   # context => '(charclass caret first check)'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, '(charclass caret first check)', 'Pattern Character Class')) {
      return 1
   }
   # String => '\\.'
   # attribute => 'Pattern Internal Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Pattern Internal Operator')) {
      return 1
   }
   # String => '\$(?=/)'
   # attribute => 'Pattern Internal Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$(?=/)', 0, 0, 0, undef, 0, '#stay', 'Pattern Internal Operator')) {
      return 1
   }
   # String => '?+*()|'
   # attribute => 'Pattern Internal Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '?+*()|', 0, 0, undef, 0, '#stay', 'Pattern Internal Operator')) {
      return 1
   }
   return 0;
};

sub parseRegularExpressionCharacterClass {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # String => '\\[\[\]]'
   # attribute => 'Pattern Character Class'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[\\[\\]]', 0, 0, 0, undef, 0, '#stay', 'Pattern Character Class')) {
      return 1
   }
   # attribute => 'Pattern Character Class'
   # char => ']'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop#pop', 'Pattern Character Class')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
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

sub parseString1 {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String Char')) {
      return 1
   }
   return 0;
};

sub parseregion_marker {
   my ($self, $text) = @_;
   # context => 'FindPHP'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPHP', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::JavaScript_PHP - a Plugin for JavaScript/PHP syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::JavaScript_PHP;
 my $sh = new Syntax::Highlight::Engine::Kate::JavaScript_PHP([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::JavaScript_PHP is a  plugin module that provides syntax highlighting
for JavaScript/PHP to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author