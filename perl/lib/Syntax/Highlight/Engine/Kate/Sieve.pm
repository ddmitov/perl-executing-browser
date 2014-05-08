# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'sieve.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.05
#kate version 2.4
#kate author Petter E. Stokke
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Sieve;

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
      'Function' => 'Function',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
      'Tagged Argument' => 'Others',
   });
   $self->listAdd('keywords',
      'discard',
      'else',
      'elsif',
      'fileinto',
      'if',
      'keep',
      'redirect',
      'reject',
      'require',
      'stop',
   );
   $self->contextdata({
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
      },
      'Member' => {
         callback => \&parseMember,
         attribute => 'Normal Text',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'MultilineString' => {
         callback => \&parseMultilineString,
         attribute => 'String',
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
   return 'Sieve';
}

sub parseComment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseMember {
   my ($self, $text) = @_;
   # String => '\b[_a-zA-Z]\w*(?=[\s]*)'
   # attribute => 'Function'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[_a-zA-Z]\\w*(?=[\\s]*)', 0, 0, 0, undef, 0, '#pop', 'Function')) {
      return 1
   }
   return 0;
};

sub parseMultilineString {
   my ($self, $text) = @_;
   # String => '\.$'
   # attribute => 'String'
   # column => '0'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.$', 0, 0, 0, 0, 0, '#pop', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
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
   # attribute => 'Symbol'
   # beginRegion => 'Brace1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Symbol'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '\d+[KMG]?'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\d+[KMG]?', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => 'text:$'
   # attribute => 'String'
   # beginRegion => 'String'
   # context => 'MultilineString'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'text:$', 0, 0, 0, undef, 0, 'MultilineString', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => ':\w+'
   # attribute => 'Tagged Argument'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ':\\w+', 0, 0, 0, undef, 0, '#stay', 'Tagged Argument')) {
      return 1
   }
   # String => '[.]{1,1}'
   # attribute => 'Symbol'
   # context => 'Member'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[.]{1,1}', 0, 0, 0, undef, 0, 'Member', 'Symbol')) {
      return 1
   }
   # String => ':!%&()+,-/.*<=>?[]|~^;'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':!%&()+,-/.*<=>?[]|~^;', 0, 0, undef, 0, '#stay', 'Symbol')) {
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
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
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

Syntax::Highlight::Engine::Kate::Sieve - a Plugin for Sieve syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Sieve;
 my $sh = new Syntax::Highlight::Engine::Kate::Sieve([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Sieve is a  plugin module that provides syntax highlighting
for Sieve to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author