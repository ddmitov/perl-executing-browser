# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'doxygen.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.25
#kate version 2.4
#kate author Dominik Haumann (dhdev@gmx.de)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Doxygen;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Comment' => 'Reserved',
      'Description' => 'Function',
      'HTML Comment' => 'Comment',
      'HTML Tag' => 'Keyword',
      'Identifier' => 'Others',
      'Normal Text' => 'Normal',
      'Tags' => 'Keyword',
      'Types' => 'DataType',
      'Word' => 'Operator',
   });
   $self->listAdd('TagOnly',
      '@#',
      '@$',
      '@@',
      '@\\\\',
      '@arg',
      '@attention',
      '@author',
      '@callgraph',
      '@code',
      '@dot',
      '@else',
      '@endcode',
      '@enddot',
      '@endhtmlonly',
      '@endif',
      '@endlatexonly',
      '@endlink',
      '@endmanonly',
      '@endverbatim',
      '@endxmlonly',
      '@f$',
      '@f[',
      '@f]',
      '@hideinitializer',
      '@htmlonly',
      '@interface',
      '@internal',
      '@invariant',
      '@latexonly',
      '@li',
      '@manonly',
      '@n',
      '@nosubgrouping',
      '@note',
      '@only',
      '@par',
      '@post',
      '@pre',
      '@remarks',
      '@return',
      '@returns',
      '@sa',
      '@see',
      '@showinitializer',
      '@since',
      '@test',
      '@todo',
      '@verbatim',
      '@warning',
      '@xmlonly',
      '@~',
      '\\\\#',
      '\\\\$',
      '\\\\@',
      '\\\\\\\\',
      '\\\\arg',
      '\\\\attention',
      '\\\\author',
      '\\\\callgraph',
      '\\\\code',
      '\\\\dot',
      '\\\\else',
      '\\\\endcode',
      '\\\\enddot',
      '\\\\endhtmlonly',
      '\\\\endif',
      '\\\\endlatexonly',
      '\\\\endlink',
      '\\\\endmanonly',
      '\\\\endverbatim',
      '\\\\endxmlonly',
      '\\\\f$',
      '\\\\f[',
      '\\\\f]',
      '\\\\hideinitializer',
      '\\\\htmlonly',
      '\\\\interface',
      '\\\\internal',
      '\\\\invariant',
      '\\\\latexonly',
      '\\\\li',
      '\\\\manonly',
      '\\\\n',
      '\\\\nosubgrouping',
      '\\\\note',
      '\\\\only',
      '\\\\par',
      '\\\\post',
      '\\\\pre',
      '\\\\remarks',
      '\\\\return',
      '\\\\returns',
      '\\\\sa',
      '\\\\see',
      '\\\\showinitializer',
      '\\\\since',
      '\\\\test',
      '\\\\todo',
      '\\\\verbatim',
      '\\\\warning',
      '\\\\xmlonly',
      '\\\\~',
   );
   $self->listAdd('TagString',
      '@addindex',
      '@brief',
      '@bug',
      '@date',
      '@deprecated',
      '@fn',
      '@ingroup',
      '@line',
      '@mainpage',
      '@name',
      '@overload',
      '@short',
      '@skip',
      '@skipline',
      '@typedef',
      '@until',
      '@var',
      '\\\\addindex',
      '\\\\brief',
      '\\\\bug',
      '\\\\date',
      '\\\\deprecated',
      '\\\\fn',
      '\\\\ingroup',
      '\\\\line',
      '\\\\mainpage',
      '\\\\name',
      '\\\\overload',
      '\\\\short',
      '\\\\skip',
      '\\\\skipline',
      '\\\\typedef',
      '\\\\until',
      '\\\\var',
   );
   $self->listAdd('TagWord',
      '@a',
      '@addtogroup',
      '@anchor',
      '@b',
      '@c',
      '@class',
      '@copydoc',
      '@def',
      '@dontinclude',
      '@dotfile',
      '@e',
      '@elseif',
      '@em',
      '@enum',
      '@example',
      '@exception',
      '@exceptions',
      '@file',
      '@htmlinclude',
      '@if',
      '@ifnot',
      '@include',
      '@link',
      '@namespace',
      '@p',
      '@package',
      '@param',
      '@ref',
      '@relates',
      '@relatesalso',
      '@retval',
      '@throw',
      '@throws',
      '@verbinclude',
      '@version',
      '@xrefitem',
      '\\\\a',
      '\\\\addtogroup',
      '\\\\anchor',
      '\\\\b',
      '\\\\c',
      '\\\\class',
      '\\\\copydoc',
      '\\\\def',
      '\\\\dontinclude',
      '\\\\dotfile',
      '\\\\e',
      '\\\\elseif',
      '\\\\em',
      '\\\\enum',
      '\\\\example',
      '\\\\exception',
      '\\\\exceptions',
      '\\\\file',
      '\\\\htmlinclude',
      '\\\\if',
      '\\\\ifnot',
      '\\\\include',
      '\\\\link',
      '\\\\namespace',
      '\\\\p',
      '\\\\package',
      '\\\\param',
      '\\\\ref',
      '\\\\relates',
      '\\\\relatesalso',
      '\\\\retval',
      '\\\\throw',
      '\\\\throws',
      '\\\\verbinclude',
      '\\\\version',
      '\\\\xrefitem',
   );
   $self->listAdd('TagWordString',
      '@defgroup',
      '@page',
      '@paragraph',
      '@section',
      '@struct',
      '@subsection',
      '@subsubsection',
      '@union',
      '@weakgroup',
      '\\\\defgroup',
      '\\\\page',
      '\\\\paragraph',
      '\\\\section',
      '\\\\struct',
      '\\\\subsection',
      '\\\\subsubsection',
      '\\\\union',
      '\\\\weakgroup',
   );
   $self->listAdd('TagWordWord',
      '@image',
      '\\\\image',
   );
   $self->contextdata({
      'BlockComment' => {
         callback => \&parseBlockComment,
         attribute => 'Comment',
      },
      'LineComment' => {
         callback => \&parseLineComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'ML_Tag2ndWord' => {
         callback => \&parseML_Tag2ndWord,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'ML_TagString' => {
         callback => \&parseML_TagString,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'ML_TagWord' => {
         callback => \&parseML_TagWord,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'ML_TagWordString' => {
         callback => \&parseML_TagWordString,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'ML_TagWordWord' => {
         callback => \&parseML_TagWordWord,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'ML_htmlcomment' => {
         callback => \&parseML_htmlcomment,
         attribute => 'HTML Comment',
      },
      'ML_htmltag' => {
         callback => \&parseML_htmltag,
         attribute => 'Identifier',
      },
      'ML_identifiers' => {
         callback => \&parseML_identifiers,
         attribute => 'Identifier',
      },
      'ML_types1' => {
         callback => \&parseML_types1,
         attribute => 'Types',
      },
      'ML_types2' => {
         callback => \&parseML_types2,
         attribute => 'Types',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'SL_Tag2ndWord' => {
         callback => \&parseSL_Tag2ndWord,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'SL_TagString' => {
         callback => \&parseSL_TagString,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'SL_TagWord' => {
         callback => \&parseSL_TagWord,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'SL_TagWordString' => {
         callback => \&parseSL_TagWordString,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'SL_TagWordWord' => {
         callback => \&parseSL_TagWordWord,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'SL_htmlcomment' => {
         callback => \&parseSL_htmlcomment,
         attribute => 'HTML Comment',
         lineending => '#pop',
      },
      'SL_htmltag' => {
         callback => \&parseSL_htmltag,
         attribute => 'Identifier',
         lineending => '#pop',
      },
      'SL_identifiers' => {
         callback => \&parseSL_identifiers,
         attribute => 'Identifier',
         lineending => '#pop',
      },
      'SL_types1' => {
         callback => \&parseSL_types1,
         attribute => 'Types',
         lineending => '#pop',
      },
      'SL_types2' => {
         callback => \&parseSL_types2,
         attribute => 'Types',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\\\|\\$|\\~');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Doxygen';
}

sub parseBlockComment {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'BlockComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # String => 'TagOnly'
   # attribute => 'Tags'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagOnly', 0, undef, 0, '#stay', 'Tags')) {
      return 1
   }
   # String => 'TagWord'
   # attribute => 'Tags'
   # context => 'ML_TagWord'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagWord', 0, undef, 0, 'ML_TagWord', 'Tags')) {
      return 1
   }
   # String => 'TagWordWord'
   # attribute => 'Tags'
   # context => 'ML_TagWordWord'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagWordWord', 0, undef, 0, 'ML_TagWordWord', 'Tags')) {
      return 1
   }
   # String => 'TagString'
   # attribute => 'Tags'
   # context => 'ML_TagString'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagString', 0, undef, 0, 'ML_TagString', 'Tags')) {
      return 1
   }
   # String => 'TagWordString'
   # attribute => 'Tags'
   # context => 'ML_TagWordString'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagWordString', 0, undef, 0, 'ML_TagWordString', 'Tags')) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\\(<|>)'
   # attribute => 'Tags'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\(<|>)', 0, 0, 0, undef, 0, '#stay', 'Tags')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '<'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '<\s*\/?\s*[a-zA-Z_:][a-zA-Z0-9._:-]*'
   # attribute => 'HTML Tag'
   # context => 'ML_htmltag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*[a-zA-Z_:][a-zA-Z0-9._:-]*', 0, 0, 0, undef, 0, 'ML_htmltag', 'HTML Tag')) {
      return 1
   }
   # String => '<!--'
   # attribute => 'HTML Comment'
   # context => 'ML_htmlcomment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'ML_htmlcomment', 'HTML Comment')) {
      return 1
   }
   return 0;
};

sub parseLineComment {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # String => 'TagOnly'
   # attribute => 'Tags'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagOnly', 0, undef, 0, '#stay', 'Tags')) {
      return 1
   }
   # String => 'TagWord'
   # attribute => 'Tags'
   # context => 'SL_TagWord'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagWord', 0, undef, 0, 'SL_TagWord', 'Tags')) {
      return 1
   }
   # String => 'TagWordWord'
   # attribute => 'Tags'
   # context => 'SL_TagWordWord'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagWordWord', 0, undef, 0, 'SL_TagWordWord', 'Tags')) {
      return 1
   }
   # String => 'TagString'
   # attribute => 'Tags'
   # context => 'SL_TagString'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagString', 0, undef, 0, 'SL_TagString', 'Tags')) {
      return 1
   }
   # String => 'TagWordString'
   # attribute => 'Tags'
   # context => 'SL_TagWordString'
   # type => 'keyword'
   if ($self->testKeyword($text, 'TagWordString', 0, undef, 0, 'SL_TagWordString', 'Tags')) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '<!--'
   # attribute => 'HTML Comment'
   # context => 'SL_htmlcomment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'SL_htmlcomment', 'HTML Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '<'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '<\s*\/?\s*[a-zA-Z_:][a-zA-Z0-9._:-]*'
   # attribute => 'HTML Tag'
   # context => 'SL_htmltag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*[a-zA-Z_:][a-zA-Z0-9._:-]*', 0, 0, 0, undef, 0, 'SL_htmltag', 'HTML Tag')) {
      return 1
   }
   return 0;
};

sub parseML_Tag2ndWord {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseML_TagString {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # String => '<!--'
   # attribute => 'HTML Comment'
   # context => 'ML_htmlcomment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'ML_htmlcomment', 'HTML Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '<'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '<\s*\/?\s*[a-zA-Z_:][a-zA-Z0-9._:-]*'
   # attribute => 'HTML Tag'
   # context => 'ML_htmltag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*[a-zA-Z_:][a-zA-Z0-9._:-]*', 0, 0, 0, undef, 0, 'ML_htmltag', 'HTML Tag')) {
      return 1
   }
   # String => '.'
   # attribute => 'Description'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 0, undef, 0, '#stay', 'Description')) {
      return 1
   }
   return 0;
};

sub parseML_TagWord {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseML_TagWordString {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseML_TagWordWord {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseML_htmlcomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
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

sub parseML_htmltag {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
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
   # String => '\s*=\s*'
   # attribute => 'Identifier'
   # context => 'ML_identifiers'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'ML_identifiers', 'Identifier')) {
      return 1
   }
   return 0;
};

sub parseML_identifiers {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # String => '\s*#?[a-zA-Z0-9]*'
   # attribute => 'String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*#?[a-zA-Z0-9]*', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # attribute => 'Types'
   # char => '''
   # context => 'ML_types1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'ML_types1', 'Types')) {
      return 1
   }
   # attribute => 'Types'
   # char => '"'
   # context => 'ML_types2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'ML_types2', 'Types')) {
      return 1
   }
   return 0;
};

sub parseML_types1 {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
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

sub parseML_types2 {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 1, undef, 0, '#pop', 'Comment')) {
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

sub parseNormal {
   my ($self, $text) = @_;
   # String => '//(!|(/(?=[^/]|$)))<?'
   # attribute => 'Comment'
   # context => 'LineComment'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//(!|(/(?=[^/]|$)))<?', 0, 0, 0, undef, 0, 'LineComment', 'Comment')) {
      return 1
   }
   # String => '/\*(\*[^*/]|!|\*$)<?'
   # attribute => 'Comment'
   # beginRegion => 'BlockComment'
   # context => 'BlockComment'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '/\\*(\\*[^*/]|!|\\*$)<?', 0, 0, 0, undef, 0, 'BlockComment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseSL_Tag2ndWord {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseSL_TagString {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '<!--'
   # attribute => 'HTML Comment'
   # context => 'SL_htmlcomment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'SL_htmlcomment', 'HTML Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '<'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '<\s*\/?\s*[a-zA-Z_:][a-zA-Z0-9._:-]*'
   # attribute => 'HTML Tag'
   # context => 'SL_htmltag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*[a-zA-Z_:][a-zA-Z0-9._:-]*', 0, 0, 0, undef, 0, 'SL_htmltag', 'HTML Tag')) {
      return 1
   }
   # String => '.'
   # attribute => 'Description'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 0, undef, 0, '#stay', 'Description')) {
      return 1
   }
   return 0;
};

