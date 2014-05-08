# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'xslt.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.1
#kate author Peter Lammich (views@gmx.de)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Xslt;

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
      'Attribute' => 'Others',
      'Attribute Value' => 'BaseN',
      'Comment' => 'Comment',
      'Entity Reference' => 'Char',
      'Invalid' => 'Error',
      'Normal Text' => 'Normal',
      'Tag' => 'Keyword',
      'Variable' => 'Variable',
      'XPath' => 'Others',
      'XPath 2.0/ XSLT 2.0 Function' => 'Operator',
      'XPath Attribute' => 'Float',
      'XPath Axis' => 'DecVal',
      'XPath String' => 'BaseN',
      'XPath/ XSLT Function' => 'Function',
      'XSLT 2.0 Tag' => 'Reserved',
      'XSLT Tag' => 'Reserved',
   });
   $self->listAdd('functions',
      'boolean',
      'ceiling',
      'concat',
      'contains',
      'count',
      'current',
      'document',
      'element-available',
      'false',
      'floor',
      'format-number',
      'function-available',
      'generate-id',
      'id',
      'key',
      'lang',
      'last',
      'local-name',
      'name',
      'namespace-uri',
      'normalize-space',
      'not',
      'number',
      'position',
      'round',
      'starts-with',
      'string',
      'string-length',
      'substring',
      'substring-after',
      'substring-before',
      'sum',
      'system-property',
      'text',
      'translate',
      'true',
      'unparsed-entity-uri',
   );
   $self->listAdd('functions_2.0',
      'QName',
      'abs',
      'adjust-date-to-timezone',
      'adjust-dateTime-to-timezone',
      'adjust-time-to-timezone',
      'avg',
      'base-uri',
      'codepoints-to-string',
      'collection',
      'compare',
      'current-date',
      'current-dateTime',
      'current-group',
      'current-grouping-key',
      'current-time',
      'data',
      'dateTime',
      'day-from-date',
      'day-from-dateTime',
      'days-from-duration',
      'deep-equal',
      'default-collation',
      'distinct-values',
      'doc',
      'document-uri',
      'empty',
      'ends-with',
      'error',
      'escape-uri',
      'exactly-one',
      'exists',
      'expanded-QName',
      'format-date',
      'format-dateTime',
      'format-time',
      'hours-from-dateTime',
      'hours-from-duration',
      'hours-from-time',
      'idref',
      'implicit-timezone',
      'in-scope-prefixes',
      'index-of',
      'input',
      'insert-before',
      'local-name-from-QName',
      'lower-case',
      'matches',
      'max',
      'min',
      'minutes-from-dateTime',
      'minutes-from-duration',
      'minutes-from-time',
      'month-from-date',
      'month-from-dateTime',
      'months-from-duration',
      'namespace-uri-for-prefix',
      'namespace-uri-from-QName',
      'node-kind',
      'node-name',
      'normalize-unicode',
      'one-or-more',
      'regex-group',
      'remove',
      'replace',
      'resolve-QName',
      'resolve-uri',
      'reverse',
      'root',
      'round-half-to-even',
      'seconds-from-dateTime',
      'seconds-from-duration',
      'seconds-from-time',
      'sequence-node-identical',
      'static-base-uri',
      'string-join',
      'string-to-codepoints',
      'subsequence',
      'subtract-dateTimes-yielding-dayTimeDuration',
      'subtract-dateTimes-yielding-yearMonthDuration',
      'subtract-dates-yielding-dayTimeDuration',
      'subtract-dates-yielding-yearMonthDuration',
      'timezone-from-date',
      'timezone-from-dateTime',
      'timezone-from-time',
      'tokenize',
      'trace',
      'unordered',
      'unparsed-entity-public-id',
      'unparsed-text',
      'upper-case',
      'year-from-date',
      'year-from-dateTime',
      'years-from-duration',
      'zero-or-one',
   );
   $self->listAdd('keytags',
      'xsl:apply-imports',
      'xsl:apply-templates',
      'xsl:attribute',
      'xsl:attribute-set',
      'xsl:call-template',
      'xsl:choose',
      'xsl:comment',
      'xsl:copy',
      'xsl:copy-of',
      'xsl:decimal-format',
      'xsl:element',
      'xsl:fallback',
      'xsl:for-each',
      'xsl:if',
      'xsl:import',
      'xsl:include',
      'xsl:key',
      'xsl:message',
      'xsl:namespace-alias',
      'xsl:number',
      'xsl:otherwise',
      'xsl:output',
      'xsl:param',
      'xsl:preserve-space',
      'xsl:processing-instruction',
      'xsl:sort',
      'xsl:strip-space',
      'xsl:stylesheet',
      'xsl:template',
      'xsl:text',
      'xsl:transform',
      'xsl:value-of',
      'xsl:variable',
      'xsl:when',
      'xsl:with-param',
   );
   $self->listAdd('keytags_2.0',
      'xsl:analyze-string',
      'xsl:character-map',
      'xsl:document',
      'xsl:for-each-group',
      'xsl:function',
      'xsl:import-schema',
      'xsl:matching-substring',
      'xsl:namespace',
      'xsl:next-match',
      'xsl:non-matching-substring',
      'xsl:output-character',
      'xsl:perform-sort',
      'xsl:result-document',
      'xsl:sequence',
   );
   $self->contextdata({
      'attrValue' => {
         callback => \&parseattrValue,
         attribute => 'Invalid',
      },
      'attributes' => {
         callback => \&parseattributes,
         attribute => 'Attribute',
      },
      'comment' => {
         callback => \&parsecomment,
         attribute => 'Comment',
      },
      'detectEntRef' => {
         callback => \&parsedetectEntRef,
         attribute => 'Normal Text',
      },
      'normalText' => {
         callback => \&parsenormalText,
         attribute => 'Normal Text',
      },
      'sqstring' => {
         callback => \&parsesqstring,
         attribute => 'Attribute Value',
      },
      'sqxpath' => {
         callback => \&parsesqxpath,
         attribute => 'XPath',
      },
      'sqxpathstring' => {
         callback => \&parsesqxpathstring,
         attribute => 'XPath String',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'Attribute Value',
      },
      'tagname' => {
         callback => \&parsetagname,
         attribute => 'Tag',
      },
      'xattrValue' => {
         callback => \&parsexattrValue,
         attribute => 'Invalid',
      },
      'xattributes' => {
         callback => \&parsexattributes,
         attribute => 'Attribute',
      },
      'xpath' => {
         callback => \&parsexpath,
         attribute => 'XPath',
      },
      'xpathstring' => {
         callback => \&parsexpathstring,
         attribute => 'XPath String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|\\!|\\+|,|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|-|:');
   $self->basecontext('normalText');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'xslt';
}

sub parseattrValue {
   my ($self, $text) = @_;
   # attribute => 'Invalid'
   # char => '/'
   # char1 => '>'
   # context => '#pop#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Invalid')) {
      return 1
   }
   # attribute => 'Invalid'
   # char => '>'
   # context => '#pop#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Invalid')) {
      return 1
   }
   # attribute => 'Attribute Value'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'Attribute Value')) {
      return 1
   }
   # attribute => 'Attribute Value'
   # char => '''
   # context => 'sqstring'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'sqstring', 'Attribute Value')) {
      return 1
   }
   return 0;
};

