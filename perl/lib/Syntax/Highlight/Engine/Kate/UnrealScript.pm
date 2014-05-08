# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'uscript.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 0.91
#kate version 2.3
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::UnrealScript;

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
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'Preprocessor' => 'Others',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('keywords',
      'Cross',
      'Dot',
      'Static',
      'abstract',
      'array',
      'auto',
      'break',
      'case',
      'coerce',
      'config',
      'const',
      'continue',
      'cpptext',
      'default',
      'defaultproperties',
      'do',
      'editconst',
      'editinline',
      'editinlinenew',
      'editinlineuse',
      'else',
      'enum',
      'event',
      'exec',
      'expands',
      'export',
      'extends',
      'false',
      'final',
      'final',
      'for',
      'foreach',
      'function',
      'global',
      'hidecategories',
      'if',
      'ignores',
      'instanceof',
      'iterator',
      'latent',
      'local',
      'localized',
      'native',
      'nativereplication',
      'new',
      'noexport',
      'none',
      'null',
      'operator',
      'optional',
      'out',
      'placeable',
      'postoperator',
      'preoperator',
      'private',
      'protected',
      'public',
      'reliable',
      'replication',
      'return',
      'self',
      'simulated',
      'singular',
      'state',
      'static',
      'struct',
      'super',
      'switch',
      'synchronized',
      'throws',
      'transient',
      'true',
      'unreliable',
      'var',
      'virtual',
      'volatile',
      'while',
   );
   $self->listAdd('types',
      'ELightType',
      'Pawn',
      'actor',
      'ammo',
      'bool',
      'boolean',
      'byte',
      'char',
      'class',
      'color',
      'coords',
      'double',
      'float',
      'int',
      'ipaddr',
      'long',
      'material',
      'name',
      'object',
      'package',
      'plane',
      'rotator',
      'short',
      'sound',
      'staticmesh',
      'string',
      'vector',
      'void',
   );
   $self->contextdata({
      'Commentar 1' => {
         callback => \&parseCommentar1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Commentar 2' => {
         callback => \&parseCommentar2,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
         lineending => '#pop',
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
   return 'UnrealScript';
}

sub parseCommentar1 {
   my ($self, $text) = @_;
   return 0;
};

sub parseCommentar2 {
   my ($self, $text) = @_;
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
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # items => 'ARRAY(0x16a9b80)'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      # String => 'fF'
      # attribute => 'Float'
      # context => '#stay'
      # type => 'AnyChar'
      if ($self->testAnyChar($text, 'fF', 0, 0, undef, 0, '#stay', 'Float')) {
         return 1
      }
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # items => 'ARRAY(0x16fe360)'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      # String => 'ULL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'ULL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LUL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LUL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LLU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LLU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'UL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'UL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'U'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'U', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'L'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'TRUE'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'L', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '//BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'Region1'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//BEGIN.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '//END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'Region1'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//END.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
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
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'Brace1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '!%&()+,-<=>?[]^{|}~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!%&()+,-<=>?[]^{|}~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '#exec'
   # attribute => 'Preprocessor'
   # context => 'Preprocessor'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#exec', 1, 0, 0, undef, 0, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Commentar 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Commentar 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Commentar 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Commentar 2', 'Comment')) {
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
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
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

Syntax::Highlight::Engine::Kate::UnrealScript - a Plugin for UnrealScript syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::UnrealScript;
 my $sh = new Syntax::Highlight::Engine::Kate::UnrealScript([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::UnrealScript is a  plugin module that provides syntax highlighting
for UnrealScript to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author