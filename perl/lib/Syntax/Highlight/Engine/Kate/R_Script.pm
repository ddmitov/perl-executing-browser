# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'r.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.1
#kate author E.L. Willighagen
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::R_Script;

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
      'Control Structure' => 'Normal',
      'Infix' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operators' => 'Operator',
      'Reserved Words' => 'Reserved',
      'String' => 'String',
   });
   $self->listAdd('controls',
      'break',
      'else',
      'for',
      'function',
      'if',
      'in',
      'next',
      'repeat',
      'switch',
      'while',
   );
   $self->listAdd('words',
      'FALSE',
      'Inf',
      'NA',
      'NULL',
      'NaN',
      'TRUE',
   );
   $self->contextdata({
      'ctx0' => {
         callback => \&parsectx0,
         attribute => 'Normal Text',
      },
      'ctx1' => {
         callback => \&parsectx1,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('ctx0');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'R Script';
}

sub parsectx0 {
   my ($self, $text) = @_;
   # String => 'controls'
   # attribute => 'Control Structure'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'controls', 0, undef, 0, '#stay', 'Control Structure')) {
      return 1
   }
   # String => 'words'
   # attribute => 'Reserved Words'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'words', 0, undef, 0, '#stay', 'Reserved Words')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'ctx1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'ctx1', 'String')) {
      return 1
   }
   # String => '[a-zA-Z_]+ *\('
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z_]+ *\\(', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '('
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => ')'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '+-*/^:$~!&|=><@'
   # attribute => 'Operators'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '+-*/^:$~!&|=><@', 0, 0, undef, 0, '#stay', 'Operators')) {
      return 1
   }
   # String => '%[a-zA-Z_]*%'
   # attribute => 'Operators'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%[a-zA-Z_]*%', 0, 0, 0, undef, 0, '#stay', 'Operators')) {
      return 1
   }
   return 0;
};

sub parsectx1 {
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

Syntax::Highlight::Engine::Kate::R_Script - a Plugin for R Script syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::R_Script;
 my $sh = new Syntax::Highlight::Engine::Kate::R_Script([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::R_Script is a  plugin module that provides syntax highlighting
for R Script to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author