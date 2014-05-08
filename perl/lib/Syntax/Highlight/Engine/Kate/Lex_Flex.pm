# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'lex.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.4
#kate author Jan Villat (jan.villat@net2000.ch)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Lex_Flex;

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
      'Definition' => 'DataType',
      'Directive' => 'Keyword',
      'Normal Text' => 'Normal',
      'RegExpr' => 'String',
   });
   $self->contextdata({
      'Action' => {
         callback => \&parseAction,
         attribute => 'Normal Text',
         lineending => '#pop',
         fallthrough => 'Action C',
      },
      'Action C' => {
         callback => \&parseActionC,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
      },
      'Definition RegExpr' => {
         callback => \&parseDefinitionRegExpr,
         attribute => 'RegExpr',
         lineending => '#pop',
      },
      'Definitions' => {
         callback => \&parseDefinitions,
         attribute => 'Normal Text',
      },
      'Detect C' => {
         callback => \&parseDetectC,
         attribute => 'Normal Text',
      },
      'Indented C' => {
         callback => \&parseIndentedC,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'Lex C Bloc' => {
         callback => \&parseLexCBloc,
         attribute => 'Normal Text',
      },
      'Lex Rule C Bloc' => {
         callback => \&parseLexRuleCBloc,
         attribute => 'Normal Text',
      },
      'Normal C Bloc' => {
         callback => \&parseNormalCBloc,
         attribute => 'Normal Text',
      },
      'Percent Command' => {
         callback => \&parsePercentCommand,
         attribute => 'Directive',
         lineending => '#pop',
      },
      'Pre Start' => {
         callback => \&parsePreStart,
         attribute => 'Normal Text',
      },
      'RegExpr (' => {
         callback => \&parseRegExprBo,
         attribute => 'RegExpr',
      },
      'RegExpr Base' => {
         callback => \&parseRegExprBase,
         attribute => 'RegExpr',
      },
      'RegExpr Q' => {
         callback => \&parseRegExprQ,
         attribute => 'RegExpr',
      },
      'RegExpr [' => {
         callback => \&parseRegExprSo,
         attribute => 'RegExpr',
      },
      'RegExpr {' => {
         callback => \&parseRegExprCo,
         attribute => 'RegExpr',
      },
      'Rule RegExpr' => {
         callback => \&parseRuleRegExpr,
         attribute => 'RegExpr',
         lineending => '#pop',
      },
      'Rules' => {
         callback => \&parseRules,
         attribute => 'Normal Text',
         fallthrough => 'Rule RegExpr',
      },
      'Start Conditions Scope' => {
         callback => \&parseStartConditionsScope,
         attribute => 'Normal Text',
         fallthrough => 'Rule RegExpr',
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
   return 'Lex/Flex';
}

sub parseAction {
   my ($self, $text) = @_;
   # String => '\|\s*$'
   # attribute => 'Directive'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\|\\s*$', 0, 0, 0, undef, 0, '#stay', 'Directive')) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'lexCbloc'
   # char => '%'
   # char1 => '{'
   # context => 'Lex Rule C Bloc'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '{', 0, 0, 0, undef, 0, 'Lex Rule C Bloc', 'Content-Type Delimiter')) {
      return 1
   }
   return 0;
};

sub parseActionC {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # beginRegion => 'bloc'
   # char => '{'
   # context => 'Normal C Bloc'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'Normal C Bloc', 'Normal Text')) {
      return 1
   }
   # attribute => 'Alert'
   # char => '}'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
      return 1
   }
   return 0;
};

sub parseComment {
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

sub parseDefinitionRegExpr {
   my ($self, $text) = @_;
   # context => 'RegExpr Base'
   # type => 'IncludeRules'
   if ($self->includeRules('RegExpr Base', $text)) {
      return 1
   }
   # String => '\S'
   # attribute => 'RegExpr'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'RegExpr')) {
      return 1
   }
   # String => '.*'
   # attribute => 'Alert'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.*', 0, 0, 0, undef, 0, '#stay', 'Alert')) {
      return 1
   }
   return 0;
};

sub parseDefinitions {
   my ($self, $text) = @_;
   # context => 'Detect C'
   # type => 'IncludeRules'
   if ($self->includeRules('Detect C', $text)) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'rules'
   # char => '%'
   # char1 => '%'
   # context => 'Rules'
   # endRegion => 'definitions'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '%', 0, 0, 0, undef, 0, 'Rules', 'Content-Type Delimiter')) {
      return 1
   }
   # attribute => 'Directive'
   # char => '%'
   # context => 'Percent Command'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, 'Percent Command', 'Directive')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # column => '0'
   # context => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, 0, 0, 'Comment', 'Comment')) {
      return 1
   }
   # String => '[A-Za-z_]\w*\s+'
   # attribute => 'Definition'
   # column => '0'
   # context => 'Definition RegExpr'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Za-z_]\\w*\\s+', 0, 0, 0, 0, 0, 'Definition RegExpr', 'Definition')) {
      return 1
   }
   return 0;
};

