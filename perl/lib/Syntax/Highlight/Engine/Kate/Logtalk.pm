# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'logtalk.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.40
#kate version 2.4
#kate author Paulo Moura (pmoura@logtalk.org)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Logtalk;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Built-in' => 'Keyword',
      'Comment' => 'Comment',
      'Directive' => 'Keyword',
      'Normal' => 'Normal',
      'Number' => 'DecVal',
      'Operator' => 'DataType',
      'String' => 'String',
      'Variable' => 'Others',
   });
   $self->contextdata({
      'atom' => {
         callback => \&parseatom,
         attribute => 'String',
      },
      'directive' => {
         callback => \&parsedirective,
         attribute => 'Directive',
      },
      'entityrelations' => {
         callback => \&parseentityrelations,
         attribute => 'Normal',
      },
      'multiline comment' => {
         callback => \&parsemultilinecomment,
         attribute => 'Comment',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal',
      },
      'single line comment' => {
         callback => \&parsesinglelinecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('normal');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Logtalk';
}

sub parseatom {
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

sub parsedirective {
   my ($self, $text) = @_;
   # String => '\b(category|object|protocol)(?=[(])'
   # attribute => 'Directive'
   # beginRegion => 'Entity'
   # context => 'entityrelations'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(category|object|protocol)(?=[(])', 0, 0, 0, undef, 0, 'entityrelations', 'Directive')) {
      return 1
   }
   # String => '\bend_(category|object|protocol)[.]'
   # attribute => 'Directive'
   # context => '#pop'
   # endRegion => 'Entity'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bend_(category|object|protocol)[.]', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   # String => '\bp(ublic|r(otected|ivate))(?=[(])'
   # attribute => 'Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bp(ublic|r(otected|ivate))(?=[(])', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   # String => '\bencoding(?=[(])'
   # attribute => 'Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bencoding(?=[(])', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   # String => '\bin(fo|itialization)(?=[(])'
   # attribute => 'Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bin(fo|itialization)(?=[(])', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   # String => '\bdynamic[.]'
   # attribute => 'Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdynamic[.]', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   # String => '\b(alias|d(ynamic|iscontiguous)|m(etapredicate|ode|ultifile))(?=[(])'
   # attribute => 'Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(alias|d(ynamic|iscontiguous)|m(etapredicate|ode|ultifile))(?=[(])', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   # String => '\bop(?=[(])'
   # attribute => 'Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bop(?=[(])', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   # String => '\b(calls|uses)(?=[(])'
   # attribute => 'Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(calls|uses)(?=[(])', 0, 0, 0, undef, 0, '#pop', 'Directive')) {
      return 1
   }
   return 0;
};

sub parseentityrelations {
   my ($self, $text) = @_;
   # String => '\b(extends|i(nstantiates|mp(lements|orts))|specializes)(?=[(])'
   # attribute => 'Directive'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(extends|i(nstantiates|mp(lements|orts))|specializes)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Directive')) {
      return 1
   }
   # attribute => 'Normal'
   # char => ')'
   # char1 => '.'
   # context => 'normal'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, ')', '.', 0, 0, 0, undef, 0, 'normal', 'Normal')) {
      return 1
   }
   return 0;
};

