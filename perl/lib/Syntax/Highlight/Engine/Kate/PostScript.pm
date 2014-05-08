# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'postscript.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.1
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::PostScript;

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
      'Header' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
   });
   $self->listAdd('keywords',
      'ASCII85Decode',
      'ASCII85Encode',
      'ASCIIHexDecode',
      'ASCIIHexEncode',
      'CCITTFaxDecode',
      'CCITTFaxEncode',
      'CIEBasedA',
      'CIEBasedABC',
      'CIEBasedDEF',
      'CIEBasedDEFG',
      'Courier',
      'Courier-Bold',
      'Courier-BoldOblique',
      'Courier-Oblique',
      'DCTDecode',
      'DCTEncode',
      'DeviceCMYK',
      'DeviceGray',
      'DeviceN',
      'DeviceRGB',
      'FontDirectory',
      'GlobalFontDirectory',
      'Helvetica',
      'Helvetica-Bold',
      'Helvetica-BoldOblique',
      'Helvetica-Oblique',
      'ISOLatin1Encoding',
      'Indexed',
      'LZWDecode',
      'LZWEncode',
      'NullEncode',
      'Pattern',
      'RunLengthDecode',
      'RunLengthEncode',
      'Separation',
      'SharedFontDirectory',
      'StandardEncoding',
      'SubFileDecode',
      'Symbol',
      'Times-Bold',
      'Times-BoldItalic',
      'Times-Italic',
      'Times-Roman',
      'UserObjects',
      'abs',
      'add',
      'aload',
      'anchorsearch',
      'and',
      'arc',
      'arcn',
      'arct',
      'arcto',
      'array',
      'ashow',
      'astore',
      'atan',
      'awidthshow',
      'banddevice',
      'begin',
      'bind',
      'bitshift',
      'bytesavailable',
      'cachestatus',
      'ceiling',
      'charpath',
      'clear',
      'cleardictstack',
      'cleartomark',
      'clip',
      'clippath',
      'closefile',
      'closepath',
      'colorimage',
      'concat',
      'concatmatrix',
      'condition',
      'copy',
      'copypage',
      'cos',
      'count',
      'countdictstack',
      'countexecstack',
      'counttomark',
      'cshow',
      'currentblackgeneration',
      'currentcacheparams',
      'currentcmykcolor',
      'currentcolor',
      'currentcolorrendering',
      'currentcolorscreen',
      'currentcolorspace',
      'currentcolortransfer',
      'currentcontext',
      'currentdash',
      'currentdevparams',
      'currentdict',
      'currentfile',
      'currentflat',
      'currentfont',
      'currentglobal',
      'currentgray',
      'currentgstate',
      'currenthalftone',
      'currenthalftonephase',
      'currenthsbcolor',
      'currentlinecap',
      'currentlinejoin',
      'currentlinewidth',
      'currentmatrix',
      'currentmiterlimit',
      'currentobjectformat',
      'currentoverprint',
      'currentpacking',
      'currentpagedevice',
      'currentpoint',
      'currentrgbcolor',
      'currentscreen',
      'currentshared',
      'currentstrokeadjust',
      'currentsystemparams',
      'currenttransfer',
      'currentundercolorremoval',
      'currentuserparams',
      'curveto',
      'cvi',
      'cvlit',
      'cvn',
      'cvr',
      'cvrs',
      'cvs',
      'cvx',
      'def',
      'defaultmatrix',
      'definefont',
      'defineresource',
      'defineusername',
      'defineuserobject',
      'deletefile',
      'detach',
      'deviceinfo',
      'dict',
      'dictstack',
      'div',
      'dtransform',
      'dup',
      'echo',
      'end',
      'eoclip',
      'eofill',
      'eoviewclip',
      'eq',
      'erasepage',
      'errordict',
      'exch',
      'exec',
      'execform',
      'execstack',
      'execuserobject',
      'executeonly',
      'exit',
      'exp',
      'false',
      'file',
      'filenameforall',
      'fileposition',
      'fill',
      'filter',
      'findencoding',
      'findfont',
      'findresource',
      'flattenpath',
      'floor',
      'flush',
      'flushfile',
      'for',
      'forall',
      'fork',
      'framedevice',
      'gcheck',
      'ge',
      'get',
      'getinterval',
      'globaldict',
      'glyphshow',
      'grestore',
      'grestoreall',
      'gsave',
      'gstate',
      'gt',
      'handleerror',
      'identmatrix',
      'idiv',
      'idtransform',
      'if',
      'ifelse',
      'image',
      'imagemask',
      'index',
      'ineofill',
      'infill',
      'initclip',
      'initgraphics',
      'initmatrix',
      'initviewclip',
      'instroke',
      'inueofill',
      'inufill',
      'inustroke',
      'invertmatrix',
      'itransform',
      'join',
      'known',
      'kshow',
      'languagelevel',
      'le',
      'length',
      'lineto',
      'ln',
      'load',
      'lock',
      'log',
      'loop',
      'lt',
      'makefont',
      'makepattern',
      'mark',
      'matrix',
      'maxlength',
      'mod',
      'monitor',
      'moveto',
      'mul',
      'ne',
      'neg',
      'newpath',
      'noaccess',
      'not',
      'notify',
      'null',
      'nulldevice',
      'or',
      'packedarray',
      'pathbbox',
      'pathforall',
      'pop',
      'print',
      'printobject',
      'product',
      'pstack',
      'put',
      'putinterval',
      'quit',
      'rand',
      'rcheck',
      'rcurveto',
      'read',
      'readhexstring',
      'readline',
      'readonly',
      'readstring',
      'realtime',
      'rectclip',
      'rectfill',
      'rectstroke',
      'rectviewclip',
      'renamefile',
      'renderbands',
      'repeat',
      'resetfile',
      'resourceforall',
      'resourcestatus',
      'restore',
      'reversepath',
      'revision',
      'rlineto',
      'rmoveto',
      'roll',
      'rootfont',
      'rotate',
      'round',
      'rrand',
      'run',
      'save',
      'scale',
      'scalefont',
      'scheck',
      'search',
      'selectfont',
      'serialnumber',
      'setbbox',
      'setblackgeneration',
      'setcachedevice',
      'setcachedevice2',
      'setcachelimit',
      'setcacheparams',
      'setcharwidth',
      'setcmykcolor',
      'setcolor',
      'setcolorrendering',
      'setcolorscreen',
      'setcolorspace',
      'setcolortransfer',
      'setdash',
      'setdevparams',
      'setfileposition',
      'setflat',
      'setfont',
      'setglobal',
      'setgray',
      'setgstate',
      'sethalftone',
      'sethalftonephase',
      'sethsbcolor',
      'setlinecap',
      'setlinejoin',
      'setlinewidth',
      'setmatrix',
      'setmiterlimit',
      'setobjectformat',
      'setoverprint',
      'setpacking',
      'setpagedevice',
      'setpattern',
      'setrgbcolor',
      'setscreen',
      'setshared',
      'setstrokeadjust',
      'setsystemparams',
      'settransfer',
      'setucacheparams',
      'setundercolorremoval',
      'setuserparams',
      'setvmthreshold',
      'shareddict',
      'show',
      'showpage',
      'sin',
      'sqrt',
      'srand',
      'stack',
      'startjob',
      'status',
      'statusdict',
      'stop',
      'stopped',
      'store',
      'string',
      'stringwidth',
      'stroke',
      'strokepath',
      'sub',
      'systemdict',
      'token',
      'transform',
      'translate',
      'true',
      'truncate',
      'type',
      'uappend',
      'ucache',
      'ucachestatus',
      'ueofill',
      'ufill',
      'undef',
      'undefinefont',
      'undefineresource',
      'undefineuserobject',
      'upath',
      'userdict',
      'usertime',
      'ustroke',
      'ustrokepath',
      'version',
      'viewclip',
      'viewclippath',
      'vmreclaim',
      'vmstatus',
      'wait',
      'wcheck',
      'where',
      'widthshow',
      'write',
      'writehexstring',
      'writeobject',
      'writestring',
      'wtranslation',
      'xcheck',
      'xor',
      'xshow',
      'xyshow',
      'yield',
      'yshow',
   );
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Header' => {
         callback => \&parseHeader,
         attribute => 'Header',
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
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'PostScript';
}

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseHeader {
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
   # attribute => 'Header'
   # char => '%'
   # char1 => '!'
   # context => 'Header'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '!', 0, 0, 0, undef, 0, 'Header', 'Header')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'String'
   # char => '('
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '\/{1,2}[^\s\(\)\{\}\[\]%/]*'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/{1,2}[^\\s\\(\\)\\{\\}\\[\\]%/]*', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::PostScript - a Plugin for PostScript syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::PostScript;
 my $sh = new Syntax::Highlight::Engine::Kate::PostScript([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::PostScript is a  plugin module that provides syntax highlighting
for PostScript to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author