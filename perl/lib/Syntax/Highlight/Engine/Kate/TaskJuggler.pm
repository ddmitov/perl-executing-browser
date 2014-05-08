# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'taskjuggler.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.21
#kate version 2.1
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::TaskJuggler;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Builtin Function' => 'Function',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Data Types' => 'DataType',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
   });
   $self->listAdd('builtinfuncs',
      'accountid',
      'accountreport',
      'accumulate',
      'allocate',
      'allowredefinitions',
      'alternative',
      'barlabels',
      'booking',
      'caption',
      'celltext',
      'cellurl',
      'columns',
      'complete',
      'completed',
      'copyright',
      'cost',
      'credit',
      'criticalness',
      'csvaccountreport',
      'csvresourcereport',
      'csvtaskreport',
      'currency',
      'currencydigits',
      'currencyformat',
      'dailymax',
      'dailyworkinghours',
      'db',
      'depends',
      'disabled',
      'duration',
      'efficiency',
      'effort',
      'empty',
      'end',
      'endbuffer',
      'endbufferstart',
      'endcredit',
      'endsAfter',
      'endsBefore',
      'export',
      'extend',
      'finished',
      'flags',
      'follows',
      'freeload',
      'gapduration',
      'gaplength',
      'headline',
      'hideaccount',
      'hidecelltext',
      'hidecellurl',
      'hideresource',
      'hidetask',
      'hierarchindex',
      'hierarchno',
      'htmlaccountreport',
      'htmlresourcereport',
      'htmlstatusreport',
      'htmltaskreport',
      'htmlweeklycalendar',
      'id',
      'include',
      'index',
      'inherit',
      'inprogress',
      'journalentry',
      'kotrusid',
      'kotrusmode',
      'label',
      'late',
      'length',
      'limits',
      'load',
      'loadunit',
      'macro',
      'mandatory',
      'maxeffort',
      'maxend',
      'maxstart',
      'milestone',
      'mineffort',
      'minend',
      'minstart',
      'monthlymax',
      'name',
      'no',
      'nokotrus',
      'note',
      'notimestamp',
      'notstarted',
      'now',
      'numberformat',
      'ontime',
      'optimize',
      'order',
      'pathcriticalness',
      'persistent',
      'precedes',
      'priority',
      'profit',
      'projectid',
      'projectids',
      'projection',
      'rate',
      'rawhead',
      'rawstylesheet',
      'rawtail',
      'reference',
      'resourceid',
      'resourcereport',
      'resources',
      'responsibilities',
      'responsible',
      'revenue',
      'rollupaccount',
      'rollupresource',
      'rolluptask',
      'scenario',
      'scenarios',
      'schedule',
      'scheduled',
      'scheduling',
      'select',
      'separator',
      'seqno',
      'shorttimeformat',
      'showprojectids',
      'sortaccounts',
      'sortresources',
      'sorttasks',
      'start',
      'startbuffer',
      'startbufferend',
      'startcredit',
      'startsAfter',
      'startsBefore',
      'status',
      'statusnote',
      'subtitle',
      'subtitleurl',
      'supplement',
      'table',
      'taskattributes',
      'taskid',
      'taskprefix',
      'taskreport',
      'taskroot',
      'text',
      'timeformat',
      'timezone',
      'timingresolution',
      'title',
      'titleurl',
      'total',
      'tree',
      'treeLevel',
      'url',
      'utilization',
      'vacation',
      'version',
      'weeklymax',
      'weekstartsmonday',
      'weekstartssunday',
      'workinghours',
      'xml',
      'xmlreport',
      'yearlyworkingdays',
   );
   $self->listAdd('keywords',
      'account',
      'project',
      'resource',
      'scenario',
      'shift',
      'task',
   );
   $self->listAdd('types',
      'alap',
      'all',
      'asap',
      'completeddown',
      'completedup',
      'containstask',
      'criticalnessdown',
      'criticalnessup',
      'd',
      'daily',
      'day',
      'days',
      'enddown',
      'endup',
      'fri',
      'fullnamedown',
      'fullnameup',
      'h',
      'hours',
      'iddown',
      'idup',
      'indexdown',
      'indexup',
      'inprogressearly',
      'inprogresslate',
      'isAResource',
      'isATask',
      'isAccount',
      'isAllocated',
      'isAllocatedToProject',
      'isAnAccount',
      'isChildOf',
      'isDutyOf',
      'isLeaf',
      'isMilestone',
      'isParentOf',
      'isResource',
      'isTask',
      'isTaskOfProject',
      'isTaskStatus',
      'isactualallocated',
      'isatask',
      'isplanallocated',
      'issubtaskof',
      'kotrusiddown',
      'kotrusidup',
      'longauto',
      'm',
      'maxeffortdown',
      'maxeffortup',
      'maxloaded',
      'min',
      'minallocated',
      'mineffortdown',
      'mineffortup',
      'minloaded',
      'minutes',
      'mon',
      'month',
      'monthly',
      'months',
      'namedown',
      'nameup',
      'off',
      'pathcriticalnessdown',
      'pathcriticalnessup',
      'prioritydown',
      'priorityup',
      'quarter',
      'quarterly',
      'random',
      'ratedown',
      'rateup',
      'responsibledown',
      'responsibleup',
      'sat',
      'sequencedown',
      'sequenceup',
      'shortauto',
      'startdown',
      'startup',
      'statusdown',
      'statusup',
      'sun',
      'thu',
      'tue',
      'undefined',
      'w',
      'wed',
      'week',
      'weekly',
      'weeks',
      'y',
      'year',
      'yearly',
      'years',
   );
   $self->contextdata({
      'Comment1' => {
         callback => \&parseComment1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Comment2' => {
         callback => \&parseComment2,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String1' => {
         callback => \&parseString1,
         attribute => 'String',
      },
      'String2' => {
         callback => \&parseString2,
         attribute => 'String',
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
   return 'TaskJuggler';
}

sub parseComment1 {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseComment2 {
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

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'builtinfuncs'
   # attribute => 'Builtin Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'builtinfuncs', 0, undef, 0, '#stay', 'Builtin Function')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Types'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Types')) {
      return 1
   }
   # attribute => 'Symbol'
   # beginRegion => 'Brace2'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Symbol'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Symbol'
   # beginRegion => 'Brace1'
   # char => '['
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Symbol'
   # char => ']'
   # context => '#stay'
   # endRegion => 'Brace1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ']', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # items => 'ARRAY(0x1782620)'
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
   # attribute => 'Decimal'
   # context => '#stay'
   # items => 'ARRAY(0x16a0c30)'
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
   # attribute => 'String'
   # char => '''
   # context => 'String1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String1', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String2'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String2', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '#'
   # context => 'Comment1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Comment1', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Comment2'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Comment2', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseString1 {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};

sub parseString2 {
   my ($self, $text) = @_;
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

Syntax::Highlight::Engine::Kate::TaskJuggler - a Plugin for TaskJuggler syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::TaskJuggler;
 my $sh = new Syntax::Highlight::Engine::Kate::TaskJuggler([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::TaskJuggler is a  plugin module that provides syntax highlighting
for TaskJuggler to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author