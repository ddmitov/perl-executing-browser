# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'xorg.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate author Jan Janssen (medhefgo@web.de)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Xorg_Configuration;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Alert' => 'Error',
      'Comment' => 'Comment',
      'Float' => 'Float',
      'Int' => 'DecVal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Section' => 'Function',
      'Section Name' => 'String',
      'Value' => 'DataType',
      'Value2' => 'Others',
   });
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Keyword' => {
         callback => \&parseKeyword,
         attribute => 'Keyword',
         lineending => '#pop',
      },
      'Section' => {
         callback => \&parseSection,
         attribute => 'Normal Text',
      },
      'Section Content' => {
         callback => \&parseSectionContent,
         attribute => 'Normal Text',
      },
      'xorg' => {
         callback => \&parsexorg,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('xorg');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'x.org Configuration';
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

sub parseKeyword {
   my ($self, $text) = @_;
   # attribute => 'Value'
   # char => '"'
   # char1 => '"'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # attribute => 'Value'
   # char => '''
   # char1 => '''
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '\'', '\'', 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
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
   # String => '[\w\d]+'
   # attribute => 'Value2'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\w\\d]+', 0, 0, 0, undef, 0, '#stay', 'Value2')) {
      return 1
   }
   # char => '#'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Comment', undef)) {
      return 1
   }
   return 0;
};

sub parseSection {
   my ($self, $text) = @_;
   # attribute => 'Section Name'
   # char => '"'
   # char1 => '"'
   # context => 'Section Content'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, 'Section Content', 'Section Name')) {
      return 1
   }
   # attribute => 'Section Name'
   # char => '''
   # char1 => '''
   # context => 'Section Content'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '\'', '\'', 0, 0, undef, 0, 'Section Content', 'Section Name')) {
      return 1
   }
   # attribute => 'Alert'
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   # char => '#'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Comment', undef)) {
      return 1
   }
   return 0;
};

sub parseSectionContent {
   my ($self, $text) = @_;
   # String => 'EndSection'
   # attribute => 'Section'
   # context => '#pop#pop'
   # endRegion => 'Section'
   # insensitive => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'EndSection', 1, 0, 0, undef, 0, '#pop#pop', 'Section')) {
      return 1
   }
   # String => 'EndSubSection'
   # attribute => 'Section'
   # context => '#pop#pop'
   # endRegion => 'SubSection'
   # insensitive => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'EndSubSection', 1, 0, 0, undef, 0, '#pop#pop', 'Section')) {
      return 1
   }
   # String => 'SubSection'
   # attribute => 'Section'
   # beginRegion => 'SubSection'
   # context => 'Section'
   # insensitive => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'SubSection', 1, 0, 0, undef, 0, 'Section', 'Section')) {
      return 1
   }
   # String => '\b\w+\b'
   # context => 'Keyword'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b\\w+\\b', 0, 0, 0, undef, 0, 'Keyword', undef)) {
      return 1
   }
   # char => '#'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Comment', undef)) {
      return 1
   }
   return 0;
};

sub parsexorg {
   my ($self, $text) = @_;
   # String => 'Section'
   # attribute => 'Section'
   # beginRegion => 'Section'
   # context => 'Section'
   # insensitive => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Section', 1, 0, 0, undef, 0, 'Section', 'Section')) {
      return 1
   }
   # char => '#'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Comment', undef)) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Xorg_Configuration - a Plugin for x.org Configuration syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Xorg_Configuration;
 my $sh = new Syntax::Highlight::Engine::Kate::Xorg_Configuration([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Xorg_Configuration is a  plugin module that provides syntax highlighting
for x.org Configuration to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author