# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'python.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.23
#kate version 2.4
#kate author Per Wigren
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Python;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Builtin Function' => 'DataType',
      'Comment' => 'Comment',
      'Complex' => 'Others',
      'Float' => 'Float',
      'Hex' => 'Others',
      'Int' => 'DecVal',
      'Keyword' => 'Keyword',
      'Long' => 'Others',
      'Normal Text' => 'Normal',
      'Octal' => 'Others',
      'Operator' => 'Char',
      'Preprocessor' => 'Char',
      'Raw String' => 'String',
      'Special Variable' => 'Others',
      'String' => 'String',
   });
   $self->listAdd('builtinfuncs',
      'abs',
      'apply',
      'buffer',
      'callable',
      'chr',
      'cmp',
      'coerce',
      'compile',
      'complex',
      'copyright',
      'credits',
      'delattr',
      'dir',
      'divmod',
      'eval',
      'execfile',
      'exit',
      'filter',
      'float',
      'getattr',
      'globals',
      'hasattr',
      'hash',
      'hex',
      'id',
      'input',
      'int',
      'intern',
      'isinstance',
      'issubclass',
      'iter',
      'len',
      'license',
      'list',
      'locals',
      'long',
      'map',
      'max',
      'min',
      'oct',
      'open',
      'ord',
      'pow',
      'quit',
      'range',
      'raw_input',
      'reduce',
      'reload',
      'repr',
      'round',
      'setattr',
      'slice',
      'str',
      'tuple',
      'type',
      'unichr',
      'unicode',
      'vars',
      'xrange',
      'zip',
   );
   $self->listAdd('prep',
      'as',
      'from',
      'import',
   );
   $self->listAdd('specialvars',
      'Ellipsis',
      'False',
      'None',
      'NotImplemented',
      'True',
      'self',
   );
   $self->listAdd('statements',
      'and',
      'assert',
      'break',
      'class',
      'continue',
      'def',
      'del',
      'elif',
      'else',
      'except',
      'exec',
      'finally',
      'for',
      'global',
      'if',
      'in',
      'is',
      'lambda',
      'not',
      'or',
      'pass',
      'print',
      'raise',
      'return',
      'try',
      'while',
      'yield',
   );
   $self->contextdata({
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Raw A-string' => {
         callback => \&parseRawAstring,
         attribute => 'Raw String',
      },
      'Raw Q-string' => {
         callback => \&parseRawQstring,
         attribute => 'Raw String',
      },
      'Single A-comment' => {
         callback => \&parseSingleAcomment,
         attribute => 'Comment',
      },
      'Single A-string' => {
         callback => \&parseSingleAstring,
         attribute => 'String',
      },
      'Single Q-comment' => {
         callback => \&parseSingleQcomment,
         attribute => 'Comment',
      },
      'Single Q-string' => {
         callback => \&parseSingleQstring,
         attribute => 'String',
      },
      'Tripple A-comment' => {
         callback => \&parseTrippleAcomment,
         attribute => 'Comment',
      },
      'Tripple A-string' => {
         callback => \&parseTrippleAstring,
         attribute => 'String',
      },
      'Tripple Q-comment' => {
         callback => \&parseTrippleQcomment,
         attribute => 'Comment',
      },
      'Tripple Q-string' => {
         callback => \&parseTrippleQstring,
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
   return 'Python';
}

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'prep'
   # attribute => 'Preprocessor'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'prep', 0, undef, 0, '#stay', 'Preprocessor')) {
      return 1
   }
   # String => 'statements'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'statements', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'builtinfuncs'
   # attribute => 'Builtin Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'builtinfuncs', 0, undef, 0, '#stay', 'Builtin Function')) {
      return 1
   }
   # String => 'specialvars'
   # attribute => 'Special Variable'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'specialvars', 0, undef, 0, '#stay', 'Special Variable')) {
      return 1
   }
   # String => '[a-zA-Z_]\w+'
   # attribute => 'Normal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z_]\\w+', 0, 0, 0, undef, 0, '#stay', 'Normal')) {
      return 1
   }
   # String => ' (((\d*\.\d+|\d+\.)|(\d+|(\d*\.\d+|\d+\.))[eE][+-]?\d+)|\d+)[jJ]'
   # attribute => 'Complex'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ' (((\\d*\\.\\d+|\\d+\\.)|(\\d+|(\\d*\\.\\d+|\\d+\\.))[eE][+-]?\\d+)|\\d+)[jJ]', 0, 0, 0, undef, 0, '#stay', 'Complex')) {
      return 1
   }
   # String => '(\d+\.\d*|\.\d+)([eE]\d+)?'
   # attribute => 'Float'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\d+\\.\\d*|\\.\\d+)([eE]\\d+)?', 0, 0, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # String => '([1-9]\d*([eE]\d+)?|0)'
   # attribute => 'Int'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([1-9]\\d*([eE]\\d+)?|0)', 0, 0, 0, undef, 0, '#stay', 'Int')) {
      return 1
   }
   # String => '[1-9]\d*([eE][\d.]+)?[Ll]'
   # attribute => 'Long'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[1-9]\\d*([eE][\\d.]+)?[Ll]', 0, 0, 0, undef, 0, '#stay', 'Long')) {
      return 1
   }
   # String => '0[Xx][\da-fA-F]+'
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0[Xx][\\da-fA-F]+', 0, 0, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # String => '0[1-9]\d*'
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0[1-9]\\d*', 0, 0, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # String => '[rR]''
   # attribute => 'Raw String'
   # context => 'Raw A-string'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[rR]\'', 0, 0, 0, undef, 0, 'Raw A-string', 'Raw String')) {
      return 1
   }
   # String => '[rR]"'
   # attribute => 'Raw String'
   # context => 'Raw Q-string'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[rR]"', 0, 0, 0, undef, 0, 'Raw Q-string', 'Raw String')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '''''
   # attribute => 'Comment'
   # context => 'Tripple A-comment'
   # firstNonSpace => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\'\'\'', 0, 0, 0, undef, 1, 'Tripple A-comment', 'Comment')) {
      return 1
   }
   # String => '"""'
   # attribute => 'Comment'
   # context => 'Tripple Q-comment'
   # firstNonSpace => 'true'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '"""', 0, 0, 0, undef, 1, 'Tripple Q-comment', 'Comment')) {
      return 1
   }
   # String => '''''
   # attribute => 'String'
   # context => 'Tripple A-string'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\'\'\'', 0, 0, 0, undef, 0, 'Tripple A-string', 'String')) {
      return 1
   }
   # String => '"""'
   # attribute => 'String'
   # context => 'Tripple Q-string'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '"""', 0, 0, 0, undef, 0, 'Tripple Q-string', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'Single A-string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Single A-string', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'Single Q-string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Single Q-string', 'String')) {
      return 1
   }
   # String => '[+*/\(\)%\|\[\]\{\}:=;\!<>!^&~-]'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[+*/\\(\\)%\\|\\[\\]\\{\\}:=;\\!<>!^&~-]', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   return 0;
};

