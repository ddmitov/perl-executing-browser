# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'rexx.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.3
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::REXX;

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
      'Built In' => 'Normal',
      'Comment' => 'Comment',
      'Function' => 'Function',
      'Instructions' => 'Keyword',
      'Normal Text' => 'Normal',
      'String' => 'String',
      'Symbol' => 'Normal',
   });
   $self->listAdd('builtin',
      'abbrev',
      'abs',
      'address',
      'b2x',
      'bitand',
      'bitor',
      'bitxor',
      'c2d',
      'c2x',
      'center',
      'charin',
      'charout',
      'chars',
      'compare',
      'condition',
      'copies',
      'd2c',
      'd2x',
      'datatype',
      'date',
      'delstr',
      'delword',
      'digits',
      'errortext',
      'form',
      'format',
      'fuzz',
      'insert',
      'lastpos',
      'left',
      'linein',
      'lineout',
      'lines',
      'max',
      'min',
      'overlay',
      'pos',
      'queued',
      'random',
      'reverse',
      'right',
      'sign',
      'sourceline',
      'space',
      'stream',
      'strip',
      'substr',
      'subword',
      'symbol',
      'time',
      'trace',
      'translate',
      'trunc',
      'value',
      'verify',
      'word',
      'wordindex',
      'wordlength',
      'wordpos',
      'words',
      'x2b',
      'x2c',
      'x2d',
      'xrange',
   );
   $self->listAdd('instructions',
      'arg',
      'drop',
      'else',
      'end',
      'exit',
      'forever',
      'if',
      'interpret',
      'iterate',
      'leave',
      'nop',
      'options',
      'otherwise',
      'pull',
      'push',
      'queue',
      'return',
      'say',
      'select',
      'syntax',
      'then',
   );
   $self->contextdata({
      'Commentar 1' => {
         callback => \&parseCommentar1,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
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
   return 'REXX';
}

sub parseCommentar1 {
   my ($self, $text) = @_;
   # String => '(FIXME|TODO)'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(FIXME|TODO)', 0, 0, 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
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

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'instructions'
   # attribute => 'Instructions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'instructions', 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # String => 'builtin'
   # attribute => 'Built In'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'builtin', 0, undef, 0, '#stay', 'Built In')) {
      return 1
   }
   # String => '\bsignal([\s]*(on|off)[\s]*(error|failure|halt|notready|novalue|syntax|lostdigits))*'
   # attribute => 'Instructions'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bsignal([\\s]*(on|off)[\\s]*(error|failure|halt|notready|novalue|syntax|lostdigits))*', 1, 0, 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # String => '\bcall([\s]*(on|off)[\s]*(error|failure|halt|notready))*'
   # attribute => 'Instructions'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bcall([\\s]*(on|off)[\\s]*(error|failure|halt|notready))*', 1, 0, 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # String => '\b(trace|address)\s*[_\w\d]'
   # attribute => 'Instructions'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(trace|address)\\s*[_\\w\\d]', 1, 0, 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # String => '\bprocedure([\s]*expose)?'
   # attribute => 'Instructions'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bprocedure([\\s]*expose)?', 1, 0, 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # String => '\bdo([\s]*forever)?'
   # attribute => 'Instructions'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdo([\\s]*forever)?', 1, 0, 0, undef, 0, '#stay', 'Instructions')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # String => ':!%&()+,-/.*<=>?[]{|}~^;'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':!%&()+,-/.*<=>?[]{|}~^;', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '\b[_\w][_\w\d]*(?=[\s]*[(:])'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[_\\w][_\\w\\d]*(?=[\\s]*[(:])', 0, 0, 0, undef, 0, '#stay', 'Function')) {
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

Syntax::Highlight::Engine::Kate::REXX - a Plugin for REXX syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::REXX;
 my $sh = new Syntax::Highlight::Engine::Kate::REXX([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::REXX is a  plugin module that provides syntax highlighting
for REXX to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author