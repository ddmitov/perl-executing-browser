# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'yacc.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.03
#kate version 2.4
#kate author Jan Villat (jan.villat@net2000.ch)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Yacc_Bison;

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
      'Backslash Code' => 'String',
      'Comment' => 'Comment',
      'Content-Type Delimiter' => 'BaseN',
      'Data Type' => 'DataType',
      'Definition' => 'Normal',
      'Directive' => 'Keyword',
      'Normal Text' => 'Normal',
      'Rule' => 'String',
      'String' => 'String',
      'String Char' => 'Char',
   });
   $self->contextdata({
      'C Declarations' => {
         callback => \&parseCDeclarations,
         attribute => 'Normal Text',
      },
      'Char' => {
         callback => \&parseChar,
         attribute => 'String Char',
         lineending => '#pop',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
      },
      'CommentSlash' => {
         callback => \&parseCommentSlash,
         attribute => 'Comment',
      },
      'CommentStar' => {
         callback => \&parseCommentStar,
         attribute => 'Comment',
      },
      'Declarations' => {
         callback => \&parseDeclarations,
         attribute => 'Normal Text',
      },
      'Dol' => {
         callback => \&parseDol,
         attribute => 'Normal Text',
         fallthrough => 'DolEnd',
      },
      'DolEnd' => {
         callback => \&parseDolEnd,
         attribute => 'Normal Text',
      },
      'Normal C Bloc' => {
         callback => \&parseNormalCBloc,
         attribute => 'Normal Text',
      },
      'PC type' => {
         callback => \&parsePCtype,
         attribute => 'Data Type',
         lineending => '#pop#pop#pop',
      },
      'Percent Command' => {
         callback => \&parsePercentCommand,
         attribute => 'Directive',
         lineending => '#pop',
      },
      'Percent Command In' => {
         callback => \&parsePercentCommandIn,
         attribute => 'NormalText',
         lineending => '#pop#pop',
      },
      'Pre Start' => {
         callback => \&parsePreStart,
         attribute => 'Normal Text',
      },
      'Rule In' => {
         callback => \&parseRuleIn,
         attribute => 'Definition',
      },
      'Rules' => {
         callback => \&parseRules,
         attribute => 'Rule',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
      },
      'StringOrChar' => {
         callback => \&parseStringOrChar,
         attribute => 'NormalText',
      },
      'Union In' => {
         callback => \&parseUnionIn,
         attribute => 'Normal Text',
      },
      'Union InIn' => {
         callback => \&parseUnionInIn,
         attribute => 'Normal Text',
      },
      'Union Start' => {
         callback => \&parseUnionStart,
         attribute => 'Normal Text',
      },
      'User Code' => {
         callback => \&parseUserCode,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Pre Start');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Yacc/Bison';
}

sub parseCDeclarations {
   my ($self, $text) = @_;
   # context => 'Comment'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment', $text)) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # char => '%'
   # char1 => '}'
   # column => '0'
   # context => '#pop'
   # endRegion => 'cdeclarations'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '}', 0, 0, 0, 0, 0, '#pop', 'Content-Type Delimiter')) {
      return 1
   }
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
      return 1
   }
   return 0;
};

sub parseChar {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Backslash Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Backslash Code')) {
      return 1
   }
   # attribute => 'String Char'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String Char')) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'CommentStar'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'CommentStar', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'CommentSlash'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'CommentSlash', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseCommentSlash {
   my ($self, $text) = @_;
   # String => '[^\\]$'
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^\\\\]$', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseCommentStar {
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

sub parseDeclarations {
   my ($self, $text) = @_;
   # context => 'Comment'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment', $text)) {
      return 1
   }
   # String => '%union'
   # attribute => 'Directive'
   # context => 'Union Start'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '%union', 0, 0, 0, undef, 0, 'Union Start', 'Directive')) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'rules'
   # char => '%'
   # char1 => '%'
   # context => 'Rules'
   # endRegion => 'declarations'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '%', 0, 0, 0, undef, 0, 'Rules', 'Content-Type Delimiter')) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'cdeclarations'
   # char => '%'
   # char1 => '{'
   # column => '0'
   # context => 'C Declarations'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '{', 0, 0, 0, 0, 0, 'C Declarations', 'Content-Type Delimiter')) {
      return 1
   }
   # attribute => 'Directive'
   # char => '%'
   # context => 'Percent Command'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Percent Command', 'Directive')) {
      return 1
   }
   return 0;
};