sub parsemultilinecomment {
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

sub parsenormal {
   my ($self, $text) = @_;
   # String => '^\s*:-'
   # attribute => 'Normal'
   # context => 'directive'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*:-', 0, 0, 0, undef, 0, 'directive', 'Normal')) {
      return 1
   }
   # String => '\b(after|before)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(after|before)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(parameter|this|se(lf|nder))(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(parameter|this|se(lf|nder))(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(current_predicate|predicate_property)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(current_predicate|predicate_property)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(expand_term|phrase)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(expand_term|phrase)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(abolish|c(reate|urrent))_(object|protocol|category)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(abolish|c(reate|urrent))_(object|protocol|category)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(object|protocol|category)_property(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(object|protocol|category)_property(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bextends_(object|protocol)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bextends_(object|protocol)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bimplements_protocol(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bimplements_protocol(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(instantiates|specializes)_class(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(instantiates|specializes)_class(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bimports_category(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bimports_category(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(current_event|(abolish|define)_events)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(current_event|(abolish|define)_events)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(current|set)_logtalk_flag(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(current|set)_logtalk_flag(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\blogtalk_(compile|l(ibrary_path|oad))(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\blogtalk_(compile|l(ibrary_path|oad))(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(clause|retract(all)?)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(clause|retract(all)?)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\ba(bolish|ssert(a|z))(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\ba(bolish|ssert(a|z))(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(ca(ll|tch)|throw)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(ca(ll|tch)|throw)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(fail|true)\b'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(fail|true)\\b', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b((bag|set)of|f(ind|or)all)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b((bag|set)of|f(ind|or)all)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bunify_with_occurs_check(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bunify_with_occurs_check(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(functor|arg|copy_term)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(functor|arg|copy_term)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(rem|mod|abs|sign)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(rem|mod|abs|sign)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bfloat(_(integer|fractional)_part)?(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfloat(_(integer|fractional)_part)?(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(floor|truncate|round|ceiling)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(floor|truncate|round|ceiling)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(cos|atan|exp|log|s(in|qrt))(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(cos|atan|exp|log|s(in|qrt))(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(var|atom(ic)?|integer|float|compound|n(onvar|umber))(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(var|atom(ic)?|integer|float|compound|n(onvar|umber))(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(current|set)_(in|out)put(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(current|set)_(in|out)put(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(open|close)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(open|close)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bflush_output(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bflush_output(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bflush_output\b'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bflush_output\\b', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(stream_property|at_end_of_stream|set_stream_position)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(stream_property|at_end_of_stream|set_stream_position)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(nl|(get|peek|put)_(byte|c(har|ode)))(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(nl|(get|peek|put)_(byte|c(har|ode)))(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bnl\b'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bnl\\b', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bread(_term)?(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bread(_term)?(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bwrite(q|_(canonical|term))?(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bwrite(q|_(canonical|term))?(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(current_)?op(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(current_)?op(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(current_)?char_conversion(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(current_)?char_conversion(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\batom_(length|c(hars|o(ncat|des)))(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\batom_(length|c(hars|o(ncat|des)))(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(char_code|sub_atom)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(char_code|sub_atom)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bnumber_c(hars|odes)(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bnumber_c(hars|odes)(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b(set|current)_prolog_flag(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(set|current)_prolog_flag(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bhalt\b'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bhalt\\b', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\bhalt(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bhalt(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\b[A-Z_]\w*'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[A-Z_]\\w*', 0, 0, 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '%'
   # context => 'single line comment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'single line comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'multiline comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'multiline comment', 'Comment')) {
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
   # context => 'atom'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'atom', 'String')) {
      return 1
   }
   # String => '0'.'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0\'.', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # String => '0b[0-1]+'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0b[0-1]+', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # String => '0o[0-7]+'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0o[0-7]+', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # String => '0x[0-9a-fA-F]+'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0x[0-9a-fA-F]+', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # String => '\d+(\.\d+)?([eE]([-+])?\d+)?'
   # attribute => 'Number'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\d+(\\.\\d+)?([eE]([-+])?\\d+)?', 0, 0, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # attribute => 'Operator'
   # char => ':'
   # char1 => ':'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, ':', ':', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '^'
   # char1 => '^'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '^', '^', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # beginRegion => 'external'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '}'
   # context => '#stay'
   # endRegion => 'external'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '\bonce(?=[(])'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bonce(?=[(])', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # String => '\brepeat\b'
   # attribute => 'Built-in'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\brepeat\\b', 0, 0, 0, undef, 0, '#stay', 'Built-in')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '>'
   # char1 => '>'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '>', '>', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '<'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '<', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '/'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '\\', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '\'
   # char1 => '/'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '/', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '\'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\\', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '\bis\b'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bis\\b', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '=:='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '=:=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '=\='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '=\\=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '<'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '='
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '=', '<', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '>'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '>'
   # char1 => '='
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '>', '=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '=..'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '=..', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '='
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '\'
   # char1 => '='
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '='
   # char1 => '='
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '=', '=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '\=='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\==', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '@=<'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@=<', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '@'
   # char1 => '<'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '@', '<', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '@>='
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@>=', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '@'
   # char1 => '>'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '@', '>', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '/'
   # char1 => '/'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '+-*/'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '+-*/', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '\b(mod|rem)\b'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(mod|rem)\\b', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '*'
   # char1 => '*'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '*', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '-->'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '-->', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '!;'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!;', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '-'
   # char1 => '>'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '>', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Operator'
   # char => '\'
   # char1 => '+'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '+', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '?@'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '?@', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Normal'
   # char => ':'
   # char1 => '-'
   # context => '#stay'
   # firstNonSpace => 'false'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, ':', '-', 0, 0, 0, undef, 0, '#stay', 'Normal')) {
      return 1
   }
   # String => '\b[a-z]\w*'
   # attribute => 'Normal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[a-z]\\w*', 0, 0, 0, undef, 0, '#stay', 'Normal')) {
      return 1
   }
   return 0;
};

sub parsesinglelinecomment {
   my ($self, $text) = @_;
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


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Logtalk - a Plugin for Logtalk syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Logtalk;
 my $sh = new Syntax::Highlight::Engine::Kate::Logtalk([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Logtalk is a  plugin module that provides syntax highlighting
for Logtalk to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author