# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'rib.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.00
#kate version 2.3
#kate author David Williams <david@david-williams.info>
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::RenderMan_RIB;

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
      'External Resource' => 'Keyword',
      'Float' => 'Float',
      'Geometric Primitive' => 'Keyword',
      'Graphics State' => 'Keyword',
      'Integer' => 'DecVal',
      'Motion' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
   });
   $self->listAdd('External Resources',
      'ArchiveRecord',
      'ErrorHandler',
      'MakeBump',
      'MakeCubeFaceEnvironment',
      'MakeLatLongEnvironment',
      'MakeTexture',
   );
   $self->listAdd('Geometric Primitives',
      'Basis',
      'Cylinder',
      'Disk',
      'GeneralPolygon',
      'Geometry',
      'Hyperboloid',
      'NuPatch',
      'ObjectBegin',
      'ObjectEnd',
      'ObjectInstance',
      'Paraboloid',
      'Patch',
      'PointsGeneralPolygons',
      'PointsPolygons',
      'Polygon',
      'Procedural',
      'SolidBegin',
      'SolidEnd',
      'Sphere',
      'Torus',
   );
   $self->listAdd('Graphics States',
      'AreaLightSource',
      'Attribute',
      'AttributeBegin',
      'AttributeEnd',
      'Begin',
      'Bound',
      'Clipping',
      'Color',
      'ColorSamples',
      'ConcatTransform',
      'CoordinateSystem',
      'CropWindow',
      'Declare',
      'DepthOfField',
      'Detail',
      'DetailRange',
      'Displacement',
      'Display',
      'End',
      'Exterior',
      'Format',
      'FrameAspectRatio',
      'FrameBegin',
      'FrameEnd',
      'GeometricApproximation',
      'Hider',
      'Identity',
      'Illuminance',
      'Illuminate',
      'Interior',
      'LightSource',
      'Matte',
      'Opacity',
      'Option',
      'Orientation',
      'Perspective',
      'PixelFilter',
      'PixelSamples',
      'PixelVariance',
      'Projection',
      'Quantize',
      'RelativeDetail',
      'Rotate',
      'Scale',
      'ScreenWindow',
      'ShadingInterpolation',
      'ShadingRate',
      'Shutter',
      'Sides',
      'Skew',
      'Surface',
      'TextureCoordinates',
      'Transform',
      'TransformBegin',
      'TransformEnd',
      'TransformPoints',
      'Translate',
      'WorldBegin',
      'WorldEnd',
      'version',
   );
   $self->listAdd('Motions',
      'MotionBegin',
      'MotionEnd',
   );
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'RenderMan RIB';
}

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'Graphics States'
   # attribute => 'Graphics State'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Graphics States', 0, undef, 0, '#stay', 'Graphics State')) {
      return 1
   }
   # String => 'Geometric Primitives'
   # attribute => 'Geometric Primitive'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Geometric Primitives', 0, undef, 0, '#stay', 'Geometric Primitive')) {
      return 1
   }
   # String => 'Motions'
   # attribute => 'Motion'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Motions', 0, undef, 0, '#stay', 'Motion')) {
      return 1
   }
   # String => 'External Resources'
   # attribute => 'External Resource'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'External Resources', 0, undef, 0, '#stay', 'External Resource')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '#'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::RenderMan_RIB - a Plugin for RenderMan RIB syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::RenderMan_RIB;
 my $sh = new Syntax::Highlight::Engine::Kate::RenderMan_RIB([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::RenderMan_RIB is a  plugin module that provides syntax highlighting
for RenderMan RIB to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author