sub parseattributes {
   my ($self, $text) = @_;
   # attribute => 'Tag'
   # char => '/'
   # char1 => '>'
   # context => '#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop#pop', 'Tag')) {
      return 1
   }
   # attribute => 'Tag'
   # char => '>'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop#pop', 'Tag')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Normal Text'
   # context => 'attrValue'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'attrValue', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parsecomment {
   my ($self, $text) = @_;
   # String => '-->'
   # attribute => 'Comment'
   # context => '#pop'
   # endRegion => 'comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '-->', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # String => '-(-(?!->))+'
   # attribute => 'Invalid'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-(-(?!->))+', 0, 0, 0, undef, 0, '#stay', 'Invalid')) {
      return 1
   }
   # String => '(FIXME|TODO|HACK)'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(FIXME|TODO|HACK)', 0, 0, 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   return 0;
};

sub parsedetectEntRef {
   my ($self, $text) = @_;
   # String => '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\w.:_-]*);'
   # attribute => 'Entity Reference'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\\w.:_-]*);', 0, 0, 0, undef, 0, '#stay', 'Entity Reference')) {
      return 1
   }
   return 0;
};

sub parsenormalText {
   my ($self, $text) = @_;
   # String => '<!--'
   # attribute => 'Comment'
   # beginRegion => 'comment'
   # context => 'comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'Tag'
   # char => '<'
   # context => 'tagname'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, 'tagname', 'Tag')) {
      return 1
   }
   # String => '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\w.:_-]*);'
   # attribute => 'Entity Reference'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\\w.:_-]*);', 0, 0, 0, undef, 0, '#stay', 'Entity Reference')) {
      return 1
   }
   return 0;
};

