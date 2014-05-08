# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'mup.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.06
#kate version 2.4
#kate author Wilbert Berendsen (wilbert@kde.nl)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::Music_Publisher;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Barline' => 'DecVal',
      'Comment' => 'Comment',
      'Context' => 'Keyword',
      'Error' => 'Error',
      'Location' => 'Operator',
      'Location Probably' => 'Reserved',
      'Lyrics' => 'BaseN',
      'Macro' => 'Others',
      'Newscore' => 'BString',
      'Normal Text' => 'Normal',
      'Note' => 'Normal',
      'Note Attribute' => 'Normal',
      'Parameter' => 'Char',
      'Print Command' => 'BaseN',
      'Special Char' => 'Keyword',
      'String' => 'String',
      'String Error' => 'Error',
      'String Lyrics' => 'String',
      'String Special' => 'IString',
      'Tuplet' => 'RegionMarker',
      'Unset Command' => 'Variable',
      'Value' => 'Float',
   });
   $self->listAdd('mupcontexts',
      'block',
      'bottom',
      'bottom2',
      'footer',
      'footer2',
      'grids',
      'header',
      'header2',
      'headshapes',
      'music',
      'music',
      'score',
      'staff',
      'top',
      'top2',
      'voice',
   );
   $self->listAdd('mupfontnames',
      'avantgarde',
      'bookman',
      'courier',
      'helvetica',
      'newcentury',
      'palatino',
      'times',
   );
   $self->listAdd('mupfontstyles',
      'bold',
      'boldital',
      'ital',
      'rom',
   );
   $self->listAdd('mupgraphics',
      'bulge',
      'curve',
      'dashed',
      'dotted',
      'down',
      'line',
      'medium',
      'midi',
      'mussym',
      'octave',
      'pedal',
      'phrase',
      'roll',
      'to',
      'to',
      'up',
      'wavy',
      'wide',
      'with',
   );
   $self->listAdd('muplocations',
      'above',
      'all',
      'below',
      'between',
   );
   $self->listAdd('mupmacrodirectives',
      'else',
      'include',
      'undef',
   );
   $self->listAdd('mupmacrodirectives_end',
      '@',
      'endif',
   );
   $self->listAdd('mupmacrodirectives_start',
      'define',
      'ifdef',
      'ifndef',
   );
   $self->listAdd('mupmusicchars',
      '128rest',
      '16rest',
      '1n',
      '1rest',
      '256rest',
      '2n',
      '2rest',
      '32rest',
      '4n',
      '4rest',
      '64rest',
      '8rest',
      'acc_gt',
      'acc_hat',
      'acc_uhat',
      'begped',
      'cclef',
      'coda',
      'com',
      'copyright',
      'cut',
      'dblflat',
      'dblsharp',
      'dblwhole',
      'diamond',
      'dim',
      'dn128n',
      'dn16n',
      'dn256n',
      'dn2n',
      'dn32n',
      'dn4n',
      'dn64n',
      'dn8n',
      'dnbow',
      'dnflag',
      'dot',
      'dwhdiamond',
      'dwhrest',
      'endped',
      'fclef',
      'ferm',
      'filldiamond',
      'flat',
      'gclef',
      'halfdim',
      'invmor',
      'invturn',
      'leg',
      'measrpt',
      'mor',
      'nat',
      'pedal',
      'qwhrest',
      'rr',
      'sharp',
      'sign',
      'sm128rest',
      'sm16rest',
      'sm1n',
      'sm1rest',
      'sm256rest',
      'sm2n',
      'sm2rest',
      'sm32rest',
      'sm4n',
      'sm4rest',
      'sm64rest',
      'sm8rest',
      'smacc_gt',
      'smacc_hat',
      'smacc_uhat',
      'smbegped',
      'smcclef',
      'smcoda',
      'smcom',
      'smcopyright',
      'smcut',
      'smdblflat',
      'smdblsharp',
      'smdblwhole',
      'smdiamond',
      'smdim',
      'smdn128n',
      'smdn16n',
      'smdn256n',
      'smdn2n',
      'smdn32n',
      'smdn4n',
      'smdn64n',
      'smdn8n',
      'smdnbow',
      'smdnflag',
      'smdot',
      'smdwhdiamond',
      'smdwhrest',
      'smendped',
      'smfclef',
      'smferm',
      'smfilldiamond',
      'smflat',
      'smgclef',
      'smhalfdim',
      'sminvmor',
      'sminvturn',
      'smleg',
      'smmeasrpt',
      'smmor',
      'smnat',
      'smpedal',
      'smqwhrest',
      'smrr',
      'smsharp',
      'smsign',
      'smtr',
      'smtriangle',
      'smturn',
      'smuferm',
      'smup128n',
      'smup16n',
      'smup256n',
      'smup2n',
      'smup32n',
      'smup4n',
      'smup64n',
      'smup8n',
      'smupbow',
      'smupflag',
      'smuwedge',
      'smwedge',
      'smxnote',
      'tr',
      'triangle',
      'turn',
      'uferm',
      'up128n',
      'up16n',
      'up256n',
      'up2n',
      'up32n',
      'up4n',
      'up64n',
      'up8n',
      'upbow',
      'upflag',
      'uwedge',
      'wedge',
      'xnote',
   );
   $self->listAdd('mupparameters',
      'aboveorder',
      'addtranspose',
      'barstyle',
      'beamslope',
      'beamstyle',
      'beloworder',
      'betweenorder',
      'bottommargin',
      'brace',
      'bracket',
      'cancelkey',
      'chorddist',
      'clef',
      'crescdist',
      'defoct',
      'dist',
      'division',
      'dyndist',
      'endingstyle',
      'firstpage',
      'font',
      'fontfamily',
      'gridfret',
      'gridsatend',
      'gridscale',
      'gridswhereused',
      'key',
      'label',
      'label2',
      'leftmargin',
      'lyricsalign',
      'lyricsfont',
      'lyricsfontfamily',
      'lyricssize',
      'measnum',
      'measnumfont',
      'measnumfontfamily',
      'measnumsize',
      'noteheads',
      'numbermrpt',
      'ontheline',
      'packexp',
      'packfact',
      'pad',
      'pageheight',
      'pagewidth',
      'panelsperpage',
      'pedstyle',
      'printmultnum',
      'rehstyle',
      'release',
      'restcombine',
      'restsymmult',
      'rightmargin',
      'scale',
      'scorepad',
      'scoresep',
      'size',
      'stafflines',
      'staffpad',
      'staffs',
      'staffscale',
      'staffsep',
      'stemlen',
      'swingunit',
      'sylposition',
      'tabwhitebox',
      'time',
      'timeunit',
      'topmargin',
      'transpose',
      'units',
      'visible',
      'vscheme',
      'warn',
   );
   $self->listAdd('mupprintcommands',
      'center',
      'left',
      'paragraph',
      'postscript',
      'print',
      'right',
      'title',
   );
   $self->listAdd('mupprintspecifiers',
      'analysis',
      'chord',
      'dyn',
      'figbass',
   );
   $self->listAdd('mupspecialchars',
      '\\\'\\\'',
      '<<',
      '>>',
      'A\\\'',
      'A:',
      'AE',
      'A^',
      'A`',
      'Aacute',
      'Acircumflex',
      'Adieresis',
      'Agrave',
      'Ao',
      'Aring',
      'Atilde',
      'A~',
      'C,',
      'Ccedilla',
      'E\\\'',
      'E:',
      'E^',
      'E`',
      'Eacute',
      'Ecircumflex',
      'Edieresis',
      'Egrave',
      'I\\\'',
      'I^',
      'I`',
      'Iacute',
      'Icircumflex',
      'Idieresis',
      'Igrave',
      'L/',
      'Lslash',
      'Ntilde',
      'N~',
      'O\\\'',
      'O/',
      'O:',
      'OE',
      'O^',
      'O`',
      'Oacute',
      'Ocircumflex',
      'Odieresis',
      'Ograve',
      'Oslash',
      'Otilde',
      'O~',
      'Scaron',
      'Sv',
      'U\\\'',
      'U:',
      'U^',
      'U`',
      'Uacute',
      'Ucircumflex',
      'Udieresis',
      'Ugrave',
      'Y:',
      'Ydieresis',
      'Zcaron',
      'Zv',
      '``',
      'a\\\'',
      'a:',
      'a^',
      'a`',
      'aacute',
      'acircumflex',
      'acute',
      'adieresis',
      'ae',
      'agrave',
      'ao',
      'aring',
      'atilde',
      'a~',
      'breve',
      'bullet',
      'c,',
      'caron',
      'ccedilla',
      'cedilla',
      'cent',
      'dagger',
      'daggerdbl',
      'dieresis',
      'dotaccent',
      'dotlessi',
      'e\\\'',
      'e:',
      'e^',
      'e`',
      'eacute',
      'ecircumflex',
      'edieresis',
      'egrave',
      'emdash',
      'exclamdown',
      'germandbls',
      'grave',
      'guildsinglleft',
      'guillemotleft',
      'guillemotright',
      'guilsinglright',
      'hungarumlaut',
      'i\\\'',
      'i:',
      'i:',
      'i^',
      'i`',
      'iacute',
      'icircumflex',
      'idieresis',
      'igrave',
      'l/',
      'lslash',
      'macron',
      'ntilde',
      'n~',
      'o\\\'',
      'o/',
      'o:',
      'o^',
      'o`',
      'oacute',
      'ocircumflex',
      'odieresis',
      'oe',
      'ogonek',
      'ograve',
      'ordfeminine',
      'ordmasculine',
      'oslash',
      'otilde',
      'o~',
      'questiondown',
      'quotedblbase',
      'quotedblleft',
      'quotedblright',
      'ring',
      'scaron',
      'space',
      'ss',
      'sterling',
      'sv',
      'u\\\'',
      'u:',
      'u^',
      'u`',
      'uacute',
      'ucircumflex',
      'udieresis',
      'ugrave',
      'y:',
      'ydieresis',
      'yen',
      'zcaron',
      'zv',
   );
   $self->listAdd('mupvalues',
      '1drum',
      '1n',
      '2f',
      '2o',
      '3f',
      '3o',
      '5drum',
      '5n',
      '8treble',
      'alt',
      'alto',
      'aug',
      'augmented',
      'baritone',
      'barred',
      'bass',
      'boxed',
      'chord',
      'circled',
      'cm',
      'common',
      'cut',
      'dim',
      'diminished',
      'down',
      'drum',
      'dyn',
      'ending',
      'frenchviolin',
      'grouped',
      'inches',
      'line',
      'lyrics',
      'maj',
      'major',
      'mezzosoprano',
      'min',
      'minor',
      'mussym',
      'n',
      'octave',
      'othertext',
      'pedal',
      'pedstar',
      'per',
      'perfect',
      'plain',
      'reh',
      'soprano',
      'tab',
      'tenor',
      'times',
      'top',
      'treble',
      'treble8',
      'up',
      'whereused',
      'y',
   );
   $self->contextdata({
      'Bar Rehearsal' => {
         callback => \&parseBarRehearsal,
         attribute => 'Barline',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Barline' => {
         callback => \&parseBarline,
         attribute => 'Barline',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Bracket' => {
         callback => \&parseBracket,
         attribute => 'Note Attribute',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Bracket Hs' => {
         callback => \&parseBracketHs,
         attribute => 'Note Attribute',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Bracket With' => {
         callback => \&parseBracketWith,
         attribute => 'Note Attribute',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Font Name' => {
         callback => \&parseFontName,
         attribute => 'String Special',
         fallthrough => '#pop',
      },
      'Font Size' => {
         callback => \&parseFontSize,
         attribute => 'String Special',
         fallthrough => '#pop',
      },
      'Font Style' => {
         callback => \&parseFontStyle,
         attribute => 'String Special',
         fallthrough => '#pop',
      },
      'Location' => {
         callback => \&parseLocation,
         attribute => 'Normal Text',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Location Probably' => {
         callback => \&parseLocationProbably,
         attribute => 'Location Problably',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Macro' => {
         callback => \&parseMacro,
         attribute => 'Macro',
         lineending => '#pop',
      },
      'Macro Location' => {
         callback => \&parseMacroLocation,
         attribute => 'Location',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'Note' => {
         callback => \&parseNote,
         attribute => 'Note',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Note Probably' => {
         callback => \&parseNoteProbably,
         attribute => 'Note',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Parameter' => {
         callback => \&parseParameter,
         attribute => 'Parameter',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Print Command' => {
         callback => \&parsePrintCommand,
         attribute => 'Print Command',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Special Char' => {
         callback => \&parseSpecialChar,
         attribute => 'String Special',
         fallthrough => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
      'Tuplet' => {
         callback => \&parseTuplet,
         attribute => 'Tuplet',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Unset' => {
         callback => \&parseUnset,
         attribute => 'Parameter',
         lineending => '#pop',
         fallthrough => '#pop',
      },
      'Value' => {
         callback => \&parseValue,
         attribute => 'Value',
         lineending => '#pop',
         fallthrough => '#pop',
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
   return 'Music Publisher';
}

sub parseBarRehearsal {
   my ($self, $text) = @_;
   # String => '\s+'
   # attribute => 'Print Command'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Print Command')) {
      return 1
   }
   # String => 'mupfontnames'
   # attribute => 'Print Command'
   # context => 'Print Command'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontnames', 0, undef, 0, 'Print Command', 'Print Command')) {
      return 1
   }
   # String => 'mupfontstyles'
   # attribute => 'Print Command'
   # context => 'Print Command'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontstyles', 0, undef, 0, 'Print Command', 'Print Command')) {
      return 1
   }
   # String => '\b(let|mnum|num)\b'
   # attribute => 'Barline'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(let|mnum|num)\\b', 0, 0, 0, undef, 0, '#pop', 'Barline')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   return 0;
};

sub parseBarline {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => '\b(ending|endending|hidechanges)\b'
   # attribute => 'Barline'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(ending|endending|hidechanges)\\b', 0, 0, 0, undef, 0, '#stay', 'Barline')) {
      return 1
   }
   # String => '\breh(earsal)?\b'
   # attribute => 'Barline'
   # context => 'Bar Rehearsal'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\breh(earsal)?\\b', 0, 0, 0, undef, 0, 'Bar Rehearsal', 'Barline')) {
      return 1
   }
   # String => '\bmnum\s*=\s*[0-9]+'
   # attribute => 'Barline'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bmnum\\s*=\\s*[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Barline')) {
      return 1
   }
   # String => '\bnum\s*=\s*[0-9]+'
   # attribute => 'Barline'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bnum\\s*=\\s*[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Barline')) {
      return 1
   }
   # String => '\blet\s*=\s*("[A-Z]{1,2}")?'
   # attribute => 'Barline'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\blet\\s*=\\s*("[A-Z]{1,2}")?', 0, 0, 0, undef, 0, '#stay', 'Barline')) {
      return 1
   }
   # String => '\bpad\s+[0-9]+'
   # attribute => 'Barline'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bpad\\s+[0-9]+', 0, 0, 0, undef, 0, '#stay', 'Barline')) {
      return 1
   }
   # String => '=([a-z]|_[a-z][a-z_0-9]*)\b'
   # attribute => 'Location'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '=([a-z]|_[a-z][a-z_0-9]*)\\b', 0, 0, 0, undef, 0, '#stay', 'Location')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   return 0;
};

