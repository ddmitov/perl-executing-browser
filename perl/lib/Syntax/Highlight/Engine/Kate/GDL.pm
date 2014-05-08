# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'gdl.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.0
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::GDL;

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
      'Datatype' => 'DataType',
      'Float' => 'Float',
      'Integer' => 'DecVal',
      'Keyword' => 'Keyword',
      'Normal' => 'Normal',
      'String' => 'String',
      'Value' => 'Others',
   });
   $self->listAdd('algorithms',
      'dfs',
      'forcedir',
      'maxdegree',
      'maxdepth',
      'maxdepthslow',
      'maxindegree',
      'maxoutdegree',
      'minbackward',
      'mindegree',
      'mindepth',
      'mindepthslow',
      'minindegree',
      'minoutdegree',
      'normal',
      'tree',
   );
   $self->listAdd('colors',
      'aquamarine',
      'black',
      'blue',
      'cyan',
      'darkblue',
      'darkcyan',
      'darkgray',
      'darkgreen',
      'darkgrey',
      'darkmagenta',
      'darkred',
      'darkyellow',
      'gold',
      'green',
      'khaki',
      'lightblue',
      'lightcyan',
      'lightgray',
      'lightgreen',
      'lightgrey',
      'lightmagenta',
      'lightred',
      'lightyellow',
      'lilac',
      'magenta',
      'orange',
      'orchid',
      'pink',
      'purple',
      'red',
      'turquoise',
      'white',
      'yellow',
      'yellowgreen',
   );
   $self->listAdd('fisheye',
      'cfish',
      'dcfish',
      'dpfish',
      'fcfish',
      'fpfish',
      'pfish',
   );
   $self->listAdd('forcedir',
      'attraction',
      'randomfactor',
      'randomimpulse',
      'randomrounds',
      'repulsion',
      'tempmax',
      'tempmin',
      'tempscheme',
      'temptreshold',
   );
   $self->listAdd('lines',
      'continuous',
      'dashed',
      'dotted',
      'double',
      'invisible',
      'solid',
      'triple',
   );
   $self->listAdd('magnetic',
      'circular',
      'no',
      'orthogonal',
      'polar',
      'polcircular',
   );
   $self->listAdd('orientation',
      'bottom_to_top',
      'bottomtotop',
      'left_to_right',
      'lefttoright',
      'right_to_left',
      'righttoleft',
      'top_to_bottom',
      'toptobottom',
   );
   $self->listAdd('shapes',
      'box',
      'circle',
      'ellipse',
      'hexagon',
      'lparallelogram',
      'rhomb',
      'rhomboid',
      'rparallelogram',
      'trapeze',
      'trapezoid',
      'triangle',
      'uptrapeze',
      'uptrapezoid',
   );
   $self->listAdd('states',
      'boxed',
      'clustered',
      'exclusive',
      'folded',
      'unfolded',
      'white',
      'wrapped',
   );
   $self->contextdata({
      'algid' => {
         callback => \&parsealgid,
         attribute => 'Normal',
      },
      'arrow' => {
         callback => \&parsearrow,
         attribute => 'Normal',
      },
      'arrowmode' => {
         callback => \&parsearrowmode,
         attribute => 'Normal',
      },
      'boolean' => {
         callback => \&parseboolean,
         attribute => 'Normal',
      },
      'ccomment' => {
         callback => \&parseccomment,
         attribute => 'Comment',
         lineending => 'default',
      },
      'cecolon' => {
         callback => \&parsececolon,
         attribute => 'Normal',
      },
      'centry' => {
         callback => \&parsecentry,
         attribute => 'Normal',
         lineending => 'default',
      },
      'classname' => {
         callback => \&parseclassname,
         attribute => 'Normal',
      },
      'colorid' => {
         callback => \&parsecolorid,
         attribute => 'Normal',
      },
      'cppcomment' => {
         callback => \&parsecppcomment,
         attribute => 'Comment',
      },
      'default' => {
         callback => \&parsedefault,
         attribute => 'Normal',
      },
      'fishid' => {
         callback => \&parsefishid,
         attribute => 'Normal',
      },
      'floatval' => {
         callback => \&parsefloatval,
         attribute => 'Normal',
      },
      'fontbase' => {
         callback => \&parsefontbase,
         attribute => 'Normal',
      },
      'fontlq' => {
         callback => \&parsefontlq,
         attribute => 'Normal',
      },
      'fontsize' => {
         callback => \&parsefontsize,
         attribute => 'Normal',
      },
      'intval' => {
         callback => \&parseintval,
         attribute => 'Normal',
      },
      'lineid' => {
         callback => \&parselineid,
         attribute => 'Normal',
      },
      'longint' => {
         callback => \&parselongint,
         attribute => 'Normal',
         lineending => 'default',
      },
      'lquote' => {
         callback => \&parselquote,
         attribute => 'Normal',
      },
      'magnor' => {
         callback => \&parsemagnor,
         attribute => 'Normal',
      },
      'nodealign' => {
         callback => \&parsenodealign,
         attribute => 'Normal',
      },
      'nodelevel' => {
         callback => \&parsenodelevel,
         attribute => 'Normal',
      },
      'orient' => {
         callback => \&parseorient,
         attribute => 'Normal',
      },
      'rgb' => {
         callback => \&parsergb,
         attribute => 'Normal',
      },
      'scaling' => {
         callback => \&parsescaling,
         attribute => 'Normal',
      },
      'shapeid' => {
         callback => \&parseshapeid,
         attribute => 'Normal',
      },
      'stateid' => {
         callback => \&parsestateid,
         attribute => 'Normal',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
      },
      'textmode' => {
         callback => \&parsetextmode,
         attribute => 'Normal',
      },
      'weight' => {
         callback => \&parseweight,
         attribute => 'Normal',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('default');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'GDL';
}

sub parsealgid {
   my ($self, $text) = @_;
   # String => 'algorithms'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'algorithms', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsearrow {
   my ($self, $text) = @_;
   # String => '(solid|line|none)'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(solid|line|none)', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsearrowmode {
   my ($self, $text) = @_;
   # String => '(free|fixed)'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(free|fixed)', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parseboolean {
   my ($self, $text) = @_;
   # String => '(yes|no)'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(yes|no)', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parseccomment {
   my ($self, $text) = @_;
   return 0;
};

sub parsececolon {
   my ($self, $text) = @_;
   # attribute => 'Value'
   # char => ':'
   # context => 'rgb'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ':', 0, 0, 0, undef, 0, 'rgb', 'Value')) {
      return 1
   }
   return 0;
};

sub parsecentry {
   my ($self, $text) = @_;
   # String => '[0-9][0-9]?'
   # attribute => 'Value'
   # context => 'cecolon'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9][0-9]?', 0, 0, 0, undef, 0, 'cecolon', 'Value')) {
      return 1
   }
   return 0;
};

