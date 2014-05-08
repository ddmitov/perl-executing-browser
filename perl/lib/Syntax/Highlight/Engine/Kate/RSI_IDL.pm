# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'rsiidl.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.1
#kate author Markus Fraenz (fraenz@linmpi.mpg.de)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::RSI_IDL;

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
      'Command' => 'BaseN',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'DecVal',
      'Hex' => 'DecVal',
      'IOCommand' => 'DataType',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'DecVal',
      'String' => 'String',
      'String Char' => 'Char',
      'bracketed' => 'Float',
   });
   $self->listAdd('commands',
      'ABS',
      'ACOS',
      'ADAPT_HIST_EQUAL',
      'ALOG',
      'ALOG10',
      'ARG_PRESENT',
      'ASIN',
      'ASSOC',
      'ATAN',
      'AXIS',
      'BESELI',
      'BESELJ',
      'BESELY',
      'BLAS_AXPY',
      'BREAKPOINT',
      'BROYDEN',
      'BYTEORDER',
      'CALL_EXTERNAL',
      'CALL_FUNCTION',
      'CALL_METHOD',
      'CALL_PROCEDURE',
      'CATCH',
      'CEIL',
      'CHECK_MATH',
      'CHOLDC',
      'CHOLSOL',
      'COLOR_CONVERT',
      'COLOR_QUAN',
      'COMPILE_OPT',
      'COMPUTE_MESH_NORMALS',
      'CONJ',
      'CONSTRAINED_MIN',
      'CONTOUR',
      'CONVERT_COORD',
      'CONVOL',
      'CORRELATE',
      'COS',
      'COSH',
      'CREATE_STRUCT',
      'CURSOR',
      'DEFINE_KEY',
      'DEFSYSV',
      'DELVAR',
      'DEVICE',
      'DFPMIN',
      'DIALOG_MESSAGE',
      'DIALOG_PICKFILE',
      'DIALOG_PRINTERSETUP',
      'DIALOG_PRINTJOB',
      'DILATE',
      'DLM_LOAD',
      'DRAW_ROI',
      'ELMHES',
      'EMPTY',
      'ENABLE_SYSRTN',
      'ERASE',
      'ERODE',
      'ERRORF',
      'EXECUTE',
      'EXIT',
      'EXP',
      'EXPAND_PATH',
      'EXPINT',
      'FINDFILE',
      'FINITE',
      'FLOOR',
      'FORMAT_AXIS_VALUES',
      'FORWARD_FUNCTION',
      'FSTAT',
      'FULSTR',
      'FZ_ROOTS',
      'GAUSSINT',
      'GETENV',
      'GET_KBRD',
      'GRID3',
      'GRID_TPS',
      'HEAP_GC',
      'HELP',
      'HISTOGRAM',
      'HQR',
      'IMAGE_STATISTICS',
      'IMAGINARY',
      'INTERPOLATE',
      'INVERT',
      'ISHFT',
      'ISOCONTOUR',
      'ISOSURFACE',
      'JOURNAL',
      'KEYWORD_SET',
      'LABEL_REGION',
      'LINBCG',
      'LINKIMAGE',
      'LMGR',
      'LNGAMMA',
      'LNP_TEST',
      'LOADCT',
      'LOCALE_GET',
      'LSODE',
      'LUDC',
      'LUMPROVE',
      'LUSOL',
      'MACHAR',
      'MAKE_ARRAY',
      'MAP_PROJ_INFO',
      'MAX',
      'MEDIAN',
      'MESH_CLIP',
      'MESH_DECIMATE',
      'MESH_ISSOLID',
      'MESH_MERGE',
      'MESH_NUMTRIANGLES',
      'MESH_SMOOTH',
      'MESH_SURFACEAREA',
      'MESH_VALIDATE',
      'MESH_VOLUME',
      'MESSAGE',
      'MIN',
      'NEWTON',
      'N_ELEMENTS',
      'N_PARAMS',
      'N_TAGS',
      'OBJ_CLASS',
      'OBJ_DESTROY',
      'OBJ_ISA',
      'OBJ_NEW',
      'OBJ_VALID',
      'ON_ERROR',
      'OPLOT',
      'PARTICLE_TRACE',
      'PLOT',
      'PLOTS',
      'POLYFILL',
      'POLYFILLV',
      'POLYSHADE',
      'POLY_2D',
      'POWELL',
      'PROFILER',
      'PTR_FREE',
      'PTR_NEW',
      'PTR_VALID',
      'QROMB',
      'QROMO',
      'QSIMP',
      'RANDOMN',
      'RANDOMU',
      'REBIN',
      'REFORM',
      'RETALL',
      'RETURN',
      'RIEMANN',
      'RK4',
      'ROBERTS',
      'ROTATE',
      'ROUND',
      'SETENV',
      'SET_PLOT',
      'SET_SHADING',
      'SHADE_SURF',
      'SHADE_VOLUME',
      'SHIFT',
      'SIN',
      'SINH',
      'SIZE',
      'SMOOTH',
      'SOBEL',
      'SORT',
      'SPL_INIT',
      'SPL_INTERP',
      'SPRSAB',
      'SPRSAX',
      'SPRSIN',
      'SQRT',
      'STOP',
      'STRCMP',
      'STRCOMPRESS',
      'STREGEX',
      'STRJOIN',
      'STRLEN',
      'STRLOWCASE',
      'STRMATCH',
      'STRMESSAGE',
      'STRMID',
      'STRPOS',
      'STRPUT',
      'STRTRIM',
      'STRUCT_ASSIGN',
      'STRUCT_HIDE',
      'STRUPCASE',
      'SURFACE',
      'SVDC',
      'SVSOL',
      'SYSTIME',
      'TAG_NAMES',
      'TAN',
      'TANH',
      'TEMPORARY',
      'TETRA_CLIP',
      'TETRA_SURFACE',
      'TETRA_VOLUME',
      'THIN',
      'THREED',
      'TOTAL',
      'TRANSPOSE',
      'TRIANGULATE',
      'TRIGRID',
      'TRIQL',
      'TRIRED',
      'TRISOL',
      'TV',
      'TVCRS',
      'TVLCT',
      'TVRD',
      'TVSCLU',
      'USERSYM',
      'VALUE_LOCATE',
      'VOIGT',
      'VOXEL_PROJ',
      'WAIT',
      'WATERSHED',
      'WDELETE',
      'WHERE',
      'WIDGET_BASE',
      'WIDGET_BUTTON',
      'WIDGET_CONTROL',
      'WIDGET_DRAW',
      'WIDGET_DROPLIST',
      'WIDGET_EVENT',
      'WIDGET_INFO',
      'WIDGET_LABEL',
      'WIDGET_LIST',
      'WIDGET_SLIDER',
      'WIDGET_TABLE',
      'WIDGET_TEXT',
      'WINDOW',
      'WSET',
      'WSHOW',
      'WTN',
      'XYOUTS',
   );
   $self->listAdd('io commands',
      'Close',
      'FLUSH',
      'Free_lun',
      'IOCTL',
      'Open',
      'Openr',
      'Openu',
      'Openw',
      'POINT_LUN',
      'RESTORE',
      'SAVE',
      'assoc',
      'catch',
      'cd',
      'eof',
      'get_lun',
      'print',
      'printf',
      'prints',
      'read',
      'readf',
      'reads',
      'spawn',
      'writu',
   );
   $self->listAdd('reserved words',
      'And',
      'Begin',
      'Case',
      'Common',
      'Do',
      'Else',
      'End',
      'Endcase',
      'Endelse',
      'Endfor',
      'Endif',
      'Endrep',
      'Endwhile',
      'Eq',
      'For',
      'Function',
      'Ge',
      'Goto',
      'Gt',
      'If',
      'Le',
      'Lt',
      'Mod',
      'Ne',
      'Not',
      'Of',
      'On_ioerror',
      'Or',
      'Pro',
      'Repeat',
      'Return',
      'Then',
      'Then',
      'Until',
      'While',
      'Xor',
   );
   $self->listAdd('system variables',
      'c',
      'd',
      'dir',
      'dlm_path',
      'dpi',
      'dtor',
      'edit_input',
      'err',
      'err_string',
      'error',
      'error_state',
      'except',
      'help_path',
      'journal',
      'map',
      'more',
      'mouse',
      'msg_prefix',
      'order',
      'p',
      'path',
      'pi',
      'prompt',
      'quiet',
      'radeg',
      'stime',
      'syserr_string',
      'syserror',
      'values',
      'version',
      'warn',
      'x',
      'y',
      'z',
   );
   $self->listAdd('types',
      'Bytarr',
      'Byte',
      'Bytscl',
      'Dblarr',
      'Dcindgen',
      'Dindgen',
      'Double',
      'Findgen',
      'Fix',
      'Float',
      'Fltarr',
      'Indgen',
      'Intarr',
      'Long',
      'Long64',
      'Objarr',
      'Ptrarr',
      'Replicate',
      'Strarr',
      'String',
      'bindgen',
      'cindgen',
      'complex',
      'complexarr',
      'dcomplex',
      'dcomplexarr',
      'l64indgen',
      'lindgen',
      'lon64arr',
      'lonarr',
      'sindgen',
      'uindgen',
      'uint',
      'uintarr',
      'ul64indgen',
      'ulindgen',
      'ulon64arr',
      'ulonarr',
      'ulong',
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
      'systemvarcontext' => {
         callback => \&parsesystemvarcontext,
         attribute => 'Char',
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
   return 'RSI IDL';
}

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'reserved words'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'reserved words', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'commands'
   # attribute => 'Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'commands', 0, undef, 0, '#stay', 'Command')) {
      return 1
   }
   # String => 'io commands'
   # attribute => 'IOCommand'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'io commands', 0, undef, 0, '#stay', 'IOCommand')) {
      return 1
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # char1 => '''
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '\'', '\'', 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # char1 => '"'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'Hex'
   # char => '('
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Hex'
   # char => ')'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Char'
   # char => '['
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => ']'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Float'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Float'
   # char => '}'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Char'
   # char => '$'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => '@'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '@', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => ':'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ':', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => ';'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, 'Comment', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => '!'
   # context => 'systemvarcontext'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '!', 0, 0, 0, undef, 0, 'systemvarcontext', 'Char')) {
      return 1
   }
   return 0;
};

sub parsesystemvarcontext {
   my ($self, $text) = @_;
   # attribute => 'Hex'
   # char => '('
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#pop', 'Hex')) {
      return 1
   }
   # attribute => 'Char'
   # char => '.'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '.', 0, 0, 0, undef, 0, '#pop', 'Char')) {
      return 1
   }
   # attribute => 'Hex'
   # char => ' '
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ' ', 0, 0, 0, undef, 0, '#pop', 'Hex')) {
      return 1
   }
   # String => 'system variables'
   # attribute => 'Float'
   # context => '#pop'
   # type => 'keyword'
   if ($self->testKeyword($text, 'system variables', 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::RSI_IDL - a Plugin for RSI IDL syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::RSI_IDL;
 my $sh = new Syntax::Highlight::Engine::Kate::RSI_IDL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::RSI_IDL is a  plugin module that provides syntax highlighting
for RSI IDL to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author