sub parseBracket {
   my ($self, $text) = @_;
   # attribute => 'Special Char'
   # char => ']'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#pop', 'Special Char')) {
      return 1
   }
   # String => '[\s;,]+'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\s;,]+', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '\b(grace|xnote|cue|diam|up|down)\b'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(grace|xnote|cue|diam|up|down)\\b', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '\b(slash|len|pad|ho|dist)\s*[0-9.+-]*'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(slash|len|pad|ho|dist)\\s*[0-9.+-]*', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '\bwith\s*(?=[A-Z"^>.-])'
   # attribute => 'Note Attribute'
   # context => 'Bracket With'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bwith\\s*(?=[A-Z"^>.-])', 0, 0, 0, undef, 0, 'Bracket With', 'Note Attribute')) {
      return 1
   }
   # String => '\bhs\s*(?=[A-Z"])'
   # attribute => 'Note Attribute'
   # context => 'Bracket Hs'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bhs\\s*(?=[A-Z"])', 0, 0, 0, undef, 0, 'Bracket Hs', 'Note Attribute')) {
      return 1
   }
   # String => '=([a-z]|_[a-z][a-z_0-9]*)\b'
   # attribute => 'Location'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '=([a-z]|_[a-z][a-z_0-9]*)\\b', 0, 0, 0, undef, 0, '#stay', 'Location')) {
      return 1
   }
   # String => '\bc\b'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bc\\b', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   return 0;
};