sub parsesqstring {
   my ($self, $text) = @_;
   # attribute => 'XPath'
   # char => '{'
   # context => 'sqxpath'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'sqxpath', 'XPath')) {
      return 1
   }
   # attribute => 'Attribute Value'
   # char => '''
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop', 'Attribute Value')) {
      return 1
   }
   # context => 'detectEntRef'
   # type => 'IncludeRules'
   if ($self->includeRules('detectEntRef', $text)) {
      return 1
   }
   return 0;
};

sub parsesqxpath {
   my ($self, $text) = @_;
   # String => 'functions'
   # attribute => 'XPath/ XSLT Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'XPath/ XSLT Function')) {
      return 1
   }
   # String => 'functions_2.0'
   # attribute => 'XPath 2.0/ XSLT 2.0 Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions_2.0', 0, undef, 0, '#stay', 'XPath 2.0/ XSLT 2.0 Function')) {
      return 1
   }
   # String => '(ancestor|ancestor-or-self|attribute|child|descendant|descendant-or-self|following|following-sibling|namespace|parent|preceding|preceding-sibling|self)::'
   # attribute => 'XPath Axis'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(ancestor|ancestor-or-self|attribute|child|descendant|descendant-or-self|following|following-sibling|namespace|parent|preceding|preceding-sibling|self)::', 0, 0, 0, undef, 0, '#stay', 'XPath Axis')) {
      return 1
   }
   # attribute => 'XPath'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'XPath')) {
      return 1
   }
   # attribute => 'XPath String'
   # char => '"'
   # context => 'xpathstring'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'xpathstring', 'XPath String')) {
      return 1
   }
   # attribute => 'XPath'
   # char => '''
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop', 'XPath')) {
      return 1
   }
   # String => '@[A-Za-z_:][\w.:_-]*'
   # attribute => 'XPath Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '@[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, '#stay', 'XPath Attribute')) {
      return 1
   }
   # String => '\$[A-Za-z_:][\w.:_-]*'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => '[A-Za-z_:][\w.:_-]*'
   # attribute => 'XPath'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, '#stay', 'XPath')) {
      return 1
   }
   # attribute => 'Invalid'
   # char => '$'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, '#stay', 'Invalid')) {
      return 1
   }
   # context => 'detectEntRef'
   # type => 'IncludeRules'
   if ($self->includeRules('detectEntRef', $text)) {
      return 1
   }
   return 0;
};

sub parsesqxpathstring {
   my ($self, $text) = @_;
   # attribute => 'XPath String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'XPath String')) {
      return 1
   }
   # context => 'detectEntRef'
   # type => 'IncludeRules'
   if ($self->includeRules('detectEntRef', $text)) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # attribute => 'XPath'
   # char => '{'
   # context => 'xpath'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'xpath', 'XPath')) {
      return 1
   }
   # attribute => 'Attribute Value'
   # char => '"'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop#pop', 'Attribute Value')) {
      return 1
   }
   # context => 'detectEntRef'
   # type => 'IncludeRules'
   if ($self->includeRules('detectEntRef', $text)) {
      return 1
   }
   return 0;
};

sub parsetagname {
   my ($self, $text) = @_;
   # String => 'keytags'
   # attribute => 'XSLT Tag'
   # context => 'xattributes'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keytags', 0, undef, 0, 'xattributes', 'XSLT Tag')) {
      return 1
   }
   # String => 'keytags_2.0'
   # attribute => 'XSLT 2.0 Tag'
   # context => 'xattributes'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keytags_2.0', 0, undef, 0, 'xattributes', 'XSLT 2.0 Tag')) {
      return 1
   }
   # String => '\s*'
   # attribute => 'Attribute'
   # context => 'attributes'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*', 0, 0, 0, undef, 0, 'attributes', 'Attribute')) {
      return 1
   }
   # attribute => 'Tag'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Tag')) {
      return 1
   }
   return 0;
};

