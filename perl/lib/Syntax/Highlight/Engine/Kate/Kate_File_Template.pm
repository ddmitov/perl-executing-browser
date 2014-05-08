# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'katetemplate.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.00
#kate version 2.3
#kate author Anders Lund
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Kate_File_Template;

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
      'Error' => 'Error',
      'Escape' => 'Others',
      'Header Keyword' => 'Operator',
      'Header Text' => 'Normal',
      'Keyword' => 'Keyword',
      'Macro' => 'DataType',
      'Normal Text' => 'Normal',
      'Property' => 'DecVal',
      'Property Value' => 'String',
   });
   $self->listAdd('macros',
      'date',
      'datetime',
      'email',
      'month',
      'organisation',
      'realname',
      'time',
      'username',
      'year',
   );
   $self->listAdd('properties',
      'author',
      'description',
      'documentname',
      'group',
      'highlight',
      'icon',
      'template',
   );
   $self->contextdata({
      'Normal Text' => {
         callback => \&parseNormalText,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'escape' => {
         callback => \&parseescape,
         attribute => 'Escape',
      },
      'header' => {
         callback => \&parseheader,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'headervalue' => {
         callback => \&parseheadervalue,
         attribute => 'Property Value',
         lineending => '#pop#pop',
      },
      'macros' => {
         callback => \&parsemacros,
         attribute => 'Error',
         lineending => '#pop',
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
   return 'Kate File Template';
}

sub parseNormalText {
   my ($self, $text) = @_;
   # String => '^katetemplate:'
   # attribute => 'Header Keyword'
   # context => 'header'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^katetemplate:', 0, 0, 0, undef, 0, 'header', 'Header Keyword')) {
      return 1
   }
   # String => '\\[$%]\{[^}\s]+\}'
   # attribute => 'Normal'
   # context => 'escape'
   # lookAhead => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[$%]\\{[^}\\s]+\\}', 0, 0, 1, undef, 0, 'escape', 'Normal')) {
      return 1
   }
   # String => '[$%]\{[^}\s]+\}'
   # attribute => 'Macro'
   # context => 'macros'
   # lookAhead => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[$%]\\{[^}\\s]+\\}', 0, 0, 1, undef, 0, 'macros', 'Macro')) {
      return 1
   }
   # attribute => 'Escape'
   # char => '\'
   # char1 => '^'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '^', 0, 0, 0, undef, 0, '#stay', 'Escape')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '^'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '^', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseescape {
   my ($self, $text) = @_;
   # attribute => 'Escape'
   # char => '\'
   # char1 => '$'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '$', 0, 0, 0, undef, 0, '#pop', 'Escape')) {
      return 1
   }
   return 0;
};

sub parseheader {
   my ($self, $text) = @_;
   # String => 'properties'
   # attribute => 'Property'
   # context => 'headervalue'
   # type => 'keyword'
   if ($self->testKeyword($text, 'properties', 0, undef, 0, 'headervalue', 'Property')) {
      return 1
   }
   return 0;
};

sub parseheadervalue {
   my ($self, $text) = @_;
   # attribute => 'Header Text'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Header Text')) {
      return 1
   }
   # String => ' \w+\s*='
   # context => '#pop'
   # lookAhead => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' \\w+\\s*=', 0, 0, 1, undef, 0, '#pop', undef)) {
      return 1
   }
   return 0;
};

sub parsemacros {
   my ($self, $text) = @_;
   # attribute => 'Keyword'
   # char => '$'
   # char1 => '{'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '%'
   # char1 => '{'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '{', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   # String => '[^}\s]+'
   # attribute => 'Macro'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^}\\s]+', 0, 0, 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   # String => 'macros'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'macros', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Kate_File_Template - a Plugin for Kate File Template syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Kate_File_Template;
 my $sh = new Syntax::Highlight::Engine::Kate::Kate_File_Template([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Kate_File_Template is a  plugin module that provides syntax highlighting
for Kate File Template to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author