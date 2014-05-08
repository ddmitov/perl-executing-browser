# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'd.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.36
#kate version 2.2
#kate author Simon J Mackenzie (project.katedxml@smackoz.fastmail.fm)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::D;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Assert' => 'Variable',
      'Binary' => 'BaseN',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Debug' => 'BaseN',
      'Escape String' => 'String',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Integer' => 'DecVal',
      'Keyword' => 'Keyword',
      'Linkage' => 'IString',
      'Linkage Type' => 'Others',
      'Module' => 'Keyword',
      'Module Name' => 'Reserved',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Phobos Library' => 'BString',
      'Pragma' => 'Keyword',
      'String' => 'String',
      'Type' => 'DataType',
      'Unit Test' => 'RegionMarker',
      'Version' => 'Keyword',
      'Version Type' => 'DataType',
      'Wysiwyg' => 'Char',
   });
   $self->listAdd('assert',
      'assert',
   );
   $self->listAdd('debug',
      'debug',
   );
   $self->listAdd('keywords',
      'abstract',
      'alias',
      'align',
      'asm',
      'auto',
      'body',
      'break',
      'case',
      'cast',
      'catch',
      'class',
      'const',
      'continue',
      'default',
      'delegate',
      'delete',
      'deprecated',
      'do',
      'else',
      'enum',
      'export',
      'false',
      'final',
      'finally',
      'for',
      'foreach',
      'function',
      'goto',
      'if',
      'in',
      'inout',
      'interface',
      'invariant',
      'is',
      'mixin',
      'new',
      'null',
      'out',
      'override',
      'package',
      'private',
      'protected',
      'public',
      'return',
      'static',
      'struct',
      'super',
      'switch',
      'synchronized',
      'template',
      'this',
      'throw',
      'true',
      'try',
      'typedef',
      'typeof',
      'union',
      'volatile',
      'while',
      'with',
   );
   $self->listAdd('linkage',
      'extern',
   );
   $self->listAdd('ltypes',
      'C',
      'D',
      'Pascal',
      'Windows',
   );
   $self->listAdd('modules',
      'import',
      'module',
   );
   $self->listAdd('phobos',
      'printf',
      'writef',
   );
   $self->listAdd('pragma',
      'pragma',
   );
   $self->listAdd('ptypes',
      'msg',
   );
   $self->listAdd('types',
      'bit',
      'byte',
      'cdouble',
      'cent',
      'cfloat',
      'char',
      'creal',
      'dchar',
      'double',
      'float',
      'idouble',
      'ifloat',
      'int',
      'ireal',
      'long',
      'real',
      'short',
      'ubyte',
      'ucent',
      'uint',
      'ulong',
      'ushort',
      'void',
      'wchar',
   );
   $self->listAdd('unittest',
      'unittest',
   );
   $self->listAdd('version',
      'version',
   );
   $self->listAdd('vtypes',
      'AMD64',
      'BigEndian',
      'D_InlineAsm',
      'DigitalMars',
      'LittleEndian',
      'Win32',
      'Win64',
      'Windows',
      'X86',
      'linux',
      'none',
   );
   $self->contextdata({
      'Char' => {
         callback => \&parseChar,
         attribute => 'Char',
      },
      'CommentBlockA' => {
         callback => \&parseCommentBlockA,
         attribute => 'Comment',
      },
      'CommentBlockB' => {
         callback => \&parseCommentBlockB,
         attribute => 'Comment',
      },
      'CommentLine' => {
         callback => \&parseCommentLine,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Hex' => {
         callback => \&parseHex,
         attribute => 'Hex',
      },
      'Linkage' => {
         callback => \&parseLinkage,
         attribute => 'Linkage',
         lineending => '#pop',
      },
      'ModuleName' => {
         callback => \&parseModuleName,
         attribute => 'Module Name',
      },
      'Pragmas' => {
         callback => \&parsePragmas,
         attribute => 'Pragma',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
      'Version' => {
         callback => \&parseVersion,
         attribute => 'Version',
         lineending => '#pop',
      },
      'Wysiwyg' => {
         callback => \&parseWysiwyg,
         attribute => 'Wysiwyg',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal Text',
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
   return 'D';
}

sub parseChar {
   my ($self, $text) = @_;
   # attribute => 'Char'
   # char => '\'
   # char1 => '''
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\'', 0, 0, 0, undef, 0, '#stay', 'Char')) {
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
   # attribute => 'Char'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Char')) {
      return 1
   }
   return 0;
};

sub parseCommentBlockA {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'CommentA'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseCommentBlockB {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '+'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'CommentB'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '+', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseCommentLine {
   my ($self, $text) = @_;
   return 0;
};

sub parseHex {
   my ($self, $text) = @_;
   # attribute => 'Hex'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Hex')) {
      return 1
   }
   return 0;
};

sub parseLinkage {
   my ($self, $text) = @_;
   # String => 'types'
   # attribute => 'Type'
   # context => '#pop'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#pop', 'Type')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '('
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => 'ltypes'
   # attribute => 'Linkage Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'ltypes', 0, undef, 0, '#stay', 'Linkage Type')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ';'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseModuleName {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => ','
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ',', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ';'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'CommentLine'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'CommentLine', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'CommentA'
   # char => '/'
   # char1 => '*'
   # context => 'CommentBlockA'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'CommentBlockA', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'CommentB'
   # char => '/'
   # char1 => '+'
   # context => 'CommentBlockB'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '+', 0, 0, 0, undef, 0, 'CommentBlockB', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsePragmas {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '('
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => 'ptypes'
   # attribute => 'Version Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'ptypes', 0, undef, 0, '#stay', 'Version Type')) {
      return 1
   }
   # String => 'vtypes'
   # attribute => 'Version Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'vtypes', 0, undef, 0, '#stay', 'Version Type')) {
      return 1
   }
   # String => '[_a-z][\w]*'
   # attribute => 'Keyword'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[_a-z][\\w]*', 1, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ','
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ',', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseString {
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

sub parseVersion {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '='
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '('
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => 'vtypes'
   # attribute => 'Version Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'vtypes', 0, undef, 0, '#stay', 'Version Type')) {
      return 1
   }
   # String => '\w'
   # attribute => 'Normal Text'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\w', 1, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseWysiwyg {
   my ($self, $text) = @_;
   # attribute => 'Wysiwyg'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Wysiwyg')) {
      return 1
   }
   # attribute => 'Wysiwyg'
   # char => '`'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, '#pop', 'Wysiwyg')) {
      return 1
   }
   return 0;
};

