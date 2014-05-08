# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'fgl-4gl.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.3
#kate author Andrej Falout (andrej@falout.org)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::FourGL;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Alert' => 'Alert',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Prep. Lib' => 'Others',
      'Preprocessor' => 'Others',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('keywords',
      'ABSOLUTE',
      'ACCEPT',
      'ALL',
      'ANY',
      'BEGIN',
      'BOLD',
      'CONSTRAINT',
      'CURRENT',
      'DEFER',
      'DIRTY',
      'DISTINCT',
      'DROP',
      'ESC',
      'ESCAPE',
      'EXTERNAL',
      'FREE',
      'GROUP',
      'HAVING',
      'HIDE',
      'HOLD',
      'HOUR',
      'INTERRUPT',
      'INT_FLAG',
      'ISOLATION',
      'LOCK',
      'MAGENTA',
      'MINUTE',
      'MODE',
      'MODIFY',
      'NEED',
      'NOTFOUND',
      'PAGENO',
      'PIPE',
      'READ',
      'ROLLBACK',
      'SCREEN',
      'SECOND',
      'STEP',
      'STOP',
      'TABLE',
      'TEMP',
      'UNIQUE',
      'UNITS',
      'UNLOAD',
      'WAIT',
      'WHILE',
      'WORK',
      'WRAP',
      'add',
      'after',
      'alter',
      'and',
      'ascii',
      'at',
      'attribute',
      'attributes',
      'avg',
      'before',
      'between',
      'blink',
      'blue',
      'border',
      'bottom',
      'by',
      'call',
      'case',
      'clear',
      'clipped',
      'close',
      'cluster',
      'column',
      'columns',
      'command',
      'comment',
      'commit',
      'committed',
      'connect',
      'construct',
      'continue',
      'count',
      'create',
      'cursor',
      'cyan',
      'database',
      'day',
      'declare',
      'defaults',
      'define',
      'delete',
      'delimiter',
      'desc',
      'display',
      'downshift',
      'else',
      'enable',
      'end',
      'error',
      'every',
      'exclusive',
      'execute',
      'exists',
      'exit',
      'false',
      'fetch',
      'fgl_lastkey',
      'fgl_lastkey()',
      'field',
      'file',
      'finish',
      'first',
      'flush',
      'for',
      'foreach',
      'form',
      'format',
      'formhandler',
      'from',
      'function',
      'globals',
      'go',
      'goto',
      'green',
      'header',
      'help',
      'if',
      'in',
      'index',
      'infield',
      'initialize',
      'input',
      'insert',
      'into',
      'is',
      'key',
      'label',
      'last',
      'left',
      'length',
      'let',
      'like',
      'line',
      'lines',
      'load',
      'locate',
      'log',
      'main',
      'margin',
      'matches',
      'max',
      'mdy',
      'menu',
      'message',
      'min',
      'month',
      'name',
      'next',
      'no',
      'normal',
      'not',
      'null',
      'of',
      'on',
      'open',
      'option',
      'options',
      'or',
      'order',
      'otherwise',
      'outer',
      'output',
      'page',
      'pause',
      'prepare',
      'previous',
      'print',
      'printer',
      'program',
      'prompt',
      'put',
      'quit',
      'quit_flag',
      'record',
      'red',
      'report',
      'return',
      'returning',
      'reverse',
      'revoke',
      'right',
      'row',
      'rows',
      'run',
      'scroll',
      'select',
      'set',
      'share',
      'show',
      'skip',
      'sleep',
      'sort',
      'space',
      'spaces',
      'start',
      'statistics',
      'status',
      'sum',
      'text',
      'then',
      'thru',
      'to',
      'today',
      'top',
      'trailer',
      'true',
      'union',
      'up',
      'update',
      'upshift',
      'user',
      'using',
      'values',
      'waiting',
      'when',
      'whenever',
      'where',
      'white',
      'window',
      'with',
      'without',
      'wordwrap',
      'year',
      'yellow',
   );
   $self->listAdd('types',
      'DATETIME',
      'DECIMAL',
      'FRACTION',
      'INTERVAL',
      'NUMERIC',
      'VARCHAR',
      'array',
      'char',
      'date',
      'float',
      'integer',
      'money',
      'serial',
      'smallint',
   );
   $self->contextdata({
      'noname' => {
         callback => \&parsenoname,
         attribute => 'Comment',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('noname');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return '4GL';
}

sub parsenoname {
   my ($self, $text) = @_;
   # String => '#if'
   # attribute => 'Comment'
   # context => '9'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#if', 0, 0, 0, undef, 0, '9', 'Comment')) {
      return 1
   }
   # String => '#endif'
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#endif', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::FourGL - a Plugin for 4GL syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::FourGL;
 my $sh = new Syntax::Highlight::Engine::Kate::FourGL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::FourGL is a  plugin module that provides syntax highlighting
for 4GL to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author