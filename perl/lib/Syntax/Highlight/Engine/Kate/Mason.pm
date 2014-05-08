# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'mason.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.04
#kate version 2.1
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Mason;

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
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'HTML' => 'String',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Mason Method' => 'Keyword',
      'Mason Tag' => 'Keyword',
      'Octal' => 'BaseN',
      'Pattern' => 'Others',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
      'normal' => 'Normal',
   });
   $self->listAdd('keywords',
      '!',
      'and',
      'bless',
      'caller',
      'chomp',
      'chop',
      'close',
      'cmp',
      'continue',
      'dbmclose',
      'dbmopen',
      'die',
      'do',
      'dump',
      'each',
      'echo',
      'else',
      'elsif',
      'eq',
      'eval',
      'for',
      'foreach',
      'ge',
      'goto',
      'gt',
      'if',
      'import',
      'last',
      'le',
      'local',
      'lt',
      'my',
      'ne',
      'new',
      'next',
      'no',
      'not',
      'open',
      'or',
      'pop',
      'print',
      'push',
      'redo',
      'ref',
      'require',
      'return',
      'split',
      'sub',
      'switch',
      'tie',
      'tied',
      'undef',
      'unless',
      'unlink',
      'untie',
      'use',
      'wantarray',
      'while',
      'xor',
      '||',
   );
   $self->contextdata({
      'Commentar 1' => {
         callback => \&parseCommentar1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Commentar 2' => {
         callback => \&parseCommentar2,
         attribute => 'Comment',
      },
      'Documentation' => {
         callback => \&parseDocumentation,
         attribute => 'Comment',
      },
      'EmbeddedPerl' => {
         callback => \&parseEmbeddedPerl,
         attribute => 'normal',
      },
      'HTML' => {
         callback => \&parseHTML,
         attribute => 'HTML',
      },
      'MethodCall' => {
         callback => \&parseMethodCall,
         attribute => 'Mason Method',
      },
      'Pattern' => {
         callback => \&parsePattern,
         attribute => 'Pattern',
      },
      'Pattern2' => {
         callback => \&parsePattern2,
         attribute => 'Pattern',
      },
      'Pattern3' => {
         callback => \&parsePattern3,
         attribute => 'Pattern',
      },
      'PerlOneLiner' => {
         callback => \&parsePerlOneLiner,
         attribute => 'String',
         lineending => '#pop',
      },
      'Something' => {
         callback => \&parseSomething,
         attribute => 'String Char',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
      'String2' => {
         callback => \&parseString2,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('HTML');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Mason';
}

sub parseCommentar1 {
   my ($self, $text) = @_;
   return 0;
};

sub parseCommentar2 {
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

sub parseDocumentation {
   my ($self, $text) = @_;
   # String => '</%doc>'
   # attribute => 'Comment'
   # context => '#pop'
   # insensitive => 'FALSE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '</%doc>', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseEmbeddedPerl {
   my ($self, $text) = @_;
   # attribute => 'Mason Tag'
   # char => '%'
   # char1 => '>'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '>', 0, 0, 0, undef, 0, '#pop', 'Mason Tag')) {
      return 1
   }
   # String => '</%perl>'
   # attribute => 'Mason Tag'
   # context => '#pop'
   # insensitive => 'FALSE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '</%perl>', 0, 0, 0, undef, 0, '#pop', 'Mason Tag')) {
      return 1
   }
   # String => '</%method>'
   # attribute => 'Mason Tag'
   # context => '#pop'
   # insensitive => 'FALSE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '</%method>', 0, 0, 0, undef, 0, '#pop', 'Mason Tag')) {
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
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '^#!.*'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^#!.*', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'String2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String2', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # char => '`'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, 'String', 'String Char')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # attribute => 'Pattern'
   # char => 's'
   # char1 => '/'
   # context => 'Pattern2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 's', '/', 0, 0, 0, undef, 0, 'Pattern2', 'Pattern')) {
      return 1
   }
   # attribute => 'Pattern'
   # char => '/'
   # context => 'Pattern'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '/', 0, 0, 0, undef, 0, 'Pattern', 'Pattern')) {
      return 1
   }
   # String => '!%&()+,-<=>?[]^{|}~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!%&()+,-<=>?[]^{|}~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '\$[0-9]+'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => '\$\#?[a-zA-Z_]+[a-zA-Z0-9_]*'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$\\#?[a-zA-Z_]+[a-zA-Z0-9_]*', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\s+\:'
   # attribute => 'Pattern'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+\\:', 0, 0, 0, undef, 0, '#stay', 'Pattern')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '#'
   # context => 'Commentar 1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseHTML {
   my ($self, $text) = @_;
   # String => '<\%method[^>]*>'
   # attribute => 'Mason Tag'
   # context => 'EmbeddedPerl'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\%method[^>]*>', 0, 0, 0, undef, 0, 'EmbeddedPerl', 'Mason Tag')) {
      return 1
   }
   # String => '<%method>'
   # attribute => 'Mason Tag'
   # context => 'EmbeddedPerl'
   # insensitive => 'FALSE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%method>', 0, 0, 0, undef, 0, 'EmbeddedPerl', 'Mason Tag')) {
      return 1
   }
   # String => '<%doc>'
   # attribute => 'Comment'
   # context => 'Documentation'
   # insensitive => 'FALSE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%doc>', 0, 0, 0, undef, 0, 'Documentation', 'Comment')) {
      return 1
   }
   # String => '<%perl>'
   # attribute => 'Mason Tag'
   # context => 'EmbeddedPerl'
   # insensitive => 'FALSE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%perl>', 0, 0, 0, undef, 0, 'EmbeddedPerl', 'Mason Tag')) {
      return 1
   }
   # attribute => 'Mason Tag'
   # char => '<'
   # char1 => '%'
   # context => 'EmbeddedPerl'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '%', 0, 0, 0, undef, 0, 'EmbeddedPerl', 'Mason Tag')) {
      return 1
   }
   # attribute => 'Mason Method'
   # char => '<'
   # char1 => '&'
   # context => 'MethodCall'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '&', 0, 0, 0, undef, 0, 'MethodCall', 'Mason Method')) {
      return 1
   }
   # String => '^%'
   # attribute => 'Mason Tag'
   # context => 'PerlOneLiner'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^%', 0, 0, 0, undef, 0, 'PerlOneLiner', 'Mason Tag')) {
      return 1
   }
   return 0;
};

