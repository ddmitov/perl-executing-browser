# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'abc.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.10
#kate version 2.4
#kate author Andrea Primiani (primiani@dag.it)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::ABC;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Bar' => 'Char',
      'Comment' => 'Comment',
      'Decoration' => 'Float',
      'Header' => 'Float',
      'Lyrics' => 'DataType',
      'Normal Text' => 'Normal',
      'Notes' => 'Keyword',
      'Preprocessor' => 'String',
      'Sharp' => 'Normal',
      'Slur' => 'DataType',
      'String' => 'String',
      'Tuplet' => 'DataType',
   });
   $self->contextdata({
      'Bar' => {
         callback => \&parseBar,
         attribute => 'Bar',
         lineending => '#pop',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Header' => {
         callback => \&parseHeader,
         attribute => 'Header',
      },
      'Header2' => {
         callback => \&parseHeader2,
         attribute => 'Header',
         lineending => '#pop',
      },
      'Lyrics' => {
         callback => \&parseLyrics,
         attribute => 'Lyrics',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Part' => {
         callback => \&parsePart,
         attribute => 'Header',
         lineending => '#pop',
      },
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
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
   return 'ABC';
}

sub parseBar {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # String => '[A-Ga-gZz]'
   # attribute => 'Normal Text'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Ga-gZz]', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ' '
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ' ', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Decoration'
   # char => '!'
   # char1 => '!'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '!', '!', 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '()'
   # attribute => 'Slur'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '()', 0, 0, undef, 0, '#stay', 'Slur')) {
      return 1
   }
   # String => ':*\|*[1-9]|/*\|'
   # attribute => 'Bar'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ':*\\|*[1-9]|/*\\|', 0, 0, 0, undef, 0, '#pop', 'Bar')) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseHeader {
   my ($self, $text) = @_;
   # String => 'K:.+'
   # attribute => 'Header'
   # column => '0'
   # context => '#pop'
   # endRegion => 'header'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'K:.+', 0, 0, 0, 0, 0, '#pop', 'Header')) {
      return 1
   }
   # attribute => 'Header'
   # char => ']'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop', 'Header')) {
      return 1
   }
   return 0;
};

sub parseHeader2 {
   my ($self, $text) = @_;
   return 0;
};

sub parseLyrics {
   my ($self, $text) = @_;
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '\([23456789]:?[23456789]?:?[23456789]?'
   # attribute => 'Tuplet'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\([23456789]:?[23456789]?:?[23456789]?', 0, 0, 0, undef, 0, '#stay', 'Tuplet')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # char1 => '"'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'Decoration'
   # char => '!'
   # char1 => '!'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '!', '!', 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\[[ABCGHILMNOQRSTUVZ]:'
   # attribute => 'Header'
   # context => 'Header'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\[[ABCGHILMNOQRSTUVZ]:', 0, 0, 0, undef, 0, 'Header', 'Header')) {
      return 1
   }
   # String => '[ABCGHILMNOPQRSTUVZ]:'
   # attribute => 'Header'
   # context => 'Header2'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[ABCGHILMNOPQRSTUVZ]:', 0, 0, 0, undef, 0, 'Header2', 'Header')) {
      return 1
   }
   # attribute => 'Header'
   # beginRegion => 'header'
   # char => 'X'
   # char1 => ':'
   # column => '0'
   # context => 'Header'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'X', ':', 0, 0, 0, 0, 0, 'Header', 'Header')) {
      return 1
   }
   # String => '|:['
   # attribute => 'Bar'
   # context => 'Bar'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '|:[', 0, 0, undef, 0, 'Bar', 'Bar')) {
      return 1
   }
   # attribute => 'Bar'
   # char => ']'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#stay', 'Bar')) {
      return 1
   }
   # String => '()'
   # attribute => 'Slur'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '()', 0, 0, undef, 0, '#stay', 'Slur')) {
      return 1
   }
   # String => '{}'
   # attribute => 'Slur'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '{}', 0, 0, undef, 0, '#stay', 'Slur')) {
      return 1
   }
   # attribute => 'Lyrics'
   # char => 'W'
   # char1 => ':'
   # context => 'Lyrics'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'W', ':', 0, 0, 0, undef, 0, 'Lyrics', 'Lyrics')) {
      return 1
   }
   # attribute => 'Lyrics'
   # char => 'w'
   # char1 => ':'
   # context => 'Lyrics'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'w', ':', 0, 0, 0, undef, 0, 'Lyrics', 'Lyrics')) {
      return 1
   }
   # attribute => 'Preprocessor'
   # char => '%'
   # char1 => '%'
   # context => 'Preprocessor'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '%', 0, 0, 0, undef, 0, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # String => '[_|\^]?[_|=|\^][A-Ga-g]'
   # attribute => 'Sharp'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[_|\\^]?[_|=|\\^][A-Ga-g]', 0, 0, 0, undef, 0, '#stay', 'Sharp')) {
      return 1
   }
   return 0;
};

sub parsePart {
   my ($self, $text) = @_;
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::ABC - a Plugin for ABC syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::ABC;
 my $sh = new Syntax::Highlight::Engine::Kate::ABC([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::ABC is a  plugin module that provides syntax highlighting
for ABC to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author