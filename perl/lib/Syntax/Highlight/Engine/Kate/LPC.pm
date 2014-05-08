# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'lpc.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.76
#kate version 2.4
#kate author Andreas Klauer (Andreas.Klauer@metamorpher.de)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::LPC;

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
      'Binary' => 'BaseN',
      'Char' => 'Char',
      'Closure' => 'Others',
      'Datatype' => 'DataType',
      'Default' => 'Normal',
      'Floats' => 'Float',
      'Hexadecimal' => 'BaseN',
      'Integer' => 'DecVal',
      'Keywords' => 'Keyword',
      'Modifier' => 'DataType',
      'Multi-Line comments' => 'Comment',
      'Octal' => 'BaseN',
      'Preprocessor' => 'Others',
      'Preprocessor-Strings' => 'String',
      'Region Marker' => 'RegionMarker',
      'Single-Line comments' => 'Comment',
      'Strings' => 'String',
   });
   $self->listAdd('attention',
      '###',
      'FIXME',
      'HACK',
      'NOTE',
      'NOTICE',
      'TODO',
      'WARNING',
   );
   $self->listAdd('keywords',
      'break',
      'case',
      'continue',
      'default',
      'do',
      'else',
      'for',
      'foreach',
      'functions',
      'if',
      'inherit',
      'nolog',
      'publish',
      'return',
      'switch',
      'variables',
      'while',
   );
   $self->listAdd('modifiers',
      'nomask',
      'nosave',
      'private',
      'protected',
      'public',
      'static',
      'varargs',
      'virtual',
   );
   $self->listAdd('types',
      'array',
      'closure',
      'float',
      'int',
      'mapping',
      'mixed',
      'object',
      'status',
      'string',
      'symbol',
      'void',
   );
   $self->contextdata({
      'Comment1' => {
         callback => \&parseComment1,
         attribute => 'Single-Line comments',
         lineending => '#pop',
      },
      'Comment2' => {
         callback => \&parseComment2,
         attribute => 'Multi-Line comments',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Default',
      },
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'String1' => {
         callback => \&parseString1,
         attribute => 'Strings',
         lineending => '#pop',
      },
      'String2' => {
         callback => \&parseString2,
         attribute => 'Preprocessor-Strings',
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
   return 'LPC';
}

sub parseComment1 {
   my ($self, $text) = @_;
   # attribute => 'Single-Line comments'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Single-Line comments')) {
      return 1
   }
   # String => 'attention'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   return 0;
};

sub parseComment2 {
   my ($self, $text) = @_;
   # attribute => 'Multi-Line comments'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'blockComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Multi-Line comments')) {
      return 1
   }
   # String => 'attention'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '//\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'regionMarker'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '//\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'regionMarker'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Single-Line comments'
   # char => '/'
   # char1 => '/'
   # context => 'Comment1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Comment1', 'Single-Line comments')) {
      return 1
   }
   # attribute => 'Multi-Line comments'
   # beginRegion => 'blockComment'
   # char => '/'
   # char1 => '*'
   # context => 'Comment2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Comment2', 'Multi-Line comments')) {
      return 1
   }
   # String => 'modifiers'
   # attribute => 'Modifier'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'modifiers', 0, undef, 0, '#stay', 'Modifier')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Datatype'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Datatype')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keywords'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keywords')) {
      return 1
   }
   # attribute => 'Preprocessor'
   # char => '#'
   # column => '0'
   # context => 'Preprocessor'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, 0, 0, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   # attribute => 'Floats'
   # context => '#stay'
   # items => 'ARRAY(0x19c5720)'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Floats')) {
      # String => 'fFeE'
      # context => '#stay'
      # type => 'AnyChar'
      if ($self->testAnyChar($text, 'fFeE', 0, 0, undef, 0, '#stay', undef)) {
         return 1
      }
   }
   # String => '0b[01]+'
   # attribute => 'Binary'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0b[01]+', 0, 0, 0, undef, 0, '#stay', 'Binary')) {
      return 1
   }
   # String => '0x[0-9a-fA-F]+'
   # attribute => 'Hexadecimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0x[0-9a-fA-F]+', 0, 0, 0, undef, 0, '#stay', 'Hexadecimal')) {
      return 1
   }
   # String => '0o[0-7]+'
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0o[0-7]+', 0, 0, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # String => '#'[^\t ][^\t ,);}\]/]*'
   # attribute => 'Closure'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\'[^\\t ][^\\t ,);}\\]/]*', 0, 0, 0, undef, 0, '#stay', 'Closure')) {
      return 1
   }
   # attribute => 'Strings'
   # char => '"'
   # context => 'String1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String1', 'Strings')) {
      return 1
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Default'
   # beginRegion => 'brace'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Default')) {
      return 1
   }
   # attribute => 'Default'
   # char => '}'
   # context => '#stay'
   # endRegion => 'brace'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Default')) {
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
   # attribute => 'Single-Line comments'
   # char => '/'
   # char1 => '/'
   # context => 'Comment1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Comment1', 'Single-Line comments')) {
      return 1
   }
   # attribute => 'Multi-Line comments'
   # beginRegion => 'blockComment'
   # char => '/'
   # char1 => '*'
   # context => 'Comment2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Comment2', 'Multi-Line comments')) {
      return 1
   }
   # String => 'modifiers'
   # attribute => 'Modifier'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'modifiers', 0, undef, 0, '#stay', 'Modifier')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Datatype'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Datatype')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keywords'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keywords')) {
      return 1
   }
   # attribute => 'Preprocessor-Strings'
   # char => '"'
   # context => 'String2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String2', 'Preprocessor-Strings')) {
      return 1
   }
   return 0;
};

sub parseString1 {
   my ($self, $text) = @_;
   # attribute => 'Default'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Default')) {
      return 1
   }
   # attribute => 'Strings'
   # char => '\'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\\', 0, 0, 0, undef, 0, '#stay', 'Strings')) {
      return 1
   }
   # attribute => 'Strings'
   # char => '\'
   # char1 => '"'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '"', 0, 0, 0, undef, 0, '#stay', 'Strings')) {
      return 1
   }
   # attribute => 'Strings'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Strings')) {
      return 1
   }
   return 0;
};

sub parseString2 {
   my ($self, $text) = @_;
   # attribute => 'Default'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Default')) {
      return 1
   }
   # attribute => 'Preprocessor-Strings'
   # char => '\'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\\', 0, 0, 0, undef, 0, '#stay', 'Preprocessor-Strings')) {
      return 1
   }
   # attribute => 'Preprocessor-Strings'
   # char => '\'
   # char1 => '"'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '"', 0, 0, 0, undef, 0, '#stay', 'Preprocessor-Strings')) {
      return 1
   }
   # attribute => 'Preprocessor-Strings'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Preprocessor-Strings')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::LPC - a Plugin for LPC syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::LPC;
 my $sh = new Syntax::Highlight::Engine::Kate::LPC([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::LPC is a  plugin module that provides syntax highlighting
for LPC to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author