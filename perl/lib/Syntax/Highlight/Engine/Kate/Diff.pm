# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'diff.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.4
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Diff;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Added line' => 'String',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Removed line' => 'Others',
   });
   $self->contextdata({
      'Added' => {
         callback => \&parseAdded,
         attribute => 'Added line',
         lineending => '#pop',
      },
      'Data' => {
         callback => \&parseData,
         attribute => 'Data Type',
         lineending => '#pop',
      },
      'Keyword' => {
         callback => \&parseKeyword,
         attribute => 'Keyword',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Removed' => {
         callback => \&parseRemoved,
         attribute => 'Removed line',
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
   return 'Diff';
}

sub parseAdded {
   my ($self, $text) = @_;
   return 0;
};

sub parseData {
   my ($self, $text) = @_;
   return 0;
};

sub parseKeyword {
   my ($self, $text) = @_;
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '(\+\+\+|\-\-\-|\*\*\*|diff|\d)'
   # attribute => 'Keyword'
   # column => '0'
   # context => 'Keyword'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\+\\+\\+|\\-\\-\\-|\\*\\*\\*|diff|\\d)', 0, 0, 0, 0, 0, 'Keyword', 'Keyword')) {
      return 1
   }
   # String => '(\+|>|!)'
   # attribute => 'Added line'
   # column => '0'
   # context => 'Added'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\+|>|!)', 0, 0, 0, 0, 0, 'Added', 'Added line')) {
      return 1
   }
   # String => '-<'
   # attribute => 'Removed line'
   # column => '0'
   # context => 'Removed'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '-<', 0, 0, 0, 0, 'Removed', 'Removed line')) {
      return 1
   }
   # attribute => 'Data Type'
   # char => '@'
   # char1 => '@'
   # column => '0'
   # context => 'Data'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '@', '@', 0, 0, 0, 0, 0, 'Data', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parseRemoved {
   my ($self, $text) = @_;
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Diff - a Plugin for Diff syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Diff;
 my $sh = new Syntax::Highlight::Engine::Kate::Diff([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Diff is a  plugin module that provides syntax highlighting
for Diff to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author