sub parseBracketHs {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   return 0;
};

sub parseBracketWith {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '[>.^-]+'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[>.^-]+', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '[\s,]+'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\s,]+', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseFontName {
   my ($self, $text) = @_;
   # attribute => 'String Special'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'String Special')) {
      return 1
   }
   # String => '[ABCHNPT][RBIX](?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[ABCHNPT][RBIX](?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => 'mupfontnames'
   # attribute => 'String Special'
   # context => 'Font Style'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontnames', 0, undef, 0, 'Font Style', 'String Special')) {
      return 1
   }
   # String => '(PV|previous)(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(PV|previous)(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[^ )"]+'
   # attribute => 'String Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^ )"]+', 0, 0, 0, undef, 0, '#stay', 'String Error')) {
      return 1
   }
   return 0;
};

sub parseFontSize {
   my ($self, $text) = @_;
   # attribute => 'String Special'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'String Special')) {
      return 1
   }
   # String => '[-+]?[0-9]+(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[-+]?[0-9]+(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '(PV|previous)(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(PV|previous)(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[^ )"]+'
   # attribute => 'String Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^ )"]+', 0, 0, 0, undef, 0, '#stay', 'String Error')) {
      return 1
   }
   return 0;
};

sub parseFontStyle {
   my ($self, $text) = @_;
   # String => '\s+'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => 'mupfontstyles'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontstyles', 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[^ )"]+'
   # attribute => 'String Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^ )"]+', 0, 0, 0, undef, 0, '#stay', 'String Error')) {
      return 1
   }
   return 0;
};

