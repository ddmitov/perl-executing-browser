# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'matlab.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.20
#kate version 2.2
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Matlab;

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
      'Delimiter' => 'Normal',
      'Incomplete String' => 'Char',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Number' => 'Float',
      'Operator' => 'Normal',
      'String' => 'String',
      'System' => 'BaseN',
      'Variable' => 'Variable',
   });
   $self->listAdd('KeywordsList',
      'break',
      'case',
      'catch',
      'continue',
      'else',
      'elseif',
      'end',
      'for',
      'function',
      'global',
      'if',
      'otherwise',
      'persistent',
      'return',
      'switch',
      'try',
      'while',
   );
   $self->contextdata({
      '_adjoint' => {
         callback => \&parse_adjoint,
         attribute => 'Operator',
         lineending => '#pop',
      },
      '_normal' => {
         callback => \&parse_normal,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('_normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Matlab';
}

sub parse_adjoint {
   my ($self, $text) = @_;
   # String => ''+'
   # attribute => 'Operator'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'+', 0, 0, 0, undef, 0, '#pop', 'Operator')) {
      return 1
   }
   return 0;
};

sub parse_normal {
   my ($self, $text) = @_;
   # String => '[a-zA-Z]\w*(?=')'
   # attribute => 'Variable'
   # context => '_adjoint'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z]\\w*(?=\')', 0, 0, 0, undef, 0, '_adjoint', 'Variable')) {
      return 1
   }
   # String => '(\d+(\.\d+)?|\.\d+)([eE][+-]?\d+)?[ij]?(?=')'
   # attribute => 'Number'
   # context => '_adjoint'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\d+(\\.\\d+)?|\\.\\d+)([eE][+-]?\\d+)?[ij]?(?=\')', 0, 0, 0, undef, 0, '_adjoint', 'Number')) {
      return 1
   }
   # String => '[\)\]}](?=')'
   # attribute => 'Delimiter'
   # context => '_adjoint'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\)\\]}](?=\')', 0, 0, 0, undef, 0, '_adjoint', 'Delimiter')) {
      return 1
   }
   # String => '\.'(?=')'
   # attribute => 'Operator'
   # context => '_adjoint'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.\'(?=\')', 0, 0, 0, undef, 0, '_adjoint', 'Operator')) {
      return 1
   }
   # String => ''[^']*(''[^']*)*'(?=[^']|$)'
   # attribute => 'String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*(\'\'[^\']*)*\'(?=[^\']|$)', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => ''[^']*(''[^']*)*'
   # attribute => 'Incomplete String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*(\'\'[^\']*)*', 0, 0, 0, undef, 0, '#stay', 'Incomplete String')) {
      return 1
   }
   # String => 'KeywordsList'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'KeywordsList', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '%.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '!.*$'
   # attribute => 'System'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '!.*$', 0, 0, 0, undef, 0, '#stay', 'System')) {
      return 1
   }
   # String => '[a-zA-Z]\w*'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z]\\w*', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => '(\d+(\.\d+)?|\.\d+)([eE][+-]?\d+)?[ij]?'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\d+(\\.\\d+)?|\\.\\d+)([eE][+-]?\\d+)?[ij]?', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # String => '()[]{}'
   # attribute => 'Delimiter'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '()[]{}', 0, 0, undef, 0, '#stay', 'Delimiter')) {
      return 1
   }
   # String => '...'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '...', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '=='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '==', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '~='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '~=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '<='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '>='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '>=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '&&'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '&&', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '||'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '||', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '.*'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.*', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '.^'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.^', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => './'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, './', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '.''
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '.\'', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '*+-/\&|<>~^=,;:@'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '*+-/\\&|<>~^=,;:@', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Matlab - a Plugin for Matlab syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Matlab;
 my $sh = new Syntax::Highlight::Engine::Kate::Matlab([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Matlab is a  plugin module that provides syntax highlighting
for Matlab to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author