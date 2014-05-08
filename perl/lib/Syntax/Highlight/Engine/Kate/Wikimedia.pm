# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'mediawiki.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.00
#kate version 2.4
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Wikimedia;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Comment' => 'Comment',
      'Error' => 'Error',
      'HTML-Entity' => 'DecVal',
      'HTML-Tag' => 'Keyword',
      'Link' => 'Others',
      'NoWiki' => 'Normal',
      'Normal' => 'Normal',
      'Section' => 'Keyword',
      'URL' => 'Others',
      'Unformatted' => 'Normal',
      'Wiki-Tag' => 'DecVal',
   });
   $self->contextdata({
      'Error' => {
         callback => \&parseError,
         attribute => 'Error',
         lineending => '#pop',
      },
      'Link' => {
         callback => \&parseLink,
         attribute => 'Template',
      },
      'NoWiki' => {
         callback => \&parseNoWiki,
         attribute => 'NoWiki',
      },
      'Pre' => {
         callback => \&parsePre,
         attribute => 'NoWiki',
      },
      'Table' => {
         callback => \&parseTable,
         attribute => 'Normal',
      },
      'Template' => {
         callback => \&parseTemplate,
         attribute => 'Link',
      },
      'URL' => {
         callback => \&parseURL,
         attribute => 'Link',
      },
      'Unformatted' => {
         callback => \&parseUnformatted,
         attribute => 'Unformatted',
         lineending => '#pop',
      },
      'WikiLink' => {
         callback => \&parseWikiLink,
         attribute => 'Link',
      },
      'comment' => {
         callback => \&parsecomment,
         attribute => 'Comment',
      },
      'normal' => {
         callback => \&parsenormal,
         attribute => 'Normal',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Wikimedia';
}

sub parseError {
   my ($self, $text) = @_;
   return 0;
};

sub parseLink {
   my ($self, $text) = @_;
   # attribute => 'Wiki-Tag'
   # char => '}'
   # char1 => '}'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '}', '}', 0, 0, 0, undef, 0, '#pop', 'Wiki-Tag')) {
      return 1
   }
   # String => ''[]'
   # attribute => 'Error'
   # context => 'Error'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '\'[]', 0, 0, undef, 0, 'Error', 'Error')) {
      return 1
   }
   return 0;
};

sub parseNoWiki {
   my ($self, $text) = @_;
   # String => '<!--[^-]*-->'
   # attribute => 'NoWiki'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<!--[^-]*-->', 0, 0, 0, undef, 0, '#stay', 'NoWiki')) {
      return 1
   }
   # String => '</nowiki>'
   # attribute => 'Wiki-Tag'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '</nowiki>', 0, 0, 0, undef, 0, '#pop', 'Wiki-Tag')) {
      return 1
   }
   # String => '[<][^>]+[>]'
   # attribute => 'HTML-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[<][^>]+[>]', 0, 0, 0, undef, 0, '#stay', 'HTML-Tag')) {
      return 1
   }
   # String => '<pre>'
   # attribute => 'HTML-Tag'
   # context => 'Pre'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<pre>', 0, 0, 0, undef, 0, 'Pre', 'HTML-Tag')) {
      return 1
   }
   return 0;
};

sub parsePre {
   my ($self, $text) = @_;
   # String => '</pre>'
   # attribute => 'Wiki-Tag'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '</pre>', 0, 0, 0, undef, 0, '#pop', 'Wiki-Tag')) {
      return 1
   }
   return 0;
};

sub parseTable {
   my ($self, $text) = @_;
   # String => '<!--'
   # attribute => 'Comment'
   # context => 'comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # String => '([=]{2,2}[^=]+[=]{2,2}|[=]{3,3}[^=]+[=]{3,3}|[=]{4,4}[^=]+[=]{4,4}|[=]{5,5}[^=]+[=]{5,5})'
   # attribute => 'Section'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([=]{2,2}[^=]+[=]{2,2}|[=]{3,3}[^=]+[=]{3,3}|[=]{4,4}[^=]+[=]{4,4}|[=]{5,5}[^=]+[=]{5,5})', 0, 0, 0, 0, 0, '#stay', 'Section')) {
      return 1
   }
   # String => '[*#;:\s]*[*#:]+'
   # attribute => 'Wiki-Tag'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[*#;:\\s]*[*#:]+', 0, 0, 0, 0, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # String => '[[](?![[])'
   # attribute => 'Wiki-Tag'
   # context => 'URL'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[[](?![[])', 0, 0, 0, undef, 0, 'URL', 'Wiki-Tag')) {
      return 1
   }
   # String => '(http:|ftp:|mailto:)[\S]*($|[\s])'
   # attribute => 'URL'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(http:|ftp:|mailto:)[\\S]*($|[\\s])', 0, 0, 0, undef, 0, '#stay', 'URL')) {
      return 1
   }
   # String => '[']{2,}'
   # attribute => 'Wiki-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\']{2,}', 0, 0, 0, undef, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => '|'
   # char1 => '}'
   # column => '0'
   # context => '#pop'
   # endRegion => 'table'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '|', '}', 0, 0, 0, 0, 0, '#pop', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => '|'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => '{'
   # char1 => '{'
   # context => 'Template'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '{', '{', 0, 0, 0, undef, 0, 'Template', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => '['
   # char1 => '['
   # context => 'WikiLink'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '[', '[', 0, 0, 0, undef, 0, 'WikiLink', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'HTML-Entity'
   # char => '&'
   # char1 => ';'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '&', ';', 0, 0, undef, 0, '#stay', 'HTML-Entity')) {
      return 1
   }
   # String => '<nowiki>'
   # attribute => 'Wiki-Tag'
   # context => 'NoWiki'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<nowiki>', 0, 0, 0, undef, 0, 'NoWiki', 'Wiki-Tag')) {
      return 1
   }
   # String => '<pre>'
   # attribute => 'HTML-Tag'
   # context => 'Pre'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<pre>', 0, 0, 0, undef, 0, 'Pre', 'HTML-Tag')) {
      return 1
   }
   # String => '[<][^>]+[>]'
   # attribute => 'HTML-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[<][^>]+[>]', 0, 0, 0, undef, 0, '#stay', 'HTML-Tag')) {
      return 1
   }
   # String => '[\s]'
   # column => '0'
   # context => 'Unformatted'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\s]', 0, 0, 0, 0, 0, 'Unformatted', undef)) {
      return 1
   }
   # String => '[~]{3,4}'
   # attribute => 'Wiki-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[~]{3,4}', 0, 0, 0, undef, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # String => '[-]{4,}'
   # attribute => 'Wiki-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[-]{4,}', 0, 0, 0, undef, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => '!'
   # column => '0'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '!', 0, 0, 0, 0, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   return 0;
};

