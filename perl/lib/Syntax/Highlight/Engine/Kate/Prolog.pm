# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'prolog.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.1
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Prolog;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Arithmetic' => 'Keyword',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Identifier' => 'Normal',
      'Integer' => 'DecVal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
      'Symbol' => 'Normal',
      'Variable' => 'Others',
   });
   $self->listAdd('arith',
      'abs',
      'arctan',
      'cos',
      'div',
      'exp',
      'ln',
      'log',
      'mod',
      'random',
      'randominit',
      'round',
      'sin',
      'sqrt',
      'tan',
      'trunc',
      'val',
   );
   $self->listAdd('basetype',
      'binary',
      'byte',
      'char',
      'dword',
      'integer',
      'long',
      'real',
      'ref',
      'sbyte',
      'short',
      'string',
      'symbol',
      'ulong',
      'unsigned',
      'ushort',
      'word',
   );
   $self->listAdd('compiler',
      'bgidriver',
      'bgifont',
      'check_determ',
      'code',
      'config',
      'diagnostics',
      'error',
      'errorlevel',
      'gstacksize',
      'heap',
      'nobreak',
      'nowarnings',
      'printermenu',
      'project',
   );
   $self->listAdd('keywordl',
      'abstract',
      'align',
      'and',
      'as',
      'class',
      'clauses',
      'constants',
      'database',
      'determ',
      'domains',
      'elsedef',
      'endclass',
      'enddef',
      'erroneous',
      'facts',
      'failure',
      'global',
      'goal',
      'if',
      'ifdef',
      'ifndef',
      'implement',
      'include',
      'language',
      'multi',
      'nocopy',
      'nondeterm',
      'object',
      'or',
      'predicates',
      'procedure',
      'protected',
      'reference',
      'single',
      'static',
      'struct',
      'this',
   );
   $self->listAdd('keywords',
      'false',
      'true',
   );
   $self->listAdd('keywordu',
      'ABSTRACT',
      'ALIGN',
      'AND',
      'AS',
      'CLASS',
      'CLAUSES',
      'CONSTANTS',
      'DATABASE',
      'DETERM',
      'DOMAINS',
      'ELSEDEF',
      'ENDCLASS',
      'ENDDEF',
      'ERRONEOUS',
      'FACTS',
      'FAILURE',
      'GLOBAL',
      'GOAL',
      'IF',
      'IFDEF',
      'IFNDEF',
      'IMPLEMENT',
      'INCLUDE',
      'LANGUAGE',
      'MULTI',
      'NOCOPY',
      'NONDETERM',
      'OBJECT',
      'OR',
      'PREDICATES',
      'PROCEDURE',
      'PROTECTED',
      'REFERENCE',
      'SINGLE',
      'STATIC',
      'STRUCT',
      'THIS',
   );
   $self->listAdd('special',
      'assert',
      'asserta',
      'assertz',
      'bound',
      'chain_inserta',
      'chain_insertafter',
      'chain_insertz',
      'chain_terms',
      'consult',
      'db_btrees',
      'db_chains',
      'fail',
      'findall',
      'format',
      'free',
      'msgrecv',
      'msgsend',
      'nl',
      'not',
      'readterm',
      'ref_term',
      'retract',
      'retractall',
      'save',
      'term_bin',
      'term_replace',
      'term_str',
      'trap',
      'write',
      'writef',
   );
   $self->contextdata({
      'comment' => {
         callback => \&parsecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'comment region' => {
         callback => \&parsecommentregion,
         attribute => 'Comment',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Symbol',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
      },
      'string2' => {
         callback => \&parsestring2,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Prolog';
}

sub parsecomment {
   my ($self, $text) = @_;
   return 0;
};

sub parsecommentregion {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsenormal {
   my ($self, $text) = @_;
   # String => 'keywordl'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywordl', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywordu'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywordu', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'arith'
   # attribute => 'Arithmetic'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'arith', 0, undef, 0, '#stay', 'Arithmetic')) {
      return 1
   }
   # String => 'compiler'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'compiler', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'special'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'special', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'basetype'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'basetype', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '[A-Z_][A-Za-z0-9_]*'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Z_][A-Za-z0-9_]*', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => '[a-z][A-Za-z0-9_]*'
   # attribute => 'Identifier'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-z][A-Za-z0-9_]*', 0, 0, 0, undef, 0, '#stay', 'Identifier')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'comment region'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'comment region', 'Comment')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'string2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'string2', 'String')) {
      return 1
   }
   # String => '~!^*()-+=[]|\:;,./?&<>'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '~!^*()-+=[]|\\:;,./?&<>', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parsestring {
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

sub parsestring2 {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Prolog - a Plugin for Prolog syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Prolog;
 my $sh = new Syntax::Highlight::Engine::Kate::Prolog([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Prolog is a  plugin module that provides syntax highlighting
for Prolog to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author