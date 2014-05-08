# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'tcl.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.08
#kate version 2.4
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Tcl_Tk;

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
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Parameter' => 'Others',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'Variable' => 'DataType',
   });
   $self->listAdd('keywords',
      'AppleScript',
      'OptProc',
      'after',
      'append',
      'argc',
      'argv',
      'array',
      'auto_execk',
      'auto_load',
      'auto_mkindex',
      'auto_path',
      'auto_reset',
      'beep',
      'bell',
      'bgerror',
      'binary',
      'bind',
      'bindtags',
      'break',
      'button',
      'canvas',
      'case',
      'catch',
      'cd',
      'checkbutton',
      'clipboard',
      'clock',
      'close',
      'concat',
      'console',
      'continue',
      'dde',
      'destroy',
      'else',
      'elseif',
      'encoding',
      'entry',
      'env',
      'eof',
      'error',
      'errorCode',
      'errorInfo',
      'eval',
      'event',
      'exec',
      'exit',
      'expr',
      'fblocked',
      'fconfigure',
      'fcopy',
      'file',
      'fileevent',
      'flush',
      'focus',
      'font',
      'for',
      'foreach',
      'format',
      'frame',
      'gets',
      'glob',
      'global',
      'grab',
      'grid',
      'history',
      'if',
      'image',
      'incr',
      'info',
      'interp',
      'join',
      'label',
      'lappend',
      'lindex',
      'linsert',
      'list',
      'listbox',
      'llength',
      'load',
      'lower',
      'lrange',
      'lreplace',
      'lsearch',
      'lsort',
      'menu',
      'menubutton',
      'message',
      'namespace',
      'open',
      'option',
      'pack',
      'package',
      'parray',
      'pid',
      'pkg_mkindex',
      'place',
      'proc',
      'puts',
      'pwd',
      'radiobutton',
      'raise',
      'read',
      'regexp',
      'registry',
      'regsub',
      'rename',
      'resource',
      'return',
      'scale',
      'scan',
      'scrollbar',
      'seek',
      'selection',
      'send',
      'set',
      'socket',
      'source',
      'split',
      'string',
      'subst',
      'switch',
      'tclLog',
      'tcl_endOfWord',
      'tcl_findLibrary',
      'tcl_library',
      'tcl_patchLevel',
      'tcl_platform',
      'tcl_precision',
      'tcl_rcFileName',
      'tcl_rcRsrcName',
      'tcl_startOfNextWord',
      'tcl_startOfPreviousWord',
      'tcl_traceCompile',
      'tcl_traceExec',
      'tcl_version',
      'tcl_wordBreakAfter',
      'tcl_wordBreakBefore',
      'tell',
      'text',
      'time',
      'tk',
      'tkTabToWindow',
      'tk_chooseColor',
      'tk_chooseDirectory',
      'tk_focusFollowMouse',
      'tk_focusNext',
      'tk_focusPrev',
      'tk_getOpenFile',
      'tk_getSaveFile',
      'tk_library',
      'tk_messageBox',
      'tk_optionMenu',
      'tk_patchLevel',
      'tk_popup',
      'tk_strictMotif',
      'tk_version',
      'tkwait',
      'toplevel',
      'trace',
      'unknown',
      'unset',
      'update',
      'uplevel',
      'upvar',
      'variable',
      'vwait',
      'while',
      'winfo',
      'wm',
   );
   $self->listAdd('keywords-opt',
      'activate',
      'actual',
      'add',
      'addtag',
      'append',
      'appname',
      'args',
      'aspect',
      'atime',
      'atom',
      'atomname',
      'attributes',
      'bbox',
      'bind',
      'body',
      'broadcast',
      'bytelength',
      'cancel',
      'canvasx',
      'canvasy',
      'caret',
      'cells',
      'cget',
      'channels',
      'children',
      'class',
      'clear',
      'clicks',
      'client',
      'clone',
      'cmdcount',
      'colormapfull',
      'colormapwindows',
      'command',
      'commands',
      'compare',
      'complete',
      'configure',
      'containing',
      'convertfrom',
      'convertto',
      'coords',
      'copy',
      'create',
      'current',
      'curselection',
      'dchars',
      'debug',
      'default',
      'deiconify',
      'delete',
      'delta',
      'depth',
      'deselect',
      'dirname',
      'dlineinfo',
      'dtag',
      'dump',
      'edit',
      'entrycget',
      'entryconfigure',
      'equal',
      'executable',
      'exists',
      'extension',
      'families',
      'find',
      'first',
      'flash',
      'focus',
      'focusmodel',
      'forget',
      'format',
      'fpixels',
      'fraction',
      'frame',
      'functions',
      'generate',
      'geometry',
      'get',
      'gettags',
      'globals',
      'grid',
      'group',
      'handle',
      'height',
      'hide',
      'hostname',
      'iconbitmap',
      'iconify',
      'iconmask',
      'iconname',
      'iconposition',
      'iconwindow',
      'icursor',
      'id',
      'identify',
      'idle',
      'ifneeded',
      'image',
      'index',
      'info',
      'insert',
      'interps',
      'inuse',
      'invoke',
      'is',
      'isdirectory',
      'isfile',
      'ismapped',
      'itemcget',
      'itemconfigure',
      'join',
      'keys',
      'last',
      'length',
      'level',
      'library',
      'link',
      'loaded',
      'locals',
      'lower',
      'lstat',
      'manager',
      'map',
      'mark',
      'match',
      'maxsize',
      'measure',
      'metrics',
      'minsize',
      'mkdir',
      'move',
      'mtime',
      'name',
      'nameofexecutable',
      'names',
      'nativename',
      'nearest',
      'normalize',
      'number',
      'overrideredirect',
      'own',
      'owned',
      'panecget',
      'paneconfigure',
      'panes',
      'parent',
      'patchlevel',
      'pathname',
      'pathtype',
      'pixels',
      'pointerx',
      'pointerxy',
      'pointery',
      'positionfrom',
      'post',
      'postcascade',
      'postscript',
      'present',
      'procs',
      'protocol',
      'provide',
      'proxy',
      'raise',
      'range',
      'readable',
      'readlink',
      'release',
      'remove',
      'rename',
      'repeat',
      'replace',
      'reqheight',
      'require',
      'reqwidth',
      'resizable',
      'rgb',
      'rootname',
      'rootx',
      'rooty',
      'scale',
      'scaling',
      'scan',
      'screen',
      'screencells',
      'screendepth',
      'screenheight',
      'screenmmheight',
      'screenmmwidth',
      'screenvisual',
      'screenwidth',
      'script',
      'search',
      'seconds',
      'see',
      'select',
      'selection',
      'separator',
      'server',
      'set',
      'sharedlibextension',
      'show',
      'size',
      'sizefrom',
      'split',
      'stackorder',
      'stat',
      'state',
      'status',
      'system',
      'tag',
      'tail',
      'tclversion',
      'title',
      'tolower',
      'toplevel',
      'totitle',
      'toupper',
      'transient',
      'trim',
      'trimleft',
      'trimright',
      'type',
      'types',
      'unknown',
      'unpost',
      'useinputmethods',
      'validate',
      'values',
      'variable',
      'vars',
      'vcompare',
      'vdelete',
      'versions',
      'viewable',
      'vinfo',
      'visual',
      'visualid',
      'visualsavailable',
      'volumes',
      'vrootheight',
      'vrootwidth',
      'vrootx',
      'vrooty',
      'vsatisfies',
      'width',
      'window',
      'windowingsystem',
      'withdraw',
      'wordend',
      'wordstart',
      'writable',
      'x',
      'xview',
      'y',
   );
   $self->contextdata({
      'Base' => {
         callback => \&parseBase,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Base');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Tcl/Tk';
}

sub parseBase {
   my ($self, $text) = @_;
   # String => '#\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'region'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '#\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'region'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywords-opt'
   # attribute => 'Parameter'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords-opt', 0, undef, 0, '#stay', 'Parameter')) {
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
   # String => '\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '\W-\w+'
   # attribute => 'Parameter'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\W-\\w+', 0, 0, 0, undef, 0, '#stay', 'Parameter')) {
      return 1
   }
   # String => '\$\{[^\}]+\}'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$\\{[^\\}]+\\}', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => '\$(::)?[\S\D]\w+'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$(::)?[\\S\\D]\\w+', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => '[^\\]""'
   # attribute => 'String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^\\\\]""', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '[^\\]"'
   # attribute => 'String'
   # context => 'String'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^\\\\]"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 1, '#stay', 'Comment')) {
      return 1
   }
   # String => ';\s*#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';\\s*#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # attribute => 'Keyword'
   # beginRegion => 'block'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '}'
   # context => '#stay'
   # endRegion => 'block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '['
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => ']'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # attribute => 'Variable'
   # char => '$'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Tcl_Tk - a Plugin for Tcl/Tk syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Tcl_Tk;
 my $sh = new Syntax::Highlight::Engine::Kate::Tcl_Tk([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Tcl_Tk is a  plugin module that provides syntax highlighting
for Tcl/Tk to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author