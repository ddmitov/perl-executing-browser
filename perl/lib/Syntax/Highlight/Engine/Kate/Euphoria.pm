# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'euphoria.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 2.08
#kate version 2.4
#kate author Irv Mullins (irvm@ellijay.com)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Euphoria;

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
      'Directive' => 'Others',
      'GtkKeyword' => 'Keyword',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Number' => 'DecVal',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'Type' => 'DataType',
   });
   $self->listAdd('GtkKeywords',
      'Error',
      'FALSE',
      'Info',
      'NULL',
      'Question',
      'TRUE',
      'Warn',
      'YesNo',
      'addto',
      'adjustment',
      'alignment',
      'append_page',
      'appendto',
      'arrow',
      'aspect_frame',
      'button',
      'calendar',
      'cell_renderer_text',
      'cell_renderer_toggle',
      'check',
      'check_menu_item',
      'checkbutton',
      'choice',
      'color_selection',
      'combo',
      'connect',
      'deallocate_strings',
      'draw_arc',
      'draw_image',
      'draw_line',
      'draw_line',
      'draw_point',
      'draw_polygon',
      'draw_rectangle',
      'drawingarea',
      'end_submenu',
      'entry',
      'euget',
      'event_box',
      'file_selection',
      'flatten',
      'font',
      'font_selection_dialog',
      'frame',
      'g_list',
      'g_list_to_sequence',
      'get',
      'getImage',
      'getSize',
      'hbox',
      'hbuttonbox',
      'hpaned',
      'hscale',
      'hscrollbar',
      'hseparator',
      'idle_add',
      'image',
      'image_menu_item',
      'init',
      'label',
      'limit',
      'list_store',
      'list_view',
      'list_view_column',
      'main',
      'mark_day',
      'menu',
      'menu_item',
      'menubar',
      'mouse_button',
      'new_gc',
      'new_group',
      'new_menu_group',
      'notebook',
      'option',
      'option_menu',
      'pack',
      'path',
      'pop',
      'progress_bar',
      'push',
      'quit',
      'radio',
      'radio_menu_item',
      'radiobutton',
      'rc_parse',
      'run',
      'scrolled_window',
      'separator_menu_item',
      'seq_to_str',
      'set',
      'setProperty',
      'set_submenu',
      'setfg',
      'show',
      'spinbutton',
      'statusbar',
      'str',
      'table',
      'textbox',
      'timer',
      'togglebutton',
      'toolbar',
      'tooltip',
      'tree_store',
      'tree_view',
      'tree_view_column',
      'vbox',
      'vbuttonbox',
      'vpaned',
      'vscale',
      'vscrollbar',
      'vseparator',
      'when',
      'window',
   );
   $self->listAdd('constants',
      'GET_SUCCESS',
      'PI',
   );
   $self->listAdd('keywords',
      '?',
      'abort',
      'allocate',
      'allocate_string',
      'allow_break',
      'and',
      'and_bits',
      'append',
      'arccos',
      'arcsin',
      'arctan',
      'as',
      'atom_to_float32',
      'atom_to_float64',
      'begin',
      'bits_to_int',
      'bytes_to_int',
      'c_func',
      'c_proc',
      'call',
      'call_back',
      'call_func',
      'call_proc',
      'chdir',
      'check_break',
      'clear_screen',
      'close',
      'command_line',
      'compare',
      'cos',
      'crash_file',
      'crash_message',
      'current_dir',
      'custom_sort',
      'date',
      'define_c_func',
      'define_c_proc',
      'define_c_var',
      'dir',
      'display_text_image',
      'do',
      'else',
      'elsif',
      'end',
      'equal',
      'exit',
      'find',
      'float32_to_atom',
      'float64_to_atom',
      'floor',
      'flush',
      'for',
      'free',
      'free_console',
      'function',
      'get_bytes',
      'get_key',
      'get_mouse',
      'get_position',
      'get_screen_char',
      'getc',
      'getenv',
      'gets',
      'if',
      'include',
      'int_to_bits',
      'int_to_bytes',
      'length',
      'lock_file',
      'log',
      'lower',
      'machine_func',
      'machine_proc',
      'match',
      'mem_copy',
      'mem_set',
      'mouse_events',
      'mouse_pointer',
      'not',
      'not_bits',
      'of',
      'open',
      'open_dll',
      'or',
      'or_bits',
      'peek',
      'peek4',
      'peek4s',
      'peek4u',
      'platform',
      'poke',
      'poke4',
      'position',
      'power',
      'prepend',
      'print',
      'printf',
      'procedure',
      'profile',
      'prompt_number',
      'prompt_string',
      'put_screen_char',
      'puts',
      'rand',
      'read_bitmap',
      'register_block',
      'remainder',
      'repeat',
      'return',
      'reverse',
      'routine_id',
      'save_bitmap',
      'save_text_image',
      'scroll',
      'seek',
      'set_rand',
      'sin',
      'sleep',
      'sort',
      'sprint',
      'sprintf',
      'sqrt',
      'system',
      'system_exec',
      'tan',
      'text_color',
      'then',
      'time',
      'to',
      'trace',
      'type',
      'unlock_file',
      'unregister_block',
      'upper',
      'value',
      'video_config',
      'wait_key',
      'walk_dir',
      'where',
      'while',
      'wildcard_file',
      'wildcard_match',
      'with',
      'without',
      'wrap',
      'xor',
      'xor_bits',
   );
   $self->listAdd('types',
      'atom',
      'constant',
      'global',
      'integer',
      'object',
      'sequence',
      'type',
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
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Euphoria';
}

sub parseComment {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '\bend\s+for\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regFor'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s+for\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bfor\b'
   # attribute => 'Keyword'
   # beginRegion => 'regFor'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfor\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\s+if\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regIf'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s+if\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bif\b'
   # attribute => 'Keyword'
   # beginRegion => 'regIf'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bif\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\s+function\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regFunction'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s+function\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bfunction\b'
   # attribute => 'Keyword'
   # beginRegion => 'regFunction'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfunction\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\s+procedure\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regProcedure'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s+procedure\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bprocedure\b'
   # attribute => 'Keyword'
   # beginRegion => 'regProcedure'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bprocedure\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\s+while\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regWhile'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s+while\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bwhile\b'
   # attribute => 'Keyword'
   # beginRegion => 'regWhile'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bwhile\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bend\s+type\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'regType'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend\\s+type\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\btype\b'
   # attribute => 'Keyword'
   # beginRegion => 'regType'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\btype\\b', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'GtkKeywords'
   # attribute => 'GtkKeyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'GtkKeywords', 0, undef, 0, '#stay', 'GtkKeyword')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Type')) {
      return 1
   }
   # attribute => 'Number'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # attribute => 'Number'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '--\s*BEGIN.*'
   # attribute => 'Region Marker'
   # beginRegion => 'regMarker'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '--\\s*BEGIN.*', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '--\s*END.*'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'regMarker'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '--\\s*END.*', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
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

Syntax::Highlight::Engine::Kate::Euphoria - a Plugin for Euphoria syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Euphoria;
 my $sh = new Syntax::Highlight::Engine::Kate::Euphoria([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Euphoria is a  plugin module that provides syntax highlighting
for Euphoria to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author