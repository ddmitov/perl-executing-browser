# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'latex.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.14
#kate version 2.4
#kate author Jeroen Wijnhout (Jeroen.Wijnhout@kdemail.net)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::LaTeX;

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
      'Environment' => 'DataType',
      'Keyword' => 'Keyword',
      'Keyword Mathmode' => 'Reserved',
      'Math' => 'Float',
      'Normal Text' => 'Normal',
      'Region Marker' => 'RegionMarker',
      'Structure' => 'String',
      'Verbatim' => 'BString',
   });
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'ContrSeq' => {
         callback => \&parseContrSeq,
         attribute => 'Keyword',
         lineending => '#pop',
      },
      'Environment' => {
         callback => \&parseEnvironment,
         attribute => 'Environment',
      },
      'FindEnvironment' => {
         callback => \&parseFindEnvironment,
         attribute => 'Normal Text',
      },
      'Label' => {
         callback => \&parseLabel,
         attribute => 'Normal Text',
         lineending => '#pop#pop',
         fallthrough => '#pop#pop',
      },
      'MathContrSeq' => {
         callback => \&parseMathContrSeq,
         attribute => 'Keyword Mathmode',
         lineending => '#pop',
      },
      'MathEnv' => {
         callback => \&parseMathEnv,
         attribute => 'Environment',
      },
      'MathFindEnd' => {
         callback => \&parseMathFindEnd,
         attribute => 'Normal Text',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'MathMode' => {
         callback => \&parseMathMode,
         attribute => 'Math',
      },
      'MathModeEnv' => {
         callback => \&parseMathModeEnv,
         attribute => 'Math',
      },
      'Normal Text' => {
         callback => \&parseNormalText,
         attribute => 'Normal Text',
      },
      'ToEndOfLine' => {
         callback => \&parseToEndOfLine,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'Verb' => {
         callback => \&parseVerb,
         attribute => 'Verbatim',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'VerbFindEnd' => {
         callback => \&parseVerbFindEnd,
         attribute => 'Normal Text',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Verbatim' => {
         callback => \&parseVerbatim,
         attribute => 'Verbatim',
      },
      'VerbatimEnv' => {
         callback => \&parseVerbatimEnv,
         attribute => 'Environment',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal Text');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'LaTeX';
}

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseContrSeq {
   my ($self, $text) = @_;
   # String => 'verb*'
   # attribute => 'Keyword'
   # context => 'Verb'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'verb*', 0, 0, 0, undef, 0, 'Verb', 'Keyword')) {
      return 1
   }
   # String => 'verb'
   # attribute => 'Keyword'
   # context => 'Verb'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'verb', 0, 0, 0, undef, 0, 'Verb', 'Keyword')) {
      return 1
   }
   # String => '[a-zA-Z]+'
   # attribute => 'Keyword'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z]+', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   # String => '[^a-zA-Z]'
   # attribute => 'Keyword'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^a-zA-Z]', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseEnvironment {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ']'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop#pop', 'Normal Text')) {
      return 1
   }
   # String => '(semiverbatim|verbatim|lstlisting|boxedverbatim|Verbatim)\*?'
   # attribute => 'Environment'
   # context => 'VerbatimEnv'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(semiverbatim|verbatim|lstlisting|boxedverbatim|Verbatim)\\*?', 0, 0, 0, undef, 0, 'VerbatimEnv', 'Environment')) {
      return 1
   }
   # String => '(equation|displaymath|eqnarray|subeqnarray|math|multline|gather|align|alignat|flalign)\*?'
   # attribute => 'Environment'
   # context => 'MathEnv'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(equation|displaymath|eqnarray|subeqnarray|math|multline|gather|align|alignat|flalign)\\*?', 0, 0, 0, undef, 0, 'MathEnv', 'Environment')) {
      return 1
   }
   return 0;
};

sub parseFindEnvironment {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '{'
   # context => 'Environment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'Environment', 'Normal Text')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Normal Text'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseLabel {
   my ($self, $text) = @_;
   # String => '\s*\{\s*'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*\\{\\s*', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '[^\}\{]+'
   # attribute => 'Environment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^\\}\\{]+', 0, 0, 0, undef, 0, '#stay', 'Environment')) {
      return 1
   }
   # String => '\s*\}\s*'
   # attribute => 'Normal Text'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*\\}\\s*', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseMathContrSeq {
   my ($self, $text) = @_;
   # String => '[a-zA-Z]+'
   # attribute => 'Keyword Mathmode'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z]+', 0, 0, 0, undef, 0, '#pop', 'Keyword Mathmode')) {
      return 1
   }
   # String => '[^a-zA-Z]'
   # attribute => 'Keyword Mathmode'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^a-zA-Z]', 0, 0, 0, undef, 0, '#pop', 'Keyword Mathmode')) {
      return 1
   }
   return 0;
};