sub parseMethodCall {
   my ($self, $text) = @_;
   # attribute => 'Mason Method'
   # char => '&'
   # char1 => '>'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '&', '>', 0, 0, 0, undef, 0, '#pop', 'Mason Method')) {
      return 1
   }
   return 0;
};

sub parsePattern {
   my ($self, $text) = @_;
   # String => '\\[\/\[\]dDwWsSnrtfb0\$@]?'
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[\\/\\[\\]dDwWsSnrtfb0\\$@]?', 0, 0, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # String => '\^[\/\[\]]?'
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\^[\\/\\[\\]]?', 0, 0, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # attribute => 'Pattern'
   # char => '/'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '/', 0, 0, 0, undef, 0, '#pop', 'Pattern')) {
      return 1
   }
   return 0;
};

sub parsePattern2 {
   my ($self, $text) = @_;
   # String => '\\[\/\[\]dDwWsSnrtfb0\$@]?'
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[\\/\\[\\]dDwWsSnrtfb0\\$@]?', 0, 0, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # String => '\^[\/\[\]]?'
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\^[\\/\\[\\]]?', 0, 0, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # String => '\/'
   # attribute => 'Pattern'
   # context => 'Pattern3'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/', 0, 0, 0, undef, 0, 'Pattern3', 'Pattern')) {
      return 1
   }
   return 0;
};

sub parsePattern3 {
   my ($self, $text) = @_;
   # String => '\\[\/\[\]dDwWsSnrtfb0\$@]?'
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[\\/\\[\\]dDwWsSnrtfb0\\$@]?', 0, 0, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # String => '\^[\/\[\]]?'
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\^[\\/\\[\\]]?', 0, 0, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # String => '\/g?'
   # attribute => 'Pattern'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/g?', 0, 0, 0, undef, 0, '#pop#pop', 'Pattern')) {
      return 1
   }
   return 0;
};

sub parsePerlOneLiner {
   my ($self, $text) = @_;
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
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '^#!.*'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^#!.*', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '"[^"]*"'
   # attribute => 'String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[^"]*"', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => ''[^']*''
   # attribute => 'String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'[^\']*\'', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # char => '`'
   # context => 'Something'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, 'Something', 'String Char')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # attribute => 'Pattern'
   # char => 's'
   # char1 => '/'
   # context => 'Pattern2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 's', '/', 0, 0, 0, undef, 0, 'Pattern2', 'Pattern')) {
      return 1
   }
   # String => '!%&()+,-<=>?[]^{|}~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!%&()+,-<=>?[]^{|}~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '\$[0-9]+'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => '\$\#?[a-zA-Z_]+[a-zA-Z0-9_]*'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$\\#?[a-zA-Z_]+[a-zA-Z0-9_]*', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '\s+\:'
   # attribute => 'Pattern'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+\\:', 0, 0, 0, undef, 0, '#stay', 'Pattern')) {
      return 1
   }
   # String => '\#.*'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\#.*', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseSomething {
   my ($self, $text) = @_;
   # attribute => 'String Char'
   # char => '`'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, '#pop', 'String Char')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
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
   # String => '\$[0-9]+'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => '\$[a-zA-Z_]*[a-zA-Z0-9_]*'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[a-zA-Z_]*[a-zA-Z0-9_]*', 0, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parseString2 {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # char => '\'
   # char1 => '''
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\'', 0, 0, 0, undef, 0, '#stay', 'String Char')) {
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


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Mason - a Plugin for Mason syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Mason;
 my $sh = new Syntax::Highlight::Engine::Kate::Mason([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Mason is a  plugin module that provides syntax highlighting
for Mason to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author