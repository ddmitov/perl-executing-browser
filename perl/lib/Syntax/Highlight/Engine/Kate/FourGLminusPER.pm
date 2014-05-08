# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'fgl-per.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.3
#kate author Andrej Falout (andrej@falout.org)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::FourGLminusPER;

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
      'COMPRESS',
      'UPSHIFT',
      'WORDWRAP',
      'attributes',
      'autonext',
      'black',
      'blue',
      'by',
      'character',
      'color',
      'comments',
      'cyan',
      'database',
      'default',
      'delimiters',
      'display',
      'downshift',
      'end',
      'format',
      'formonly',
      'green',
      'include',
      'input',
      'instructions',
      'invisible',
      'keys',
      'like',
      'magenta',
      'noentry',
      'not',
      'noupdate',
      'null',
      'picture',
      'record',
      'red',
      'required',
      'reverse',
      'screen',
      'size',
      'tables',
      'through',
      'to',
      'today',
      'type',
      'underline',
      'white',
      'without',
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
   return '4GL-PER';
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

Syntax::Highlight::Engine::Kate::FourGLminusPER - a Plugin for 4GL-PER syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::FourGLminusPER;
 my $sh = new Syntax::Highlight::Engine::Kate::FourGLminusPER([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::FourGLminusPER is a  plugin module that provides syntax highlighting
for 4GL-PER to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author