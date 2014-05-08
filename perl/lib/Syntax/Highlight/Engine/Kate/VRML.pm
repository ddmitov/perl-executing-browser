# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'vrml.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate author Volker Krause (volker.krause@rwth-aachen.de)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::VRML;

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
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Node' => 'Others',
      'Normal Text' => 'Normal',
      'String' => 'String',
      'String Char' => 'Char',
   });
   $self->listAdd('keywords',
      'DEF',
      'EXTERNPROTO',
      'FALSE',
      'IS',
      'NULL',
      'PROTO',
      'ROUTE',
      'TO',
      'TRUE',
      'USE',
      'eventIn',
      'eventOut',
      'exposedField',
      'field',
   );
   $self->listAdd('nodes',
      'Anchor',
      'Appearance',
      'AudioClip',
      'Background',
      'Billboard',
      'Box',
      'Collision',
      'Color',
      'ColorInterpolator',
      'Cone',
      'Coordinate',
      'CoordinateInterpolator',
      'Cylinder',
      'CylinderSensor',
      'DirectionalLight',
      'ElevationGrid',
      'Extrusion',
      'Fog',
      'FontStyle',
      'Group',
      'ImageTexture',
      'IndexedFaceSet',
      'IndexedLineSet',
      'Inline',
      'LOD',
      'Material',
      'MovieTexture',
      'NavigationInfo',
      'Normal',
      'NormalInterpolator',
      'OrientationInterpolator',
      'PixelTexture',
      'Plane',
      'PlaneSensor',
      'PointLight',
      'PointSet',
      'PositionInterpolator',
      'ProximitySensor',
      'ScalarInterpolator',
      'Script',
      'Sensor',
      'Shape',
      'Sound',
      'Sphere',
      'SphereSensor',
      'SpotLight',
      'Switch',
      'Text',
      'TextureCoordinate',
      'TextureTransform',
      'TimeSensor',
      'TouchSensor',
      'Transform',
      'Viewpoint',
      'VisibilitySensor',
      'WorldInfo',
   );
   $self->listAdd('types',
      'MFColor',
      'MFFloat',
      'MFInt32',
      'MFNode',
      'MFRotation',
      'MFString',
      'MFTime',
      'MFVec2f',
      'MFVec3f',
      'SFBool',
      'SFColor',
      'SFFloat',
      'SFImage',
      'SFInt32',
      'SFNode',
      'SFRotation',
      'SFString',
      'SFTime',
      'SFVec2f',
      'SFVec3f',
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
   return 'VRML';
}

sub parseComment {
   my ($self, $text) = @_;
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
   # String => 'nodes'
   # attribute => 'Node'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'nodes', 0, undef, 0, '#stay', 'Node')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
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
   # attribute => 'Normal Text'
   # beginRegion => 'Brace'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
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
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
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


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::VRML - a Plugin for VRML syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::VRML;
 my $sh = new Syntax::Highlight::Engine::Kate::VRML([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::VRML is a  plugin module that provides syntax highlighting
for VRML to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author