sub parsexattrValue {
   my ($self, $text) = @_;
   # attribute => 'Invalid'
   # char => '/'
   # char1 => '>'
   # context => '#pop#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Invalid')) {
      return 1
   }
   # attribute => 'Invalid'
   # char => '>'
   # context => '#pop#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Invalid')) {
      return 1
   }
   # attribute => 'XPath'
   # char => '"'
   # context => 'xpath'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'xpath', 'XPath')) {
      return 1
   }
   # attribute => 'XPath'
   # char => '''
   # context => 'sqxpath'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'sqxpath', 'XPath')) {
      return 1
   }
   return 0;
};

sub parsexattributes {
   my ($self, $text) = @_;
   # attribute => 'Tag'
   # char => '/'
   # char1 => '>'
   # context => '#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop#pop', 'Tag')) {
      return 1
   }
   # attribute => 'Tag'
   # char => '>'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop#pop', 'Tag')) {
      return 1
   }
   # String => 'select\s*=\s*'
   # attribute => 'Attribute'
   # context => 'xattrValue'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'select\\s*=\\s*', 0, 0, 0, undef, 0, 'xattrValue', 'Attribute')) {
      return 1
   }
   # String => 'test\s*=\s*'
   # attribute => 'Attribute'
   # context => 'xattrValue'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'test\\s*=\\s*', 0, 0, 0, undef, 0, 'xattrValue', 'Attribute')) {
      return 1
   }
   # String => 'match\s*=\s*'
   # attribute => 'Attribute'
   # context => 'xattrValue'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'match\\s*=\\s*', 0, 0, 0, undef, 0, 'xattrValue', 'Attribute')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Attribute'
   # context => 'attrValue'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'attrValue', 'Attribute')) {
      return 1
   }
   return 0;
};

sub parsexpath {
   my ($self, $text) = @_;
   # String => 'functions'
   # attribute => 'XPath/ XSLT Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'XPath/ XSLT Function')) {
      return 1
   }
   # String => 'functions_2.0'
   # attribute => 'XPath 2.0/ XSLT 2.0 Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions_2.0', 0, undef, 0, '#stay', 'XPath 2.0/ XSLT 2.0 Function')) {
      return 1
   }
   # String => '(ancestor|ancestor-or-self|attribute|child|descendant|descendant-or-self|following|following-sibling|namespace|parent|preceding|preceding-sibling|self)::'
   # attribute => 'XPath Axis'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(ancestor|ancestor-or-self|attribute|child|descendant|descendant-or-self|following|following-sibling|namespace|parent|preceding|preceding-sibling|self)::', 0, 0, 0, undef, 0, '#stay', 'XPath Axis')) {
      return 1
   }
   # attribute => 'XPath'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'XPath')) {
      return 1
   }
   # attribute => 'XPath String'
   # char => '''
   # context => 'sqxpathstring'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'sqxpathstring', 'XPath String')) {
      return 1
   }
   # attribute => 'XPath'
   # char => '"'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop#pop', 'XPath')) {
      return 1
   }
   # String => '@[A-Za-z_:][\w.:_-]*'
   # attribute => 'XPath Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '@[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, '#stay', 'XPath Attribute')) {
      return 1
   }
   # String => '\$[A-Za-z_:][\w.:_-]*'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => '[A-Za-z_:][\w.:_-]*'
   # attribute => 'XPath'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, '#stay', 'XPath')) {
      return 1
   }
   # attribute => 'Invalid'
   # char => '$'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, '#stay', 'Invalid')) {
      return 1
   }
   # context => 'detectEntRef'
   # type => 'IncludeRules'
   if ($self->includeRules('detectEntRef', $text)) {
      return 1
   }
   return 0;
};

sub parsexpathstring {
   my ($self, $text) = @_;
   # attribute => 'XPath String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'XPath String')) {
      return 1
   }
   # context => 'detectEntRef'
   # type => 'IncludeRules'
   if ($self->includeRules('detectEntRef', $text)) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Xslt - a Plugin for xslt syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Xslt;
 my $sh = new Syntax::Highlight::Engine::Kate::Xslt([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Xslt is a  plugin module that provides syntax highlighting
for xslt to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author