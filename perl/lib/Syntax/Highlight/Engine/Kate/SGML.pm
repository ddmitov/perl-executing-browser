# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'sgml.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.1
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::SGML;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Attribute Name' => 'Others',
      'Attribute Value' => 'DataType',
      'Comment' => 'Comment',
      'Normal Text' => 'Normal',
      'Tag' => 'Keyword',
   });
   $self->contextdata({
      'Attribute' => {
         callback => \&parseAttribute,
         attribute => 'Attribute Name',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
      },
      'Normal Text' => {
         callback => \&parseNormalText,
         attribute => 'Normal Text',
      },
      'Value' => {
         callback => \&parseValue,
         attribute => 'Attribute Value',
      },
      'Value 2' => {
         callback => \&parseValue2,
         attribute => 'Attribute Value',
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
   return 'SGML';
}

sub parseAttribute {
   my ($self, $text) = @_;
   # attribute => 'Tag'
   # char => '/'
   # char1 => '>'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop', 'Tag')) {
      return 1
   }
   # attribute => 'Tag'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Tag')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Normal Text'
   # context => 'Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'Value', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   # String => '-->'
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '-->', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseNormalText {
   my ($self, $text) = @_;
   # String => '<!--'
   # attribute => 'Comment'
   # context => 'Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # String => '<\s*\/?\s*[a-zA-Z_:][a-zA-Z0-9._:-]*'
   # attribute => 'Tag'
   # context => 'Attribute'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*[a-zA-Z_:][a-zA-Z0-9._:-]*', 0, 0, 0, undef, 0, 'Attribute', 'Tag')) {
      return 1
   }
   return 0;
};

sub parseValue {
   my ($self, $text) = @_;
   # attribute => 'Tag'
   # char => '/'
   # char1 => '>'
   # context => '#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop#pop', 'Tag')) {
      return 1
   }
   # attribute => 'Tag'
   # char => '>'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop#pop', 'Tag')) {
      return 1
   }
   # attribute => 'Attribute Value'
   # char => '"'
   # context => 'Value 2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Value 2', 'Attribute Value')) {
      return 1
   }
   return 0;
};

sub parseValue2 {
   my ($self, $text) = @_;
   # attribute => 'Attribute Value'
   # char => '"'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop#pop', 'Attribute Value')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::SGML - a Plugin for SGML syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::SGML;
 my $sh = new Syntax::Highlight::Engine::Kate::SGML([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::SGML is a  plugin module that provides syntax highlighting
for SGML to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author