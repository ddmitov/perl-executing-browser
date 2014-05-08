# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'scheme.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.11
#kate version 2.4
#kate author Dominik Haumann (dhdev@gmx.de)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Scheme;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'BaseN' => 'BaseN',
      'Brackets1' => 'Others',
      'Brackets2' => 'Others',
      'Brackets3' => 'Others',
      'Brackets4' => 'Others',
      'Brackets5' => 'Others',
      'Brackets6' => 'Others',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Data' => 'DataType',
      'Decimal' => 'DecVal',
      'Definition' => 'Reserved',
      'Float' => 'Float',
      'Function' => 'Function',
      'Keyword' => 'Keyword',
      'Normal' => 'Normal',
      'Operator' => 'Operator',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
   });
   $self->listAdd('characters',
      '#\\\\ack',
      '#\\\\backspace',
      '#\\\\bel',
      '#\\\\bs',
      '#\\\\bs',
      '#\\\\can',
      '#\\\\cr',
      '#\\\\cr',
      '#\\\\dc1',
      '#\\\\dc2',
      '#\\\\dc3',
      '#\\\\dc4',
      '#\\\\dle',
      '#\\\\em',
      '#\\\\enq',
      '#\\\\eot',
      '#\\\\esc',
      '#\\\\etb',
      '#\\\\etx',
      '#\\\\fs',
      '#\\\\gs',
      '#\\\\ht',
      '#\\\\ht',
      '#\\\\nak',
      '#\\\\newline',
      '#\\\\nl',
      '#\\\\nl',
      '#\\\\np',
      '#\\\\np',
      '#\\\\nul',
      '#\\\\nul',
      '#\\\\null',
      '#\\\\page',
      '#\\\\return',
      '#\\\\rs',
      '#\\\\si',
      '#\\\\so',
      '#\\\\soh',
      '#\\\\sp',
      '#\\\\space',
      '#\\\\stx',
      '#\\\\sub',
      '#\\\\syn',
      '#\\\\tab',
      '#\\\\us',
      '#\\\\vt',
   );
   $self->listAdd('defines',
      'define',
      'define*',
      'define*-public',
      'define-accessor',
      'define-class',
      'define-generic',
      'define-macro',
      'define-method',
      'define-module',
      'define-private',
      'define-public',
      'define-reader-ctor',
      'define-syntax',
      'define-syntax-macro',
      'defined?',
      'defmacro',
      'defmacro*',
      'defmacro*-public',
   );
   $self->listAdd('keywords',
      'abs',
      'acos',
      'and',
      'angle',
      'append',
      'applymap',
      'asin',
      'assoc',
      'assq',
      'assv',
      'atan',
      'begin',
      'boolean?',
      'break',
      'caaaar',
      'caaadr',
      'caaar',
      'caadar',
      'caaddr',
      'caadr',
      'caar',
      'cadaar',
      'cadadr',
      'cadar',
      'caddar',
      'cadddr',
      'caddr',
      'cadr',
      'call-with-current-continuation',
      'call-with-input-file',
      'call-with-output-file',
      'call-with-values',
      'call/cc',
      'car',
      'case',
      'catch',
      'cdaaar',
      'cdaadr',
      'cdaar',
      'cdadar',
      'cdaddr',
      'cdadr',
      'cdar',
      'cddaar',
      'cddadr',
      'cddar',
      'cdddar',
      'cddddr',
      'cdddr',
      'cddr',
      'cdr',
      'ceiling',
      'char->integer',
      'char-alphabetic?',
      'char-ci<=?',
      'char-ci=?',
      'char-ci>=?',
      'char-ci>?',
      'char-downcase',
      'char-lower-case?',
      'char-numeric?',
      'char-ready?',
      'char-upcase',
      'char-upper-case?',
      'char-whitespace?',
      'char<=?',
      'char<?c',
      'char=?',
      'char>=?',
      'char>?',
      'char?',
      'close-input-port',
      'close-output-port',
      'complex?',
      'cond',
      'cons',
      'continue',
      'cos',
      'current-input-port',
      'current-output-port',
      'denominator',
      'display',
      'do',
      'dynamic-wind',
      'else',
      'eof-object?',
      'eq?',
      'equal?',
      'eqv?',
      'eval',
      'even?',
      'exact->inexact',
      'exact?',
      'exp',
      'expt',
      'floor',
      'for-each',
      'force',
      'gcd',
      'har-ci<?',
      'if',
      'imag-part',
      'inexact->exact',
      'inexact?',
      'input-port?',
      'integer->char',
      'integer?',
      'interaction-environment',
      'lambda',
      'lcm',
      'length',
      'let',
      'let*',
      'let-syntax',
      'letrec',
      'letrec-syntax',
      'list',
      'list->string',
      'list-ref',
      'list-tail',
      'list?',
      'load',
      'log',
      'magnitude',
      'make-polar',
      'make-rectangular',
      'make-string',
      'make-vector',
      'max',
      'member',
      'memq',
      'memv',
      'min',
      'modulo',
      'negative?',
      'newline',
      'not',
      'null-environment',
      'null?',
      'number->string',
      'number?',
      'numerator',
      'odd?',
      'open-input-file',
      'open-output-file',
      'or',
      'output-port?',
      'pair?',
      'peek-char',
      'port?',
      'positive?',
      'procedure?',
      'quotient',
      'rational?',
      'rationalize',
      'read',
      'read-char',
      'real-part',
      'real?',
      'remainder',
      'reverse',
      'round',
      'scheme-report-environment',
      'set-car!',
      'set-cdr!',
      'sin',
      'sqrt',
      'string',
      'string->list',
      'string->number',
      'string->symbol',
      'string-append',
      'string-ci<=?',
      'string-ci<?',
      'string-ci=?',
      'string-ci>=?',
      'string-ci>?',
      'string-copy',
      'string-fill!',
      'string-length',
      'string-ref',
      'string-set!',
      'string<=?',
      'string<?',
      'string=?',
      'string>=?',
      'string>?',
      'string?',
      'substring',
      'symbol->string',
      'symbol?',
      'syntax-rules',
      'tan',
      'transcript-off',
      'transcript-on',
      'truncate',
      'values',
      'vector',
      'vector->listlist->vector',
      'vector-fill!',
      'vector-length',
      'vector-ref',
      'vector-set!',
      'vector?',
      'while',
      'with-input-from-file',
      'with-output-to-file',
      'write',
      'write-char',
      'zero?',
   );
   $self->listAdd('operators',
      '*)',
      '*,*',
      '+',
      '-',
      '/',
      '<',
      '<=',
      '=',
      '=>',
      '>',
      '>=',
   );
   $self->contextdata({
      'Default' => {
         callback => \&parseDefault,
         attribute => 'Normal',
      },
      'Level0' => {
         callback => \&parseLevel0,
         attribute => 'Normal',
      },
      'Level1' => {
         callback => \&parseLevel1,
         attribute => 'Normal',
      },
      'Level2' => {
         callback => \&parseLevel2,
         attribute => 'Normal',
      },
      'Level3' => {
         callback => \&parseLevel3,
         attribute => 'Normal',
      },
      'Level4' => {
         callback => \&parseLevel4,
         attribute => 'Normal',
      },
      'Level5' => {
         callback => \&parseLevel5,
         attribute => 'Normal',
      },
      'Level6' => {
         callback => \&parseLevel6,
         attribute => 'Normal',
      },
      'MultiLineComment' => {
         callback => \&parseMultiLineComment,
         attribute => 'Comment',
      },
      'SpecialNumber' => {
         callback => \&parseSpecialNumber,
         attribute => 'Normal',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
      'function_decl' => {
         callback => \&parsefunction_decl,
         attribute => 'Function',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|,|\\%|\\&|;|\\[|\\]|\\^|\\{|\\||\\}|\\~|-|\\+|\\*|\\?|\\!|<|>|=|\\/|:|#|\\\\');
   $self->basecontext('Level0');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Scheme';
}

sub parseDefault {
   my ($self, $text) = @_;
   # String => ';+\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'region'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';+\\s*BEGIN.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => ';+\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'region'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';+\\s*END.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => ';.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'region'
   # char => '#'
   # char1 => '!'
   # context => 'MultiLineComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '#', '!', 0, 0, 0, undef, 0, 'MultiLineComment', 'Comment')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'operators'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'operators', 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => 'defines'
   # attribute => 'Definition'
   # context => 'function_decl'
   # type => 'keyword'
   if ($self->testKeyword($text, 'defines', 0, undef, 0, 'function_decl', 'Definition')) {
      return 1
   }
   # String => 'characters'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'characters', 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '#\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '#[bodxei]'
   # attribute => 'Char'
   # context => 'SpecialNumber'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#[bodxei]', 0, 0, 0, undef, 0, 'SpecialNumber', 'Char')) {
      return 1
   }
   # String => '#[tf]'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#[tf]', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
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
   # attribute => 'Brackets1'
   # char => '('
   # context => 'Level1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level1', 'Brackets1')) {
      return 1
   }
   return 0;
};

sub parseLevel0 {
   my ($self, $text) = @_;
   # attribute => 'Brackets1'
   # char => '('
   # context => 'Level1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level1', 'Brackets1')) {
      return 1
   }
   # context => 'Default'
   # type => 'IncludeRules'
   if ($self->includeRules('Default', $text)) {
      return 1
   }
   return 0;
};

