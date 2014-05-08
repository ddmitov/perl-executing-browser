# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'xml.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.96
#kate version 2.4
#kate author Wilbert Berendsen (wilbert@kde.nl)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::XML;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Attribute' => 'Others',
      'CDATA' => 'BaseN',
      'Comment' => 'Comment',
      'Doctype' => 'DataType',
      'Element' => 'Keyword',
      'EntityRef' => 'DecVal',
      'Error' => 'Error',
      'Normal Text' => 'Normal',
      'PEntityRef' => 'DecVal',
      'Processing Instruction' => 'Keyword',
      'Value' => 'String',
   });
   $self->contextdata({
      'Attribute' => {
         callback => \&parseAttribute,
         attribute => 'Normal Text',
      },
      'CDATA' => {
         callback => \&parseCDATA,
         attribute => 'Normal Text',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
      },
      'Doctype' => {
         callback => \&parseDoctype,
         attribute => 'Normal Text',
      },
      'Doctype Internal Subset' => {
         callback => \&parseDoctypeInternalSubset,
         attribute => 'Normal Text',
      },
      'Doctype Markupdecl' => {
         callback => \&parseDoctypeMarkupdecl,
         attribute => 'Normal Text',
      },
      'Doctype Markupdecl DQ' => {
         callback => \&parseDoctypeMarkupdeclDQ,
         attribute => 'Value',
      },
      'Doctype Markupdecl SQ' => {
         callback => \&parseDoctypeMarkupdeclSQ,
         attribute => 'Value',
      },
      'El Content' => {
         callback => \&parseElContent,
         attribute => 'Normal Text',
      },
      'El End' => {
         callback => \&parseElEnd,
         attribute => 'Normal Text',
      },
      'Element' => {
         callback => \&parseElement,
         attribute => 'Normal Text',
      },
      'FindEntityRefs' => {
         callback => \&parseFindEntityRefs,
         attribute => 'Normal Text',
      },
      'FindPEntityRefs' => {
         callback => \&parseFindPEntityRefs,
         attribute => 'Normal Text',
      },
      'FindXML' => {
         callback => \&parseFindXML,
         attribute => 'Normal Text',
      },
      'PI' => {
         callback => \&parsePI,
         attribute => 'Normal Text',
      },
      'Start' => {
         callback => \&parseStart,
         attribute => 'Normal Text',
      },
      'Value' => {
         callback => \&parseValue,
         attribute => 'Normal Text',
      },
      'Value DQ' => {
         callback => \&parseValueDQ,
         attribute => 'Value',
      },
      'Value SQ' => {
         callback => \&parseValueSQ,
         attribute => 'Value',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Start');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'XML';
}

sub parseAttribute {
   my ($self, $text) = @_;
   # attribute => 'Attribute'
   # char => '='
   # context => 'Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, 'Value', 'Attribute')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};

sub parseCDATA {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => ']]>'
   # attribute => 'CDATA'
   # context => '#pop'
   # endRegion => 'cdata'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ']]>', 0, 0, 0, undef, 0, '#pop', 'CDATA')) {
      return 1
   }
   # String => ']]&gt;'
   # attribute => 'EntityRef'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ']]&gt;', 0, 0, 0, undef, 0, '#stay', 'EntityRef')) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '-->'
   # attribute => 'Comment'
   # context => '#pop'
   # endRegion => 'comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '-->', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # String => '-(-(?!->))+'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '-(-(?!->))+', 0, 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   return 0;
};

sub parseDoctype {
   my ($self, $text) = @_;
   # attribute => 'Doctype'
   # char => '>'
   # context => '#pop'
   # endRegion => 'doctype'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Doctype')) {
      return 1
   }
   # attribute => 'Doctype'
   # beginRegion => 'int_subset'
   # char => '['
   # context => 'Doctype Internal Subset'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, 'Doctype Internal Subset', 'Doctype')) {
      return 1
   }
   return 0;
};

