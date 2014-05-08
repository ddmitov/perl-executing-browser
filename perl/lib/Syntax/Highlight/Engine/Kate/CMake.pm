# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'cmake.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.4
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::CMake;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Commands' => 'Keyword',
      'Comment' => 'Comment',
      'Macros' => 'Keyword',
      'Normal Text' => 'Normal',
      'Region Marker' => 'RegionMarker',
      'Special Args' => 'Others',
      'Variable' => 'DecVal',
   });
   $self->listAdd('commands',
      'ABSTRACT_FILES',
      'ADD_CUSTOM_COMMAND',
      'ADD_CUSTOM_TARGET',
      'ADD_DEFINITIONS',
      'ADD_DEPENDENCIES',
      'ADD_EXECUTABLE',
      'ADD_LIBRARY',
      'ADD_TEST',
      'AUX_SOURCE_DIRECTORY',
      'BUILD_COMMAND',
      'BUILD_NAME',
      'CMAKE_MINIMUM_REQUIRED',
      'CONFIGURE_FILE',
      'CREATE_TEST_SOURCELIST',
      'ELSE',
      'ENABLE_TESTING',
      'ENDFOREACH',
      'ENDIF',
      'ENDMACRO',
      'EXEC_PROGRAM',
      'EXPORT_LIBRARY_DEPENDENCIES',
      'FILE',
      'FIND_FILE',
      'FIND_LIBRARY',
      'FIND_PACKAGE',
      'FIND_PATH',
      'FIND_PROGRAM',
      'FLTK_WRAP_UI',
      'FOREACH',
      'GET_CMAKE_PROPERTY',
      'GET_DIRECTORY_PROPERTY',
      'GET_FILENAME_COMPONENT',
      'GET_SOURCE_FILE_PROPERTY',
      'GET_TARGET_PROPERTY',
      'IF',
      'INCLUDE',
      'INCLUDE_DIRECTORIES',
      'INCLUDE_EXTERNAL_MSPROJECT',
      'INCLUDE_REGULAR_EXPRESSION',
      'INSTALL_FILES',
      'INSTALL_PROGRAMS',
      'INSTALL_TARGETS',
      'ITK_WRAP_TCL',
      'LINK_DIRECTORIE',
      'LINK_LIBRARIES',
      'LOAD_CACHE',
      'LOAD_COMMAND',
      'MACRO',
      'MAKE_DIRECTORY',
      'MARK_AS_ADVANCED',
      'MESSAGE',
      'OPTION',
      'OUTPUT_REQUIRED_FILES',
      'PROJECT',
      'QT_WRAP_CPP',
      'QT_WRAP_UI',
      'REMOVE',
      'REMOVE_DEFINITIONS',
      'SEPARATE_ARGUMENTS',
      'SET',
      'SET_DIRECTORY_PROPERTIES',
      'SET_SOURCE_FILES_PROPERTIES',
      'SET_TARGET_PROPERTIES',
      'SITE_NAME',
      'SOURCE_FILES',
      'SOURCE_FILES_REMOVE',
      'SOURCE_GROUP',
      'STRING',
      'SUBDIRS',
      'SUBDIR_DEPENDS',
      'TARGET_LINK_LIBRARIES',
      'TRY_COMPILE',
      'TRY_RUN',
      'USE_MANGLED_MESA',
      'UTILITY_SOURCE',
      'VARIABLE_REQUIRES',
      'VTK_MAKE_INSTANTIATOR',
      'VTK_WRAP_JAVA',
      'VTK_WRAP_PYTHON',
      'VTK_WRAP_TCL',
      'WRAP_EXCLUDE_FILES',
      'WRITE_FILE',
   );
   $self->listAdd('special_args',
      'ABSOLUTE',
      'ABSTRACT',
      'ADDITIONAL_MAKE_CLEAN_FILES',
      'ALL',
      'AND',
      'APPEND',
      'ARGS',
      'ASCII',
      'BEFORE',
      'CACHE',
      'CACHE_VARIABLES',
      'CLEAR',
      'COMMAND',
      'COMMANDS',
      'COMMAND_NAME',
      'COMMENT',
      'COMPARE',
      'COMPILE_FLAGS',
      'COPYONLY',
      'DEFINED',
      'DEFINE_SYMBOL',
      'DEPENDS',
      'DOC',
      'EQUAL',
      'ESCAPE_QUOTES',
      'EXCLUDE',
      'EXCLUDE_FROM_ALL',
      'EXISTS',
      'EXPORT_MACRO',
      'EXT',
      'EXTRA_INCLUDE',
      'FATAL_ERROR',
      'FILE',
      'FILES',
      'FORCE',
      'FUNCTION',
      'GENERATED',
      'GLOB',
      'GLOB_RECURSE',
      'GREATER',
      'GROUP_SIZE',
      'HEADER_FILE_ONLY',
      'HEADER_LOCATION',
      'IMMEDIATE',
      'INCLUDES',
      'INCLUDE_DIRECTORIES',
      'INCLUDE_INTERNALS',
      'INCLUDE_REGULAR_EXPRESSION',
      'LESS',
      'LINK_DIRECTORIES',
      'LINK_FLAGS',
      'LOCATION',
      'MACOSX_BUNDLE',
      'MACROS',
      'MAIN_DEPENDENCY',
      'MAKE_DIRECTORY',
      'MATCH',
      'MATCHALL',
      'MATCHES',
      'MODULE',
      'NAME',
      'NAME_WE',
      'NOT',
      'NOTEQUAL',
      'NO_SYSTEM_PATH',
      'OBJECT_DEPENDS',
      'OPTIONAL',
      'OR',
      'OUTPUT',
      'OUTPUT_VARIABLE',
      'PATH',
      'PATHS',
      'POST_BUILD',
      'POST_INSTALL_SCRIPT',
      'PREFIX',
      'PREORDER',
      'PRE_BUILD',
      'PRE_INSTALL_SCRIPT',
      'PRE_LINK',
      'PROGRAM',
      'PROGRAM_ARGS',
      'PROPERTIES',
      'QUIET',
      'RANGE',
      'READ',
      'REGEX',
      'REGULAR_EXPRESSION',
      'REPLACE',
      'REQUIRED',
      'RETURN_VALUE',
      'RUNTIME_DIRECTORY',
      'SEND_ERROR',
      'SHARED',
      'SOURCES',
      'STATIC',
      'STATUS',
      'STREQUAL',
      'STRGREATER',
      'STRLESS',
      'SUFFIX',
      'TARGET',
      'TOLOWER',
      'TOUPPER',
      'VAR',
      'VARIABLES',
      'VERSION',
      'WIN32',
      'WRAP_EXCLUDE',
      'WRITE',
   );
   $self->contextdata({
      'Function Args' => {
         callback => \&parseFunctionArgs,
         attribute => 'Normal Text',
      },
      'Normal Text' => {
         callback => \&parseNormalText,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal Text');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'CMake';
}

sub parseFunctionArgs {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # String => 'special_args'
   # attribute => 'Special Args'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'special_args', 0, undef, 0, '#stay', 'Special Args')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\$\{\s*\w+\s*\}'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$\\{\\s*\\w+\\s*\\}', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   return 0;
};

sub parseNormalText {
   my ($self, $text) = @_;
   # String => 'commands'
   # attribute => 'Commands'
   # context => 'Function Args'
   # type => 'keyword'
   if ($self->testKeyword($text, 'commands', 0, undef, 0, 'Function Args', 'Commands')) {
      return 1
   }
   # String => '#\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'block'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '#\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'block'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\$\{\s*\w+\s*\}'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$\\{\\s*\\w+\\s*\\}', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => '\s*\w+\s*(?=\(.*\))'
   # attribute => 'Macros'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*\\w+\\s*(?=\\(.*\\))', 0, 0, 0, undef, 0, '#stay', 'Macros')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::CMake - a Plugin for CMake syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::CMake;
 my $sh = new Syntax::Highlight::Engine::Kate::CMake([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::CMake is a  plugin module that provides syntax highlighting
for CMake to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author