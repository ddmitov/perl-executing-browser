# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'ini.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.0
#kate author Jan Janssen (medhefgo@web.de)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::INI_Files;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Assignment' => 'Others',
      'Comment' => 'Comment',
      'Float' => 'Float',
      'Int' => 'DecVal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'DataType',
      'Section' => 'Keyword',
      'Value' => 'String',
   });
   $self->listAdd('keywords',
      'Default',
      'Defaults',
      'E_ALL',
      'E_COMPILE_ERROR',
      'E_COMPILE_WARNING',
      'E_CORE_ERROR',
      'E_CORE_WARNING',
      'E_ERROR',
      'E_NOTICE',
      'E_PARSE',
      'E_STRICT',
      'E_USER_ERROR',
      'E_USER_NOTICE',
      'E_USER_WARNING',
      'E_WARNING',
      'False',
      'Localhost',
      'No',
      'Normal',
      'Null',
      'Off',
      'On',
      'True',
      'Yes',
   );
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Value' => {
         callback => \&parseValue,
         attribute => 'Value',
         lineending => '#pop',
      },
      'ini' => {
         callback => \&parseini,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('ini');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'INI Files';
}

sub parseComment {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   return 0;
};

sub parseValue {
   my ($self, $text) = @_;
   # attribute => 'Float'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Int'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Int')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => ';.*$'
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';.*$', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseini {
   my ($self, $text) = @_;
   # attribute => 'Section'
   # beginRegion => 'Section'
   # char => '['
   # char1 => ']'
   # context => '#pop'
   # endRegion => 'Section'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '[', ']', 0, 0, undef, 0, '#pop', 'Section')) {
      return 1
   }
   # attribute => 'Assignment'
   # char => '='
   # context => 'Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, 'Value', 'Assignment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => ';'
   # context => 'Comment'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 1, 'Comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '#'
   # context => 'Comment'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 1, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::INI_Files - a Plugin for INI Files syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::INI_Files;
 my $sh = new Syntax::Highlight::Engine::Kate::INI_Files([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::INI_Files is a  plugin module that provides syntax highlighting
for INI Files to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author