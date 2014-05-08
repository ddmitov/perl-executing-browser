# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'cgis.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.4
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::CGiS;

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
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Hint' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('keywords',
      '1D',
      '2D',
      'break',
      'continue',
      'do',
      'else',
      'extern',
      'for',
      'forall',
      'foreach',
      'function',
      'if',
      'in',
      'inout',
      'internal',
      'out',
      'reduction',
      'return',
      'struct',
      'typedef',
      'while',
   );
   $self->listAdd('types',
      'bool',
      'bool2',
      'bool3',
      'bool4',
      'float',
      'float2',
      'float3',
      'float4',
      'half',
      'half2',
      'half3',
      'half4',
      'int',
      'int2',
      'int3',
      'int4',
   );
   $self->contextdata({
      'Code' => {
         callback => \&parseCode,
         attribute => 'Normal Text',
      },
      'Commentar 1' => {
         callback => \&parseCommentar1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Commentar 2' => {
         callback => \&parseCommentar2,
         attribute => 'Comment',
      },
      'Common' => {
         callback => \&parseCommon,
         attribute => 'Normal Text',
      },
      'Control' => {
         callback => \&parseControl,
         attribute => 'Normal Text',
      },
      'Hint' => {
         callback => \&parseHint,
         attribute => 'Hint',
      },
      'Interface' => {
         callback => \&parseInterface,
         attribute => 'Normal Text',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Region Marker' => {
         callback => \&parseRegionMarker,
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
   return 'CGiS';
}

sub parseCode {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => 'CONTROL'
   # attribute => 'Keyword'
   # context => 'Control'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CONTROL', 0, 0, 0, undef, 0, 'Control', 'Keyword')) {
      return 1
   }
   # String => '#HINT'
   # attribute => 'Hint'
   # context => 'Hint'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#HINT', 0, 0, 0, undef, 0, 'Hint', 'Hint')) {
      return 1
   }
   # context => 'Common'
   # type => 'IncludeRules'
   if ($self->includeRules('Common', $text)) {
      return 1
   }
   return 0;
};

sub parseCommentar1 {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseCommentar2 {
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
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseCommon {
   my ($self, $text) = @_;
   # String => '//BEGIN'
   # attribute => 'Region Marker'
   # beginRegion => 'Region1'
   # context => 'Region Marker'
   # firstNonSpace => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '//BEGIN', 0, 0, 0, undef, 1, 'Region Marker', 'Region Marker')) {
      return 1
   }
   # String => '//END'
   # attribute => 'Region Marker'
   # context => 'Region Marker'
   # endRegion => 'Region1'
   # firstNonSpace => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '//END', 0, 0, 0, undef, 1, 'Region Marker', 'Region Marker')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
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
   # attribute => 'Float'
   # context => '#stay'
   # items => 'ARRAY(0x11a5b70)'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      # String => 'fF'
      # attribute => 'Float'
      # context => '#stay'
      # type => 'AnyChar'
      if ($self->testAnyChar($text, 'fF', 0, 0, undef, 0, '#stay', 'Float')) {
         return 1
      }
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
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # context => '##Doxygen'
   # type => 'IncludeRules'
   if ($self->includePlugin('Doxygen', $text)) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseControl {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => 'CODE'
   # attribute => 'Keyword'
   # context => 'Code'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CODE', 0, 0, 0, undef, 0, 'Code', 'Keyword')) {
      return 1
   }
   # context => 'Common'
   # type => 'IncludeRules'
   if ($self->includeRules('Common', $text)) {
      return 1
   }
   return 0;
};

sub parseHint {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'Hint'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Hint')) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   return 0;
};

sub parseInterface {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => 'CONTROL'
   # attribute => 'Keyword'
   # context => 'Control'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CONTROL', 0, 0, 0, undef, 0, 'Control', 'Keyword')) {
      return 1
   }
   # String => 'CODE'
   # attribute => 'Keyword'
   # context => 'Code'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CODE', 0, 0, 0, undef, 0, 'Code', 'Keyword')) {
      return 1
   }
   # context => 'Common'
   # type => 'IncludeRules'
   if ($self->includeRules('Common', $text)) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => 'PROGRAM'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'PROGRAM', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'INTERFACE'
   # attribute => 'Keyword'
   # context => 'Interface'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'INTERFACE', 0, 0, 0, undef, 0, 'Interface', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseRegionMarker {
   my ($self, $text) = @_;
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::CGiS - a Plugin for CGiS syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::CGiS;
 my $sh = new Syntax::Highlight::Engine::Kate::CGiS([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::CGiS is a  plugin module that provides syntax highlighting
for CGiS to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author