sub parseDoctypeInternalSubset {
   my ($self, $text) = @_;
   # attribute => 'Doctype'
   # char => ']'
   # context => '#pop'
   # endRegion => 'int_subset'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop', 'Doctype')) {
      return 1
   }
   # String => '<!(ELEMENT|ENTITY|ATTLIST|NOTATION)\b'
   # attribute => 'Doctype'
   # context => 'Doctype Markupdecl'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<!(ELEMENT|ENTITY|ATTLIST|NOTATION)\\b', 0, 0, 0, undef, 0, 'Doctype Markupdecl', 'Doctype')) {
      return 1
   }
   # String => '<!--'
   # attribute => 'Comment'
   # beginRegion => 'comment'
   # context => 'Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # String => '<\?[\w:_-]*'
   # attribute => 'Processing Instruction'
   # beginRegion => 'pi'
   # context => 'PI'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\?[\\w:_-]*', 0, 0, 0, undef, 0, 'PI', 'Processing Instruction')) {
      return 1
   }
   # context => 'FindPEntityRefs'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPEntityRefs', $text)) {
      return 1
   }
   return 0;
};

sub parseDoctypeMarkupdecl {
   my ($self, $text) = @_;
   # attribute => 'Doctype'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Doctype')) {
      return 1
   }
   # attribute => 'Value'
   # char => '"'
   # context => 'Doctype Markupdecl DQ'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Doctype Markupdecl DQ', 'Value')) {
      return 1
   }
   # attribute => 'Value'
   # char => '''
   # context => 'Doctype Markupdecl SQ'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Doctype Markupdecl SQ', 'Value')) {
      return 1
   }
   return 0;
};

sub parseDoctypeMarkupdeclDQ {
   my ($self, $text) = @_;
   # attribute => 'Value'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Value')) {
      return 1
   }
   # context => 'FindPEntityRefs'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPEntityRefs', $text)) {
      return 1
   }
   return 0;
};

sub parseDoctypeMarkupdeclSQ {
   my ($self, $text) = @_;
   # attribute => 'Value'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'Value')) {
      return 1
   }
   # context => 'FindPEntityRefs'
   # type => 'IncludeRules'
   if ($self->includeRules('FindPEntityRefs', $text)) {
      return 1
   }
   return 0;
};

sub parseElContent {
   my ($self, $text) = @_;
   # String => '</[A-Za-z_:][\w.:_-]*'
   # attribute => 'Element'
   # context => 'El End'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '</[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, 'El End', 'Element')) {
      return 1
   }
   # context => 'FindXML'
   # type => 'IncludeRules'
   if ($self->includeRules('FindXML', $text)) {
      return 1
   }
   return 0;
};

sub parseElEnd {
   my ($self, $text) = @_;
   # attribute => 'Element'
   # char => '>'
   # context => '#pop#pop#pop'
   # endRegion => 'element'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Element')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};

sub parseElement {
   my ($self, $text) = @_;
   # attribute => 'Element'
   # char => '/'
   # char1 => '>'
   # context => '#pop'
   # endRegion => 'element'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '#pop', 'Element')) {
      return 1
   }
   # attribute => 'Element'
   # char => '>'
   # context => 'El Content'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, 'El Content', 'Element')) {
      return 1
   }
   # String => '^[A-Za-z_:][\w.:_-]*'
   # attribute => 'Attribute'
   # context => 'Attribute'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, 'Attribute', 'Attribute')) {
      return 1
   }
   # String => '\s+[A-Za-z_:][\w.:_-]*'
   # attribute => 'Attribute'
   # context => 'Attribute'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, 'Attribute', 'Attribute')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};

sub parseFindEntityRefs {
   my ($self, $text) = @_;
   # String => '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\w.:_-]*);'
   # attribute => 'EntityRef'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\\w.:_-]*);', 0, 0, 0, undef, 0, '#stay', 'EntityRef')) {
      return 1
   }
   # String => '&<'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '&<', 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};