sub parseLevel1 {
   my ($self, $text) = @_;
   # attribute => 'Brackets2'
   # char => '('
   # context => 'Level2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level2', 'Brackets2')) {
      return 1
   }
   # attribute => 'Brackets1'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Brackets1')) {
      return 1
   }
   # context => 'Default'
   # type => 'IncludeRules'
   if ($self->includeRules('Default', $text)) {
      return 1
   }
   return 0;
};

sub parseLevel2 {
   my ($self, $text) = @_;
   # attribute => 'Brackets3'
   # char => '('
   # context => 'Level3'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level3', 'Brackets3')) {
      return 1
   }
   # attribute => 'Brackets2'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Brackets2')) {
      return 1
   }
   # context => 'Default'
   # type => 'IncludeRules'
   if ($self->includeRules('Default', $text)) {
      return 1
   }
   return 0;
};

sub parseLevel3 {
   my ($self, $text) = @_;
   # attribute => 'Brackets4'
   # char => '('
   # context => 'Level4'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level4', 'Brackets4')) {
      return 1
   }
   # attribute => 'Brackets3'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Brackets3')) {
      return 1
   }
   # context => 'Default'
   # type => 'IncludeRules'
   if ($self->includeRules('Default', $text)) {
      return 1
   }
   return 0;
};

