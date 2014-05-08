# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'debiancontrol.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.82
#kate version 2.4
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Debian_Control;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Email' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Value' => 'DataType',
      'Variable' => 'Others',
      'Version' => 'DecVal',
   });
   $self->contextdata({
      'Constrain' => {
         callback => \&parseConstrain,
         attribute => 'Version',
      },
      'DependencyField' => {
         callback => \&parseDependencyField,
         attribute => 'Value',
         lineending => '#pop',
      },
      'Field' => {
         callback => \&parseField,
         attribute => 'Value',
         lineending => '#pop',
      },
      'Variable' => {
         callback => \&parseVariable,
         attribute => 'Variable',
         lineending => '#pop',
      },
      'noname' => {
         callback => \&parsenoname,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('noname');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Debian Control';
}

sub parseConstrain {
   my ($self, $text) = @_;
   # attribute => 'Keyword'
   # char => '$'
   # char1 => '{'
   # context => 'Variable'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Variable', 'Keyword')) {
      return 1
   }
   # String => '[!<=>]'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[!<=>]', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => ']'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseDependencyField {
   my ($self, $text) = @_;
   # String => '<.*@.*>'
   # attribute => 'Email'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<.*@.*>', 0, 0, 0, undef, 0, '#stay', 'Email')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '$'
   # char1 => '{'
   # context => 'Variable'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Variable', 'Keyword')) {
      return 1
   }
   # String => '[,\|]'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[,\\|]', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '('
   # context => 'Constrain'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Constrain', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '['
   # context => 'Constrain'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, 'Constrain', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseField {
   my ($self, $text) = @_;
   # String => '<.*@.*>'
   # attribute => 'Email'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<.*@.*>', 0, 0, 0, undef, 0, '#stay', 'Email')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '$'
   # char1 => '{'
   # context => 'Variable'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Variable', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseVariable {
   my ($self, $text) = @_;
   # attribute => 'Keyword'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parsenoname {
   my ($self, $text) = @_;
   # String => 'Depends:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Depends:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Recommends:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Recommends:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Suggests:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Suggests:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Conflicts:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Conflicts:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Provides:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Provides:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Replaces:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Replaces:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Enhances:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Enhances:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Pre-Depends:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Pre-Depends:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Build-Depends:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Build-Depends:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Build-Depends-Indep:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Build-Depends-Indep:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Build-Conflicts:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Build-Conflicts:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => 'Build-Conflicts-Indep:'
   # attribute => 'Keyword'
   # context => 'DependencyField'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'Build-Conflicts-Indep:', 0, 0, 0, undef, 0, 'DependencyField', 'Keyword')) {
      return 1
   }
   # String => '[^ ]*:'
   # attribute => 'Keyword'
   # column => '0'
   # context => 'Field'
   # minimal => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^ ]*?:', 0, 0, 0, 0, 0, 'Field', 'Keyword')) {
      return 1
   }
   # attribute => 'Value'
   # char => ' '
   # column => '0'
   # context => 'Field'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ' ', 0, 0, 0, 0, 0, 'Field', 'Value')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Debian_Control - a Plugin for Debian Control syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Debian_Control;
 my $sh = new Syntax::Highlight::Engine::Kate::Debian_Control([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Debian_Control is a  plugin module that provides syntax highlighting
for Debian Control to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author