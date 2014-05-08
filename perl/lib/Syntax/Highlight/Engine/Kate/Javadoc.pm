# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'javadoc.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.4
#kate author Alfredo Luiz Foltran Fialho (alfoltran@ig.com.br)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Javadoc;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'BlockTag' => 'Keyword',
      'InlineTag' => 'Keyword',
      'Javadoc' => 'Comment',
      'JavadocFS' => 'Comment',
      'JavadocParam' => 'Keyword',
      'Normal Text' => 'Normal',
      'SeeTag' => 'Keyword',
   });
   $self->contextdata({
      'FindJavadoc' => {
         callback => \&parseFindJavadoc,
         attribute => 'Normal Text',
      },
      'InlineTagar' => {
         callback => \&parseInlineTagar,
         attribute => 'InlineTag',
         lineending => '#pop',
      },
      'JavadocFSar' => {
         callback => \&parseJavadocFSar,
         attribute => 'JavadocFS',
      },
      'JavadocParam' => {
         callback => \&parseJavadocParam,
         attribute => 'Javadoc',
         lineending => '#pop',
      },
      'Javadocar' => {
         callback => \&parseJavadocar,
         attribute => 'Javadoc',
      },
      'LiteralTagar' => {
         callback => \&parseLiteralTagar,
         attribute => 'InlineTag',
         lineending => '#pop',
      },
      'SeeTag' => {
         callback => \&parseSeeTag,
         attribute => 'SeeTag',
         lineending => '#pop',
      },
      'Start' => {
         callback => \&parseStart,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Start');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Javadoc';
}

sub parseFindJavadoc {
   my ($self, $text) = @_;
   # String => '/**'
   # attribute => 'JavadocFS'
   # beginRegion => 'Javadoc'
   # context => 'JavadocFSar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '/**', 0, 0, 0, undef, 0, 'JavadocFSar', 'JavadocFS')) {
      return 1
   }
   return 0;
};

sub parseInlineTagar {
   my ($self, $text) = @_;
   # attribute => 'InlineTag'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'InlineTag')) {
      return 1
   }
   # attribute => 'JavadocFS'
   # char => '*'
   # char1 => '/'
   # context => '#pop#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop#pop#pop', 'JavadocFS')) {
      return 1
   }
   # context => '##HTML'
   # type => 'IncludeRules'
   if ($self->includePlugin('HTML', $text)) {
      return 1
   }
   return 0;
};

sub parseJavadocFSar {
   my ($self, $text) = @_;
   # attribute => 'JavadocFS'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'Javadoc'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'JavadocFS')) {
      return 1
   }
   # String => '(!|\?)'
   # attribute => 'JavadocFS'
   # context => 'Javadocar'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(!|\\?)', 0, 0, 0, undef, 0, 'Javadocar', 'JavadocFS')) {
      return 1
   }
   # String => '(\.\s*$)'
   # attribute => 'JavadocFS'
   # context => 'Javadocar'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\.\\s*$)', 0, 0, 0, undef, 0, 'Javadocar', 'JavadocFS')) {
      return 1
   }
   # String => '(\.\s)(?![\da-z])'
   # attribute => 'JavadocFS'
   # context => 'Javadocar'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\.\\s)(?![\\da-z])', 0, 0, 0, undef, 0, 'Javadocar', 'JavadocFS')) {
      return 1
   }
   # String => '\**\s*(?=@(author|deprecated|exception|param|return|see|serial|serialData|serialField|since|throws|version)(\s|$))'
   # attribute => 'JavadocFS'
   # context => 'Javadocar'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\**\\s*(?=@(author|deprecated|exception|param|return|see|serial|serialData|serialField|since|throws|version)(\\s|$))', 0, 0, 0, undef, 1, 'Javadocar', 'JavadocFS')) {
      return 1
   }
   # String => '{@code '
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@code ', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@code	'
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@code	', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@docRoot}'
   # attribute => 'InlineTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@docRoot}', 0, 0, 0, undef, 0, '#stay', 'InlineTag')) {
      return 1
   }
   # String => '{@inheritDoc}'
   # attribute => 'InlineTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@inheritDoc}', 0, 0, 0, undef, 0, '#stay', 'InlineTag')) {
      return 1
   }
   # String => '{@link '
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@link ', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@link	'
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@link	', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@linkplain '
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@linkplain ', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@linkplain	'
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@linkplain	', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@literal '
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@literal ', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@literal	'
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@literal	', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@value}'
   # attribute => 'InlineTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@value}', 0, 0, 0, undef, 0, '#stay', 'InlineTag')) {
      return 1
   }
   # String => '{@value '
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@value ', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@value	'
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@value	', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # context => '##HTML'
   # type => 'IncludeRules'
   if ($self->includePlugin('HTML', $text)) {
      return 1
   }
   return 0;
};

sub parseJavadocParam {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\S*(?=\*/)'
   # attribute => 'JavadocParam'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S*(?=\\*/)', 0, 0, 0, undef, 0, '#pop#pop', 'JavadocParam')) {
      return 1
   }
   # String => '\S*(\s|$)'
   # attribute => 'JavadocParam'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S*(\\s|$)', 0, 0, 0, undef, 0, '#pop', 'JavadocParam')) {
      return 1
   }
   return 0;
};