sub parseclassname {
   my ($self, $text) = @_;
   # String => '[0-9]+'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # attribute => 'Value'
   # char => ':'
   # context => 'lquote'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ':', 0, 0, 0, undef, 0, 'lquote', 'Value')) {
      return 1
   }
   return 0;
};

sub parsecolorid {
   my ($self, $text) = @_;
   # String => 'colors'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'colors', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   # String => '[0-9][0-9]?'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9][0-9]?', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsecppcomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => 'default'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, 'default', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsedefault {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'ccomment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'ccomment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'cppcomment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'cppcomment', 'Comment')) {
      return 1
   }
   # String => 'focus'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'focus', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '(graph|edge|node|region|backedge|(left|right|)(bent|)nearedge):'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(graph|edge|node|region|backedge|(left|right|)(bent|)nearedge):', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'loc *:'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'loc *:', 0, 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # String => 'colorentry'
   # attribute => 'Value'
   # context => 'centry'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'colorentry', 0, 0, 0, undef, 0, 'centry', 'Value')) {
      return 1
   }
   # String => 'arrow_?mode *:'
   # attribute => 'Value'
   # context => 'arrowmode'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'arrow_?mode *:', 0, 0, 0, undef, 0, 'arrowmode', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|)(text|border|)color *:'
   # attribute => 'Value'
   # context => 'colorid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|)(text|border|)color *:', 0, 0, 0, undef, 0, 'colorid', 'Value')) {
      return 1
   }
   # String => '(foldedge.|edge.|)(arrow|backarrow|)color *:'
   # attribute => 'Value'
   # context => 'colorid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldedge.|edge.|)(arrow|backarrow|)color *:', 0, 0, 0, undef, 0, 'colorid', 'Value')) {
      return 1
   }
   # String => '(foldedge.|edge.|)(arrow|backarrow)style *:'
   # attribute => 'Value'
   # context => 'arrow'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldedge.|edge.|)(arrow|backarrow)style *:', 0, 0, 0, undef, 0, 'arrow', 'Value')) {
      return 1
   }
   # String => '(foldedge.|edge.|)linestyle *:'
   # attribute => 'Value'
   # context => 'lineid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldedge.|edge.|)linestyle *:', 0, 0, 0, undef, 0, 'lineid', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|)borderstyle *:'
   # attribute => 'Value'
   # context => 'lineid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|)borderstyle *:', 0, 0, 0, undef, 0, 'lineid', 'Value')) {
      return 1
   }
   # String => 'view *:'
   # attribute => 'Value'
   # context => 'fishid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'view *:', 0, 0, 0, undef, 0, 'fishid', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|)shape'
   # attribute => 'Value'
   # context => 'shapeid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|)shape', 0, 0, 0, undef, 0, 'shapeid', 'Value')) {
      return 1
   }
   # String => '(source|target)(name|)'
   # attribute => 'Value'
   # context => 'lquote'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(source|target)(name|)', 0, 0, 0, undef, 0, 'lquote', 'Value')) {
      return 1
   }
   # String => 'title *:'
   # attribute => 'Value'
   # context => 'lquote'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'title *:', 0, 0, 0, undef, 0, 'lquote', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|foldedge.|edge.|)label *:'
   # attribute => 'Value'
   # context => 'lquote'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|foldedge.|edge.|)label *:', 0, 0, 0, undef, 0, 'lquote', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|foldedge.|edge.|)fontname *:'
   # attribute => 'Value'
   # context => 'fontlq'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|foldedge.|edge.|)fontname *:', 0, 0, 0, undef, 0, 'fontlq', 'Value')) {
      return 1
   }
   # String => 'infoname(1|2|3) *:'
   # attribute => 'Value'
   # context => 'lquote'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'infoname(1|2|3) *:', 0, 0, 0, undef, 0, 'lquote', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|)info(1|2|3) *:'
   # attribute => 'Value'
   # context => 'lquote'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|)info(1|2|3) *:', 0, 0, 0, undef, 0, 'lquote', 'Value')) {
      return 1
   }
   # String => 'spreadlevel *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'spreadlevel *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|)(level|vertical_?order) *:'
   # attribute => 'Value'
   # context => 'nodelevel'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|)(level|vertical_?order) *:', 0, 0, 0, undef, 0, 'nodelevel', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|foldedge.|edge.|)horizontal_?order *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|foldedge.|edge.|)horizontal_?order *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'stat(e|us) *:'
   # attribute => 'Value'
   # context => 'stateid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'stat(e|us) *:', 0, 0, 0, undef, 0, 'stateid', 'Value')) {
      return 1
   }
   # String => 'layout_?algorithm *:'
   # attribute => 'Value'
   # context => 'algid'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'layout_?algorithm *:', 0, 0, 0, undef, 0, 'algid', 'Value')) {
      return 1
   }
   # String => 'crossing_?optimization *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'crossing_?optimization *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'crossing_?phase2 *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'crossing_?phase2 *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => '(dirty_edge_|display_edge_|displayedge|late_edge_|subgraph_?)labels *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(dirty_edge_|display_edge_|displayedge|late_edge_|subgraph_?)labels *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 's?manhatt(a|e)n_?edges *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 's?manhatt(a|e)n_?edges *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => '(nodes|near_?edges|edges|splines) *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(nodes|near_?edges|edges|splines) *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'classname'
   # attribute => 'Value'
   # context => 'classname'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'classname', 0, 0, 0, undef, 0, 'classname', 'Value')) {
      return 1
   }
   # String => 'orientation *:'
   # attribute => 'Value'
   # context => 'orient'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'orientation *:', 0, 0, 0, undef, 0, 'orient', 'Value')) {
      return 1
   }
   # String => 'node_alignment *:'
   # attribute => 'Value'
   # context => 'nodealign'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'node_alignment *:', 0, 0, 0, undef, 0, 'nodealign', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|)textmode *:'
   # attribute => 'Value'
   # context => 'textmode'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|)textmode *:', 0, 0, 0, undef, 0, 'textmode', 'Value')) {
      return 1
   }
   # String => 'equal_y_dist *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'equal_y_dist *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'equal_?ydist *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'equal_?ydist *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'crossing_?weight *:'
   # attribute => 'Value'
   # context => 'weight'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'crossing_?weight *:', 0, 0, 0, undef, 0, 'weight', 'Value')) {
      return 1
   }
   # String => '(fast_?|)icons *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(fast_?|)icons *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'fine_?tuning *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'fine_?tuning *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => '(f?straight_?|priority_)phase *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(f?straight_?|priority_)phase *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'ignore_?singles *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'ignore_?singles *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => '(in|out|)port_?sharing *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(in|out|)port_?sharing *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'linear_?segments *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'linear_?segments *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => '(foldnode.|node.|)(height|width|borderwidth|stretch|shrink) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldnode.|node.|)(height|width|borderwidth|stretch|shrink) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => '(foldedge.|edge.|)(arrowsize|backarrowsize|thickness|class|priority) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(foldedge.|edge.|)(arrowsize|backarrowsize|thickness|class|priority) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'anchor *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'anchor *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'iconcolors *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'iconcolors *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'hidden *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'hidden *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'energetic *:'
   # attribute => 'Value'
   # context => 'boolean'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'energetic *:', 0, 0, 0, undef, 0, 'boolean', 'Value')) {
      return 1
   }
   # String => 'layout_(up|down|near|spline)factor *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'layout_(up|down|near|spline)factor *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'border +(x|y) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'border +(x|y) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'splinefactor *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'splinefactor *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => '(gravity|tempfactor|treefactor) *:'
   # attribute => 'Value'
   # context => 'floatval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(gravity|tempfactor|treefactor) *:', 0, 0, 0, undef, 0, 'floatval', 'Value')) {
      return 1
   }
   # String => '(xspace|xbase|xmax|xraster|x) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(xspace|xbase|xmax|xraster|x) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => '(yspace|ybase|ymax|yraster|y) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(yspace|ybase|ymax|yraster|y) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => '(xlraster|xlspace) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(xlraster|xlspace) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'magnetic_force(1|2) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'magnetic_force(1|2) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'magnetic_field(1|2) *:'
   # attribute => 'Value'
   # context => 'magnor'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'magnetic_field(1|2) *:', 0, 0, 0, undef, 0, 'magnor', 'Value')) {
      return 1
   }
   # String => '(a|b|c|fd|p|r|s)(max) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(a|b|c|fd|p|r|s)(max) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => '(c|p|r)(min) *:'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(c|p|r)(min) *:', 0, 0, 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'forcedir'
   # attribute => 'Value'
   # context => 'intval'
   # type => 'keyword'
   if ($self->testKeyword($text, 'forcedir', 0, undef, 0, 'intval', 'Value')) {
      return 1
   }
   # String => 'scaling *:'
   # attribute => 'Value'
   # context => 'scaling'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'scaling *:', 0, 0, 0, undef, 0, 'scaling', 'Value')) {
      return 1
   }
   # String => 'useraction(name|cmd)(1|2|3|4) *:'
   # attribute => 'Value'
   # context => 'lquote'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'useraction(name|cmd)(1|2|3|4) *:', 0, 0, 0, undef, 0, 'lquote', 'Value')) {
      return 1
   }
   return 0;
};

