# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'ocaml.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.4
#kate author Glyn Webster (glyn@wave.co.nz)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Objective_Caml;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Binary' => 'BaseN',
      'Camlp4 Quotation' => 'String',
      'Character' => 'Char',
      'Comment' => 'Comment',
      'Core Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Directive' => 'Others',
      'Escaped characters' => 'Char',
      'Float' => 'Float',
      'Hexadecimal' => 'BaseN',
      'Identifier' => 'Normal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Revised Syntax Keyword' => 'Normal',
      'String' => 'String',
   });
   $self->listAdd('core types',
      'array',
      'bool',
      'char',
      'exn',
      'format',
      'int',
      'lazy_t',
      'list',
      'option',
      'real',
      'ref',
      'string',
      'unit',
   );
   $self->listAdd('keywords',
      'and',
      'as',
      'asr',
      'assert',
      'begin',
      'class',
      'closed',
      'constraint',
      'do',
      'done',
      'downto',
      'else',
      'end',
      'exception',
      'external',
      'false',
      'for',
      'fun',
      'function',
      'functor',
      'if',
      'in',
      'include',
      'inherit',
      'land',
      'lazy',
      'let',
      'lor',
      'lsl',
      'lsr',
      'lxor',
      'match',
      'method',
      'mod',
      'module',
      'mutable',
      'new',
      'of',
      'open',
      'or',
      'parser',
      'private',
      'rec',
      'sig',
      'struct',
      'then',
      'to',
      'true',
      'try',
      'type',
      'val',
      'virtual',
      'when',
      'while',
      'with',
   );
   $self->listAdd('revised syntax keywords',
      'declare',
      'value',
      'where',
   );
   $self->contextdata({
      'Camlp4 Quotation Constant' => {
         callback => \&parseCamlp4QuotationConstant,
         attribute => 'Camlp4 Quotation',
      },
      'Multiline Comment' => {
         callback => \&parseMultilineComment,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String Constant' => {
         callback => \&parseStringConstant,
         attribute => 'String',
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
   return 'Objective Caml';
}

sub parseCamlp4QuotationConstant {
   my ($self, $text) = @_;
   # attribute => 'Camlp4 Quotation'
   # char => '>'
   # char1 => '>'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '>', '>', 0, 0, 0, undef, 0, '#pop', 'Camlp4 Quotation')) {
      return 1
   }
   # attribute => 'Camlp4 Quotation'
   # char => '<'
   # char1 => '<'
   # context => 'Camlp4 Quotation Constant'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, 'Camlp4 Quotation Constant', 'Camlp4 Quotation')) {
      return 1
   }
   # String => '<:[A-Za-z\300-\326\330-\366\370-\377_][A-Za-z\300-\326\330-\366\370-\3770-9_']*<'
   # attribute => 'Camlp4 Quotation'
   # context => 'Camlp4 Quotation Constant'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<:[A-Za-z\\300-\\326\\330-\\366\\370-\\377_][A-Za-z\\300-\\326\\330-\\366\\370-\\3770-9_\']*<', 0, 0, 0, undef, 0, 'Camlp4 Quotation Constant', 'Camlp4 Quotation')) {
      return 1
   }
   # String => '\\(\\|>>|<<)'
   # attribute => 'Escaped characters'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\(\\\\|>>|<<)', 0, 0, 0, undef, 0, '#stay', 'Escaped characters')) {
      return 1
   }
   # String => '\\<:[A-Za-z\300-\326\330-\366\370-\377_][A-Za-z\300-\326\330-\366\370-\3770-9_']*<'
   # attribute => 'Escaped characters'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\<:[A-Za-z\\300-\\326\\330-\\366\\370-\\377_][A-Za-z\\300-\\326\\330-\\366\\370-\\3770-9_\']*<', 0, 0, 0, undef, 0, '#stay', 'Escaped characters')) {
      return 1
   }
   return 0;
};