sub parseLocation {
   my ($self, $text) = @_;
   # String => '[\+\-\s]+'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\+\\-\\s]+', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '\btime\b'
   # attribute => 'Location'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\btime\\b', 0, 0, 0, undef, 0, '#stay', 'Location')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   return 0;
};

sub parseLocationProbably {
   my ($self, $text) = @_;
   # String => '[h-qt-z]|_[a-z][a-z_0-9]*'
   # attribute => 'Location Probably'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[h-qt-z]|_[a-z][a-z_0-9]*', 0, 0, 0, undef, 0, '#pop', 'Location Probably')) {
      return 1
   }
   return 0;
};

sub parseMacro {
   my ($self, $text) = @_;
   # String => 'mupmacrodirectives_start'
   # attribute => 'Macro'
   # beginRegion => 'macro'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupmacrodirectives_start', 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   # String => 'mupmacrodirectives_end'
   # attribute => 'Macro'
   # context => '#stay'
   # endRegion => 'macro'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupmacrodirectives_end', 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   # String => 'mupmacrodirectives'
   # attribute => 'Macro'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupmacrodirectives', 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   # String => '[A-Z][A-Z0-9_]*(?=\.[xynews]\b)'
   # attribute => 'Macro'
   # context => 'Macro Location'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Z][A-Z0-9_]*(?=\\.[xynews]\\b)', 0, 0, 0, undef, 0, 'Macro Location', 'Macro')) {
      return 1
   }
   # String => '[A-Z][A-Z0-9_]*'
   # attribute => 'Macro'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[A-Z][A-Z0-9_]*', 0, 0, 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   # attribute => 'Macro'
   # char => '@'
   # context => '#stay'
   # endRegion => 'macro'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '@', 0, 0, 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   return 0;
};