sub parseSL_TagWord {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseSL_TagWordString {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseSL_TagWordWord {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S\s'
   # attribute => 'Word'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S\\s', 0, 0, 0, undef, 0, '#pop', 'Word')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Word'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Word')) {
      return 1
   }
   return 0;
};

sub parseSL_htmlcomment {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
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

sub parseSL_htmltag {
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
   # String => '\s*=\s*'
   # attribute => 'Identifier'
   # context => 'SL_identifiers'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'SL_identifiers', 'Identifier')) {
      return 1
   }
   return 0;
};

sub parseSL_identifiers {
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
   # context => 'SL_types1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'SL_types1', 'Types')) {
      return 1
   }
   # attribute => 'Types'
   # char => '"'
   # context => 'SL_types2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'SL_types2', 'Types')) {
      return 1
   }
   return 0;
};

sub parseSL_types1 {
   my ($self, $text) = @_;
   # attribute => 'Types'
   # char => '''
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   return 0;
};

sub parseSL_types2 {
   my ($self, $text) = @_;
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

Syntax::Highlight::Engine::Kate::Doxygen - a Plugin for Doxygen syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Doxygen;
 my $sh = new Syntax::Highlight::Engine::Kate::Doxygen([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Doxygen is a  plugin module that provides syntax highlighting
for Doxygen to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author