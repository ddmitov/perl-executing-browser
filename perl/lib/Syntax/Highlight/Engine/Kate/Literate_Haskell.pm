# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'literate-haskell.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.4
#kate author Marcel Martin (mmar@freenet.de)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Literate_Haskell;

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
      'Class' => 'Keyword',
      'Comment' => 'Comment',
      'Constructor' => 'Others',
      'Data Constructor' => 'Keyword',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Function' => 'Function',
      'Function Definition' => 'Function',
      'Infix Operator' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Special' => 'Char',
      'String' => 'String',
      'Type Constructor' => 'DataType',
   });
   $self->listAdd('classes',
      'Bounded',
      'Enum',
      'Eq',
      'Floating',
      'Fractional',
      'Functor',
      'Integral',
      'Ix',
      'Monad',
      'Num',
      'Ord',
      'Read',
      'Real',
      'RealFloat',
      'RealFrac',
      'Show',
   );
   $self->listAdd('data constructors',
      'EQ',
      'False',
      'GT',
      'Just',
      'LT',
      'Left',
      'Nothing',
      'Right',
      'True',
   );
   $self->listAdd('functions',
      'FilePath',
      'IOError',
      'abs',
      'acos',
      'acosh',
      'all',
      'and',
      'any',
      'appendFile',
      'approxRational',
      'asTypeOf',
      'asin',
      'asinh',
      'atan',
      'atan2',
      'atanh',
      'basicIORun',
      'break',
      'catch',
      'ceiling',
      'chr',
      'compare',
      'concat',
      'concatMap',
      'const',
      'cos',
      'cosh',
      'curry',
      'cycle',
      'decodeFloat',
      'denominator',
      'digitToInt',
      'div',
      'divMod',
      'drop',
      'dropWhile',
      'either',
      'elem',
      'encodeFloat',
      'enumFrom',
      'enumFromThen',
      'enumFromThenTo',
      'enumFromTo',
      'error',
      'even',
      'exp',
      'exponent',
      'fail',
      'filter',
      'flip',
      'floatDigits',
      'floatRadix',
      'floatRange',
      'floor',
      'fmap',
      'foldl',
      'foldl1',
      'foldr',
      'foldr1',
      'fromDouble',
      'fromEnum',
      'fromInt',
      'fromInteger',
      'fromIntegral',
      'fromRational',
      'fst',
      'gcd',
      'getChar',
      'getContents',
      'getLine',
      'head',
      'id',
      'inRange',
      'index',
      'init',
      'intToDigit',
      'interact',
      'ioError',
      'isAlpha',
      'isAlphaNum',
      'isAscii',
      'isControl',
      'isDenormalized',
      'isDigit',
      'isHexDigit',
      'isIEEE',
      'isInfinite',
      'isLower',
      'isNaN',
      'isNegativeZero',
      'isOctDigit',
      'isPrint',
      'isSpace',
      'isUpper',
      'iterate',
      'last',
      'lcm',
      'length',
      'lex',
      'lexDigits',
      'lexLitChar',
      'lines',
      'log',
      'logBase',
      'lookup',
      'map',
      'mapM',
      'mapM_',
      'max',
      'maxBound',
      'maximum',
      'maybe',
      'min',
      'minBound',
      'minimum',
      'mod',
      'negate',
      'not',
      'notElem',
      'null',
      'numerator',
      'odd',
      'or',
      'ord',
      'otherwise',
      'pi',
      'pred',
      'primExitWith',
      'print',
      'product',
      'properFraction',
      'putChar',
      'putStr',
      'putStrLn',
      'quot',
      'quotRem',
      'range',
      'rangeSize',
      'read',
      'readDec',
      'readFile',
      'readFloat',
      'readHex',
      'readIO',
      'readInt',
      'readList',
      'readLitChar',
      'readLn',
      'readOct',
      'readParen',
      'readSigned',
      'reads',
      'readsPrec',
      'realToFrac',
      'recip',
      'rem',
      'repeat',
      'replicate',
      'return',
      'reverse',
      'round',
      'scaleFloat',
      'scanl',
      'scanl1',
      'scanr',
      'scanr1',
      'seq',
      'sequence',
      'sequence_',
      'show',
      'showChar',
      'showInt',
      'showList',
      'showLitChar',
      'showParen',
      'showSigned',
      'showString',
      'shows',
      'showsPrec',
      'significand',
      'signum',
      'sin',
      'sinh',
      'snd',
      'span',
      'splitAt',
      'sqrt',
      'subtract',
      'succ',
      'sum',
      'tail',
      'take',
      'takeWhile',
      'tan',
      'tanh',
      'threadToIOResult',
      'toEnum',
      'toInt',
      'toInteger',
      'toLower',
      'toRational',
      'toUpper',
      'truncate',
      'uncurry',
      'undefined',
      'unlines',
      'until',
      'unwords',
      'unzip',
      'unzip3',
      'userError',
      'words',
      'writeFile',
      'zip',
      'zip3',
      'zipWith',
      'zipWith3',
   );
   $self->listAdd('infix operators',
      'div',
      'elem',
      'mod',
      'notElem',
      'quot',
      'rem',
      'seq',
   );
   $self->listAdd('keywords',
      'case',
      'class',
      'data',
      'deriving',
      'do',
      'else',
      'if',
      'in',
      'infixl',
      'infixr',
      'instance',
      'let',
      'module',
      'of',
      'primitive',
      'then',
      'type',
      'where',
   );
   $self->listAdd('type constructors',
      'Bool',
      'Char',
      'Double',
      'Either',
      'Float',
      'IO',
      'Int',
      'Integer',
      'Maybe',
      'Ordering',
      'Ratio',
      'Rational',
      'ReadS',
      'ShowS',
      'String',
   );
   $self->contextdata({
      'comment_multi_line' => {
         callback => \&parsecomment_multi_line,
         attribute => 'Comment',
      },
      'comment_single_line' => {
         callback => \&parsecomment_single_line,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'function_definition' => {
         callback => \&parsefunction_definition,
         attribute => 'Function Definition',
         lineending => '#pop',
      },
      'infix' => {
         callback => \&parseinfix,
         attribute => 'Infix Operator',
      },
      'literate-normal' => {
         callback => \&parseliteratenormal,
         attribute => 'Comment',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal Text',
         lineending => 'literate-normal',
      },
      'single_char' => {
         callback => \&parsesingle_char,
         attribute => 'Char',
         lineending => '#pop',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('literate-normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Literate Haskell';
}

sub parsecomment_multi_line {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '-'
   # char1 => '}'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '}', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsecomment_single_line {
   my ($self, $text) = @_;
   return 0;
};

sub parsefunction_definition {
   my ($self, $text) = @_;
   # attribute => 'Function Definition'
   # char => ';'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'Function Definition')) {
      return 1
   }
   return 0;
};

sub parseinfix {
   my ($self, $text) = @_;
   # attribute => 'Infix Operator'
   # char => '`'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, '#pop', 'Infix Operator')) {
      return 1
   }
   return 0;
};

sub parseliteratenormal {
   my ($self, $text) = @_;
   # attribute => 'Special'
   # char => '>'
   # column => '0'
   # context => 'normal'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, 0, 0, 'normal', 'Special')) {
      return 1
   }
   return 0;
};

sub parsenormal {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '{'
   # char1 => '-'
   # context => 'comment_multi_line'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '{', '-', 0, 0, 0, undef, 0, 'comment_multi_line', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'comment_single_line'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'comment_single_line', 'Comment')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'classes'
   # attribute => 'Class'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'classes', 0, undef, 0, '#stay', 'Class')) {
      return 1
   }
   # String => 'type constructors'
   # attribute => 'Type Constructor'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'type constructors', 0, undef, 0, '#stay', 'Type Constructor')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => 'data constructors'
   # attribute => 'Data Constructor'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'data constructors', 0, undef, 0, '#stay', 'Data Constructor')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   # attribute => 'Infix Operator'
   # char => '`'
   # context => 'infix'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, 'infix', 'Infix Operator')) {
      return 1
   }
   # String => '\w[']+'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\w[\']+', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Char'
   # char => '''
   # context => 'single_char'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'single_char', 'Char')) {
      return 1
   }
   # String => '\s*[a-z_]+\w*'*\s*::'
   # attribute => 'Function Definition'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*[a-z_]+\\w*\'*\\s*::', 0, 0, 0, undef, 0, '#stay', 'Function Definition')) {
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
   return 0;
};

sub parsesingle_char {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'Char'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Char')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'String')) {
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

Syntax::Highlight::Engine::Kate::Literate_Haskell - a Plugin for Literate Haskell syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Literate_Haskell;
 my $sh = new Syntax::Highlight::Engine::Kate::Literate_Haskell([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Literate_Haskell is a  plugin module that provides syntax highlighting
for Literate Haskell to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author