sub parseLevel4 {
   my ($self, $text) = @_;
   # attribute => 'Brackets5'
   # char => '('
   # context => 'Level5'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level5', 'Brackets5')) {
      return 1
   }
   # attribute => 'Brackets4'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Brackets4')) {
      return 1
   }
   # context => 'Default'
   # type => 'IncludeRules'
   if ($self->includeRules('Default', $text)) {
      return 1
   }
   return 0;
};

sub parseLevel5 {
   my ($self, $text) = @_;
   # attribute => 'Brackets6'
   # char => '('
   # context => 'Level6'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level6', 'Brackets6')) {
      return 1
   }
   # attribute => 'Brackets5'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Brackets5')) {
      return 1
   }
   # context => 'Default'
   # type => 'IncludeRules'
   if ($self->includeRules('Default', $text)) {
      return 1
   }
   return 0;
};

sub parseLevel6 {
   my ($self, $text) = @_;
   # attribute => 'Brackets1'
   # char => '('
   # context => 'Level1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'Level1', 'Brackets1')) {
      return 1
   }
   # attribute => 'Brackets6'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Brackets6')) {
      return 1
   }
   # context => 'Default'
   # type => 'IncludeRules'
   if ($self->includeRules('Default', $text)) {
      return 1
   }
   return 0;
};

sub parseMultiLineComment {
   my ($self, $text) = @_;
   # String => '!#\s*$'
   # attribute => 'Comment'
   # column => '0'
   # context => '#pop'
   # endRegion => 'region'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '!#\\s*$', 0, 0, 0, 0, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseSpecialNumber {
   my ($self, $text) = @_;
   # attribute => 'Float'
   # context => '#pop'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#pop'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#pop', 'Decimal')) {
      return 1
   }
   # attribute => 'BaseN'
   # context => '#pop'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#pop', 'BaseN')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#pop'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # String => 'characters'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'characters', 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '#\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => '\'
   # char1 => '"'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '"', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => '\'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\\', 0, 0, 0, undef, 0, '#stay', 'Char')) {
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

sub parsefunction_decl {
   my ($self, $text) = @_;
   # String => '\s*[A-Za-z0-9-+\<\>//\*]*\s*'
   # attribute => 'Function'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*[A-Za-z0-9-+\\<\\>//\\*]*\\s*', 0, 0, 0, undef, 0, '#pop', 'Function')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Scheme - a Plugin for Scheme syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Scheme;
 my $sh = new Syntax::Highlight::Engine::Kate::Scheme([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Scheme is a  plugin module that provides syntax highlighting
for Scheme to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author