# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'cue.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.91
#kate version 2.1
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::CUE_Sheet;

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
      'Decimal' => 'DecVal',
      'Flags' => 'Reserved',
      'Format' => 'Function',
      'Keyword' => 'Keyword',
      'Mode' => 'Operator',
      'Normal Text' => 'Normal',
      'String' => 'String',
   });
   $self->listAdd('flags',
      '4CH',
      'DCP',
      'PRE',
      'SCMS',
   );
   $self->listAdd('format',
      'AIFF',
      'BINARY',
      'MOTOTOLA',
      'MP3',
      'WAVE',
   );
   $self->listAdd('keywords',
      'CATALOG',
      'CDTEXTFILE',
      'FILE',
      'FLAGS',
      'INDEX',
      'ISRC',
      'PERFORMER',
      'POSTGAP',
      'PREGAP',
      'REM',
      'SONGWRITER',
      'TITLE',
      'TRACK',
   );
   $self->listAdd('mode',
      'AUDIO',
      'CDG',
      'CDI',
      'MODE1',
      'MODE2',
      'RAW',
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
   return 'CUE Sheet';
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
   # String => 'format'
   # attribute => 'Format'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'format', 0, undef, 0, '#stay', 'Format')) {
      return 1
   }
   # String => 'mode'
   # attribute => 'Mode'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mode', 0, undef, 0, '#stay', 'Mode')) {
      return 1
   }
   # String => 'flags'
   # attribute => 'Flags'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'flags', 0, undef, 0, '#stay', 'Flags')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
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
   # char => ';'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
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

Syntax::Highlight::Engine::Kate::CUE_Sheet - a Plugin for CUE Sheet syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::CUE_Sheet;
 my $sh = new Syntax::Highlight::Engine::Kate::CUE_Sheet([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::CUE_Sheet is a  plugin module that provides syntax highlighting
for CUE Sheet to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author