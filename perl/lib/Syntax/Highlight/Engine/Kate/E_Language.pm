# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'e.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.21
#kate version 2.3
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::E_Language;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Action' => 'Reserved',
      'Bit' => 'DecVal',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Function' => 'Function',
      'Integer' => 'DecVal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operators' => 'Normal',
      'OutSide E code' => 'Comment',
      'Statement' => 'Others',
      'Vector' => 'String',
   });
   $self->listAdd('Action',
      'C',
      'add',
      'also',
      'and',
      'as',
      'as_a',
      'break',
      'code',
      'compute',
      'computed',
      'delayed',
      'do',
      'each',
      'else',
      'emit',
      'empty',
      'end',
      'exit',
      'finish',
      'for',
      'from',
      'if',
      'in',
      'is',
      'like',
      'log',
      'new',
      'no',
      'not',
      'only',
      'or',
      'out',
      'read',
      'repeat',
      'return',
      'reverse',
      'routine',
      'step',
      'then',
      'to',
      'traceable',
      'untraceable',
      'var',
      'when',
      'while',
      'with',
      'write',
      'xor',
   );
   $self->listAdd('Cover',
      'address',
      'cover',
      'error',
      'event',
      'events',
      'illegal',
      'item',
      'kind',
      'length',
      'range',
      'ranges',
      'sample',
      'text',
      'transition',
      'value',
   );
   $self->listAdd('Function',
      'append',
      'clear',
      'crc_32',
      'deep_compare',
      'deep_compare_physical',
      'delete',
      'dut_error',
      'hex',
      'init',
      'is_empty',
      'pack',
      'pop0',
      'post_generate',
      'pre_generate',
      'pre_generate',
      'run',
      'set_config',
      'setup',
      'size',
      'stop_run',
      'unpack',
   );
   $self->listAdd('Generation',
      'before',
      'by',
      'choose',
      'gen',
      'keep',
      'keeping',
      'matches',
      'next',
      'select',
      'sequence',
      'soft',
      'using',
   );
   $self->listAdd('Simulator',
      'all',
      'always',
      'basic',
      'call',
      'change',
      'check',
      'clock',
      'cycle',
      'cycles',
      'expect',
      'fall',
      'first',
      'forever',
      'idle',
      'initial',
      'negedge',
      'on',
      'others',
      'posedge',
      'rise',
      'start',
      'task',
      'that',
      'time',
      'until',
      'verilog',
      'vhdl',
      'wait',
      'within',
   );
   $self->listAdd('Statement',
      'DOECHO',
      'ECHO',
      'chars',
      'define',
      'event',
      'extend',
      'import',
      'initialize',
      'non_terminal',
      'script',
      'struct',
      'testgroup',
      'type',
      'unit',
   );
   $self->listAdd('Type',
      'FALSE',
      'MAX_INT',
      'MIN_INT',
      'NULL',
      'TRUE',
      'UNDEF',
      'bit',
      'bits',
      'body',
      'bool',
      'byte',
      'byte_array',
      'continue',
      'copy',
      'default',
      'external_pointer',
      'file',
      'files',
      'form',
      'global',
      'index',
      'init',
      'int',
      'it',
      'list',
      'load',
      'long',
      'me',
      'method',
      'module',
      'ntv',
      'of',
      'pat',
      'print',
      'result',
      'source_ref',
      'string',
      'symtab',
      'sys',
      'test',
      'uint',
      'untyped',
      'vec',
   );
   $self->contextdata({
      'comment' => {
         callback => \&parsecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal Text',
      },
      'out_comment' => {
         callback => \&parseout_comment,
         attribute => 'OutSide E code',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'Vector',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('out_comment');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'E Language';
}

sub parsecomment {
   my ($self, $text) = @_;
   return 0;
};

sub parsenormal {
   my ($self, $text) = @_;
   # attribute => 'Operators'
   # beginRegion => 'Region1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Operators')) {
      return 1
   }
   # attribute => 'Operators'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Region1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Operators')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'OutSide E code'
   # char => '''
   # char1 => '>'
   # context => 'out_comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\'', '>', 0, 0, 0, undef, 0, 'out_comment', 'OutSide E code')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # attribute => 'Vector'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'Vector')) {
      return 1
   }
   # String => ''[&><=:+\-*\|].,;'
   # attribute => 'Operators'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '\'[&><=:+\\-*\\|].,;', 0, 0, undef, 0, '#stay', 'Operators')) {
      return 1
   }
   # String => 'Type'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Type', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => 'Function'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Function', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => 'Statement'
   # attribute => 'Statement'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Statement', 0, undef, 0, '#stay', 'Statement')) {
      return 1
   }
   # String => 'Action'
   # attribute => 'Action'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Action', 0, undef, 0, '#stay', 'Action')) {
      return 1
   }
   # String => 'Generation'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Generation', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'Cover'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Cover', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'Simulator'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Simulator', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseout_comment {
   my ($self, $text) = @_;
   # attribute => 'OutSide E code'
   # char => '<'
   # char1 => '''
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '<', '\'', 0, 0, 0, undef, 0, '#pop', 'OutSide E code')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # attribute => 'Vector'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Vector')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::E_Language - a Plugin for E Language syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::E_Language;
 my $sh = new Syntax::Highlight::Engine::Kate::E_Language([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::E_Language is a  plugin module that provides syntax highlighting
for E Language to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author