sub parsenormal {
   my ($self, $text) = @_;
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'modules'
   # attribute => 'Module'
   # context => 'ModuleName'
   # type => 'keyword'
   if ($self->testKeyword($text, 'modules', 0, undef, 0, 'ModuleName', 'Module')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Type')) {
      return 1
   }
   # String => 'phobos'
   # attribute => 'Phobos Library'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'phobos', 0, undef, 0, '#stay', 'Phobos Library')) {
      return 1
   }
   # String => 'linkage'
   # attribute => 'Linkage'
   # context => 'Linkage'
   # type => 'keyword'
   if ($self->testKeyword($text, 'linkage', 0, undef, 0, 'Linkage', 'Linkage')) {
      return 1
   }
   # String => 'debug'
   # attribute => 'Debug'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'debug', 0, undef, 0, '#stay', 'Debug')) {
      return 1
   }
   # String => 'assert'
   # attribute => 'Assert'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'assert', 0, undef, 0, '#stay', 'Assert')) {
      return 1
   }
   # String => 'pragma'
   # attribute => 'Pragma'
   # context => 'Pragmas'
   # type => 'keyword'
   if ($self->testKeyword($text, 'pragma', 0, undef, 0, 'Pragmas', 'Pragma')) {
      return 1
   }
   # String => 'version'
   # attribute => 'Version'
   # context => 'Version'
   # type => 'keyword'
   if ($self->testKeyword($text, 'version', 0, undef, 0, 'Version', 'Version')) {
      return 1
   }
   # String => 'unittest'
   # attribute => 'Unit Test'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'unittest', 0, undef, 0, '#stay', 'Unit Test')) {
      return 1
   }
   # attribute => 'Wysiwyg'
   # char => 'r'
   # char1 => '"'
   # context => 'Wysiwyg'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'r', '"', 0, 0, 0, undef, 0, 'Wysiwyg', 'Wysiwyg')) {
      return 1
   }
   # attribute => 'Hex'
   # char => 'x'
   # char1 => '"'
   # context => 'Hex'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, 'x', '"', 0, 0, 0, undef, 0, 'Hex', 'Hex')) {
      return 1
   }
   # String => '[_a-z][\w]*'
   # attribute => 'Normal Text'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[_a-z][\\w]*', 1, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # String => '\#[ ]*line'
   # attribute => 'Pragma'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\#[ ]*line', 0, 0, 0, undef, 0, '#pop', 'Pragma')) {
      return 1
   }
   # String => '\\[n|t|"]'
   # attribute => 'Escape String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\[n|t|"]', 0, 0, 0, undef, 0, '#pop', 'Escape String')) {
      return 1
   }
   # String => '(\\r\\n)'
   # attribute => 'Escape String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\\\r\\\\n)', 0, 0, 0, undef, 0, '#pop', 'Escape String')) {
      return 1
   }
   # String => '\\0[0-7]+'
   # attribute => 'Escape String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\0[0-7]+', 0, 0, 0, undef, 0, '#pop', 'Escape String')) {
      return 1
   }
   # String => '\\u[\d]+'
   # attribute => 'Escape String'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\u[\\d]+', 1, 0, 0, undef, 0, '#pop', 'Escape String')) {
      return 1
   }
   # String => '\\x[\da-fA-F]+'
   # attribute => 'Escape String'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\x[\\da-fA-F]+', 0, 0, 0, undef, 0, '#pop', 'Escape String')) {
      return 1
   }
   # String => '0b[01]+[_01]*[ ]*\.\.[ ]*0b[01]+[_01]*(UL|LU|U|L)?'
   # attribute => 'Binary'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0b[01]+[_01]*[ ]*\\.\\.[ ]*0b[01]+[_01]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Binary')) {
      return 1
   }
   # String => '0[0-7]+[_0-7]*[ ]*\.\.[ ]*0[0-7]+[_0-7]*(UL|LU|U|L)?'
   # attribute => 'Octal'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0[0-7]+[_0-7]*[ ]*\\.\\.[ ]*0[0-7]+[_0-7]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Octal')) {
      return 1
   }
   # String => '0x[\da-f]+[_\da-f]*[ ]*\.\.[ ]*0x[\da-f]+[_\da-f]*(UL|LU|U|L)?'
   # attribute => 'Hex'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0x[\\da-f]+[_\\da-f]*[ ]*\\.\\.[ ]*0x[\\da-f]+[_\\da-f]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Hex')) {
      return 1
   }
   # String => '[\d]+[_\d]*(UL|LU|U|L)?[ ]*\.\.[ ]*[\d]+[_\d]*(UL|LU|U|L)?'
   # attribute => 'Integer'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\d]+[_\\d]*(UL|LU|U|L)?[ ]*\\.\\.[ ]*[\\d]+[_\\d]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Integer')) {
      return 1
   }
   # String => '[\d]*[_\d]*\.[_\d]*(e-|e|e\+)?[\d]+[_\d]*(F|L|I|FI|LI|)?'
   # attribute => 'Float'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\d]*[_\\d]*\\.[_\\d]*(e-|e|e\\+)?[\\d]+[_\\d]*(F|L|I|FI|LI|)?', 1, 0, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   # String => '[\d]*[_\d]*\.?[_\d]*(e-|e|e\+)[\d]+[_\d]*(F|L|I|FI|LI|)?'
   # attribute => 'Float'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\d]*[_\\d]*\\.?[_\\d]*(e-|e|e\\+)[\\d]+[_\\d]*(F|L|I|FI|LI|)?', 1, 0, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   # String => '0x[\da-f]+[_\da-f]*\.[_\da-f]*(p-|p|p\+)?[\da-f]+[_\da-f]*(F|L|I|FI|LI)?'
   # attribute => 'Float'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0x[\\da-f]+[_\\da-f]*\\.[_\\da-f]*(p-|p|p\\+)?[\\da-f]+[_\\da-f]*(F|L|I|FI|LI)?', 1, 0, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   # String => '0x[\da-f]+[_\da-f]*\.?[_\da-f]*(p-|p|p\+)[\da-f]+[_\da-f]*(F|L|I|FI|LI)?'
   # attribute => 'Float'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0x[\\da-f]+[_\\da-f]*\\.?[_\\da-f]*(p-|p|p\\+)[\\da-f]+[_\\da-f]*(F|L|I|FI|LI)?', 1, 0, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   # String => '0B[01]+[_01]*(UL|LU|U|L)?'
   # attribute => 'Binary'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0B[01]+[_01]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Binary')) {
      return 1
   }
   # String => '0[0-7]+[_0-7]*(UL|LU|U|L)?'
   # attribute => 'Octal'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0[0-7]+[_0-7]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Octal')) {
      return 1
   }
   # String => '0x[\da-f]+[_\da-f]*(UL|LU|U|L)?'
   # attribute => 'Hex'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '0x[\\da-f]+[_\\da-f]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Hex')) {
      return 1
   }
   # String => '[\d]+[_\d]*(UL|LU|U|L)?'
   # attribute => 'Integer'
   # context => '#pop'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\d]+[_\\d]*(UL|LU|U|L)?', 1, 0, 0, undef, 0, '#pop', 'Integer')) {
      return 1
   }
   # attribute => 'Char'
   # char => '''
   # context => 'Char'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Char', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'Wysiwyg'
   # char => '`'
   # context => 'Wysiwyg'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, 'Wysiwyg', 'Wysiwyg')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'CommentLine'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'CommentLine', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'CommentA'
   # char => '/'
   # char1 => '*'
   # context => 'CommentBlockA'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'CommentBlockA', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'CommentB'
   # char => '/'
   # char1 => '+'
   # context => 'CommentBlockB'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '+', 0, 0, 0, undef, 0, 'CommentBlockB', 'Comment')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'BraceA'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'BraceA'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::D - a Plugin for D syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::D;
 my $sh = new Syntax::Highlight::Engine::Kate::D([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::D is a  plugin module that provides syntax highlighting
for D to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author