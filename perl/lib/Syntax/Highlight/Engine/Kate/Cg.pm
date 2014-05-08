# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'cg.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.11
#kate version 2.4
#kate author Florian Schanda (florian.schanda@schanda.de)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Cg;

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
      'Binding' => 'Keyword',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Error' => 'Error',
      'Fixed' => 'Float',
      'Float' => 'Float',
      'Function' => 'Function',
      'Half' => 'Float',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'StdFunction' => 'Reserved',
      'Swizzle' => 'Operator',
      'Symbol' => 'Normal',
   });
   $self->listAdd('attention',
      'BUG',
      'FIXME',
      'TODO',
   );
   $self->listAdd('binding',
      'BCOL0',
      'BCOL1',
      'BINORMAL',
      'BLENDINDICES',
      'BLENDWEIGHT',
      'COLOR',
      'COLOR0',
      'COLOR1',
      'COLOR2',
      'COLOR3',
      'DEPTH',
      'FACE',
      'FOG',
      'FOGCOORD',
      'NORMAL',
      'POSITION',
      'PSIZE',
      'TANGENT',
      'TESSFACTOR',
      'TEXCOORD0',
      'TEXCOORD1',
      'TEXCOORD10',
      'TEXCOORD11',
      'TEXCOORD12',
      'TEXCOORD13',
      'TEXCOORD14',
      'TEXCOORD15',
      'TEXCOORD2',
      'TEXCOORD3',
      'TEXCOORD4',
      'TEXCOORD5',
      'TEXCOORD6',
      'TEXCOORD7',
      'TEXCOORD8',
      'TEXCOORD9',
      'TEXUNIT0',
      'TEXUNIT1',
      'TEXUNIT10',
      'TEXUNIT11',
      'TEXUNIT12',
      'TEXUNIT13',
      'TEXUNIT14',
      'TEXUNIT15',
      'TEXUNIT2',
      'TEXUNIT3',
      'TEXUNIT4',
      'TEXUNIT5',
      'TEXUNIT6',
      'TEXUNIT7',
      'TEXUNIT8',
      'TEXUNIT9',
      'WPOS',
   );
   $self->listAdd('keywords',
      'discard',
      'do',
      'else',
      'false',
      'for',
      'if',
      'return',
      'static',
      'struct',
      'true',
      'typedef',
      'while',
   );
   $self->listAdd('stdlib',
      'abs',
      'acos',
      'all',
      'any',
      'asin',
      'atan',
      'atan2',
      'ceil',
      'clamp',
      'cos',
      'cosh',
      'cross',
      'ddx',
      'ddy',
      'debug',
      'degrees',
      'determinant',
      'distance',
      'dot',
      'exp',
      'exp2',
      'faceforward',
      'floor',
      'fmod',
      'frac',
      'frexp',
      'isfinite',
      'isinf',
      'isnan',
      'ldexp',
      'length',
      'lerp',
      'lit',
      'log',
      'log10',
      'log2',
      'max',
      'min',
      'modf',
      'mul',
      'noise',
      'normalize',
      'pack_2half',
      'pack_2ushort',
      'pack_4byte',
      'pack_4ubyte',
      'pow',
      'radians',
      'reflect',
      'refract',
      'round',
      'rsqrt',
      'saturate',
      'sign',
      'sin',
      'sincos',
      'sinh',
      'smoothstep',
      'sqrt',
      'step',
      'tan',
      'tanh',
      'tex1D',
      'tex1Dproj',
      'tex2D',
      'tex2Dproj',
      'tex3D',
      'tex3Dproj',
      'texCUBE',
      'texCUBEproj',
      'texRECT',
      'texRECTproj',
      'transpose',
      'unpack_2half',
      'unpack_2ushort',
      'unpack_4byte',
      'unpack_4ubyte',
   );
   $self->listAdd('stdstruct',
      'fragout',
      'fragout_float',
   );
   $self->listAdd('types',
      'bool',
      'const',
      'fixed',
      'float',
      'half',
      'in',
      'inout',
      'int',
      'out',
      'packed',
      'sampler',
      'sampler1D',
      'sampler2D',
      'sampler3D',
      'samplerCUBE',
      'samplerRECT',
      'uniform',
      'void',
   );
   $self->contextdata({
      'Commentar 1' => {
         callback => \&parseCommentar1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Commentar 2' => {
         callback => \&parseCommentar2,
         attribute => 'Comment',
      },
      'Commentar/Preprocessor' => {
         callback => \&parseCommentarPreprocessor,
         attribute => 'Comment',
      },
      'Member' => {
         callback => \&parseMember,
         attribute => 'Normal Text',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Outscoped' => {
         callback => \&parseOutscoped,
         attribute => 'Comment',
      },
      'Outscoped intern' => {
         callback => \&parseOutscopedintern,
         attribute => 'Comment',
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
   return 'Cg';
}

sub parseCommentar1 {
   my ($self, $text) = @_;
   # String => 'attention'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Alert')) {
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
   # String => 'attention'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   return 0;
};

sub parseCommentarPreprocessor {
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
   return 0;
};

sub parseMember {
   my ($self, $text) = @_;
   # String => '\b[_\w][_\w\d]*(?=[\s]*)'
   # attribute => 'Function'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[_\\w][_\\w\\d]*(?=[\\s]*)', 0, 0, 0, undef, 0, '#pop', 'Function')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'binding'
   # attribute => 'Binding'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'binding', 0, undef, 0, '#stay', 'Binding')) {
      return 1
   }
   # String => 'attention'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Alert')) {
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
   # String => 'float[1234](x[1234])?'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'float[1234](x[1234])?', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'half[1234](x[1234])?'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'half[1234](x[1234])?', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'fixed[1234](x[1234])?'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'fixed[1234](x[1234])?', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'bool[1234](x[1234])?'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'bool[1234](x[1234])?', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'int[1234](x[1234])?'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'int[1234](x[1234])?', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'stdstruct'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'stdstruct', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '[0123456789]*[.][0123456789]+f'
   # attribute => 'Float'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0123456789]*[.][0123456789]+f', 0, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '[0123456789]*[.][0123456789]+h'
   # attribute => 'Half'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0123456789]*[.][0123456789]+h', 0, 0, 0, undef, 0, '#stay', 'Half')) {
      return 1
   }
   # String => '[0123456789]*[.][0123456789]+x'
   # attribute => 'Fixed'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0123456789]*[.][0123456789]+x', 0, 0, 0, undef, 0, '#stay', 'Fixed')) {
      return 1
   }
   # String => '[0123456789]*[.][0123456789]+'
   # attribute => 'Float'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0123456789]*[.][0123456789]+', 0, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
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
   # String => 'stdlib'
   # attribute => 'StdFunction'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'stdlib', 0, undef, 0, '#stay', 'StdFunction')) {
      return 1
   }
   # String => '\b[_\w][_\w\d]*(?=[\s]*[(])'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[_\\w][_\\w\\d]*(?=[\\s]*[(])', 0, 0, 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => '[.]{1,1}[rgbaxyzw]+(?=[\s/*-+<>])'
   # attribute => 'Swizzle'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[.]{1,1}[rgbaxyzw]+(?=[\\s/*-+<>])', 0, 0, 0, undef, 0, '#stay', 'Swizzle')) {
      return 1
   }
   # String => '[.]{1,1}'
   # attribute => 'Symbol'
   # context => 'Member'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[.]{1,1}', 0, 0, 0, undef, 0, 'Member', 'Symbol')) {
      return 1
   }
   # String => ':!%&()+,-/.*<=>?[]|~^;'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':!%&()+,-/.*<=>?[]|~^;', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseOutscoped {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # String => 'attention'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   # String => '#\s*if'
   # attribute => 'Comment'
   # beginRegion => 'Outscoped'
   # context => 'Outscoped intern'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*if', 0, 0, 0, undef, 1, 'Outscoped intern', 'Comment')) {
      return 1
   }
   # String => '#\s*(endif|else|elif)'
   # attribute => 'Preprocessor'
   # context => '#pop'
   # endRegion => 'Outscoped'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*(endif|else|elif)', 0, 0, 0, undef, 1, '#pop', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parseOutscopedintern {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # String => '#\s*if'
   # attribute => 'Comment'
   # beginRegion => 'Outscoped'
   # context => 'Outscoped intern'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*if', 0, 0, 0, undef, 1, 'Outscoped intern', 'Comment')) {
      return 1
   }
   # String => '#\s*endif'
   # attribute => 'Comment'
   # context => '#pop'
   # endRegion => 'Outscoped'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*endif', 0, 0, 0, undef, 1, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Cg - a Plugin for Cg syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Cg;
 my $sh = new Syntax::Highlight::Engine::Kate::Cg([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Cg is a  plugin module that provides syntax highlighting
for Cg to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author