sub parseMacroLocation {
   my ($self, $text) = @_;
   # String => '..'
   # attribute => 'Location Probably'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '..', 0, 0, 0, undef, 0, '#pop', 'Location Probably')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'mupcontexts'
   # attribute => 'Context'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupcontexts', 0, undef, 0, '#stay', 'Context')) {
      return 1
   }
   # String => '\blyrics\b'
   # attribute => 'Lyrics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\blyrics\\b', 0, 0, 0, undef, 0, '#stay', 'Lyrics')) {
      return 1
   }
   # String => '\b((dashed|dotted)\s+)?(bar|endbar|dblbar|invisbar|repeatstart|repeatboth|repeatend|restart)\b'
   # attribute => 'Barline'
   # context => 'Barline'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b((dashed|dotted)\\s+)?(bar|endbar|dblbar|invisbar|repeatstart|repeatboth|repeatend|restart)\\b', 0, 0, 0, undef, 0, 'Barline', 'Barline')) {
      return 1
   }
   # String => '\bnew(score|page)\b'
   # attribute => 'Newscore'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bnew(score|page)\\b', 0, 0, 0, undef, 0, '#stay', 'Newscore')) {
      return 1
   }
   # String => '\bmultirest\s+[0-9]+\b'
   # attribute => 'Newscore'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bmultirest\\s+[0-9]+\\b', 0, 0, 0, undef, 0, '#stay', 'Newscore')) {
      return 1
   }
   # String => '\bunset\b'
   # attribute => 'Unset Command'
   # context => 'Unset'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bunset\\b', 0, 0, 0, undef, 0, 'Unset', 'Unset Command')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Comment', 'Comment')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '\\$'
   # attribute => 'Special Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\$', 0, 0, 0, undef, 0, '#stay', 'Special Char')) {
      return 1
   }
   # String => 'mupprintcommands'
   # attribute => 'Print Command'
   # context => 'Print Command'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupprintcommands', 0, undef, 0, 'Print Command', 'Print Command')) {
      return 1
   }
   # String => 'mupfontnames'
   # attribute => 'Print Command'
   # context => 'Print Command'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontnames', 0, undef, 0, 'Print Command', 'Print Command')) {
      return 1
   }
   # String => 'mupfontstyles'
   # attribute => 'Print Command'
   # context => 'Print Command'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontstyles', 0, undef, 0, 'Print Command', 'Print Command')) {
      return 1
   }
   # String => '\b((ragged|justified)\s+)?paragraph\b'
   # attribute => 'Print Command'
   # context => 'Print Command'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b((ragged|justified)\\s+)?paragraph\\b', 0, 0, 0, undef, 0, 'Print Command', 'Print Command')) {
      return 1
   }
   # String => 'mupprintspecifiers'
   # attribute => 'Print Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupprintspecifiers', 0, undef, 0, '#stay', 'Print Command')) {
      return 1
   }
   # String => 'mupgraphics'
   # attribute => 'Print Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupgraphics', 0, undef, 0, '#stay', 'Print Command')) {
      return 1
   }
   # String => 'muplocations'
   # attribute => 'Print Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'muplocations', 0, undef, 0, '#stay', 'Print Command')) {
      return 1
   }
   # String => '\bdist(?=\s+[^=])'
   # attribute => 'Print Command'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdist(?=\\s+[^=])', 0, 0, 0, undef, 0, '#stay', 'Print Command')) {
      return 1
   }
   # String => 'mupparameters'
   # attribute => 'Parameter'
   # context => 'Parameter'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupparameters', 0, undef, 0, 'Parameter', 'Parameter')) {
      return 1
   }
   # String => '\[(?=(grace|xnote|cue|diam|with|slash|up|down|len|pad|ho|dist|hs|c\b|=))'
   # attribute => 'Special Char'
   # context => 'Bracket'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\[(?=(grace|xnote|cue|diam|with|slash|up|down|len|pad|ho|dist|hs|c\\b|=))', 0, 0, 0, undef, 0, 'Bracket', 'Special Char')) {
      return 1
   }
   # attribute => 'Special Char'
   # char => '}'
   # context => 'Tuplet'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, 'Tuplet', 'Special Char')) {
      return 1
   }
   # String => '[]{'
   # attribute => 'Special Char'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '[]{', 0, 0, undef, 0, '#stay', 'Special Char')) {
      return 1
   }
   # String => '(<<|>>)'
   # attribute => 'Special Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(<<|>>)', 0, 0, 0, undef, 0, '#stay', 'Special Char')) {
      return 1
   }
   # String => '(\(\s*)?((1/4|1/2|1|2|4|8|16|32|64|128|256)\.*\s*)?((\(\s*)?([a-grs]|us)(?!bm)([0-9'?\sxn]|[+-]+|[&#]{1,2}|\(\s*[&#]{1,2}\s*\)|\(\s*[xn]\s*\)|\(\s*[0-9]\s*\))*\)?\s*)*\s*(?=[;~="<A-Z@^]|\b(bm|es?bm|dashed|dotted|tie|slur|alt|hs|ifn?def|else|elseif|endif|with|above)\b)'
   # attribute => 'Note'
   # context => 'Note'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\(\\s*)?((1/4|1/2|1|2|4|8|16|32|64|128|256)\\.*\\s*)?((\\(\\s*)?([a-grs]|us)(?!bm)([0-9\'?\\sxn]|[+-]+|[&#]{1,2}|\\(\\s*[&#]{1,2}\\s*\\)|\\(\\s*[xn]\\s*\\)|\\(\\s*[0-9]\\s*\\))*\\)?\\s*)*\\s*(?=[;~="<A-Z@^]|\\b(bm|es?bm|dashed|dotted|tie|slur|alt|hs|ifn?def|else|elseif|endif|with|above)\\b)', 0, 0, 0, undef, 0, 'Note', 'Note')) {
      return 1
   }
   # String => ';\s*(?=[~=<]|\b(bm|es?bm|dashed|dotted|tie|slur|alt|hs|ifn?def|else|elseif|endif)\b)'
   # attribute => 'Normal Text'
   # context => 'Note'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';\\s*(?=[~=<]|\\b(bm|es?bm|dashed|dotted|tie|slur|alt|hs|ifn?def|else|elseif|endif)\\b)', 0, 0, 0, undef, 0, 'Note', 'Normal Text')) {
      return 1
   }
   # String => '(1/4|1/2|1|2|4|8|16|32|64|128|256)?mu?[rs]+\s*(?=;)'
   # attribute => 'Note'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(1/4|1/2|1|2|4|8|16|32|64|128|256)?mu?[rs]+\\s*(?=;)', 0, 0, 0, undef, 0, '#stay', 'Note')) {
      return 1
   }
   # String => 'm\s*rpt\s*(?=;)'
   # attribute => 'Note'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'm\\s*rpt\\s*(?=;)', 0, 0, 0, undef, 0, '#stay', 'Note')) {
      return 1
   }
   # String => '=([a-z]|_[a-z][a-z_0-9]*)\b'
   # attribute => 'Location'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '=([a-z]|_[a-z][a-z_0-9]*)\\b', 0, 0, 0, undef, 0, '#stay', 'Location')) {
      return 1
   }
   # String => '([a-z]|_[a-z][a-z_0-9]*)\.[xynews]\b'
   # attribute => 'Location'
   # context => 'Location'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([a-z]|_[a-z][a-z_0-9]*)\\.[xynews]\\b', 0, 0, 0, undef, 0, 'Location', 'Location')) {
      return 1
   }
   # String => '([a-z]|_[a-z][a-z_0-9]*)\.(?=[A-Z])'
   # attribute => 'Location Probably'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '([a-z]|_[a-z][a-z_0-9]*)\\.(?=[A-Z])', 0, 0, 0, undef, 0, '#stay', 'Location Probably')) {
      return 1
   }
   # String => '[(,]\s*(?=([h-qt-z]|_[a-z][a-z_0-9]*)\s*[,)])'
   # attribute => 'Normal Text'
   # context => 'Location Probably'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[(,]\\s*(?=([h-qt-z]|_[a-z][a-z_0-9]*)\\s*[,)])', 0, 0, 0, undef, 0, 'Location Probably', 'Normal Text')) {
      return 1
   }
   # String => '[(,]\s*(?=[a-grs]\s*[,)])'
   # attribute => 'Normal Text'
   # context => 'Note Probably'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[(,]\\s*(?=[a-grs]\\s*[,)])', 0, 0, 0, undef, 0, 'Note Probably', 'Normal Text')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   # String => '[0-9.]*\s*til\s*(([0-9]+m(\s*\+\s*[0-9.]+)?)|[0-9.]+)\s*;'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9.]*\\s*til\\s*(([0-9]+m(\\s*\\+\\s*[0-9.]+)?)|[0-9.]+)\\s*;', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '[0-9]*[a-z_]+'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-9]*[a-z_]+', 0, 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};

