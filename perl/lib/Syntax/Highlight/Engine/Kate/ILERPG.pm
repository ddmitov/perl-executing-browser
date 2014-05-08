# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'ilerpg.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.1
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::ILERPG;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Base-N' => 'BaseN',
      'Biff' => 'Keyword',
      'BoldComment' => 'Alert',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Constant' => 'DataType',
      'Decimal' => 'DecVal',
      'Directive' => 'Others',
      'DivideComment' => 'Alert',
      'Fill' => 'Reserved',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'RegExpr' => 'BaseN',
      'Symbol' => 'Normal',
   });
   $self->listAdd('biffs',
      'ABS',
      'ADDR',
      'CHAR',
      'DEC',
      'DECH',
      'DECPOS',
      'EDITC',
      'EDITFLT',
      'EDITW',
      'ELEM',
      'EOF',
      'EQUAL',
      'ERROR',
      'FLOAT',
      'FOUND',
      'INT',
      'INTH',
      'LEN',
      'NULLIND',
      'OPEN',
      'PADDR',
      'PARMS',
      'REPLACE',
      'SCAN',
      'SIZE',
      'STATUS',
      'STR',
      'SUBST',
      'TRIM',
      'TRIML',
      'TRIMR',
      'UNS',
      'UNSH',
   );
   $self->listAdd('opcodes',
      '*BLANKS',
      'ACQ',
      'ADD',
      'ADDDUR',
      'ALLOC',
      'AND',
      'ANDEQ',
      'ANDGE',
      'ANDGT',
      'ANDLE',
      'ANDLT',
      'ANDNE',
      'BEGSR',
      'BITOFF',
      'BITON',
      'CAB',
      'CABEQ',
      'CABGE',
      'CABGT',
      'CABLE',
      'CABLT',
      'CABNE',
      'CALL',
      'CALLB',
      'CALLP',
      'CAS',
      'CASEQ',
      'CASGE',
      'CASGT',
      'CASLE',
      'CASLT',
      'CASNE',
      'CAT',
      'CHAIN',
      'CHECK',
      'CHECKR',
      'CLEAR',
      'CLOSE',
      'COMMIT',
      'COMP',
      'DEALLOC',
      'DEFINE',
      'DELETE',
      'DIV',
      'DO',
      'DOU',
      'DOUEQ',
      'DOUGE',
      'DOUGT',
      'DOULE',
      'DOULT',
      'DOUNE',
      'DOW',
      'DOWEQ',
      'DOWGE',
      'DOWGT',
      'DOWLE',
      'DOWLT',
      'DOWNE',
      'DSPLY',
      'DUMP',
      'ELSE',
      'END',
      'ENDCS',
      'ENDDO',
      'ENDIF',
      'ENDSL',
      'ENDSR',
      'EVAL',
      'EXCEPT',
      'EXFMT',
      'EXSR',
      'EXTRCT',
      'FEOD',
      'FORCE',
      'GOTO',
      'IF',
      'IFEQ',
      'IFGE',
      'IFGT',
      'IFLE',
      'IFLT',
      'IFNE',
      'IN',
      'ITER',
      'KFLD',
      'KLIST',
      'LEAVE',
      'LOOKUP',
      'MHHZO',
      'MHLZO',
      'MLHZO',
      'MLLZO',
      'MOVE',
      'MOVEA',
      'MOVEL',
      'MULT',
      'MVR',
      'NEXT',
      'OCCUR',
      'OPEN',
      'OR',
      'OREQ',
      'ORGE',
      'ORGT',
      'ORLE',
      'ORLT',
      'ORNE',
      'OTHER',
      'OUT',
      'PARM',
      'PLIST',
      'POST',
      'READ',
      'READC',
      'READE',
      'READP',
      'READPE',
      'REALLOC',
      'REL',
      'RESET',
      'RETURN',
      'ROLBK',
      'SCAN',
      'SELECT',
      'SETGT',
      'SETLL',
      'SETOFF',
      'SETON',
      'SHTDN',
      'SORTA',
      'SQRT',
      'SUB',
      'SUBDUR',
      'SUBST',
      'TAG',
      'TEST',
      'TESTB',
      'TESTN',
      'TESTZ',
      'TIME',
      'UNLOCK',
      'UPDATE',
      'WHEN',
      'WHENEQ',
      'WHENGE',
      'WHENGT',
      'WHENLE',
      'WHENLT',
      'WHENNR',
      'WRITE',
      'XFOOT',
      'XLATE',
      'Z-ADD',
      'Z-SUB',
   );
   $self->contextdata({
      'Default' => {
         callback => \&parseDefault,
         attribute => 'Normal Text',
      },
      'context1' => {
         callback => \&parsecontext1,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'context3' => {
         callback => \&parsecontext3,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'context4' => {
         callback => \&parsecontext4,
         attribute => 'Constant',
      },
      'context5' => {
         callback => \&parsecontext5,
         attribute => 'Constant',
      },
      'context6' => {
         callback => \&parsecontext6,
         attribute => 'Keyword',
         lineending => '#pop#pop',
      },
      'context7' => {
         callback => \&parsecontext7,
         attribute => 'BoldComment',
         lineending => 'Default',
      },
      'context8' => {
         callback => \&parsecontext8,
         attribute => 'Biff',
         lineending => '#pop#pop#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Default');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'ILERPG';
}

sub parseDefault {
   my ($self, $text) = @_;
   # String => '[POIHFDC ]?\*'
   # attribute => 'Comment'
   # context => 'context3'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[POIHFDC ]?\\*', 0, 0, 0, undef, 0, 'context3', 'Comment')) {
      return 1
   }
   # String => 'POIHFDC'
   # attribute => 'Keyword'
   # context => 'context1'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, 'POIHFDC', 0, 0, undef, 0, 'context1', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parsecontext1 {
   my ($self, $text) = @_;
   # String => 'opcodes'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'opcodes', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Biff'
   # char => '%'
   # context => 'context7'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'context7', 'Biff')) {
      return 1
   }
   # attribute => 'Constant'
   # char => '''
   # context => 'context3'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'context3', 'Constant')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '[Xx]'[0-9a-fA-F]{2,}''
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[Xx]\'[0-9a-fA-F]{2,}\'', 0, 0, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # items => 'ARRAY(0x1190f00)'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      # String => 'ULL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'ULL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LUL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LUL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LLU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LLU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'UL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'UL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'U'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'U', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'L'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'L', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
   }
   return 0;
};

