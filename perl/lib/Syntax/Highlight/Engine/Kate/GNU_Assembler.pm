# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'gnuassembler.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.05
#kate version 2.4
#kate author John Zaitseff (J.Zaitseff@zap.org.au), Roland Pabel (roland@pabel.name)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::GNU_Assembler;

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
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Label' => 'Normal',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Preprocessor' => 'Others',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('keywords',
      '.abort',
      '.align',
      '.appfile',
      '.appline',
      '.arm',
      '.ascii',
      '.asciz',
      '.balign',
      '.balignl',
      '.balignw',
      '.bss',
      '.byte',
      '.code',
      '.comm',
      '.common',
      '.common.s',
      '.data',
      '.dc',
      '.dc.b',
      '.dc.d',
      '.dc.l',
      '.dc.s',
      '.dc.w',
      '.dc.x',
      '.dcb',
      '.dcb.b',
      '.dcb.d',
      '.dcb.l',
      '.dcb.s',
      '.dcb.w',
      '.dcb.x',
      '.debug',
      '.def',
      '.desc',
      '.dim',
      '.double',
      '.ds',
      '.ds.b',
      '.ds.d',
      '.ds.l',
      '.ds.p',
      '.ds.s',
      '.ds.w',
      '.ds.x',
      '.dsect',
      '.eject',
      '.else',
      '.elsec',
      '.elseif',
      '.end',
      '.endc',
      '.endef',
      '.endfunc',
      '.endif',
      '.endm',
      '.endr',
      '.equ',
      '.equiv',
      '.err',
      '.even',
      '.exitm',
      '.extend',
      '.extern',
      '.fail',
      '.file',
      '.fill',
      '.float',
      '.force_thumb',
      '.format',
      '.func',
      '.global',
      '.globl',
      '.hidden',
      '.hword',
      '.ident',
      '.if',
      '.ifc',
      '.ifdef',
      '.ifeq',
      '.ifeqs',
      '.ifge',
      '.ifgt',
      '.ifle',
      '.iflt',
      '.ifnc',
      '.ifndef',
      '.ifne',
      '.ifnes',
      '.ifnotdef',
      '.include',
      '.int',
      '.internal',
      '.irep',
      '.irepc',
      '.irp',
      '.irpc',
      '.lcomm',
      '.ldouble',
      '.lflags',
      '.line',
      '.linkonce',
      '.list',
      '.llen',
      '.ln',
      '.loc',
      '.long',
      '.lsym',
      '.ltorg',
      '.macro',
      '.mexit',
      '.name',
      '.noformat',
      '.nolist',
      '.nopage',
      '.octa',
      '.offset',
      '.org',
      '.p2align',
      '.p2alignl',
      '.p2alignw',
      '.packed',
      '.page',
      '.plen',
      '.pool',
      '.popsection',
      '.previous',
      '.print',
      '.protected',
      '.psize',
      '.purgem',
      '.pushsection',
      '.quad',
      '.rep',
      '.rept',
      '.req',
      '.rva',
      '.sbttl',
      '.scl',
      '.sect',
      '.sect.s',
      '.section',
      '.section.s',
      '.set',
      '.short',
      '.single',
      '.size',
      '.skip',
      '.sleb128',
      '.space',
      '.spc',
      '.stabd',
      '.stabn',
      '.stabs',
      '.string',
      '.struct',
      '.subsection',
      '.symver',
      '.tag',
      '.text',
      '.thumb',
      '.thumb_func',
      '.thumb_set',
      '.title',
      '.ttl',
      '.type',
      '.uleb128',
      '.use',
      '.val',
      '.version',
      '.vtable_entry',
      '.vtable_inherit',
      '.weak',
      '.word',
      '.xcom',
      '.xdef',
      '.xref',
      '.xstabs',
      '.zero',
   );
   $self->contextdata({
      'Commentar 1' => {
         callback => \&parseCommentar1,
         attribute => 'Comment',
      },
      'Commentar 2' => {
         callback => \&parseCommentar2,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'Some Context' => {
         callback => \&parseSomeContext,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|_|\\.|\\$');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'GNU Assembler';
}

sub parseCommentar1 {
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

sub parseCommentar2 {
   my ($self, $text) = @_;
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '[A-Za-z0-9_.$]+:'
   # attribute => 'Label'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z0-9_.$]+:', 0, 0, 0, undef, 1, '#stay', 'Label')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
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
   # String => '0[bB][01]+'
   # attribute => 'Binary'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0[bB][01]+', 0, 0, 0, undef, 0, '#stay', 'Binary')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => '0[fFeEdD][-+]?[0-9]*\.?[0-9]*[eE]?[-+]?[0-9]+'
   # attribute => 'Float'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0[fFeEdD][-+]?[0-9]*\\.?[0-9]*[eE]?[-+]?[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '[A-Za-z_.$][A-Za-z0-9_.$]*'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z_.$][A-Za-z0-9_.$]*', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => ''(\\x[0-9a-fA-F][0-9a-fA-F]?|\\[0-7]?[0-7]?[0-7]?|\\.|.)'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'(\\\\x[0-9a-fA-F][0-9a-fA-F]?|\\\\[0-7]?[0-7]?[0-7]?|\\\\.|.)', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # String => '@;'
   # attribute => 'Comment'
   # context => 'Commentar 2'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '@;', 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # String => '!#%&*()+,-<=>?/:[]^{|}~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!#%&*()+,-<=>?/:[]^{|}~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '^#'
   # attribute => 'Preprocessor'
   # context => 'Preprocessor'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^#', 0, 0, 0, undef, 0, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   return 0;
};

sub parseSomeContext {
   my ($self, $text) = @_;
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => 'Some Context'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, 'Some Context', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
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

Syntax::Highlight::Engine::Kate::GNU_Assembler - a Plugin for GNU Assembler syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::GNU_Assembler;
 my $sh = new Syntax::Highlight::Engine::Kate::GNU_Assembler([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::GNU_Assembler is a  plugin module that provides syntax highlighting
for GNU Assembler to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author