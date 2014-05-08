# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'povray.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.4
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::POVminusRay;

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
      'Constant' => 'Float',
      'Declaration' => 'Operator',
      'Declare Keyword' => 'Variable',
      'Declare Macro' => 'DecVal',
      'Directives' => 'Others',
      'Filetype' => 'DataType',
      'Float' => 'Float',
      'Functions' => 'Function',
      'Keyword' => 'Keyword',
      'Macro' => 'Operator',
      'Normal Text' => 'Normal',
      'Objects' => 'Keyword',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'String Char' => 'IString',
      'Symbol' => 'BString',
      'Texturing' => 'Keyword',
      'Transforms' => 'Keyword',
   });
   $self->listAdd('attention',
      '###',
      'FIXME',
      'TODO',
   );
   $self->listAdd('constants',
      'false',
      'no',
      'off',
      'on',
      'pi',
      'true',
      'yes',
   );
   $self->listAdd('directives',
      '#debug',
      '#default',
      '#else',
      '#end',
      '#error',
      '#fclose',
      '#fopen',
      '#if',
      '#ifdef',
      '#ifndef',
      '#include',
      '#range',
      '#read',
      '#render',
      '#statistics',
      '#switch',
      '#undef',
      '#version',
      '#warning',
      '#while',
      '#write',
   );
   $self->listAdd('filetypes',
      'df3',
      'gif',
      'iff',
      'jpeg',
      'pgm',
      'png',
      'pot',
      'ppm',
      'tga',
      'tiff',
      'ttf',
   );
   $self->listAdd('functions',
      'abs',
      'acos',
      'acosh',
      'asc',
      'asin',
      'asinh',
      'atan',
      'atan2',
      'atanh',
      'ceil',
      'chr',
      'concat',
      'cos',
      'cosh',
      'cube',
      'defined',
      'degress',
      'dimension_size',
      'dimensions',
      'div',
      'exp',
      'file_exists',
      'floor',
      'inside',
      'int',
      'ln',
      'log',
      'max',
      'min',
      'mod',
      'pow',
      'prod',
      'pwr',
      'radians',
      'rand',
      'seed',
      'select',
      'sin',
      'sinh',
      'sqrt',
      'str',
      'strcmp',
      'strlen',
      'strlwr',
      'strupr',
      'substr',
      'sum',
      'tan',
      'tanh',
      'trace',
      'val',
      'vaxis_rotate',
      'vcross',
      'vdot',
      'vlength',
      'vnormalize',
      'vrotate',
      'vstr',
      'vturbulence',
   );
   $self->listAdd('identifiers',
      'clock',
      'clock_delta',
      'clock_on',
      'final_clock',
      'final_frame',
      'frame_number',
      'image_height',
      'image_width',
      'initial_clock',
      'initial_frame',
      't',
      'u',
      'v',
      'x',
      'y',
      'z',
   );
   $self->listAdd('keywords',
      'aa_level',
      'aa_threshold',
      'abs',
      'absorption',
      'accuracy',
      'acos',
      'acosh',
      'adaptive',
      'adc_bailout',
      'agate',
      'agate_turb',
      'all',
      'all_intersections',
      'alpha',
      'altitude',
      'always_sample',
      'ambient',
      'ambient_light',
      'angle',
      'aperture',
      'append',
      'arc_angle',
      'area_light',
      'array',
      'asc',
      'ascii',
      'asin',
      'asinh',
      'assumed_gamma',
      'atan',
      'atan2',
      'atanh',
      'autostop',
      'average',
      'b_spline',
      'background',
      'bezier_spline',
      'bicubic_patch',
      'black_hole',
      'blob',
      'blue',
      'blur_samples',
      'bounded_by',
      'box',
      'boxed',
      'bozo',
      'brick',
      'brick_size',
      'brightness',
      'brilliance',
      'bump_map',
      'bump_size',
      'bumps',
      'camera',
      'caustics',
      'ceil',
      'cells',
      'charset',
      'checker',
      'chr',
      'circular',
      'clipped_by',
      'clock',
      'clock_delta',
      'clock_on',
      'collect',
      'color',
      'color_map',
      'colour',
      'colour_map',
      'component',
      'composite',
      'concat',
      'cone',
      'confidence',
      'conic_sweep',
      'conserve_energy',
      'contained_by',
      'control0',
      'control1',
      'coords',
      'cos',
      'cosh',
      'count',
      'crackle',
      'crand',
      'cube',
      'cubic',
      'cubic_spline',
      'cubic_wave',
      'cutaway_textures',
      'cylinder',
      'cylindrical',
      'defined',
      'degrees',
      'density',
      'density_file',
      'density_map',
      'dents',
      'df3',
      'difference',
      'diffuse',
      'dimension_size',
      'dimensions',
      'direction',
      'disc',
      'dispersion',
      'dispersion_samples',
      'dist_exp',
      'distance',
      'distance_maximum',
      'div',
      'double_illuminate',
      'eccentricity',
      'emission',
      'error_bound',
      'evaluate',
      'exp',
      'expand_thresholds',
      'exponent',
      'exterior',
      'extinction',
      'face_indices',
      'facets',
      'fade_color',
      'fade_colour',
      'fade_distance',
      'fade_power',
      'falloff',
      'falloff_angle',
      'false',
      'file_exists',
      'filter',
      'final_clock',
      'final_frame',
      'finish',
      'fisheye',
      'flatness',
      'flip',
      'floor',
      'focal_point',
      'fog',
      'fog_alt',
      'fog_offset',
      'fog_type',
      'form',
      'frame_number',
      'frequency',
      'fresnel',
      'function',
      'gather',
      'gif',
      'global',
      'global_lights',
      'global_settings',
      'gradient',
      'granite',
      'gray',
      'gray_threshold',
      'green',
      'height_field',
      'hexagon',
      'hf_gray_16',
      'hierarchy',
      'hollow',
      'hypercomplex',
      'iff',
      'image_height',
      'image_map',
      'image_pattern',
      'image_width',
      'initial_clock',
      'initial_frame',
      'inside',
      'inside_vector',
      'int',
      'interior',
      'interior_texture',
      'internal',
      'interpolate',
      'intersection',
      'intervals',
      'inverse',
      'ior',
      'irid',
      'irid_wavelength',
      'isosurface',
      'jitter',
      'jpeg',
      'julia',
      'julia_fractal',
      'lambda',
      'lathe',
      'leopard',
      'light_group',
      'light_source',
      'linear_spline',
      'linear_sweep',
      'ln',
      'load_file',
      'location',
      'log',
      'look_at',
      'looks_like',
      'low_error_factor',
      'magnet',
      'major_radius',
      'mandel',
      'map_type',
      'marble',
      'material',
      'material_map',
      'matrix',
      'max',
      'max_extent',
      'max_gradient',
      'max_intersections',
      'max_iteration',
      'max_sample',
      'max_trace',
      'max_trace_level',
      'media',
      'media_attenuation',
      'media_interaction',
      'merge',
      'mesh',
      'mesh2',
      'metallic',
      'method',
      'metric',
      'min',
      'min_extent',
      'minimum_reuse',
      'mod',
      'mortar',
      'natural_spline',
      'nearest_count',
      'no',
      'no_bump_scale',
      'no_image',
      'no_reflection',
      'no_shadow',
      'noise_generator',
      'normal',
      'normal',
      'normal_indices',
      'normal_map',
      'normal_vectors',
      'number_of_waves',
      'object',
      'octaves',
      'off',
      'offset',
      'omega',
      'omnimax',
      'on',
      'once',
      'onion',
      'open',
      'orient',
      'orientation',
      'orthographic',
      'panoramic',
      'parallel',
      'parametric',
      'pass_through',
      'pattern',
      'perspective',
      'pgm',
      'phase',
      'phong',
      'phong_size',
      'photons',
      'pi',
      'pigment',
      'pigment_map',
      'pigment_pattern',
      'planar',
      'plane',
      'png',
      'point_at',
      'poly',
      'poly_wave',
      'polygon',
      'pot',
      'pow',
      'ppm',
      'precision',
      'precompute',
      'pretrace_end',
      'pretrace_start',
      'prism',
      'prod',
      'projected_through',
      'pwr',
      'quadratic_spline',
      'quadric',
      'quartic',
      'quaternion',
      'quick_color',
      'quick_colour',
      'quilted',
      'radial',
      'radians',
      'radiosity',
      'radius',
      'rainbow',
      'ramp_wave',
      'rand',
      'range',
      'ratio',
      'reciprocal',
      'recursion_limit',
      'red',
      'reflection',
      'reflection_exponent',
      'refraction',
      'repeat',
      'rgb',
      'rgbf',
      'rgbft',
      'rgbt',
      'right',
      'ripples',
      'rotate',
      'roughness',
      'samples',
      'save_file',
      'scale',
      'scallop_wave',
      'scattering',
      'seed',
      'select',
      'shadowless',
      'sin',
      'sine_wave',
      'sinh',
      'size',
      'sky',
      'sky_sphere',
      'slice',
      'slope',
      'slope_map',
      'smooth',
      'smooth_triangle',
      'solid',
      'sor',
      'spacing',
      'specular',
      'sphere',
      'sphere_sweep',
      'spherical',
      'spiral1',
      'spiral2',
      'spline',
      'split_union',
      'spotlight',
      'spotted',
      'sqr',
      'sqrt',
      'statistics',
      'steps',
      'str',
      'strcmp',
      'strength',
      'strlen',
      'strlwr',
      'strupr',
      'sturm',
      'substr',
      'sum',
      'superellipsoid',
      'sys',
      't',
      'tan',
      'tanh',
      'target',
      'text',
      'texture',
      'texture_list',
      'texture_map',
      'tga',
      'thickness',
      'threshold',
      'tiff',
      'tightness',
      'tile2',
      'tiles',
      'tolerance',
      'toroidal',
      'torus',
      'trace',
      'transform',
      'translate',
      'transmit',
      'triangle',
      'triangle_wave',
      'true',
      'ttf',
      'turb_depth',
      'turbulence',
      'type',
      'u',
      'u_steps',
      'ultra_wide_angle',
      'union',
      'up',
      'use_alpha',
      'use_color',
      'use_colour',
      'use_index',
      'utf8',
      'uv_indices',
      'uv_mapping',
      'uv_vectors',
      'v',
      'v_steps',
      'val',
      'variance',
      'vaxis_rotate',
      'vcross',
      'vdot',
      'vertex_vectors',
      'vlength',
      'vnormalize',
      'vrotate',
      'vstr',
      'vturbulence',
      'warning',
      'warp',
      'water_level',
      'waves',
      'while',
      'width',
      'wood',
      'wrinkles',
      'write',
      'x',
      'y',
      'yes',
      'z',
   );
   $self->listAdd('objects',
      'bicubic_patch',
      'blob',
      'box',
      'cone',
      'cubic',
      'cylinder',
      'difference',
      'disc',
      'height_field',
      'intersection',
      'isosurface',
      'julia_fractal',
      'lathe',
      'light_source',
      'merge',
      'mesh',
      'mesh2',
      'object',
      'parametric',
      'plane',
      'poly',
      'polygon',
      'prism',
      'quadric',
      'quartic',
      'smooth_triangle',
      'sor',
      'sphere',
      'sphere_sweep',
      'superellipsoid',
      'text',
      'torus',
      'triangle',
      'union',
   );
   $self->listAdd('texturing',
      'aa_level',
      'aa_threshold',
      'absorption',
      'agate',
      'agate_turb',
      'ambient',
      'average',
      'black_hole',
      'blue',
      'boxed',
      'brick',
      'brick_size',
      'brilliance',
      'bump_map',
      'bump_size',
      'bumps',
      'caustics',
      'cells',
      'checker',
      'color',
      'color_map',
      'colour',
      'colour_map',
      'conserve_energy',
      'control0',
      'control1',
      'crackle',
      'crand',
      'cubic_wave',
      'cutaway_textures',
      'cylindrical',
      'density',
      'density_file',
      'density_map',
      'dents',
      'diffuse',
      'dist_exp',
      'double_illuminate',
      'eccentricity',
      'emission',
      'exponent',
      'exterior',
      'extinction',
      'facets',
      'fade_color',
      'fade_colour',
      'fade_distance',
      'fade_power',
      'filter',
      'finish',
      'form',
      'frequency',
      'fresnel',
      'gradient',
      'granite',
      'gray',
      'green',
      'hexagon',
      'hypercomplex',
      'image_map',
      'image_pattern',
      'interior',
      'interior_texture',
      'interpolate',
      'intervals',
      'ior',
      'irid',
      'irid_wavelength',
      'julia',
      'lambda',
      'leopard',
      'magnet',
      'mandel',
      'map_type',
      'marble',
      'material',
      'material_map',
      'media',
      'metallic',
      'method',
      'metric',
      'mortar',
      'no_bump_scale',
      'normal',
      'normal',
      'normal_map',
      'number_of_waves',
      'octaves',
      'omega',
      'once',
      'onion',
      'orientation',
      'phase',
      'phong',
      'phong_size',
      'pigment',
      'pigment_map',
      'pigment_pattern',
      'planar',
      'quaternion',
      'quick_color',
      'quick_colour',
      'quilted',
      'radial',
      'ramp_wave',
      'red',
      'reflection',
      'reflection_exponent',
      'repeat',
      'rgb',
      'rgbf',
      'rgbft',
      'rgbt',
      'ripples',
      'roughness',
      'samples',
      'scallop_wave',
      'scattering',
      'sine_wave',
      'slope',
      'slope_map',
      'solid',
      'specular',
      'spherical',
      'spiral1',
      'spiral2',
      'spotted',
      'texture',
      'texture_list',
      'texture_map',
      'tile2',
      'tiles',
      'toroidal',
      'transmit',
      'triangle_wave',
      'turb_depth',
      'turbulence',
      'use_alpha',
      'use_color',
      'use_colour',
      'use_index',
      'uv_mapping',
      'warp',
      'waves',
      'wood',
      'wrinkles',
   );
   $self->listAdd('transforms',
      'matrix',
      'rotate',
      'scale',
      'transform',
      'translate',
   );
   $self->contextdata({
      'Commentar' => {
         callback => \&parseCommentar,
         attribute => 'Comment',
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
      'Declaration' => {
         callback => \&parseDeclaration,
         attribute => 'Declaration',
         lineending => '#pop',
      },
      'Declare_Keyword' => {
         callback => \&parseDeclare_Keyword,
         attribute => 'Declare Keyword',
         lineending => '#pop',
      },
      'Declare_Macro' => {
         callback => \&parseDeclare_Macro,
         attribute => 'Declare Macro',
         lineending => '#pop',
      },
      'Macro' => {
         callback => \&parseMacro,
         attribute => 'Macro',
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
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'POV-Ray';
}

sub parseCommentar {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseCommentar1 {
   my ($self, $text) = @_;
   # String => 'attention'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   return 0;
};

sub parseCommentar2 {
   my ($self, $text) = @_;
   # String => 'attention'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attention', 0, undef, 0, '#stay', 'Decimal')) {
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

sub parseDeclaration {
   my ($self, $text) = @_;
   # String => '\w+'
   # attribute => 'Declare Keyword'
   # context => 'Declare_Keyword'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\w+', 0, 0, 0, undef, 0, 'Declare_Keyword', 'Declare Keyword')) {
      return 1
   }
   # attribute => 'Declaration'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Declaration')) {
      return 1
   }
   # String => '=[('
   # attribute => 'Symbol'
   # context => '#pop#pop'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '=[(', 0, 0, undef, 0, '#pop#pop', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseDeclare_Keyword {
   my ($self, $text) = @_;
   # attribute => 'Declare Keyword'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Declare Keyword')) {
      return 1
   }
   # String => '=[('
   # attribute => 'Symbol'
   # context => '#pop#pop'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '=[(', 0, 0, undef, 0, '#pop#pop', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseDeclare_Macro {
   my ($self, $text) = @_;
   # attribute => 'Declare Macro'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Declare Macro')) {
      return 1
   }
   # attribute => 'Symbol'
   # char => '('
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#pop#pop', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseMacro {
   my ($self, $text) = @_;
   # String => '\w+'
   # attribute => 'Declare Macro'
   # context => 'Declare_Macro'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\w+', 0, 0, 0, undef, 0, 'Declare_Macro', 'Declare Macro')) {
      return 1
   }
   # attribute => 'Macro'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   # attribute => 'Symbol'
   # char => '('
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#pop#pop', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '#declare'
   # attribute => 'Declaration'
   # context => 'Declaration'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#declare', 0, 0, 0, undef, 0, 'Declaration', 'Declaration')) {
      return 1
   }
   # String => '#local'
   # attribute => 'Declaration'
   # context => 'Declaration'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#local', 0, 0, 0, undef, 0, 'Declaration', 'Declaration')) {
      return 1
   }
   # String => '#macro'
   # attribute => 'Macro'
   # context => 'Macro'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#macro', 0, 0, 0, undef, 0, 'Macro', 'Macro')) {
      return 1
   }
   # String => 'objects'
   # attribute => 'Objects'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'objects', 0, undef, 0, '#stay', 'Objects')) {
      return 1
   }
   # String => 'texturing'
   # attribute => 'Texturing'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'texturing', 0, undef, 0, '#stay', 'Texturing')) {
      return 1
   }
   # String => 'transforms'
   # attribute => 'Transforms'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'transforms', 0, undef, 0, '#stay', 'Transforms')) {
      return 1
   }
   # String => 'filetypes'
   # attribute => 'Filetype'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'filetypes', 0, undef, 0, '#stay', 'Filetype')) {
      return 1
   }
   # String => 'identifiers'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'identifiers', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'constants'
   # attribute => 'Constant'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'constants', 0, undef, 0, '#stay', 'Constant')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Functions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Functions')) {
      return 1
   }
   # String => 'directives'
   # attribute => 'Directives'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'directives', 0, undef, 0, '#stay', 'Directives')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '//\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'Region1'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '//\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'Region1'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
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
   # String => ':!%&()+,-/.*<=>?[]{|}~^;'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':!%&()+,-/.*<=>?[]{|}~^;', 0, 0, undef, 0, '#stay', 'Symbol')) {
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

Syntax::Highlight::Engine::Kate::POVminusRay - a Plugin for POV-Ray syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::POVminusRay;
 my $sh = new Syntax::Highlight::Engine::Kate::POVminusRay([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::POVminusRay is a  plugin module that provides syntax highlighting
for POV-Ray to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author