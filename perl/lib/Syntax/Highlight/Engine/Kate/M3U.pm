# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'm3u.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.10
#kate author Jan Janssen (medhefgo@web.de)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::M3U;

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
      'Descr' => 'String',
      'EXTINF' => 'Others',
      'Lenght' => 'DecVal',
      'M3USpec' => 'Keyword',
      'Normal Text' => 'Normal',
   });
   $self->contextdata({
      'FindEXTINF' => {
         callback => \&parseFindEXTINF,
         attribute => 'Normal Text',
      },
      'M3U' => {
         callback => \&parseM3U,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('M3U');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'M3U';
}

sub parseFindEXTINF {
   my ($self, $text) = @_;
   # String => ':\d+'
   # attribute => 'Lenght'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ':\\d+', 0, 0, 0, undef, 0, '#stay', 'Lenght')) {
      return 1
   }
   # String => ',.*$'
   # attribute => 'Descr'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ',.*$', 0, 0, 0, undef, 0, '#pop', 'Descr')) {
      return 1
   }
   return 0;
};

sub parseM3U {
   my ($self, $text) = @_;
   # String => '#EXTM3U'
   # attribute => 'M3USpec'
   # column => '0'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#EXTM3U', 0, 0, 0, 0, 0, '#pop', 'M3USpec')) {
      return 1
   }
   # String => '#EXTINF'
   # attribute => 'EXTINF'
   # column => '0'
   # context => 'FindEXTINF'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '#EXTINF', 0, 0, 0, 0, 0, 'FindEXTINF', 'EXTINF')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 1, '#stay', 'Comment')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::M3U - a Plugin for M3U syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::M3U;
 my $sh = new Syntax::Highlight::Engine::Kate::M3U([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::M3U is a  plugin module that provides syntax highlighting
for M3U to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author