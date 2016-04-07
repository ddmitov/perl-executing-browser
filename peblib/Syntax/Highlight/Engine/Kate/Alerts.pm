# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'alert.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.06
#kate version 2.3
#kate author Dominik Haumann (dhdev@gmx.de)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Alerts;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Alert' => 'Alert',
      'Normal Text' => 'Normal',
   });
   $self->listAdd('alerts',
      '###',
      'FIXME',
      'HACK',
      'NOTE',
      'NOTICE',
      'TASK',
      'TODO',
   );
   $self->contextdata({
      'Normal Text' => {
         callback => \&parseNormalText,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal Text');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Alerts';
}

sub parseNormalText {
   my ($self, $text) = @_;
   # String => 'alerts'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'alerts', 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Alerts - a Plugin for Alerts syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Alerts;
 my $sh = new Syntax::Highlight::Engine::Kate::Alerts([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Alerts is a  plugin module that provides syntax highlighting
for Alerts to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author