sub parseFindPEntityRefs {
   my ($self, $text) = @_;
   # String => '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\w.:_-]*);'
   # attribute => 'EntityRef'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&(#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z_:][\\w.:_-]*);', 0, 0, 0, undef, 0, '#stay', 'EntityRef')) {
      return 1
   }
   # String => '%[A-Za-z_:][\w.:_-]*;'
   # attribute => 'PEntityRef'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%[A-Za-z_:][\\w.:_-]*;', 0, 0, 0, undef, 0, '#stay', 'PEntityRef')) {
      return 1
   }
   # String => '&%'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '&%', 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};

sub parseFindXML {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '<!--'
   # attribute => 'Comment'
   # beginRegion => 'comment'
   # context => 'Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # String => '<![CDATA['
   # attribute => 'CDATA'
   # beginRegion => 'cdata'
   # context => 'CDATA'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<![CDATA[', 0, 0, 0, undef, 0, 'CDATA', 'CDATA')) {
      return 1
   }
   # String => '<!DOCTYPE\s+'
   # attribute => 'Doctype'
   # beginRegion => 'doctype'
   # context => 'Doctype'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<!DOCTYPE\\s+', 0, 0, 0, undef, 0, 'Doctype', 'Doctype')) {
      return 1
   }
   # String => '<\?[\w:_-]*'
   # attribute => 'Processing Instruction'
   # beginRegion => 'pi'
   # context => 'PI'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\?[\\w:_-]*', 0, 0, 0, undef, 0, 'PI', 'Processing Instruction')) {
      return 1
   }
   # String => '<[A-Za-z_:][\w.:_-]*'
   # attribute => 'Element'
   # beginRegion => 'element'
   # context => 'Element'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<[A-Za-z_:][\\w.:_-]*', 0, 0, 0, undef, 0, 'Element', 'Element')) {
      return 1
   }
   # context => 'FindEntityRefs'
   # type => 'IncludeRules'
   if ($self->includeRules('FindEntityRefs', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   return 0;
};

sub parsePI {
   my ($self, $text) = @_;
   # attribute => 'Processing Instruction'
   # char => '?'
   # char1 => '>'
   # context => '#pop'
   # endRegion => 'pi'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '?', '>', 0, 0, 0, undef, 0, '#pop', 'Processing Instruction')) {
      return 1
   }
   return 0;
};

sub parseStart {
   my ($self, $text) = @_;
   # context => 'FindXML'
   # type => 'IncludeRules'
   if ($self->includeRules('FindXML', $text)) {
      return 1
   }
   return 0;
};

sub parseValue {
   my ($self, $text) = @_;
   # attribute => 'Value'
   # char => '"'
   # context => 'Value DQ'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Value DQ', 'Value')) {
      return 1
   }
   # attribute => 'Value'
   # char => '''
   # context => 'Value SQ'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Value SQ', 'Value')) {
      return 1
   }
   # String => '\S'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};

sub parseValueDQ {
   my ($self, $text) = @_;
   # attribute => 'Value'
   # char => '"'
   # context => '#pop#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Value')) {
      return 1
   }
   # context => 'FindEntityRefs'
   # type => 'IncludeRules'
   if ($self->includeRules('FindEntityRefs', $text)) {
      return 1
   }
   return 0;
};

sub parseValueSQ {
   my ($self, $text) = @_;
   # attribute => 'Value'
   # char => '''
   # context => '#pop#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Value')) {
      return 1
   }
   # context => 'FindEntityRefs'
   # type => 'IncludeRules'
   if ($self->includeRules('FindEntityRefs', $text)) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::XML - a Plugin for XML syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::XML;
 my $sh = new Syntax::Highlight::Engine::Kate::XML([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::XML is a  plugin module that provides syntax highlighting
for XML to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author