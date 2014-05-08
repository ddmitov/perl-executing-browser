# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'yacas.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.3
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Yacas;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Highlight' => 'Alert',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Parens' => 'Normal',
      'String' => 'String',
      'Symbol' => 'Others',
   });
   $self->listAdd('keywords',
      '=',
      'And',
      'ApplyPure',
      'ArrayCreate',
      'ArrayGet',
      'ArraySet',
      'ArraySize',
      'Atom',
      'Berlekamp',
      'BitAnd',
      'BitOr',
      'BitXor',
      'Bodied',
      'CTokenizer',
      'Check',
      'Clear',
      'CommonLispTokenizer',
      'Concat',
      'ConcatStrings',
      'CurrentFile',
      'CurrentLine',
      'CustomEval',
      'CustomEval\\\'Expression',
      'CustomEval\\\'Locals',
      'CustomEval\\\'Result',
      'CustomEval\\\'Stop',
      'DefLoad',
      'DefLoadFunction',
      'DefMacroRuleBase',
      'DefMacroRuleBaseListed',
      'DefaultDirectory',
      'DefaultTokenizer',
      'Delete',
      'DestructiveDelete',
      'DestructiveInsert',
      'DestructiveReplace',
      'DestructiveReverse',
      'DllEnumerate',
      'DllLoad',
      'DllUnload',
      'Equals',
      'Eval',
      'FastArcCos',
      'FastArcSin',
      'FastArcTan',
      'FastAssoc',
      'FastCos',
      'FastExp',
      'FastIsPrime',
      'FastLog',
      'FastPower',
      'FastSin',
      'FastTan',
      'FindFile',
      'FindFunction',
      'FlatCopy',
      'FromBase',
      'FromFile',
      'FromString',
      'FullForm',
      'GarbageCollect',
      'GenericTypeName',
      'GetExtraInfo',
      'GetPrecision',
      'GreaterThan',
      'Head',
      'Hold',
      'HoldArg',
      'If',
      'Infix',
      'Insert',
      'IsAtom',
      'IsBodied',
      'IsBound',
      'IsFunction',
      'IsGeneric',
      'IsInfix',
      'IsInteger',
      'IsList',
      'IsNumber',
      'IsPostfix',
      'IsPrefix',
      'IsString',
      'LazyGlobal',
      'LeftPrecedence',
      'Length',
      'LessThan',
      'LispRead',
      'LispReadListed',
      'List',
      'Listify',
      'Load',
      'Local',
      'LocalSymbols',
      'MacroClear',
      'MacroLocal',
      'MacroRule',
      'MacroRuleBase',
      'MacroRuleBaseListed',
      'MacroRulePattern',
      'MacroSet',
      'MathAbs',
      'MathAdd',
      'MathAnd',
      'MathArcCos',
      'MathArcSin',
      'MathArcTan',
      'MathCeil',
      'MathCos',
      'MathDiv',
      'MathDivide',
      'MathExp',
      'MathFac',
      'MathFloor',
      'MathGcd',
      'MathGetExactBits',
      'MathLibrary',
      'MathLog',
      'MathMod',
      'MathMultiply',
      'MathNot',
      'MathNth',
      'MathOr',
      'MathPi',
      'MathPower',
      'MathSetExactBits',
      'MathSin',
      'MathSqrt',
      'MathSubtract',
      'MathTan',
      'MaxEvalDepth',
      'Not',
      'OpLeftPrecedence',
      'OpPrecedence',
      'OpRightPrecedence',
      'Or',
      'PatchLoad',
      'PatchString',
      'PatternCreate',
      'PatternMatches',
      'Postfix',
      'Precision',
      'Prefix',
      'PrettyPrinter',
      'Prog',
      'Read',
      'ReadToken',
      'Replace',
      'Retract',
      'RightAssociative',
      'RightPrecedence',
      'Rule',
      'RuleBase',
      'RuleBaseArgList',
      'RuleBaseDefined',
      'RuleBaseListed',
      'RulePattern',
      'Secure',
      'Set',
      'SetExtraInfo',
      'SetStringMid',
      'ShiftLeft',
      'ShiftRight',
      'String',
      'StringMid',
      'Subst',
      'SystemCall',
      'Tail',
      'ToBase',
      'ToFile',
      'ToString',
      'TraceRule',
      'TraceStack',
      'Type',
      'UnFence',
      'UnList',
      'Use',
      'Version',
      'While',
      'Write',
      'WriteString',
      'XmlExplodeTag',
      'XmlTokenizer',
      '`',
   );
   $self->contextdata({
      'default' => {
         callback => \&parsedefault,
         attribute => 'Normal Text',
      },
      'linecomment' => {
         callback => \&parselinecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'multilinecomment' => {
         callback => \&parsemultilinecomment,
         attribute => 'Comment',
      },
      'string' => {
         callback => \&parsestring,
         attribute => 'String',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|=|`');
   $self->basecontext('default');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'yacas';
}

sub parsedefault {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'linecomment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'linecomment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'multilinecomment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'multilinecomment', 'Comment')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '{[('
   # attribute => 'Parens'
   # beginRegion => 'brace'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '{[(', 0, 0, undef, 0, '#stay', 'Parens')) {
      return 1
   }
   # String => '}])'
   # attribute => 'Parens'
   # context => '#stay'
   # endRegion => 'brace'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '}])', 0, 0, undef, 0, '#stay', 'Parens')) {
      return 1
   }
   # String => '+-*/=`~:!@#$^&*_|<>'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '+-*/=`~:!@#$^&*_|<>', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   return 0;
};

sub parselinecomment {
   my ($self, $text) = @_;
   # String => '(FIXME|TODO)'
   # attribute => 'Highlight'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(FIXME|TODO)', 0, 0, 0, undef, 0, '#stay', 'Highlight')) {
      return 1
   }
   return 0;
};

sub parsemultilinecomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # String => '(FIXME|TODO)'
   # attribute => 'Highlight'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(FIXME|TODO)', 0, 0, 0, undef, 0, '#stay', 'Highlight')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#stay'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#stay', 'String')) {
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


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Yacas - a Plugin for yacas syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Yacas;
 my $sh = new Syntax::Highlight::Engine::Kate::Yacas([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Yacas is a  plugin module that provides syntax highlighting
for yacas to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author