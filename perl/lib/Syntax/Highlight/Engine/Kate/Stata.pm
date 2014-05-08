# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'stata.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.01
#kate version 2.1
#kate author Edwin Leuven (e.leuven@uva.nl)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Stata;

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
      'Data Type' => 'DataType',
      'Keyword' => 'Keyword',
      'Macro' => 'Others',
      'Normal Text' => 'Normal',
      'String' => 'String',
      'String Char' => 'Char',
   });
   $self->listAdd('keywords',
      '_pctile',
      'about',
      'adjust',
      'ado',
      'alpha',
      'anova',
      'anovadef',
      'append',
      'arch',
      'areg',
      'args',
      'arima',
      'assert',
      'bar',
      'binreg',
      'biprobit',
      'bitest',
      'boxcox',
      'break',
      'brier',
      'browse',
      'bstrap',
      'by',
      'canon',
      'cap',
      'capture',
      'cat',
      'cd',
      'centile',
      'cf',
      'checksum',
      'ci',
      'class',
      'clavg',
      'clcomp',
      'clear',
      'clgen',
      'clist',
      'clkmeans',
      'clkmed',
      'clnote',
      'clogit',
      'cloglog',
      'clsing',
      'cltree',
      'cluster',
      'clutil',
      'cmdlog',
      'cnreg',
      'cnsreg',
      'codebook',
      'collapse',
      'compare',
      'compress',
      'confirm',
      'constraint',
      'continue',
      'contract',
      'copy',
      'copyright',
      'corr',
      'corr2data',
      'correlate',
      'corrgram',
      'count',
      'cox',
      'creturn',
      'cross',
      'ct',
      'ctset',
      'cttost',
      'cumsp',
      'cumul',
      'cusum',
      'datatypes',
      'decode',
      'define',
      'describe',
      'destring',
      'dfuller',
      'di',
      'diagplots',
      'dir',
      'discard',
      'display',
      'do',
      'doedit',
      'dotplot',
      'drawnorm',
      'drop',
      'dstdize',
      'edit',
      'egen',
      'eivreg',
      'else',
      'encode',
      'end',
      'epitab',
      'erase',
      'ereturn',
      'exit',
      'expand',
      'export',
      'factor',
      'fdadescribe',
      'fdasave',
      'fdause',
      'file',
      'filefilter',
      'fillin',
      'flist',
      'for',
      'foreach',
      'format',
      'forv',
      'forval',
      'forvalues',
      'fracpoly',
      'g',
      'gen',
      'generate',
      'gettoken',
      'glm',
      'glogit',
      'gprefs',
      'gr',
      'gr7',
      'graph',
      'graph7',
      'grmeanby',
      'gsort',
      'hadimvo',
      'hausman',
      'haver',
      'heckman',
      'heckprob',
      'help',
      'hetprob',
      'hexdump',
      'hilite',
      'hist',
      'hotel',
      'icd9',
      'if',
      'impute',
      'in',
      'infile',
      'infile1',
      'infile2',
      'infiling',
      'infix',
      'input',
      'insheet',
      'inspect',
      'ipolate',
      'ivreg',
      'jknife',
      'joinby',
      'kappa',
      'kdensity',
      'keep',
      'ksm',
      'ksmirnov',
      'kwallis',
      'label',
      'ladder',
      'levels',
      'lfit',
      'limits',
      'lincom',
      'line',
      'linktest',
      'list',
      'lnskew0',
      'log',
      'logistic',
      'logit',
      'loneway',
      'lowess',
      'lroc',
      'lrtest',
      'lsens',
      'lstat',
      'ltable',
      'lv',
      'manova',
      'manovatest',
      'mark',
      'markin',
      'markout',
      'marksample',
      'matsize',
      'maximize',
      'means',
      'median',
      'memory',
      'merge',
      'mfx',
      'mkdir',
      'mkspline',
      'ml',
      'mleval',
      'mlmatbysum',
      'mlmatsum',
      'mlogit',
      'mlsum',
      'mlvecsum',
      'more',
      'move',
      'mvencode',
      'mvreg',
      'nbreg',
      'net',
      'newey',
      'news',
      'nl',
      'nlogit',
      'nobreak',
      'nois',
      'noisily',
      'notes',
      'nptrend',
      'numlist',
      'obs',
      'odbc',
      'ologit',
      'oneway',
      'oprobit',
      'order',
      'orthog',
      'outfile',
      'outsheet',
      'parse',
      'pcorr',
      'pctile',
      'pergram',
      'pk',
      'pkcollapse',
      'pkcross',
      'pkequiv',
      'pkexamine',
      'pkshape',
      'pksumm',
      'plot',
      'poisson',
      'post',
      'postclose',
      'postfile',
      'postutil',
      'pperron',
      'prais',
      'predict',
      'preserve',
      'probit',
      'program',
      'prtest',
      'pwcorr',
      'qc',
      'qreg',
      'quadchk',
      'query',
      'qui',
      'quietly',
      'range',
      'ranksum',
      'recast',
      'recode',
      'reg',
      'reg3',
      'regdiag',
      'regress',
      'rename',
      'replace',
      'reshape',
      'restore',
      'return',
      'roc',
      'rocplot',
      'rotate',
      'rreg',
      'run',
      'runtest',
      'sample',
      'sampsi',
      'save',
      'scatter',
      'scobit',
      'score',
      'sdtest',
      'search',
      'separate',
      'serrbar',
      'set',
      'shell',
      'signrank',
      'signtest',
      'simul',
      'sktest',
      'smooth',
      'snapspan',
      'sort',
      'spearman',
      'spikeplot',
      'sreturn',
      'st',
      'stack',
      'statsby',
      'stb',
      'stbase',
      'stci',
      'stcox',
      'stdes',
      'stem',
      'stfill',
      'stgen',
      'stir',
      'stphplot',
      'stptime',
      'strate',
      'streg',
      'sts',
      'stset',
      'stsplit',
      'stsum',
      'sttocc',
      'sttoct',
      'stvary',
      'sum',
      'summarize',
      'sureg',
      'svy',
      'svydes',
      'svylc',
      'svymean',
      'svyset',
      'svytab',
      'svytest',
      'sw',
      'swilk',
      'symmetry',
      'syntax',
      'tab',
      'tabdisp',
      'table',
      'tabstat',
      'tabsum',
      'tabulate',
      'tempfile',
      'tempname',
      'tempvar',
      'test',
      'testnl',
      'tobit',
      'tokenize',
      'translate',
      'translator',
      'transmap',
      'treatreg',
      'truncreg',
      'tsreport',
      'tsrevar',
      'tsset',
      'ttest',
      'tutorials',
      'twoway',
      'type',
      'unabbr',
      'unabcmd',
      'update',
      'use',
      'using',
      'vce',
      'version',
      'view',
      'vwls',
      'weibull',
      'whelp',
      'which',
      'while',
      'wntestb',
      'wntestq',
      'xcorr',
      'xi',
      'xpose',
      'xt',
      'xtabond',
      'xtclog',
      'xtdata',
      'xtdes',
      'xtgee',
      'xtgls',
      'xtile',
      'xtintreg',
      'xtivreg',
      'xtlogit',
      'xtnbreg',
      'xtpcse',
      'xtpois',
      'xtprobit',
      'xtrchh',
      'xtreg',
      'xtregar',
      'xtsum',
      'xttab',
      'xttobit',
      'zip',
   );
   $self->listAdd('types',
      'char',
      'double',
      'error',
      'float',
      'global',
      'int',
      'local',
      'long',
      'macro',
      'mat',
      'matrix',
      'result',
      'scalar',
      'text',
      'var',
      'variable',
      'varlist',
      'varname',
   );
   $self->contextdata({
      'Comment 1' => {
         callback => \&parseComment1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Comment 2' => {
         callback => \&parseComment2,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'string' => {
         callback => \&parsestring,
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
   return 'Stata';
}

sub parseComment1 {
   my ($self, $text) = @_;
   return 0;
};

sub parseComment2 {
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
   # attribute => 'String'
   # char => '"'
   # context => 'string'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'string', 'String')) {
      return 1
   }
   # attribute => 'Macro'
   # char => '`'
   # char1 => '''
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '`', '\'', 0, 0, undef, 0, '#stay', 'Macro')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Comment 1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Comment 1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Comment 2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Comment 2', 'Comment')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'block'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'block'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parsestring {
   my ($self, $text) = @_;
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
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Stata - a Plugin for Stata syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Stata;
 my $sh = new Syntax::Highlight::Engine::Kate::Stata([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Stata is a  plugin module that provides syntax highlighting
for Stata to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author