sub parseJavadocar {
   my ($self, $text) = @_;
   # attribute => 'JavadocFS'
   # char => '*'
   # char1 => '/'
   # context => '#pop#pop'
   # endRegion => 'Javadoc'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop#pop', 'JavadocFS')) {
      return 1
   }
   # String => '\*+(?!/)'
   # attribute => 'JavadocFS'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\*+(?!/)', 0, 0, 0, undef, 1, '#stay', 'JavadocFS')) {
      return 1
   }
   # String => '@author '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@author ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@deprecated '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@deprecated ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@exception '
   # attribute => 'BlockTag'
   # context => 'JavadocParam'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@exception ', 0, 0, 0, undef, 0, 'JavadocParam', 'BlockTag')) {
      return 1
   }
   # String => '@param '
   # attribute => 'BlockTag'
   # context => 'JavadocParam'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@param ', 0, 0, 0, undef, 0, 'JavadocParam', 'BlockTag')) {
      return 1
   }
   # String => '@return '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@return ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@see '
   # attribute => 'BlockTag'
   # context => 'SeeTag'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@see ', 0, 0, 0, undef, 0, 'SeeTag', 'BlockTag')) {
      return 1
   }
   # String => '@serial '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@serial ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@serialData '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@serialData ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@serialField '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@serialField ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@since '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@since ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@throws '
   # attribute => 'BlockTag'
   # context => 'JavadocParam'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@throws ', 0, 0, 0, undef, 0, 'JavadocParam', 'BlockTag')) {
      return 1
   }
   # String => '@version '
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@version ', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@author	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@author	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@deprecated	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@deprecated	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@exception	'
   # attribute => 'BlockTag'
   # context => 'JavadocParam'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@exception	', 0, 0, 0, undef, 0, 'JavadocParam', 'BlockTag')) {
      return 1
   }
   # String => '@param	'
   # attribute => 'BlockTag'
   # context => 'JavadocParam'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@param	', 0, 0, 0, undef, 0, 'JavadocParam', 'BlockTag')) {
      return 1
   }
   # String => '@return	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@return	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@see	'
   # attribute => 'BlockTag'
   # context => 'SeeTag'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@see	', 0, 0, 0, undef, 0, 'SeeTag', 'BlockTag')) {
      return 1
   }
   # String => '@serial	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@serial	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@serialData	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@serialData	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@serialField	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@serialField	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@since	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@since	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '@throws	'
   # attribute => 'BlockTag'
   # context => 'JavadocParam'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@throws	', 0, 0, 0, undef, 0, 'JavadocParam', 'BlockTag')) {
      return 1
   }
   # String => '@version	'
   # attribute => 'BlockTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '@version	', 0, 0, 0, undef, 0, '#stay', 'BlockTag')) {
      return 1
   }
   # String => '{@code '
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@code ', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@code	'
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@code	', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@docRoot}'
   # attribute => 'InlineTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@docRoot}', 0, 0, 0, undef, 0, '#stay', 'InlineTag')) {
      return 1
   }
   # String => '{@inheritDoc}'
   # attribute => 'InlineTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@inheritDoc}', 0, 0, 0, undef, 0, '#stay', 'InlineTag')) {
      return 1
   }
   # String => '{@link '
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@link ', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@link	'
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@link	', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@linkplain '
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@linkplain ', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@linkplain	'
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@linkplain	', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@literal '
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@literal ', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@literal	'
   # attribute => 'InlineTag'
   # context => 'LiteralTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@literal	', 0, 0, 0, undef, 0, 'LiteralTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@value}'
   # attribute => 'InlineTag'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@value}', 0, 0, 0, undef, 0, '#stay', 'InlineTag')) {
      return 1
   }
   # String => '{@value '
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@value ', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # String => '{@value	'
   # attribute => 'InlineTag'
   # context => 'InlineTagar'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '{@value	', 0, 0, 0, undef, 0, 'InlineTagar', 'InlineTag')) {
      return 1
   }
   # context => '##HTML'
   # type => 'IncludeRules'
   if ($self->includePlugin('HTML', $text)) {
      return 1
   }
   return 0;
};

sub parseLiteralTagar {
   my ($self, $text) = @_;
   # attribute => 'InlineTag'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'InlineTag')) {
      return 1
   }
   # attribute => 'JavadocFS'
   # char => '*'
   # char1 => '/'
   # context => '#pop#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop#pop#pop', 'JavadocFS')) {
      return 1
   }
   return 0;
};

sub parseSeeTag {
   my ($self, $text) = @_;
   # attribute => 'JavadocFS'
   # char => '*'
   # char1 => '/'
   # context => '#pop#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop#pop#pop', 'JavadocFS')) {
      return 1
   }
   # context => '##HTML'
   # type => 'IncludeRules'
   if ($self->includePlugin('HTML', $text)) {
      return 1
   }
   return 0;
};

sub parseStart {
   my ($self, $text) = @_;
   # context => 'FindJavadoc'
   # type => 'IncludeRules'
   if ($self->includeRules('FindJavadoc', $text)) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Javadoc - a Plugin for Javadoc syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Javadoc;
 my $sh = new Syntax::Highlight::Engine::Kate::Javadoc([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Javadoc is a  plugin module that provides syntax highlighting
for Javadoc to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author