sub parsefishid {
   my ($self, $text) = @_;
   # String => 'fisheye'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'fisheye', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsefloatval {
   my ($self, $text) = @_;
   # attribute => 'Float'
   # context => 'default'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, 'default', 'Float')) {
      return 1
   }
   return 0;
};

sub parsefontbase {
   my ($self, $text) = @_;
   # String => '((tim|ncen)(R|B|I|BI)|(cour|helv)(R|B|O|BO)|symb)'
   # attribute => 'Datatype'
   # context => 'fontsize'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '((tim|ncen)(R|B|I|BI)|(cour|helv)(R|B|O|BO)|symb)', 0, 0, 0, undef, 0, 'fontsize', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsefontlq {
   my ($self, $text) = @_;
   # attribute => 'Datatype'
   # char => '"'
   # context => 'fontbase'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'fontbase', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsefontsize {
   my ($self, $text) = @_;
   # String => '(08|10|12|14|18|24)(.vcf|)'
   # attribute => 'Datatype'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(08|10|12|14|18|24)(.vcf|)', 0, 0, 0, undef, 0, '#stay', 'Datatype')) {
      return 1
   }
   # attribute => 'Datatype'
   # char => '"'
   # context => 'default'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parseintval {
   my ($self, $text) = @_;
   # attribute => 'Integer'
   # context => 'longint'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, 'longint', 'Integer')) {
      return 1
   }
   return 0;
};