sub parseMultilineComment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => ')'
   # context => '#pop'
   # endRegion => 'comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', ')', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'comment'
   # char => '('
   # char1 => '*'
   # context => 'Multiline Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'Multiline Comment', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # beginRegion => 'comment'
   # char => '('
   # char1 => '*'
   # context => 'Multiline Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '(', '*', 0, 0, 0, undef, 0, 'Multiline Comment', 'Comment')) {
      return 1
   }
   # String => '#[A-Za-z\300-\326\330-\366\370-\377_][A-Za-z\300-\326\330-\366\370-\3770-9_']*.*$'
   # attribute => 'Directive'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#[A-Za-z\\300-\\326\\330-\\366\\370-\\377_][A-Za-z\\300-\\326\\330-\\366\\370-\\3770-9_\']*.*$', 0, 0, 0, undef, 1, '#stay', 'Directive')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String Constant'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String Constant', 'String')) {
      return 1
   }
   # String => ''((\\[ntbr'"\\]|\\[0-9]{3}|\\x[0-9A-Fa-f]{2})|[^'])''
   # attribute => 'Character'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'((\\\\[ntbr\'"\\\\]|\\\\[0-9]{3}|\\\\x[0-9A-Fa-f]{2})|[^\'])\'', 0, 0, 0, undef, 0, '#stay', 'Character')) {
      return 1
   }
   # attribute => 'Camlp4 Quotation'
   # char => '<'
   # char1 => '<'
   # context => 'Camlp4 Quotation Constant'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, 'Camlp4 Quotation Constant', 'Camlp4 Quotation')) {
      return 1
   }
   # String => '<:[A-Za-z\300-\326\330-\366\370-\377_][A-Za-z\300-\326\330-\366\370-\3770-9_']*<'
   # attribute => 'Camlp4 Quotation'
   # context => 'Camlp4 Quotation Constant'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<:[A-Za-z\\300-\\326\\330-\\366\\370-\\377_][A-Za-z\\300-\\326\\330-\\366\\370-\\3770-9_\']*<', 0, 0, 0, undef, 0, 'Camlp4 Quotation Constant', 'Camlp4 Quotation')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'revised syntax keywords'
   # attribute => 'Revised Syntax Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'revised syntax keywords', 0, undef, 0, '#stay', 'Revised Syntax Keyword')) {
      return 1
   }
   # String => 'core types'
   # attribute => 'Core Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'core types', 0, undef, 0, '#stay', 'Core Data Type')) {
      return 1
   }
   # String => '[A-Za-z\300-\326\330-\366\370-\377_][A-Za-z\300-\326\330-\366\370-\3770-9_']*'
   # attribute => 'Identifier'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z\\300-\\326\\330-\\366\\370-\\377_][A-Za-z\\300-\\326\\330-\\366\\370-\\3770-9_\']*', 0, 0, 0, undef, 0, '#stay', 'Identifier')) {
      return 1
   }
   # String => '-?0[xX][0-9A-Fa-f_]+'
   # attribute => 'Hexadecimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-?0[xX][0-9A-Fa-f_]+', 0, 0, 0, undef, 0, '#stay', 'Hexadecimal')) {
      return 1
   }
   # String => '-?0[oO][0-7_]+'
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-?0[oO][0-7_]+', 0, 0, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # String => '-?0[bB][01_]+'
   # attribute => 'Binary'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-?0[bB][01_]+', 0, 0, 0, undef, 0, '#stay', 'Binary')) {
      return 1
   }
   # String => '-?[0-9][0-9_]*(\.[0-9][0-9_]*([eE][-+]?[0-9][0-9_]*)?|[eE][-+]?[0-9][0-9_]*)'
   # attribute => 'Float'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-?[0-9][0-9_]*(\\.[0-9][0-9_]*([eE][-+]?[0-9][0-9_]*)?|[eE][-+]?[0-9][0-9_]*)', 0, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '-?[0-9][0-9_]*'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-?[0-9][0-9_]*', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   return 0;
};

sub parseStringConstant {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # String => '(\\[ntbr'"\\]|\\[0-9]{3}|\\x[0-9A-Fa-f]{2})'
   # attribute => 'Escaped characters'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\\\[ntbr\'"\\\\]|\\\\[0-9]{3}|\\\\x[0-9A-Fa-f]{2})', 0, 0, 0, undef, 0, '#stay', 'Escaped characters')) {
      return 1
   }
   # String => '\\$'
   # attribute => 'Escaped characters'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\$', 0, 0, 0, undef, 0, '#stay', 'Escaped characters')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Objective_Caml - a Plugin for Objective Caml syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Objective_Caml;
 my $sh = new Syntax::Highlight::Engine::Kate::Objective_Caml([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Objective_Caml is a  plugin module that provides syntax highlighting
for Objective Caml to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author