# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'lilypond.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.3
#kate author Andrea Primiani (primiani@dag.it)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::LilyPond;

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
      'Chord' => 'BaseN',
      'Comment' => 'Comment',
      'Context' => 'DataType',
      'Decoration' => 'Reserved',
      'Drums' => 'RegionMarker',
      'Dynamics' => 'BString',
      'Header' => 'Float',
      'Keyword' => 'Keyword',
      'Lyrics' => 'DecVal',
      'Normal Text' => 'Normal',
      'Preprocessor' => 'IString',
      'Repeat' => 'Operator',
      'Sharp' => 'Others',
      'Slur' => 'Variable',
      'String' => 'String',
      'Tuplet' => 'Float',
   });
   $self->listAdd('commands',
      '\\\\clef',
      '\\\\key',
      '\\\\tempo',
      '\\\\time',
   );
   $self->listAdd('repeats',
      '"percent"',
      '"tremolo"',
      '\\\\alternative',
      '\\\\repeat',
      'unfold',
      'volta',
   );
   $self->contextdata({
      'Command' => {
         callback => \&parseCommand,
         attribute => 'Header',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Context' => {
         callback => \&parseContext,
         attribute => 'Normal Text',
      },
      'Header' => {
         callback => \&parseHeader,
         attribute => 'Header',
      },
      'Keyword' => {
         callback => \&parseKeyword,
         attribute => 'Keyword',
         lineending => '#pop',
      },
      'Lyrics' => {
         callback => \&parseLyrics,
         attribute => 'Lyrics',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'Repeat' => {
         callback => \&parseRepeat,
         attribute => 'Normal Text',
      },
      'Slur' => {
         callback => \&parseSlur,
         attribute => 'Normal',
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
   return 'LilyPond';
}

sub parseCommand {
   my ($self, $text) = @_;
   # attribute => 'Header'
   # char => '('
   # context => 'Command'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Command', 'Header')) {
      return 1
   }
   # attribute => 'Header'
   # char => ')'
   # context => '#pop'
   # endRegion => 'command'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Header')) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseContext {
   my ($self, $text) = @_;
   # attribute => 'Context'
   # char => '>'
   # char1 => '>'
   # context => '#pop'
   # endRegion => 'context'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '>', '>', 0, 0, 0, undef, 0, '#pop', 'Context')) {
      return 1
   }
   return 0;
};

sub parseHeader {
   my ($self, $text) = @_;
   # attribute => 'Keyword'
   # char => '}'
   # context => '#pop'
   # endRegion => 'header'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseKeyword {
   my ($self, $text) = @_;
   return 0;
};

sub parseLyrics {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '%'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # attribute => 'Lyrics'
   # char => '}'
   # context => '#pop'
   # endRegion => 'lyrics'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Lyrics')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'repeats'
   # attribute => 'Repeat'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'repeats', 0, undef, 0, '#stay', 'Repeat')) {
      return 1
   }
   # String => 'commands'
   # attribute => 'Keyword'
   # context => 'Keyword'
   # type => 'keyword'
   if ($self->testKeyword($text, 'commands', 0, undef, 0, 'Keyword', 'Keyword')) {
      return 1
   }
   # String => '\addquote'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\addquote', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\aeolian'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\aeolian', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\applymusic'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\applymusic', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\applyoutput'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\applyoutput', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\autochange'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\autochange', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bar'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\bar', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bold'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\bold', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bookpaper'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\bookpaper', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\book'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\book', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\breathe'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\breathe', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\breve '
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\breve ', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\cadenzaOff'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\cadenzaOff', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\cadenzaOn'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\cadenzaOn', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\change'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\change', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\chords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\chords', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\column'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\column', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\consists'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\consists', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\context'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\context', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\default'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\default', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\dorian'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\dorian', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\dotsBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\dotsBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\dotsDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\dotsDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\dotsUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\dotsUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\drums'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\drums', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\dynamicBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\dynamicBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\dynamicDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\dynamicDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\dynamicUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\dynamicUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\emptyText'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\emptyText', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\fatText'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\fatText', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\figures'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\figures', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\finger'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\finger', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\flat'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\flat', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\germanChords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\germanChords', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\include'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\include', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\input'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\input', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\italic'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\italic', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\ionian'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\ionian', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\locrian'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\locrian', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\longa'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\longa', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\lydian'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\lydian', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\lyricsto'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\lyricsto', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\major'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\major', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\mark'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\mark', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\markup'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\markup', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\midi'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\midi', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\minor'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\minor', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\mixolydian'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\mixolydian', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\musicglyph'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\musicglyph', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\newlyrics'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\newlyrics', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\new'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\new', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\noBeam'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\noBeam', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\notes'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\notes', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\octave'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\octave', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\once'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\once', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\oneVoice'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\oneVoice', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\override'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\override', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\pageBreak'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\pageBreak', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\paper'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\paper', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\partcombine'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\partcombine', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\partial'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\partial', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\phrasingSlurBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\phrasingSlurBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\phrasingSlurDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\phrasingSlurDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\phrasingSlurUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\phrasingSlurUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\phrigian'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\phrigian', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\property'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\property', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\quote'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\quote', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\raise'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\raise', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\relative'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\relative', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\remove'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\remove', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\renameinput'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\renameinput', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\rest'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\rest', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\revert'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\revert', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\score'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\score', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\scriptBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\scriptBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\scriptDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\scriptDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\scriptUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\scriptUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\semiGermanChords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\semiGermanChords', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\setEasyHeads'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\setEasyHeads', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\setHairpinCresc'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\setHairpinCresc', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\setTextCresc'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\setTextCresc', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\set'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\set', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\shiftOff'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\shiftOff', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\shiftOnnn'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\shiftOnnn', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\shiftOnn'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\shiftOnn', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\shiftOn'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\shiftOn', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\simultaneous'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\simultaneous', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\skip '
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\skip ', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\slurBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\slurBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\slurDotted'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\slurDotted', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\slurDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\slurDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\slurSolid'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\slurSolid', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\slurUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\slurUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\smaller'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\smaller', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\startGroup'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\startGroup', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\startTextSpan'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\startTextSpan', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\stemBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\stemBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\stemDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\stemDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\stemUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\stemUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\stopGroup'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\stopGroup', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\stopTextSpan'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\stopTextSpan', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tag'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tag', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tempo'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tempo', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\thumb'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\thumb', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tieBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tieBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tieDotted'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tieDotted', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tieDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tieDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tieSolid'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tieSolid', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tieUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tieUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\transpose'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\transpose', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\transposition'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\transposition', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tupletBoth'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tupletBoth', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tupletDown'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tupletDown', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\tupletUp'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tupletUp', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\typewriter'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\typewriter', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\voiceFour'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\voiceFour', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\unset'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\unset', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\voiceOne'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\voiceOne', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\voiceThree'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\voiceThree', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\voiceTwo'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\voiceTwo', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\with'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\with', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\accento'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\accento', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\acciaccatura'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\acciaccatura', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\appoggiatura'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\appoggiatura', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\arpeggioBoth'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\arpeggioBoth', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\arpeggioBracket'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\arpeggioBracket', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\arpeggioDown'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\arpeggioDown', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\arpeggioUp'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\arpeggioUp', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\arpeggio'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\arpeggio', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\coda'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\coda', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\downbow'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\downbow', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\downmordent'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\downmordent', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\downprall'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\downprall', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\fermataMarkup'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\fermataMarkup', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\fermata'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\fermata', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\flageolet'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\flageolet', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\glissando'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\glissando', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\grace'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\grace', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\harmonic'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\harmonic', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\lheel'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\lheel', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\lineprall'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\lineprall', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\longfermata'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\longfermata', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\ltoe'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\ltoe', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\melismaEnd'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\melismaEnd', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\melisma'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\melisma', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\mordent'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\mordent', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\open'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\open', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\portato'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\portato', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\prall'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\prall', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\pralldown'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\pralldown', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\prallmordent'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\prallmordent', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\prallprall'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\prallprall', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\prallup'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\prallup', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\reverseturn'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\reverseturn', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\rheel'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\rheel', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\rtoe'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\rtoe', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\segno'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\segno', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\shortfermata'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\shortfermata', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\signumcongruentiae'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\signumcongruentiae', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\sostenutoDown'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\sostenutoDown', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\sostenutoUp'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\sostenutoUp', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\staccatissimo'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\staccatissimo', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\staccato'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\staccato', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\stopped'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\stopped', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\sustainDown'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\sustainDown', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\sustainUp'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\sustainUp', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\tenuto'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\tenuto', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\thumb'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\thumb', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\trill'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\trill', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\turn'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\turn', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\upbow'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\upbow', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\upmordent'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\upmordent', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\upprall'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\upprall', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\varcoda'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\varcoda', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => '\verylongfermata'
   # attribute => 'Decoration'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\verylongfermata', 0, 0, 0, undef, 0, '#stay', 'Decoration')) {
      return 1
   }
   # String => ' hihat'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' hihat', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' snaredrum'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' snaredrum', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' crashcymbal'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' crashcymbal', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' openhihat'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' openhihat', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' halfopenhihat'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' halfopenhihat', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' closedhihat'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' closedhihat', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' bassdrum'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' bassdrum', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' snare'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' snare', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' bd'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' bd', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' sn'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' sn', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cymc'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cymc', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cyms'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cyms', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cymr'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cymr', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' hhho'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' hhho', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' hhc'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' hhc', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' hho'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' hho', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' hhp'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' hhp', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' hh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' hh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cb'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cb', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' hc'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' hc', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' ssl'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' ssl', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' ssh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' ssh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' ss'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' ss', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' tommmh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' tommmh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' tommh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' tommh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' tomh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' tomh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' toml'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' toml', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' tomfh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' tomfh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' tomfl'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' tomfl', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' timh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' timh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' timl'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' timl', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cgho'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cgho', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cghm'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cghm', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cgh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cgh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cglo'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cglo', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cglm'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cglm', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cgl'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cgl', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' boho'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' boho', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' bohm'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' bohm', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' boh'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' boh', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' bolo'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' bolo', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' bolm'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' bolm', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' bol'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' bol', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' trio'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' trio', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' trim'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' trim', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' tri'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' tri', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' guis'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' guis', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' guil'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' guil', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' gui'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' gui', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cl'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cl', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' tamb'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' tamb', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' cab'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' cab', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => ' mar'
   # attribute => 'Drums'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ' mar', 0, 0, 0, undef, 0, '#stay', 'Drums')) {
      return 1
   }
   # String => '\\times [1-9]?/[1-9]?'
   # attribute => 'Tuplet'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\times [1-9]?/[1-9]?', 0, 0, 0, undef, 0, '#pop', 'Tuplet')) {
      return 1
   }
   # String => '\lyrics {'
   # attribute => 'Lyrics'
   # beginRegion => 'lyrics'
   # context => 'Lyrics'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\lyrics {', 0, 0, 0, undef, 0, 'Lyrics', 'Lyrics')) {
      return 1
   }
   # String => '\newlyrics {'
   # attribute => 'Lyrics'
   # beginRegion => 'lyrics'
   # context => 'Lyrics'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\newlyrics {', 0, 0, 0, undef, 0, 'Lyrics', 'Lyrics')) {
      return 1
   }
   # String => '\\header\s*{'
   # attribute => 'Keyword'
   # beginRegion => 'header'
   # context => 'Header'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\header\\s*{', 0, 0, 0, undef, 0, 'Header', 'Keyword')) {
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
   # attribute => 'Chord'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Chord')) {
      return 1
   }
   # attribute => 'Chord'
   # char => '}'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Chord')) {
      return 1
   }
   # attribute => 'Chord'
   # char => '['
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, '#stay', 'Chord')) {
      return 1
   }
   # attribute => 'Chord'
   # char => ']'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#stay', 'Chord')) {
      return 1
   }
   # attribute => 'Chord'
   # char => '<'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Chord')) {
      return 1
   }
   # attribute => 'Chord'
   # char => '>'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#stay', 'Chord')) {
      return 1
   }
   # attribute => 'Header'
   # beginRegion => 'command'
   # char => '#'
   # char1 => '('
   # context => 'Command'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '#', '(', 0, 0, 0, undef, 0, 'Command', 'Header')) {
      return 1
   }
   # attribute => 'Context'
   # beginRegion => 'context'
   # char => '<'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, '#stay', 'Context')) {
      return 1
   }
   # attribute => 'Context'
   # char => '>'
   # char1 => '>'
   # context => '#stay'
   # endRegion => 'context'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '>', '>', 0, 0, 0, undef, 0, '#stay', 'Context')) {
      return 1
   }
   # attribute => 'Chord'
   # char => '~'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '~', 0, 0, 0, undef, 0, '#stay', 'Chord')) {
      return 1
   }
   # attribute => 'Bar'
   # char => '|'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '#stay', 'Bar')) {
      return 1
   }
   # String => '[1-9]+:[1-9]+\b'
   # attribute => 'Repeat'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[1-9]+:[1-9]+\\b', 0, 0, 0, undef, 0, '#stay', 'Repeat')) {
      return 1
   }
   # String => '\\?\('
   # attribute => 'Slur'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\?\\(', 0, 0, 0, undef, 0, '#stay', 'Slur')) {
      return 1
   }
   # String => '\\?\)'
   # attribute => 'Slur'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\?\\)', 0, 0, 0, undef, 0, '#stay', 'Slur')) {
      return 1
   }
   # String => '\\fff\b'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\fff\\b', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '\\ff\b'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\ff\\b', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '\\ppp\b'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\ppp\\b', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '\\pp\b'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\pp\\b', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '\\m?[f|p]\b'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\m?[f|p]\\b', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '\\[s|r]fz?\b'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[s|r]fz?\\b', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '_[_.\|+>^-]\b?'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '_[_.\\|+>^-]\\b?', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '\^[_.\|+>^-]\b?'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\^[_.\\|+>^-]\\b?', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '-[_.\|+>^-]\b?'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-[_.\\|+>^-]\\b?', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # attribute => 'Dynamics'
   # char => '\'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '<', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # attribute => 'Dynamics'
   # char => '\'
   # char1 => '>'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '>', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # attribute => 'Dynamics'
   # char => '\'
   # char1 => '!'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '!', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # String => '-[0-5]\b'
   # attribute => 'Dynamics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-[0-5]\\b', 0, 0, 0, undef, 0, '#stay', 'Dynamics')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   return 0;
};

sub parseRepeat {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # String => '"tremolo"'
   # attribute => 'Repeat'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '"tremolo"', 0, 0, 0, undef, 0, '#pop', 'Repeat')) {
      return 1
   }
   # String => '"percent"'
   # attribute => 'Repeat'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '"percent"', 0, 0, 0, undef, 0, '#pop', 'Repeat')) {
      return 1
   }
   # String => 'volta\b[1-9]\b'
   # attribute => 'Repeat'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'volta\\b[1-9]\\b', 0, 0, 0, undef, 0, '#pop', 'Repeat')) {
      return 1
   }
   return 0;
};

sub parseSlur {
   my ($self, $text) = @_;
   # String => '\\?\('
   # attribute => 'Slur'
   # context => 'Slur'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\?\\(', 0, 0, 0, undef, 0, 'Slur', 'Slur')) {
      return 1
   }
   # String => '\\?\)'
   # attribute => 'Slur'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\?\\)', 0, 0, 0, undef, 0, '#pop', 'Slur')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::LilyPond - a Plugin for LilyPond syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::LilyPond;
 my $sh = new Syntax::Highlight::Engine::Kate::LilyPond([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::LilyPond is a  plugin module that provides syntax highlighting
for LilyPond to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author