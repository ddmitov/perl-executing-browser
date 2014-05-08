# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'kbasic.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.1
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::KBasic;

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
      'Identifier' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
      'Types' => 'DataType',
   });
   $self->listAdd('keywords',
      'And',
      'As',
      'Close',
      'Declare',
      'Dim',
      'Do',
      'Else',
      'End',
      'Exit',
      'Explicit',
      'False',
      'For',
      'Function',
      'Get',
      'Global',
      'Goto',
      'If',
      'Implements',
      'In',
      'Input',
      'Let',
      'Load',
      'Loop',
      'Next',
      'Not',
      'Open',
      'Option',
      'Or',
      'Output',
      'Print',
      'Private',
      'Property',
      'Public',
      'Put',
      'Repeat',
      'Seek',
      'Set',
      'Sub',
      'Sub',
      'Then',
      'To',
      'True',
      'Unload',
      'Until',
      'Wend',
      'While',
      'Xor',
   );
   $self->listAdd('types',
      'Boolean',
      'Byte',
      'Control',
      'Currency',
      'Double',
      'Integer',
      'Long',
      'Object',
      'Single',
      'String',
      'Variant',
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
   return 'KBasic';
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
   # String => 'types'
   # attribute => 'Identifier'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Identifier')) {
      return 1
   }
   # attribute => 'String'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'Types'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Types')) {
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
   # char => '''
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::KBasic - a Plugin for KBasic syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::KBasic;
 my $sh = new Syntax::Highlight::Engine::Kate::KBasic([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::KBasic is a  plugin module that provides syntax highlighting
for KBasic to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author