sub parseTemplate {
   my ($self, $text) = @_;
   # attribute => 'Wiki-Tag'
   # char => '}'
   # char1 => '}'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '}', '}', 0, 0, 0, undef, 0, '#pop', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Error'
   # char => '''
   # context => 'Error'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Error', 'Error')) {
      return 1
   }
   return 0;
};

sub parseURL {
   my ($self, $text) = @_;
   # attribute => 'Wiki-Tag'
   # char => ']'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Error'
   # char => '''
   # context => 'Error'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Error', 'Error')) {
      return 1
   }
   return 0;
};

sub parseUnformatted {
   my ($self, $text) = @_;
   return 0;
};

sub parseWikiLink {
   my ($self, $text) = @_;
   # attribute => 'Wiki-Tag'
   # char => '|'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => ']'
   # char1 => ']'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, ']', ']', 0, 0, 0, undef, 0, '#pop', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Error'
   # char => '''
   # context => 'Error'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Error', 'Error')) {
      return 1
   }
   return 0;
};

sub parsecomment {
   my ($self, $text) = @_;
   # String => '-->'
   # attribute => 'Comment'
   # context => '#pop'
   # endRegion => 'comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '-->', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parsenormal {
   my ($self, $text) = @_;
   # String => '<!--'
   # attribute => 'Comment'
   # beginRegion => 'comment'
   # context => 'comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'comment', 'Comment')) {
      return 1
   }
   # String => '([=]{2,2}[^=]+[=]{2,2}|[=]{3,3}[^=]+[=]{3,3}|[=]{4,4}[^=]+[=]{4,4}|[=]{5,5}[^=]+[=]{5,5})'
   # attribute => 'Section'
   # column => '0'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([=]{2,2}[^=]+[=]{2,2}|[=]{3,3}[^=]+[=]{3,3}|[=]{4,4}[^=]+[=]{4,4}|[=]{5,5}[^=]+[=]{5,5})', 0, 0, 0, 0, 0, '#stay', 'Section')) {
      return 1
   }
   # String => '[~]{3,4}'
   # attribute => 'Wiki-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[~]{3,4}', 0, 0, 0, undef, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # String => '[*#;:\s]*[*#:]+'
   # attribute => 'Wiki-Tag'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[*#;:\\s]*[*#:]+', 0, 0, 0, 0, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # String => '[[](?![[])'
   # attribute => 'Wiki-Tag'
   # context => 'URL'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[[](?![[])', 0, 0, 0, undef, 0, 'URL', 'Wiki-Tag')) {
      return 1
   }
   # String => '(http:|ftp:|mailto:)[\S]*($|[\s])'
   # attribute => 'URL'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(http:|ftp:|mailto:)[\\S]*($|[\\s])', 0, 0, 0, undef, 0, '#stay', 'URL')) {
      return 1
   }
   # String => '[']{2,}'
   # attribute => 'Wiki-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\']{2,}', 0, 0, 0, undef, 0, '#stay', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # beginRegion => 'table'
   # char => '{'
   # char1 => '|'
   # column => '0'
   # context => 'Table'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '{', '|', 0, 0, 0, 0, 0, 'Table', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => '{'
   # char1 => '{'
   # context => 'Template'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '{', '{', 0, 0, 0, undef, 0, 'Template', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'Wiki-Tag'
   # char => '['
   # char1 => '['
   # context => 'WikiLink'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '[', '[', 0, 0, 0, undef, 0, 'WikiLink', 'Wiki-Tag')) {
      return 1
   }
   # attribute => 'HTML-Entity'
   # char => '&'
   # char1 => ';'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '&', ';', 0, 0, undef, 0, '#stay', 'HTML-Entity')) {
      return 1
   }
   # String => '<nowiki>'
   # attribute => 'Wiki-Tag'
   # context => 'NoWiki'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<nowiki>', 0, 0, 0, undef, 0, 'NoWiki', 'Wiki-Tag')) {
      return 1
   }
   # String => '<pre>'
   # attribute => 'HTML-Tag'
   # context => 'Pre'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<pre>', 0, 0, 0, undef, 0, 'Pre', 'HTML-Tag')) {
      return 1
   }
   # String => '[<][^>]+[>]'
   # attribute => 'HTML-Tag'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[<][^>]+[>]', 0, 0, 0, undef, 0, '#stay', 'HTML-Tag')) {
      return 1
   }
   # String => '[\s]'
   # column => '0'
   # context => 'Unformatted'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\s]', 0, 0, 0, 0, 0, 'Unformatted', undef)) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Wikimedia - a Plugin for Wikimedia syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Wikimedia;
 my $sh = new Syntax::Highlight::Engine::Kate::Wikimedia([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Wikimedia is a  plugin module that provides syntax highlighting
for Wikimedia to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author