sub parseDetectC {
   my ($self, $text) = @_;
   # String => '^\s'
   # attribute => 'Normal Text'
   # context => 'Indented C'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s', 0, 0, 0, undef, 0, 'Indented C', 'Normal Text')) {
      return 1
   }
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'lexCbloc'
   # char => '%'
   # char1 => '{'
   # column => '0'
   # context => 'Lex C Bloc'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '{', 0, 0, 0, 0, 0, 'Lex C Bloc', 'Content-Type Delimiter')) {
      return 1
   }
   return 0;
};

sub parseIndentedC {
   my ($self, $text) = @_;
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
      return 1
   }
   return 0;
};

sub parseLexCBloc {
   my ($self, $text) = @_;
   # attribute => 'Content-Type Delimiter'
   # char => '%'
   # char1 => '}'
   # column => '0'
   # context => '#pop'
   # endRegion => 'lexCbloc'
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

sub parseLexRuleCBloc {
   my ($self, $text) = @_;
   # attribute => 'Content-Type Delimiter'
   # char => '%'
   # char1 => '}'
   # context => '#pop'
   # endRegion => 'lexCbloc'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '}', 0, 0, 0, undef, 0, '#pop', 'Content-Type Delimiter')) {
      return 1
   }
   # context => '##C++'
   # type => 'IncludeRules'
   if ($self->includePlugin('C++', $text)) {
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
   return 0;
};

sub parsePercentCommand {
   my ($self, $text) = @_;
   return 0;
};

sub parsePreStart {
   my ($self, $text) = @_;
   # String => '.'
   # attribute => 'Normal Text'
   # beginRegion => 'definitions'
   # context => 'Definitions'
   # lookAhead => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 1, undef, 0, 'Definitions', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseRegExprBo {
   my ($self, $text) = @_;
   # context => 'RegExpr Base'
   # type => 'IncludeRules'
   if ($self->includeRules('RegExpr Base', $text)) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'RegExpr')) {
      return 1
   }
   # String => '.'
   # attribute => 'RegExpr'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 0, undef, 0, '#stay', 'RegExpr')) {
      return 1
   }
   return 0;
};

sub parseRegExprBase {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Backslash Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Backslash Code')) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => '('
   # context => 'RegExpr ('
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, 'RegExpr (', 'RegExpr')) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => '['
   # context => 'RegExpr ['
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, 'RegExpr [', 'RegExpr')) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => '{'
   # context => 'RegExpr {'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, 'RegExpr {', 'RegExpr')) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => '"'
   # context => 'RegExpr Q'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'RegExpr Q', 'RegExpr')) {
      return 1
   }
   return 0;
};

sub parseRegExprQ {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Backslash Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Backslash Code')) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'RegExpr')) {
      return 1
   }
   # String => '.'
   # attribute => 'RegExpr'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 0, undef, 0, '#stay', 'RegExpr')) {
      return 1
   }
   return 0;
};

sub parseRegExprSo {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Backslash Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Backslash Code')) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => ']'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop', 'RegExpr')) {
      return 1
   }
   # String => '.'
   # attribute => 'RegExpr'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 0, undef, 0, '#stay', 'RegExpr')) {
      return 1
   }
   return 0;
};

sub parseRegExprCo {
   my ($self, $text) = @_;
   # String => '\\.'
   # attribute => 'Backslash Code'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\.', 0, 0, 0, undef, 0, '#stay', 'Backslash Code')) {
      return 1
   }
   # attribute => 'RegExpr'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'RegExpr')) {
      return 1
   }
   # String => '.'
   # attribute => 'RegExpr'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '.', 0, 0, 0, undef, 0, '#stay', 'RegExpr')) {
      return 1
   }
   return 0;
};

sub parseRuleRegExpr {
   my ($self, $text) = @_;
   # String => '\{$'
   # attribute => 'Content-Type Delimiter'
   # beginRegion => 'SCscope'
   # context => 'Start Conditions Scope'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\{$', 0, 0, 0, undef, 0, 'Start Conditions Scope', 'Content-Type Delimiter')) {
      return 1
   }
   # context => 'RegExpr Base'
   # type => 'IncludeRules'
   if ($self->includeRules('RegExpr Base', $text)) {
      return 1
   }
   # String => '\S'
   # attribute => 'RegExpr'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\S', 0, 0, 0, undef, 0, '#stay', 'RegExpr')) {
      return 1
   }
   # String => '\s+'
   # attribute => 'Normal Text'
   # context => 'Action'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, 'Action', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseRules {
   my ($self, $text) = @_;
   # context => 'Detect C'
   # type => 'IncludeRules'
   if ($self->includeRules('Detect C', $text)) {
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
   return 0;
};

sub parseStartConditionsScope {
   my ($self, $text) = @_;
   # String => '\s*\}'
   # attribute => 'Content-Type Delimiter'
   # context => '#pop'
   # endRegion => 'SCscope'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*\\}', 0, 0, 0, undef, 0, '#pop', 'Content-Type Delimiter')) {
      return 1
   }
   # String => '\s*'
   # attribute => 'Normal Text'
   # context => 'Rule RegExpr'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*', 0, 0, 0, undef, 0, 'Rule RegExpr', 'Normal Text')) {
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

Syntax::Highlight::Engine::Kate::Lex_Flex - a Plugin for Lex/Flex syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Lex_Flex;
 my $sh = new Syntax::Highlight::Engine::Kate::Lex_Flex([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Lex_Flex is a  plugin module that provides syntax highlighting
for Lex/Flex to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author