sub parseNote {
   my ($self, $text) = @_;
   # String => '(\bdashed\s+|\bdotted\s+)?(<(/n|\\n|n/|n\\|[a-g]([+-]*|[0-7]))?>|tie|slur|[~])'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\\bdashed\\s+|\\bdotted\\s+)?(<(/n|\\\\n|n/|n\\\\|[a-g]([+-]*|[0-7]))?>|tie|slur|[~])', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '^(/|[a-g]([+-]*|[0-7]))'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^(/|[a-g]([+-]*|[0-7]))', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '\bbm\b(\s+with\s+staff\s+(below|above)\b)?'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bbm\\b(\\s+with\\s+staff\\s+(below|above)\\b)?', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '\bes?bm\b'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bes?bm\\b', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '\balt\s+[1-9]\b'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\balt\\s+[1-9]\\b', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # String => '\bhs\s+'
   # attribute => 'Note Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bhs\\s+', 0, 0, 0, undef, 0, '#stay', 'Note Attribute')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   return 0;
};

sub parseNoteProbably {
   my ($self, $text) = @_;
   # String => '[a-grs]*'
   # attribute => 'Note'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-grs]*', 0, 0, 0, undef, 0, '#pop', 'Note')) {
      return 1
   }
   return 0;
};

sub parseParameter {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => '='
   # context => 'Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, 'Value', 'Normal Text')) {
      return 1
   }
   # String => '\s+'
   # attribute => 'Parameter'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Parameter')) {
      return 1
   }
   return 0;
};

