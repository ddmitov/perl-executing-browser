# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'winehq.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.4
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::WINE_Config;

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
      'Key' => 'DataType',
      'Normal Text' => 'Normal',
      'RegistryBeginEnd' => 'Float',
      'Section' => 'Keyword',
      'Value' => 'Variable',
      'ValueFilesystem1' => 'BaseN',
      'ValueFilesystem2' => 'DecVal',
   });
   $self->contextdata({
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Value' => {
         callback => \&parseValue,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'WINE Config';
}

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'WINE REGISTRY Version.*$'
   # attribute => 'RegistryBeginEnd'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'WINE REGISTRY Version.*$', 0, 0, 0, undef, 0, '#stay', 'RegistryBeginEnd')) {
      return 1
   }
   # String => '#\s*<\s*wineconf\s*>'
   # attribute => 'RegistryBeginEnd'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*<\\s*wineconf\\s*>', 0, 0, 0, 0, 0, '#stay', 'RegistryBeginEnd')) {
      return 1
   }
   # String => '#\s*<\s*\/\s*wineconf\s*>'
   # attribute => 'RegistryBeginEnd'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*<\\s*\\/\\s*wineconf\\s*>', 0, 0, 0, 0, 0, '#stay', 'RegistryBeginEnd')) {
      return 1
   }
   # String => '\[.*\]$'
   # attribute => 'Section'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\[.*\\]$', 0, 0, 0, 0, 0, '#stay', 'Section')) {
      return 1
   }
   # String => ';.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\s*"\s*[a-zA-Z0-9_.:*]*\s*"'
   # attribute => 'Key'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*"\\s*[a-zA-Z0-9_.:*]*\\s*"', 0, 0, 0, undef, 0, '#stay', 'Key')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '='
   # context => 'Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, 'Value', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseValue {
   my ($self, $text) = @_;
   # String => '\s*".*"'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*".*"', 0, 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # String => ';.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::WINE_Config - a Plugin for WINE Config syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::WINE_Config;
 my $sh = new Syntax::Highlight::Engine::Kate::WINE_Config([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::WINE_Config is a  plugin module that provides syntax highlighting
for WINE Config to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author