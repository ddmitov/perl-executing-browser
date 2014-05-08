# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'ada.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.05
#kate version 2.4
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Ada;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Base-N' => 'BaseN',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
   });
   $self->listAdd('keywords',
      'abort',
      'abs',
      'abstract',
      'accept',
      'access',
      'aliased',
      'all',
      'and',
      'array',
      'at',
      'begin',
      'body',
      'constant',
      'declare',
      'delay',
      'delta',
      'digits',
      'do',
      'else',
      'elsif',
      'end',
      'entry',
      'exception',
      'exit',
      'for',
      'function',
      'generic',
      'goto',
      'in',
      'is',
      'limited',
      'mod',
      'new',
      'not',
      'null',
      'of',
      'or',
      'others',
      'out',
      'package',
      'pragma',
      'private',
      'procedure',
      'protected',
      'raise',
      'range',
      'record',
      'rem',
      'renames',
      'requeue',
      'return',
      'reverse',
      'separate',
      'subtype',
      'tagged',
      'task',
      'terminate',
      'then',
      'type',
      'until',
      'use',
      'when',
      'while',
      'with',
      'xor',
   );
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Default' => {
         callback => \&parseDefault,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Default');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Ada';
}

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseDefault {
   my ($self, $text) = @_;
   # String => 'if '
   # attribute => 'Keyword'
   # beginRegion => 'Region1'
   # context => '#stay'
   # firstNonSpace => 'true'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'if ', 1, 0, 0, undef, 1, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'end if'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'Region1'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'end if', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'case '
   # attribute => 'Keyword'
   # beginRegion => 'Region2'
   # context => '#stay'
   # firstNonSpace => 'true'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'case ', 1, 0, 0, undef, 1, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'end case'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'Region2'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'end case', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\sloop\s+'
   # attribute => 'Keyword'
   # beginRegion => 'Region3'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\sloop\\s+', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\sloop$'
   # attribute => 'Keyword'
   # beginRegion => 'Region3'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\sloop$', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'end loop;'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'Region3'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'end loop;', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\sselect\s+'
   # attribute => 'Keyword'
   # beginRegion => 'Region4'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\sselect\\s+', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\sselect$'
   # attribute => 'Keyword'
   # beginRegion => 'Region4'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\sselect$', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'end select;'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'Region4'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'end select;', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
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
   # String => ''.''
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'.\'', 0, 0, 0, undef, 0, '#stay', 'Char')) {
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

Syntax::Highlight::Engine::Kate::Ada - a Plugin for Ada syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Ada;
 my $sh = new Syntax::Highlight::Engine::Kate::Ada([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Ada is a  plugin module that provides syntax highlighting
for Ada to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author