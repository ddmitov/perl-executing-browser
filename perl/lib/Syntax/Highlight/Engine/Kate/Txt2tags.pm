# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'txt2tags.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.4
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Txt2tags;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Bar' => 'IString',
      'Bold' => 'Float',
      'BoldItalic' => 'Operator',
      'Comment' => 'Comment',
      'Date' => 'BaseN',
      'DefList' => 'Reserved',
      'Italic' => 'DecVal',
      'Link' => 'Variable',
      'List' => 'Reserved',
      'Monospaced' => 'Others',
      'Normal' => 'Normal',
      'NumList' => 'Reserved',
      'Quote' => 'Function',
      'Tabel' => 'BString',
      'Title' => 'Keyword',
      'Verbatim Area' => 'String',
      'Verbatim Line' => 'String',
   });
   $self->contextdata({
      'Context' => {
         callback => \&parseContext,
         attribute => 'Normal',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Context');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'txt2tags';
}

sub parseContext {
   my ($self, $text) = @_;
   # String => '%%date(\(.*\))?'
   # attribute => 'Date'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%%date(\\(.*\\))?', 0, 0, 0, undef, 0, 'Context', 'Date')) {
      return 1
   }
   # String => '%.*'
   # attribute => 'Comment'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%.*', 0, 0, 0, undef, 0, 'Context', 'Comment')) {
      return 1
   }
   # String => '\*\*.*\*\*'
   # attribute => 'Bold'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*\\*.*\\*\\*', 0, 0, 0, undef, 0, 'Context', 'Bold')) {
      return 1
   }
   # String => '//.*//'
   # attribute => 'Italic'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//.*//', 0, 0, 0, undef, 0, 'Context', 'Italic')) {
      return 1
   }
   # String => '\*\*//.*//\*\*'
   # attribute => 'BoldItalic'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*\\*//.*//\\*\\*', 0, 0, 0, undef, 0, 'Context', 'BoldItalic')) {
      return 1
   }
   # String => '__.*__'
   # attribute => 'BoldItalic'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '__.*__', 0, 0, 0, undef, 0, 'Context', 'BoldItalic')) {
      return 1
   }
   # String => '``.*``'
   # attribute => 'Monospaced'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '``.*``', 0, 0, 0, undef, 0, 'Context', 'Monospaced')) {
      return 1
   }
   # String => '``` .*'
   # attribute => 'Verbatim Line'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '``` .*', 0, 0, 0, undef, 0, 'Context', 'Verbatim Line')) {
      return 1
   }
   # String => ' *=[^=].*[^=]=\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *=[^=].*[^=]=\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *==[^=].*[^=]==\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *==[^=].*[^=]==\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *===[^=].*[^=]===\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *===[^=].*[^=]===\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *====[^=].*[^=]====\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *====[^=].*[^=]====\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *=====[^=].*[^=]=====\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *=====[^=].*[^=]=====\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *\+[^=].*[^=]\+\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\+[^=].*[^=]\\+\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *\+\+[^=].*[^=]\+\+\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\+\\+[^=].*[^=]\\+\\+\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *\+\+\+[^=].*[^=]\+\+\+\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\+\\+\\+[^=].*[^=]\\+\\+\\+\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *\+\+\+\+[^=].*[^=]\+\+\+\+\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\+\\+\\+\\+[^=].*[^=]\\+\\+\\+\\+\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # String => ' *\+\+\+\+\+[^=].*[^=]\+\+\+\+\+\s*$'
   # attribute => 'Title'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\+\\+\\+\\+\\+[^=].*[^=]\\+\\+\\+\\+\\+\\s*$', 0, 0, 0, 0, 0, 'Context', 'Title')) {
      return 1
   }
   # attribute => 'Link'
   # char => '['
   # char1 => ']'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '[', ']', 0, 0, undef, 0, '#stay', 'Link')) {
      return 1
   }
   # String => ' *\|\| .*'
   # attribute => 'Tabel'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\|\\| .*', 0, 0, 0, 0, 0, 'Context', 'Tabel')) {
      return 1
   }
   # String => ' *\| .*'
   # attribute => 'Tabel'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\| .*', 0, 0, 0, 0, 0, 'Context', 'Tabel')) {
      return 1
   }
   # String => ' *\: .*'
   # attribute => 'DefList'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\: .*', 0, 0, 0, 0, 0, 'Context', 'DefList')) {
      return 1
   }
   # String => ' *\- .*'
   # attribute => 'List'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\- .*', 0, 0, 0, 0, 0, 'Context', 'List')) {
      return 1
   }
   # String => ' *\+ .*'
   # attribute => 'NumList'
   # column => '0'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' *\\+ .*', 0, 0, 0, 0, 0, 'Context', 'NumList')) {
      return 1
   }
   # String => '\t.*'
   # attribute => 'Quote'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\t.*', 0, 0, 0, undef, 0, 'Context', 'Quote')) {
      return 1
   }
   # String => '\s*([_=-]{20,})\s*$'
   # attribute => 'Bar'
   # context => 'Context'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*([_=-]{20,})\\s*$', 0, 0, 0, undef, 0, 'Context', 'Bar')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Txt2tags - a Plugin for txt2tags syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Txt2tags;
 my $sh = new Syntax::Highlight::Engine::Kate::Txt2tags([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Txt2tags is a  plugin module that provides syntax highlighting
for txt2tags to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author