sub parseDol {
   my ($self, $text) = @_;
   # String => '<[^>]+>'
   # attribute => 'Data Type'
   # context => 'DolEnd'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<[^>]+>', 0, 0, 0, undef, 0, 'DolEnd', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parseDolEnd {
   my ($self, $text) = @_;
   # String => '\d+'
   # attribute => 'Directive'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\d+', 0, 0, 0, undef, 0, '#pop#pop', 'Directive')) {
      return 1
   }
   # attribute => 'Directive'
   # char => '$'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, '#pop#pop', 'Directive')) {
      return 1
   }
   return 0;
};

sub parseNormalCBloc {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # beginRegion => 'bloc'
   # char => '{'
   # context => 'Normal C Bloc'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'Normal C Bloc', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#pop'
   # endRegion => 'bloc'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
      return 1
   }
   # attribute => 'Directive'
   # char => '$'
   # context => 'Dol'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '$', 0, 0, 0, undef, 0, 'Dol', 'Directive')) {
      return 1
   }
   return 0;
};

sub parsePCtype {
   my ($self, $text) = @_;
   # attribute => 'Data Type'
   # char => '>'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '#pop', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parsePercentCommand {
   my ($self, $text) = @_;
   # context => 'Comment'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment', $text)) {
      return 1
   }
   # String => '\W'
   # attribute => 'Normal Text'
   # context => 'Percent Command In'
   # lookAhead => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\W', 0, 0, 1, undef, 0, 'Percent Command In', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parsePercentCommandIn {
   my ($self, $text) = @_;
   # context => 'StringOrChar'
   # type => 'IncludeRules'
   if ($self->includeRules('StringOrChar', $text)) {
      return 1
   }
   # attribute => 'Data Type'
   # char => '<'
   # context => 'PC type'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, 'PC type', 'Data Type')) {
      return 1
   }
   return 0;
};

sub parsePreStart {
   my ($self, $text) = @_;
   # context => 'Comment'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment', $text)) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'cdeclarations'
   # char => '%'
   # char1 => '{'
   # column => '0'
   # context => 'C Declarations'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '{', 0, 0, 0, 0, 0, 'C Declarations', 'Content-Type Delimiter')) {
      return 1
   }
   # String => '.'
   # attribute => 'Normal Text'
   # beginRegion => 'declarations'
   # context => 'Declarations'
   # lookAhead => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 1, undef, 0, 'Declarations', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseRuleIn {
   my ($self, $text) = @_;
   # context => 'Comment'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment', $text)) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => ';'
   # context => '#pop'
   # endRegion => 'rule'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'bloc'
   # char => '{'
   # context => 'Normal C Bloc'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'Normal C Bloc', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '|'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # context => 'StringOrChar'
   # type => 'IncludeRules'
   if ($self->includeRules('StringOrChar', $text)) {
      return 1
   }
   return 0;
};

sub parseRules {
   my ($self, $text) = @_;
   # context => 'Comment'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment', $text)) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'code'
   # char => '%'
   # char1 => '%'
   # context => 'User Code'
   # endRegion => 'rules'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '%', 0, 0, 0, undef, 0, 'User Code', 'Content-Type Delimiter')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'rule'
   # char => ':'
   # context => 'Rule In'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ':', 0, 0, 0, undef, 0, 'Rule In', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Backslash Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Backslash Code')) {
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

sub parseStringOrChar {
   my ($self, $text) = @_;
   # attribute => 'String Char'
   # char => '''
   # context => 'Char'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Char', 'String Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   return 0;
};

sub parseUnionIn {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '{'
   # context => 'Union InIn'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'Union InIn', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#pop#pop'
   # endRegion => 'union'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop#pop', 'Normal Text')) {
      return 1
   }
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
      return 1
   }
   return 0;
};

sub parseUnionInIn {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '{'
   # context => 'Union InIn'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'Union InIn', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
      return 1
   }
   return 0;
};

sub parseUnionStart {
   my ($self, $text) = @_;
   # context => 'Comment'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment', $text)) {
      return 1
   }
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'union'
   # char => '{'
   # context => 'Union In'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'Union In', 'Normal Text')) {
      return 1
   }
   # String => '.'
   # attribute => 'Alert'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 0, undef, 0, '#pop', 'Alert')) {
      return 1
   }
   return 0;
};

sub parseUserCode {
   my ($self, $text) = @_;
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Yacc_Bison - a Plugin for Yacc/Bison syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Yacc_Bison;
 my $sh = new Syntax::Highlight::Engine::Kate::Yacc_Bison([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Yacc_Bison is a  plugin module that provides syntax highlighting
for Yacc/Bison to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author