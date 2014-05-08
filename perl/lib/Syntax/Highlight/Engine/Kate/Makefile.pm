# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'makefile.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.06
#kate version 2.4
#kate author Per Wigren (wigren@home.se)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Makefile;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Commands' => 'BaseN',
      'Comment' => 'Comment',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operator' => 'Char',
      'Section' => 'Others',
      'Special' => 'Float',
      'String' => 'String',
      'Target' => 'DecVal',
      'Variable' => 'DataType',
   });
   $self->listAdd('keywords',
      'define',
      'else',
      'endef',
      'endif',
      'ifdef',
      'ifeq',
      'ifndef',
      'ifneq',
      'include',
   );
   $self->contextdata({
      'Commands' => {
         callback => \&parseCommands,
         attribute => 'Normal Text',
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
      'Value' => {
         callback => \&parseValue,
         attribute => 'String',
      },
      'VarFromNormal' => {
         callback => \&parseVarFromNormal,
         attribute => 'Variable',
      },
      'VarFromValue' => {
         callback => \&parseVarFromValue,
         attribute => 'Variable',
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
   return 'Makefile';
}

sub parseCommands {
   my ($self, $text) = @_;
   # String => '[$][\({]'
   # attribute => 'Operator'
   # context => 'VarFromNormal'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[$][\\({]', 0, 0, 0, undef, 0, 'VarFromNormal', 'Operator')) {
      return 1
   }
   # String => '[_\w-]*\b'
   # attribute => 'Commands'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[_\\w-]*\\b', 0, 0, 0, undef, 0, '#pop', 'Commands')) {
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
   # String => '[_\w\d]*\s*(?=:=|=)'
   # attribute => 'Variable'
   # context => 'Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[_\\w\\d]*\\s*(?=:=|=)', 0, 0, 0, undef, 0, 'Value', 'Variable')) {
      return 1
   }
   # String => '[_\w\d-]*\s*:'
   # attribute => 'Target'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[_\\w\\d-]*\\s*:', 0, 0, 0, undef, 1, '#stay', 'Target')) {
      return 1
   }
   # String => '^[.].*:'
   # attribute => 'Section'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[.].*:', 0, 0, 0, undef, 0, '#stay', 'Section')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '[$][\({]'
   # attribute => 'Operator'
   # context => 'VarFromNormal'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[$][\\({]', 0, 0, 0, undef, 0, 'VarFromNormal', 'Operator')) {
      return 1
   }
   # String => '+*=%$():\\;'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '+*=%$():\\\\;', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '[@-]'
   # attribute => 'Operator'
   # context => 'Commands'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[@-]', 0, 0, 0, undef, 1, 'Commands', 'Operator')) {
      return 1
   }
   # String => '(:^|[^\\])#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(:^|[^\\\\])#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
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
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};

sub parseValue {
   my ($self, $text) = @_;
   # String => '\\$'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\$', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '[^\\]?$'
   # attribute => 'String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^\\\\]?$', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # String => '[$][\({]'
   # attribute => 'Operator'
   # context => 'VarFromValue'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[$][\\({]', 0, 0, 0, undef, 0, 'VarFromValue', 'Operator')) {
      return 1
   }
   # String => '@[-_\d\w]*@'
   # attribute => 'Special'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '@[-_\\d\\w]*@', 0, 0, 0, undef, 0, '#pop', 'Special')) {
      return 1
   }
   # attribute => 'Operator'
   # char => ';'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'Operator')) {
      return 1
   }
   return 0;
};

sub parseVarFromNormal {
   my ($self, $text) = @_;
   # String => '[\)}]'
   # attribute => 'Operator'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\)}]', 0, 0, 0, undef, 0, '#pop', 'Operator')) {
      return 1
   }
   return 0;
};

sub parseVarFromValue {
   my ($self, $text) = @_;
   # String => '[\)}](?=/)'
   # attribute => 'Operator'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\)}](?=/)', 0, 0, 0, undef, 0, '#pop', 'Operator')) {
      return 1
   }
   # String => '[\)}][^$]'
   # attribute => 'Operator'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\)}][^$]', 0, 0, 0, undef, 0, '#pop', 'Operator')) {
      return 1
   }
   # String => '[\)}]$'
   # attribute => 'Operator'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\)}]$', 0, 0, 0, undef, 0, '#pop#pop', 'Operator')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Makefile - a Plugin for Makefile syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Makefile;
 my $sh = new Syntax::Highlight::Engine::Kate::Makefile([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Makefile is a  plugin module that provides syntax highlighting
for Makefile to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author