sub parsePrintCommand {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # String => 'mupfontstyles'
   # attribute => 'Print Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontstyles', 0, undef, 0, '#stay', 'Print Command')) {
      return 1
   }
   # String => '\bnl\b'
   # attribute => 'Print Command'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bnl\\b', 0, 0, 0, undef, 0, '#stay', 'Print Command')) {
      return 1
   }
   # String => '\([0-9]+\)'
   # attribute => 'Print Command'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\([0-9]+\\)', 0, 0, 0, undef, 0, '#pop', 'Print Command')) {
      return 1
   }
   return 0;
};

sub parseSpecialChar {
   my ($self, $text) = @_;
   # attribute => 'String Special'
   # char => ')'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#pop', 'String Special')) {
      return 1
   }
   # String => 'mupspecialchars'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupspecialchars', 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => 'mupmusicchars'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupmusicchars', 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[AaEeOo]['`:^~](?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[AaEeOo][\'`:^~](?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[IiUu]['`:^](?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[IiUu][\'`:^](?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[Nn]~(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[Nn]~(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[Yy]:(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[Yy]:(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[LlOo]/(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[LlOo]/(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[Cc],(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[Cc],(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '(>>|<<|``|'')(?=\))'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(>>|<<|``|\'\')(?=\\))', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[^)"]+'
   # attribute => 'String Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^)"]+', 0, 0, 0, undef, 0, '#stay', 'String Error')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # String => '[\\][][{}%#"nb|^:,\\/ ]'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\\\][][{}%#"nb|^:,\\\\/ ]', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '\('
   # attribute => 'String Special'
   # context => 'Special Char'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\(', 0, 0, 0, undef, 0, 'Special Char', 'String Special')) {
      return 1
   }
   # String => '\f('
   # attribute => 'String Special'
   # context => 'Font Name'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\f(', 0, 0, 0, undef, 0, 'Font Name', 'String Special')) {
      return 1
   }
   # String => '\s('
   # attribute => 'String Special'
   # context => 'Font Size'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\\s(', 0, 0, 0, undef, 0, 'Font Size', 'String Special')) {
      return 1
   }
   # String => '\\v\(-?[0-9]{1,3}\)'
   # attribute => 'String Special'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\\\v\\(-?[0-9]{1,3}\\)', 0, 0, 0, undef, 0, '#stay', 'String Special')) {
      return 1
   }
   # String => '[~<>|^]'
   # attribute => 'String Lyrics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[~<>|^]', 0, 0, 0, undef, 0, '#stay', 'String Lyrics')) {
      return 1
   }
   # String => '[-+]?[0-9]+\|'
   # attribute => 'String Lyrics'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[-+]?[0-9]+\\|', 0, 0, 0, undef, 0, '#stay', 'String Lyrics')) {
      return 1
   }
   return 0;
};