sub parselineid {
   my ($self, $text) = @_;
   # String => 'lines'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'lines', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parselongint {
   my ($self, $text) = @_;
   # attribute => 'Integer'
   # context => 'longint'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, 'longint', 'Integer')) {
      return 1
   }
   # String => '\ '
   # attribute => 'Normal'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\ ', 0, 0, 0, undef, 0, 'default', 'Normal')) {
      return 1
   }
   return 0;
};

sub parselquote {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   return 0;
};

sub parsemagnor {
   my ($self, $text) = @_;
   # String => 'magnetic'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'magnetic', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   # String => 'orientation'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'orientation', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsenodealign {
   my ($self, $text) = @_;
   # String => '(top|center|bottom)'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(top|center|bottom)', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsenodelevel {
   my ($self, $text) = @_;
   # String => 'maxlevel'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'maxlevel', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   # attribute => 'Integer'
   # context => 'longint'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, 'longint', 'Integer')) {
      return 1
   }
   return 0;
};

sub parseorient {
   my ($self, $text) = @_;
   # String => 'orientation'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'orientation', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsergb {
   my ($self, $text) = @_;
   # String => '[0-9][0-9]?[0-9]? +[0-9][0-9]?[0-9]? +[0-9][0-9]?[0-9]?'
   # attribute => 'Integer'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9][0-9]?[0-9]? +[0-9][0-9]?[0-9]? +[0-9][0-9]?[0-9]?', 0, 0, 0, undef, 0, 'default', 'Integer')) {
      return 1
   }
   return 0;
};

