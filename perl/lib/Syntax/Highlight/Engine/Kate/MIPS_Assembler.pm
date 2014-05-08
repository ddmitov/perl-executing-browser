# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'mips.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.4
#kate author Dominik Haumann (dhdev@gmx.de)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::MIPS_Assembler;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Floating Point Register' => 'Float',
      'Hardware Instruction' => 'Keyword',
      'Hex' => 'BaseN',
      'Label' => 'Others',
      'Main Register' => 'DataType',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Other Register' => 'DataType',
      'Pseudo Instruction' => 'Function',
      'Region Marker' => 'RegionMarker',
      'Section' => 'DataType',
      'String' => 'String',
      'Type' => 'Keyword',
   });
   $self->listAdd('fp',
      '$f0',
      '$f1',
      '$f10',
      '$f11',
      '$f12',
      '$f13',
      '$f14',
      '$f15',
      '$f16',
      '$f17',
      '$f18',
      '$f19',
      '$f2',
      '$f20',
      '$f21',
      '$f22',
      '$f23',
      '$f24',
      '$f25',
      '$f26',
      '$f27',
      '$f28',
      '$f29',
      '$f3',
      '$f30',
      '$f31',
      '$f4',
      '$f5',
      '$f6',
      '$f7',
      '$f8',
      '$f9',
   );
   $self->listAdd('hardware',
      'abs.d',
      'abs.s',
      'add',
      'add.d',
      'add.s',
      'addi',
      'addiu',
      'addu',
      'and',
      'andi',
      'bc0f',
      'bc0t',
      'bc1f',
      'bc1t',
      'bc2f',
      'bc2t',
      'bc3f',
      'bc3t',
      'beq',
      'bgez',
      'bgezal',
      'bgtz',
      'blez',
      'bltz',
      'bltzal',
      'bne',
      'break',
      'c.eq.d',
      'c.eq.s',
      'c.le.d',
      'c.le.s',
      'c.lt.d',
      'c.lt.s',
      'c.ole.d',
      'c.ole.s',
      'c.olt.d',
      'c.olt.s',
      'c.seq.d',
      'c.seq.s',
      'c.ueq.d',
      'c.ueq.s',
      'c.ule.d',
      'c.ule.s',
      'c.ult.d',
      'c.ult.s',
      'c.un.d',
      'c.un.s',
      'cvt.d.s',
      'cvt.d.w',
      'cvt.s.d',
      'cvt.s.w',
      'cvt.w.d',
      'cvt.w.s',
      'div.d',
      'div.s',
      'j',
      'jal',
      'jalr',
      'jr',
      'lb',
      'lbu',
      'lh',
      'lhu',
      'lui',
      'lw',
      'lwc0',
      'lwc1',
      'lwc2',
      'lwc3',
      'lwl',
      'lwr',
      'mfc0',
      'mfc1',
      'mfc2',
      'mfc3',
      'mfhi',
      'mflo',
      'mtc0',
      'mtc1',
      'mtc2',
      'mtc3',
      'mthi',
      'mtlo',
      'mul.d',
      'mul.s',
      'mult',
      'multu',
      'nor',
      'or',
      'ori',
      'rfe',
      'sb',
      'sh',
      'sll',
      'sllv',
      'slt',
      'slti',
      'sltiu',
      'sra',
      'srav',
      'srl',
      'srlv',
      'sub',
      'sub.d',
      'sub.s',
      'subu',
      'sw',
      'sw',
      'swc0',
      'swc1',
      'swc2',
      'swc3',
      'swcl',
      'swl',
      'swl',
      'swr',
      'swr',
      'syscall',
      'xor',
      'xori',
   );
   $self->listAdd('pseudo',
      'abs',
      'b',
      'beqz',
      'bge',
      'bgeu',
      'bgt',
      'bgtu',
      'ble',
      'bleu',
      'blt',
      'bltu',
      'bnez',
      'div',
      'divu',
      'l.d',
      'l.s',
      'la',
      'ld',
      'li',
      'li.d',
      'li.s',
      'mfc0.d',
      'mfc1.d',
      'mfc2.d',
      'mfc3.d',
      'mov.d',
      'mov.s',
      'move',
      'mul',
      'mulo',
      'mulou',
      'neg',
      'neg.d',
      'neg.s',
      'negu',
      'nop',
      'not',
      'rem',
      'remu',
      'rol',
      'ror',
      's.d',
      's.s',
      'sd',
      'seq',
      'sge',
      'sgeu',
      'sgt',
      'sgtu',
      'sle',
      'sleu',
      'sne',
      'ulh',
      'ulhu',
      'ulw',
      'ush',
      'usw',
   );
   $self->listAdd('register1',
      '$0',
      '$1',
      '$10',
      '$11',
      '$12',
      '$13',
      '$14',
      '$15',
      '$16',
      '$17',
      '$18',
      '$19',
      '$2',
      '$20',
      '$21',
      '$22',
      '$23',
      '$24',
      '$25',
      '$26',
      '$27',
      '$28',
      '$29',
      '$3',
      '$30',
      '$31',
      '$4',
      '$5',
      '$6',
      '$7',
      '$8',
      '$9',
      '$t0',
      '$t1',
      '$t2',
      '$t3',
      '$t4',
      '$t5',
      '$t6',
      '$t7',
      '$t8',
      '$t9',
      '$zero',
   );
   $self->listAdd('register2',
      '$a0',
      '$a1',
      '$a2',
      '$a3',
      '$at',
      '$fp',
      '$gp',
      '$k0',
      '$k1',
      '$ra',
      '$s0',
      '$s1',
      '$s2',
      '$s3',
      '$s4',
      '$s5',
      '$s6',
      '$s7',
      '$sp',
      '$v0',
      '$v1',
   );
   $self->listAdd('section',
      '.data',
      '.kdata',
      '.ktext',
      '.text',
   );
   $self->listAdd('type',
      '.align',
      '.ascii',
      '.asciiz',
      '.byte',
      '.double',
      '.extern',
      '.float',
      '.globl',
      '.half',
      '.sdata',
      '.set',
      '.space',
      '.word',
   );
   $self->contextdata({
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal Text',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|\\.');
   $self->basecontext('normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'MIPS Assembler';
}

sub parsenormal {
   my ($self, $text) = @_;
   # String => 'hardware'
   # attribute => 'Hardware Instruction'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'hardware', 0, undef, 0, '#stay', 'Hardware Instruction')) {
      return 1
   }
   # String => 'pseudo'
   # attribute => 'Pseudo Instruction'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'pseudo', 0, undef, 0, '#stay', 'Pseudo Instruction')) {
      return 1
   }
   # String => 'register1'
   # attribute => 'Other Register'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'register1', 0, undef, 0, '#stay', 'Other Register')) {
      return 1
   }
   # String => 'register2'
   # attribute => 'Main Register'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'register2', 0, undef, 0, '#stay', 'Main Register')) {
      return 1
   }
   # String => 'fp'
   # attribute => 'Floating Point Register'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'fp', 0, undef, 0, '#stay', 'Floating Point Register')) {
      return 1
   }
   # String => 'section'
   # attribute => 'Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'section', 0, undef, 0, '#stay', 'Type')) {
      return 1
   }
   # String => 'type'
   # attribute => 'Section'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'type', 0, undef, 0, '#stay', 'Section')) {
      return 1
   }
   # String => '#\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'region'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '#\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'region'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '[\w_\.]+:'
   # attribute => 'Label'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\w_\\.]+:', 0, 0, 0, undef, 1, '#stay', 'Label')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
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


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::MIPS_Assembler - a Plugin for MIPS Assembler syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::MIPS_Assembler;
 my $sh = new Syntax::Highlight::Engine::Kate::MIPS_Assembler([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::MIPS_Assembler is a  plugin module that provides syntax highlighting
for MIPS Assembler to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author