sub parseTuplet {
   my ($self, $text) = @_;
   # String => '\s*(above|below)?\s*[0-9]{1,2}(y|n|num)?(\s*,\s*[0-9]{1,2}\.?([+][0-9]{1,2}\.?)*)?'
   # attribute => 'Tuplet'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*(above|below)?\\s*[0-9]{1,2}(y|n|num)?(\\s*,\\s*[0-9]{1,2}\\.?([+][0-9]{1,2}\\.?)*)?', 0, 0, 0, undef, 0, '#pop', 'Tuplet')) {
      return 1
   }
   return 0;
};

sub parseUnset {
   my ($self, $text) = @_;
   # String => 'mupparameters'
   # attribute => 'Parameter'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupparameters', 0, undef, 0, '#stay', 'Parameter')) {
      return 1
   }
   # String => '[\s,]+'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\s,]+', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '\w+'
   # attribute => 'Error'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\w+', 0, 0, 0, undef, 0, '#pop', 'Error')) {
      return 1
   }
   return 0;
};

sub parseValue {
   my ($self, $text) = @_;
   # attribute => 'Normal Text'
   # char => ';'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # String => '[\s,&()-]+'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\s,&()-]+', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => 'mupvalues'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupvalues', 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # String => 'mupfontnames'
   # attribute => 'Value'
   # context => '#pop'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontnames', 0, undef, 0, '#pop', 'Value')) {
      return 1
   }
   # String => 'mupfontstyles'
   # attribute => 'Value'
   # context => '#pop'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mupfontstyles', 0, undef, 0, '#pop', 'Value')) {
      return 1
   }
   # String => '\b[1-9][0-9]*/(1|2|4|8|16|32|64|128)n?\b'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[1-9][0-9]*/(1|2|4|8|16|32|64|128)n?\\b', 0, 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # String => '\b[a-g][#&]?'?([0-9]\b)?'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b[a-g][#&]?\'?([0-9]\\b)?', 0, 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # String => '[0-7][#&]'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[0-7][#&]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # String => 'r\b'
   # attribute => 'Value'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'r\\b', 0, 0, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # attribute => 'Value'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # attribute => 'Value'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Value')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # context => 'Macro'
   # type => 'IncludeRules'
   if ($self->includeRules('Macro', $text)) {
      return 1
   }
   # String => '[a-z][a-z0-9]*'
   # attribute => 'Error'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-z][a-z0-9]*', 0, 0, 0, undef, 0, '#stay', 'Error')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Music_Publisher - a Plugin for Music Publisher syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Music_Publisher;
 my $sh = new Syntax::Highlight::Engine::Kate::Music_Publisher([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Music_Publisher is a  plugin module that provides syntax highlighting
for Music Publisher to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author