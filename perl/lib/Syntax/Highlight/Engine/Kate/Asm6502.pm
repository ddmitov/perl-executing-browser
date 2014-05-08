# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'asm6502.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.1
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Asm6502;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Command' => 'Normal',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operator' => 'Others',
      'Parameter' => 'Others',
      'Preprocessor' => 'Others',
      'String' => 'String',
      'Substitution' => 'Others',
   });
   $self->contextdata({
      'Base' => {
         callback => \&parseBase,
         attribute => 'Normal Text',
      },
      'Commentar 2' => {
         callback => \&parseCommentar2,
         attribute => 'Comment',
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
   return 'Asm6502';
}

sub parseBase {
   my ($self, $text) = @_;
   # String => '#define.*$'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#define.*$', 0, 0, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # String => '#include .*$'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#include .*$', 0, 0, 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # String => ';.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\.byte'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.byte', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.byt'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.byt', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.word'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.word', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.asc'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.asc', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.dsb'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.dsb', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.fopt'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.fopt', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.text'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.text', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.data'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.data', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.bss'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.bss', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.zero'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.zero', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\.align'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\.align', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\$[A-Za-z0-9]*'
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[A-Za-z0-9]*', 0, 0, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # String => ',x$'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ',x$', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => ',y$'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ',y$', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '#'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'TAX'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'TAX', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'ADC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'ADC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'AND'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'AND', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'ASL'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'ASL', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BCC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BCC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BCS'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BCS', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BEQ'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BEQ', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BIT'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BIT', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BMI'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BMI', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BNE'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BNE', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BPL'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BPL', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BRK'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BRK', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BVC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BVC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'BVS'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'BVS', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CLC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CLC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CLD'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CLD', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CLI'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CLI', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CLV'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CLV', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CMP'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CMP', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CPX'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CPX', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'CPY'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CPY', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'DEC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'DEC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'DEX'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'DEX', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'DEY'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'DEY', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'EOR'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'EOR', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'INC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'INC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'INX'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'INX', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'INY'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'INY', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'JMP'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'JMP', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'JSR'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'JSR', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'LDA'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'LDA', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'LDX'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'LDX', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'LDY'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'LDY', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'LSR'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'LSR', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'NOP'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'NOP', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'ORA'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'ORA', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'PHA'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'PHA', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'PHP'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'PHP', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'PLA'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'PLA', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'PLP'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'PLP', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'ROL'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'ROL', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'ROR'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'ROR', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'RTI'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'RTI', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'RTS'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'RTS', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'SBC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'SBC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'SEC'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'SEC', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'SED'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'SED', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'SEI'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'SEI', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'STA'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'STA', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'STX'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'STX', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'STY'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'STY', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'TAY'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'TAY', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'TSX'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'TSX', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'TXA'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'TXA', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'TXS'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'TXS', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'TYA'
   # attribute => 'Keyword'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'TYA', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\*='
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*=', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # char1 => '"'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '-+<>=;'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '-+<>=;', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseCommentar2 {
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


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Asm6502 - a Plugin for Asm6502 syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Asm6502;
 my $sh = new Syntax::Highlight::Engine::Kate::Asm6502([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Asm6502 is a  plugin module that provides syntax highlighting
for Asm6502 to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author