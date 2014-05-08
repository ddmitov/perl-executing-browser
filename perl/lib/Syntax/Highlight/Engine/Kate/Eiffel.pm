# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'eiffel.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.1
#kate author Sebastian Vuorinen
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Eiffel;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Assertions' => 'Others',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Predefined entities' => 'Others',
      'String' => 'String',
   });
   $self->listAdd('assertions',
      'check',
      'ensure',
      'invariant',
      'require',
      'variant',
   );
   $self->listAdd('keywords',
      'agent',
      'alias',
      'all',
      'and',
      'as',
      'assign',
      'class',
      'convert',
      'create',
      'creation',
      'debug',
      'deferred',
      'do',
      'else',
      'elseif',
      'end',
      'expanded',
      'export',
      'external',
      'feature',
      'from',
      'frozen',
      'if',
      'implies',
      'indexing',
      'infix',
      'inherit',
      'inspect',
      'is',
      'like',
      'local',
      'loop',
      'not',
      'obsolete',
      'old',
      'once',
      'or',
      'prefix',
      'pure',
      'redefine',
      'reference',
      'rename',
      'rescue',
      'retry',
      'separate',
      'then',
      'undefine',
   );
   $self->listAdd('predefined-entities',
      'Current',
      'False',
      'Precursor',
      'Result',
      'TUPLE',
      'True',
   );
   $self->contextdata({
      'Documentation' => {
         callback => \&parseDocumentation,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Quoted String' => {
         callback => \&parseQuotedString,
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
   return 'Eiffel';
}

sub parseDocumentation {
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
   # String => 'predefined-entities'
   # attribute => 'Predefined entities'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'predefined-entities', 0, undef, 0, '#stay', 'Predefined entities')) {
      return 1
   }
   # String => 'assertions'
   # attribute => 'Assertions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'assertions', 0, undef, 0, '#stay', 'Assertions')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'Quoted String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Quoted String', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'Documentation'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'Documentation', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseQuotedString {
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

Syntax::Highlight::Engine::Kate::Eiffel - a Plugin for Eiffel syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Eiffel;
 my $sh = new Syntax::Highlight::Engine::Kate::Eiffel([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Eiffel is a  plugin module that provides syntax highlighting
for Eiffel to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author