sub parseMathEnv {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '}'
   # context => 'MathModeEnv'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, 'MathModeEnv', 'Normal Text')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Normal Text'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseMathFindEnd {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '[a-zA-Z]*(equation|displaymath|eqnarray|subeqnarray|math|multline|gather|align|alignat|flalign)\*?'
   # attribute => 'Environment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z]*(equation|displaymath|eqnarray|subeqnarray|math|multline|gather|align|alignat|flalign)\\*?', 0, 0, 0, undef, 0, '#stay', 'Environment')) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#pop#pop#pop#pop#pop'
   # endRegion => 'block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop#pop#pop#pop#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseMathMode {
   my ($self, $text) = @_;
   # attribute => 'Math'
   # char => '\'
   # char1 => ']'
   # context => '#pop'
   # endRegion => 'mathMode'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', ']', 0, 0, 0, undef, 0, '#pop', 'Math')) {
      return 1
   }
   # attribute => 'Math'
   # char => '\'
   # char1 => ')'
   # context => '#pop'
   # endRegion => 'mathMode'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', ')', 0, 0, 0, undef, 0, '#pop', 'Math')) {
      return 1
   }
   # String => '\\begin(?=[^a-zA-Z])'
   # attribute => 'Keyword Mathmode'
   # beginRegion => 'block'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\begin(?=[^a-zA-Z])', 0, 0, 0, undef, 0, '#stay', 'Keyword Mathmode')) {
      return 1
   }
   # String => '\\end(?=[^a-zA-Z])'
   # attribute => 'Keyword Mathmode'
   # context => '#stay'
   # endRegion => 'block'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\end(?=[^a-zA-Z])', 0, 0, 0, undef, 0, '#stay', 'Keyword Mathmode')) {
      return 1
   }
   # attribute => 'Keyword Mathmode'
   # char => '\'
   # context => 'MathContrSeq'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\\', 0, 0, 0, undef, 0, 'MathContrSeq', 'Keyword Mathmode')) {
      return 1
   }
   # String => '$$'
   # attribute => 'Math'
   # context => '#pop'
   # endRegion => 'mathMode'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '$$', 0, 0, 0, undef, 0, '#pop', 'Math')) {
      return 1
   }
   # attribute => 'Math'
   # char => '$'
   # context => '#pop'
   # endRegion => 'mathMode'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, '#pop', 'Math')) {
      return 1
   }
   # String => '%\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'regionMarker'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '%\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'regionMarker'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseMathModeEnv {
   my ($self, $text) = @_;
   # String => '\\end(?=\s*\{\s*[a-zA-Z]*(equation|displaymath|eqnarray|subeqnarray|math|multline|gather|align|alignat|flalign)\*?\s*\})'
   # attribute => 'Structure'
   # context => 'MathFindEnd'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\end(?=\\s*\\{\\s*[a-zA-Z]*(equation|displaymath|eqnarray|subeqnarray|math|multline|gather|align|alignat|flalign)\\*?\\s*\\})', 0, 0, 0, undef, 0, 'MathFindEnd', 'Structure')) {
      return 1
   }
   # String => '\\begin(?=[^a-zA-Z])'
   # attribute => 'Keyword Mathmode'
   # beginRegion => 'block'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\begin(?=[^a-zA-Z])', 0, 0, 0, undef, 0, '#stay', 'Keyword Mathmode')) {
      return 1
   }
   # String => '\\end(?=[^a-zA-Z])'
   # attribute => 'Keyword Mathmode'
   # context => '#stay'
   # endRegion => 'block'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\end(?=[^a-zA-Z])', 0, 0, 0, undef, 0, '#stay', 'Keyword Mathmode')) {
      return 1
   }
   # String => '\('
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # context => 'MathMode'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\(', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # String => '\['
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # context => 'MathMode'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\[', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # attribute => 'Keyword Mathmode'
   # char => '\'
   # context => 'MathContrSeq'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\\', 0, 0, 0, undef, 0, 'MathContrSeq', 'Keyword Mathmode')) {
      return 1
   }
   # String => '$$'
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # context => 'MathMode'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '$$', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # char => '$'
   # context => 'MathMode'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # String => '%\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'regionMarker'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '%\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'regionMarker'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseNormalText {
   my ($self, $text) = @_;
   # String => '\\begin(?=[^a-zA-Z])'
   # attribute => 'Structure'
   # beginRegion => 'block'
   # context => 'FindEnvironment'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\begin(?=[^a-zA-Z])', 0, 0, 0, undef, 0, 'FindEnvironment', 'Structure')) {
      return 1
   }
   # String => '\\end(?=[^a-zA-Z])'
   # attribute => 'Structure'
   # context => 'FindEnvironment'
   # endRegion => 'block'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\end(?=[^a-zA-Z])', 0, 0, 0, undef, 0, 'FindEnvironment', 'Structure')) {
      return 1
   }
   # String => '\\(label|pageref|ref|cite)(?=[^a-zA-Z])'
   # attribute => 'Structure'
   # context => 'Label'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\(label|pageref|ref|cite)(?=[^a-zA-Z])', 0, 0, 0, undef, 0, 'Label', 'Structure')) {
      return 1
   }
   # String => '\\(part|chapter|section|subsection|subsubsection|paragraph|subparagraph)(?=[^a-zA-Z])'
   # attribute => 'Structure'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\(part|chapter|section|subsection|subsubsection|paragraph|subparagraph)(?=[^a-zA-Z])', 0, 0, 0, undef, 0, '#stay', 'Structure')) {
      return 1
   }
   # String => '\renewcommand'
   # attribute => 'Keyword'
   # context => 'ToEndOfLine'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\renewcommand', 0, 0, 0, undef, 0, 'ToEndOfLine', 'Keyword')) {
      return 1
   }
   # String => '\newcommand'
   # attribute => 'Keyword'
   # context => 'ToEndOfLine'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\newcommand', 0, 0, 0, undef, 0, 'ToEndOfLine', 'Keyword')) {
      return 1
   }
   # String => '\('
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # context => 'MathMode'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\(', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # String => '\['
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # context => 'MathMode'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\[', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '\'
   # context => 'ContrSeq'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\\', 0, 0, 0, undef, 0, 'ContrSeq', 'Keyword')) {
      return 1
   }
   # String => '$$'
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # context => 'MathMode'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '$$', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # attribute => 'Math'
   # beginRegion => 'mathMode'
   # char => '$'
   # context => 'MathMode'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, 'MathMode', 'Math')) {
      return 1
   }
   # String => '%\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'regionMarker'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '%\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'regionMarker'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseToEndOfLine {
   my ($self, $text) = @_;
   return 0;
};