sub parsecontext3 {
   my ($self, $text) = @_;
   # String => '\(*(FIXME|TODO)\)*'
   # attribute => 'BoldComment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\(*(FIXME|TODO)\\)*', 0, 0, 0, undef, 0, '#stay', 'BoldComment')) {
      return 1
   }
   # String => '\(*(NOTE:)\)*'
   # attribute => 'BoldComment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\(*(NOTE:)\\)*', 0, 0, 0, undef, 0, '#stay', 'BoldComment')) {
      return 1
   }
   # attribute => 'BoldComment'
   # char => '!'
   # context => 'context6'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '!', 0, 0, 0, undef, 0, 'context6', 'BoldComment')) {
      return 1
   }
   # String => '-|='
   # attribute => 'DivideComment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-|=', 0, 0, 0, undef, 0, '#stay', 'DivideComment')) {
      return 1
   }
   return 0;
};

sub parsecontext4 {
   my ($self, $text) = @_;
   # attribute => 'Constant'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Constant')) {
      return 1
   }
   return 0;
};

sub parsecontext5 {
   my ($self, $text) = @_;
   # String => 'FHDICO'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, 'FHDICO', 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Constant'
   # char => ' '
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ' ', 0, 0, 0, undef, 0, '#pop', 'Constant')) {
      return 1
   }
   return 0;
};

sub parsecontext6 {
   my ($self, $text) = @_;
   return 0;
};

sub parsecontext7 {
   my ($self, $text) = @_;
   # attribute => 'BoldComment'
   # char => '!'
   # context => 'context3'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '!', 0, 0, 0, undef, 0, 'context3', 'BoldComment')) {
      return 1
   }
   return 0;
};

sub parsecontext8 {
   my ($self, $text) = @_;
   # String => 'biffs'
   # attribute => 'Biff'
   # context => '#pop#pop'
   # type => 'keyword'
   if ($self->testKeyword($text, 'biffs', 0, undef, 0, '#pop#pop', 'Biff')) {
      return 1
   }
   # attribute => 'Biff'
   # char => ' '
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ' ', 0, 0, 0, undef, 0, '#pop#pop', 'Biff')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::ILERPG - a Plugin for ILERPG syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::ILERPG;
 my $sh = new Syntax::Highlight::Engine::Kate::ILERPG([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::ILERPG is a  plugin module that provides syntax highlighting
for ILERPG to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author