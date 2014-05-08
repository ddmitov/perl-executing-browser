# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'awk.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.90
#kate version 2.3
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::AWK;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Builtin' => 'DataType',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Field' => 'Others',
      'Float' => 'Float',
      'Function' => 'Function',
      'Keyword' => 'Keyword',
      'Normal' => 'Normal',
      'Pattern' => 'String',
      'String' => 'String',
   });
   $self->listAdd('builtins',
      'ARGC',
      'ARGV',
      'CONVFMT',
      'ENVIRON',
      'FILENAME',
      'FNR',
      'FS',
      'NF',
      'NR',
      'OFMT',
      'OFS',
      'ORS',
      'RLENGTH',
      'RS',
      'RSTART',
      'SUBSEP',
   );
   $self->listAdd('functions',
      'atan2',
      'close',
      'cos',
      'exp',
      'fflush',
      'gensub',
      'gsub',
      'index',
      'int',
      'length',
      'log',
      'match',
      'rand',
      'sin',
      'split',
      'sprintf',
      'sqrt',
      'srand',
      'sub',
      'substr',
      'system',
      'tolower',
      'toupper',
   );
   $self->listAdd('keywords',
      'break',
      'continue',
      'do',
      'else',
      'exit',
      'for',
      'function',
      'getline',
      'if',
      'in',
      'next',
      'print',
      'printf',
      'return',
      'while',
   );
   $self->contextdata({
      'Base' => {
         callback => \&parseBase,
         attribute => 'Normal',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Base');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'AWK';
}

sub parseBase {
   my ($self, $text) = @_;
   # String => '\b(BEGIN|END)\b'
   # attribute => 'Pattern'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(BEGIN|END)\\b', 0, 0, 0, undef, 0, '#stay', 'Pattern')) {
      return 1
   }
   # String => '/([^\/[]|\\.|\[\]?(\[[^]]+\]|.)+\])+/'
   # attribute => 'Pattern'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '/([^\\/[]|\\\\.|\\[\\]?(\\[[^]]+\\]|.)+\\])+/', 0, 0, 0, undef, 0, '#stay', 'Pattern')) {
      return 1
   }
   # attribute => 'Keyword'
   # beginRegion => 'block'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '}'
   # context => '#stay'
   # endRegion => 'block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '#'
   # context => 'Comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'builtins'
   # attribute => 'Builtin'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'builtins', 0, undef, 0, '#stay', 'Builtin')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => '\$[A-Za-z0-9_]+'
   # attribute => 'Field'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[A-Za-z0-9_]+', 0, 0, 0, undef, 0, '#stay', 'Field')) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # attribute => 'String'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::AWK - a Plugin for AWK syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::AWK;
 my $sh = new Syntax::Highlight::Engine::Kate::AWK([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::AWK is a  plugin module that provides syntax highlighting
for AWK to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author