sub parsescaling {
   my ($self, $text) = @_;
   # String => 'maxspect'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'maxspect', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   # attribute => 'Float'
   # context => 'default'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, 'default', 'Float')) {
      return 1
   }
   return 0;
};

sub parseshapeid {
   my ($self, $text) = @_;
   # String => 'shapes'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'shapes', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsestateid {
   my ($self, $text) = @_;
   # String => 'states'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'keyword'
   if ($self->testKeyword($text, 'states', 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => 'default'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'default', 'String')) {
      return 1
   }
   # attribute => 'Char'
   # char => '\'
   # char1 => '"'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '"', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '\\(n|a|t|b)'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\(n|a|t|b)', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '\\fi(0|1|2)[0-9][0-9]'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\fi(0|1|2)[0-9][0-9]', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '\\f(u|I|b|B|n|[0-9][0-9])'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\f(u|I|b|B|n|[0-9][0-9])', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   return 0;
};

sub parsetextmode {
   my ($self, $text) = @_;
   # String => '(center|left_justify|right_justify)'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(center|left_justify|right_justify)', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};

sub parseweight {
   my ($self, $text) = @_;
   # String => '(medianbary|barymedian|bary|median)'
   # attribute => 'Datatype'
   # context => 'default'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(medianbary|barymedian|bary|median)', 0, 0, 0, undef, 0, 'default', 'Datatype')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::GDL - a Plugin for GDL syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::GDL;
 my $sh = new Syntax::Highlight::Engine::Kate::GDL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::GDL is a  plugin module that provides syntax highlighting
for GDL to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author