sub parseVerb {
   my ($self, $text) = @_;
   # String => '(.).*\1'
   # attribute => 'Verbatim'
   # context => '#pop#pop'
   # minimal => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(.).*?\\1', 0, 0, 0, undef, 0, '#pop#pop', 'Verbatim')) {
      return 1
   }
   return 0;
};

sub parseVerbFindEnd {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '(semiverbatim|verbatim|lstlisting|boxedverbatim|Verbatim)\*?'
   # attribute => 'Environment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(semiverbatim|verbatim|lstlisting|boxedverbatim|Verbatim)\\*?', 0, 0, 0, undef, 0, '#stay', 'Environment')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#pop#pop#pop#pop#pop'
   # endRegion => 'block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop#pop#pop#pop#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseVerbatim {
   my ($self, $text) = @_;
   # String => '\\end(?=\{(semiverbatim|verbatim|lstlisting|boxedverbatim|Verbatim)\*?\})'
   # attribute => 'Structure'
   # context => 'VerbFindEnd'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\end(?=\\{(semiverbatim|verbatim|lstlisting|boxedverbatim|Verbatim)\\*?\\})', 0, 0, 0, undef, 0, 'VerbFindEnd', 'Structure')) {
      return 1
   }
   return 0;
};

sub parseVerbatimEnv {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '*'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '*', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => 'Verbatim'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, 'Verbatim', 'Normal Text')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Normal Text'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::LaTeX - a Plugin for LaTeX syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::LaTeX;
 my $sh = new Syntax::Highlight::Engine::Kate::LaTeX([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::LaTeX is a  plugin module that provides syntax highlighting
for LaTeX to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author