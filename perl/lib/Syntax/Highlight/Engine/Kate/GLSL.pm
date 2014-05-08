# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'glsl.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.4
#kate author Oliver Richers (o.richers@tu-bs.de)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::GLSL;

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
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Function' => 'Function',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Preprocessor' => 'Others',
      'StdFunction' => 'Function',
      'StdVariable' => 'Function',
      'Symbol' => 'Normal',
      'Type Qualifier' => 'DataType',
   });
   $self->listAdd('attention',
      'BUG',
      'FIXME',
      'TODO',
   );
   $self->listAdd('keywords',
      'break',
      'continue',
      'discard',
      'do',
      'else',
      'false',
      'for',
      'if',
      'return',
      'struct',
      'true',
      'while',
   );
   $self->listAdd('stdlib',
      'abs',
      'acos',
      'all',
      'any',
      'asin',
      'atan',
      'ceil',
      'clamp',
      'cos',
      'cross',
      'dFdx',
      'dFdy',
      'degrees',
      'distance',
      'dot',
      'equal',
      'exp',
      'exp2',
      'faceforward',
      'floor',
      'fract',
      'ftransform',
      'fwidth',
      'greaterThan',
      'greaterThanEqual',
      'inversesqrt',
      'length',
      'lessThan',
      'lessThenEqual',
      'log',
      'log2',
      'matrixCompMult',
      'max',
      'min',
      'mix',
      'mod',
      'noise1',
      'noise2',
      'noise3',
      'noise4',
      'normalize',
      'not',
      'notEqual',
      'pow',
      'radians',
      'reflect',
      'refract',
      'shadow1D',
      'shadow1DLod',
      'shadow1DProj',
      'shadow1DProjLod',
      'shadow2D',
      'shadow2DLod',
      'shadow2DProj',
      'shadow2DProjLod',
      'sign',
      'sin',
      'smoothstep',
      'sqrt',
      'step',
      'tan',
      'texture1D',
      'texture1DLod',
      'texture1DProj',
      'texture1DProjLod',
      'texture2D',
      'texture2DLod',
      'texture2DProj',
      'texture2DProjLod',
      'texture3D',
      'texture3DLod',
      'texture3DProj',
      'texture3DProjLod',
      'textureCube',
      'textureCubeLod',
   );
   $self->listAdd('stdvar',
      'gl_BackColor',
      'gl_BackLightModelProduct',
      'gl_BackLightProduct',
      'gl_BackMaterial',
      'gl_BackSecondaryColor',
      'gl_ClipPlane',
      'gl_ClipVertex',
      'gl_Color',
      'gl_Color',
      'gl_DepthRange',
      'gl_DepthRangeParameters',
      'gl_EyePlaneQ',
      'gl_EyePlaneR',
      'gl_EyePlaneS',
      'gl_EyePlaneT',
      'gl_Fog',
      'gl_FogColor',
      'gl_FogFragCoord',
      'gl_FogParameters',
      'gl_FragColor',
      'gl_FragCoord',
      'gl_FragData',
      'gl_FragDepth',
      'gl_FragFacing',
      'gl_FrontColor',
      'gl_FrontLightModelProduct',
      'gl_FrontLightProduct',
      'gl_FrontMaterial',
      'gl_FrontSecondaryColor',
      'gl_LightModel',
      'gl_LightModelParameters',
      'gl_LightModelProducts',
      'gl_LightProducts',
      'gl_LightSource',
      'gl_LightSourceParameters',
      'gl_MaterialParameters',
      'gl_MaxClipPlanes',
      'gl_MaxCombinedTextureImageUnits',
      'gl_MaxDrawBuffers',
      'gl_MaxFragmentUniformComponents',
      'gl_MaxLights',
      'gl_MaxTextureCoords',
      'gl_MaxTextureImageUnits',
      'gl_MaxTextureUnits',
      'gl_MaxVaryingFloats',
      'gl_MaxVertexAttributes',
      'gl_MaxVertexTextureImageUnits',
      'gl_MaxVertexUniformComponents',
      'gl_ModelViewMatrix',
      'gl_ModelViewMatrixInverse',
      'gl_ModelViewMatrixInverseTranspose',
      'gl_ModelViewMatrixTranspose',
      'gl_ModelViewProjectionMatrix',
      'gl_ModelViewProjectionMatrixInverse',
      'gl_ModelViewProjectionMatrixInverseTranspose',
      'gl_ModelViewProjectionMatrixTranspose',
      'gl_MultiTexCoord0',
      'gl_MultiTexCoord1',
      'gl_MultiTexCoord2',
      'gl_MultiTexCoord2',
      'gl_MultiTexCoord3',
      'gl_MultiTexCoord4',
      'gl_MultiTexCoord5',
      'gl_MultiTexCoord6',
      'gl_MultiTexCoord7',
      'gl_NormScale',
      'gl_Normal',
      'gl_NormalMatrix',
      'gl_ObjectPlaneQ',
      'gl_ObjectPlaneR',
      'gl_ObjectPlaneS',
      'gl_ObjectPlaneT',
      'gl_Point',
      'gl_PointParameters',
      'gl_PointSize',
      'gl_Position',
      'gl_ProjectionMatrix',
      'gl_ProjectionMatrixInverse',
      'gl_ProjectionMatrixInverseTranspose',
      'gl_ProjectionMatrixTranspose',
      'gl_SecondaryColor',
      'gl_SecondaryColor',
      'gl_TexCoord',
      'gl_TextureEnvColor',
      'gl_TextureMatrix',
      'gl_TextureMatrixInverse',
      'gl_TextureMatrixInverseTranspose',
      'gl_TextureMatrixTranspose',
      'gl_Vertex',
   );
   $self->listAdd('typequal',
      'attribute',
      'const',
      'in',
      'inout',
      'out',
      'uniform',
      'varying',
   );
   $self->listAdd('types',
      'bool',
      'bvec2',
      'bvec3',
      'bvec4',
      'float',
      'int',
      'ivec2',
      'ivec3',
      'ivec4',
      'mat2',
      'mat3',
      'mat4',
      'sampler1D',
      'sampler1DShadow',
      'sampler2D',
      'sampler2DShadow',
      'sampler3D',
      'samplerCube',
      'vec2',
      'vec3',
      'vec4',
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
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
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
   return 'GLSL';
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
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'typequal'
   # attribute => 'Type Qualifier'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'typequal', 0, undef, 0, '#stay', 'Type Qualifier')) {
      return 1
   }
   # String => 'stdlib'
   # attribute => 'StdFunction'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'stdlib', 0, undef, 0, '#stay', 'StdFunction')) {
      return 1
   }
   # String => 'stdvar'
   # attribute => 'StdVariable'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'stdvar', 0, undef, 0, '#stay', 'StdVariable')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
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
   # attribute => 'Preprocessor'
   # char => '#'
   # context => 'Preprocessor'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 1, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   # String => '\b[_\w][_\w\d]*(?=[\s]*[(])'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[_\\w][_\\w\\d]*(?=[\\s]*[(])', 0, 0, 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => '[.]{1,1}'
   # attribute => 'Symbol'
   # context => 'Member'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[.]{1,1}', 0, 0, 0, undef, 0, 'Member', 'Symbol')) {
      return 1
   }
   # String => '.+-/*%<>[]()^|&~=!:;,?;'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '.+-/*%<>[]()^|&~=!:;,?;', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::GLSL - a Plugin for GLSL syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::GLSL;
 my $sh = new Syntax::Highlight::Engine::Kate::GLSL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::GLSL is a  plugin module that provides syntax highlighting
for GLSL to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author