sub parseRawAstring {
   my ($self, $text) = @_;
   # attribute => 'Raw String'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'Raw String')) {
      return 1
   }
   # attribute => 'Raw String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Raw String')) {
      return 1
   }
   return 0;
};

sub parseRawQstring {
   my ($self, $text) = @_;
   # attribute => 'Raw String'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'Raw String')) {
      return 1
   }
   # attribute => 'Raw String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Raw String')) {
      return 1
   }
   return 0;
};

sub parseSingleAcomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseSingleAstring {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '%[a-zA-Z]'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%[a-zA-Z]', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};

sub parseSingleQcomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseSingleQstring {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '%[a-zA-Z]'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%[a-zA-Z]', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
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

sub parseTrippleAcomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '''''
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\'\'\'', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseTrippleAstring {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '%[a-zA-Z]'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%[a-zA-Z]', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '''''
   # attribute => 'String'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\'\'\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};

sub parseTrippleQcomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '"""'
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '"""', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseTrippleQstring {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '%[a-zA-Z]'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%[a-zA-Z]', 0, 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => '"""'
   # attribute => 'String'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '"""', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Python - a Plugin for Python syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Python;
 my $sh = new Syntax::Highlight::Engine::Kate::Python([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Python is a  plugin module that provides syntax highlighting
for Python to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author