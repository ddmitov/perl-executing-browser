# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'email.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.00
#kate version 2.4
#kate author Carl A Joslin (carl.joslin@joslin.dyndns.org)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Email;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Normal Text' => 'Normal',
      'base64' => 'RegionMarker',
      'common' => 'Keyword',
      'email' => 'Function',
      'indent1' => 'DataType',
      'indent2' => 'DecVal',
      'indent3' => 'Float',
      'indent4' => 'BaseN',
      'indent5' => 'BString',
      'indent6' => 'Reserved',
      'marker' => 'Alert',
      'other' => 'Others',
      'rfc' => 'Operator',
      'rfc-main' => 'Alert',
      'sign' => 'Comment',
      'string' => 'String',
   });
   $self->contextdata({
      'headder' => {
         callback => \&parseheadder,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('headder');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Email';
}

sub parseheadder {
   my ($self, $text) = @_;
   # String => '^[Tt]o:.*$'
   # attribute => 'rfc-main'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Tt]o:.*$', 0, 0, 0, undef, 0, '#stay', 'rfc-main')) {
      return 1
   }
   # String => '^[Ff]rom:.*$'
   # attribute => 'rfc-main'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ff]rom:.*$', 0, 0, 0, undef, 0, '#stay', 'rfc-main')) {
      return 1
   }
   # String => '^[Cc][Cc]:.*$'
   # attribute => 'rfc-main'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Cc][Cc]:.*$', 0, 0, 0, undef, 0, '#stay', 'rfc-main')) {
      return 1
   }
   # String => '^[Bb][Cc][Cc]:.*$'
   # attribute => 'rfc-main'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Bb][Cc][Cc]:.*$', 0, 0, 0, undef, 0, '#stay', 'rfc-main')) {
      return 1
   }
   # String => '^[Ss]ubject:.*$'
   # attribute => 'rfc-main'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ss]ubject:.*$', 0, 0, 0, undef, 0, '#stay', 'rfc-main')) {
      return 1
   }
   # String => '^[Dd]ate:.*$'
   # attribute => 'rfc-main'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Dd]ate:.*$', 0, 0, 0, undef, 0, '#stay', 'rfc-main')) {
      return 1
   }
   # String => '^[Ss]ender:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ss]ender:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]eply-[Tt]o:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]eply-[Tt]o:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Mm]essage-[Ii][Dd]:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Mm]essage-[Ii][Dd]:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Ii]n-[Rr]eply-[Tt]o:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ii]n-[Rr]eply-[Tt]o:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]eferences:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]eferences:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Cc]omments:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Cc]omments:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Kk]eywors:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Kk]eywors:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Dd]ate:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Dd]ate:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Ff]rom:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Ff]rom:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Ss]ender:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Ss]ender:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Tt]o:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Tt]o:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Cc][Cc]:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Cc][Cc]:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Bb][Cc][Cc]:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Bb][Cc][Cc]:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Mm]essage-[Ii][Dd]:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Mm]essage-[Ii][Dd]:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]esent-[Rr]eply-[Tt]o:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]esent-[Rr]eply-[Tt]o:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]eturn-[Pp]ath:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]eturn-[Pp]ath:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Rr]eceived:'
   # attribute => 'rfc'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Rr]eceived:', 0, 0, 0, undef, 0, '#stay', 'rfc')) {
      return 1
   }
   # String => '^[Xx]-[Mm]ozilla-[Ss]tatus:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Mm]ozilla-[Ss]tatus:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Xx]-[Mm]ozilla-[Ss]tatus2:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Mm]ozilla-[Ss]tatus2:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Ee]nverlope-[Tt]o:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ee]nverlope-[Tt]o:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Dd]elivery-[Dd]ate:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Dd]elivery-[Dd]ate:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Xx]-[Oo]riginating-[Ii][Pp]:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Oo]riginating-[Ii][Pp]:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Xx]-[Oo]riginating-[Ee]mail:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Oo]riginating-[Ee]mail:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Xx]-[Ss]ender:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Ss]ender:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Mm]ime-[Vv]ersion:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Mm]ime-[Vv]ersion:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Cc]ontent-[Tt]ype:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Cc]ontent-[Tt]ype:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Xx]-[Mm]ailing-[Ll]ist:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Mm]ailing-[Ll]ist:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Xx]-[Ll]oop:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Ll]oop:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Ll]ist-[Pp]ost:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ll]ist-[Pp]ost:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Ll]ist-[Hh]elp:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ll]ist-[Hh]elp:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Ll]ist-[Uu]nsubscribe:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Ll]ist-[Uu]nsubscribe:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Pp]recedence:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Pp]recedence:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Cc]ontent-[Tt]ransfer-[Ee]ncoding:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Cc]ontent-[Tt]ransfer-[Ee]ncoding:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Cc]ontent-[Tt]ype:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Cc]ontent-[Tt]ype:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Xx]-[Bb]ulkmail:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Xx]-[Bb]ulkmail:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Pp]recedence:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Pp]recedence:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[Cc]ontent-[Dd]isposition:'
   # attribute => 'common'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[Cc]ontent-[Dd]isposition:', 0, 0, 0, undef, 0, '#stay', 'common')) {
      return 1
   }
   # String => '^[0-9a-zA-Z-.]+:'
   # attribute => 'other'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[0-9a-zA-Z-.]+:', 0, 0, 0, undef, 0, '#stay', 'other')) {
      return 1
   }
   # String => '[a-zA-Z0-9.\-]+\@[a-zA-Z0-9.\-]+'
   # attribute => 'email'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z0-9.\\-]+\\@[a-zA-Z0-9.\\-]+', 0, 0, 0, undef, 0, '#stay', 'email')) {
      return 1
   }
   # String => '[a-zA-Z0-9.\-]*\s*<[a-zA-Z0-9.\-]+\@[a-zA-Z0-9.\-]+>'
   # attribute => 'email'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z0-9.\\-]*\\s*<[a-zA-Z0-9.\\-]+\\@[a-zA-Z0-9.\\-]+>', 0, 0, 0, undef, 0, '#stay', 'email')) {
      return 1
   }
   # String => '"[a-zA-Z0-9. \-]+"\s*<[a-zA-Z0-9.\-]+\@[a-zA-Z0-9.\-]+>'
   # attribute => 'email'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '"[a-zA-Z0-9. \\-]+"\\s*<[a-zA-Z0-9.\\-]+\\@[a-zA-Z0-9.\\-]+>', 0, 0, 0, undef, 0, '#stay', 'email')) {
      return 1
   }
   # String => '".*"'
   # attribute => 'string'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '".*"', 0, 0, 0, undef, 0, '#stay', 'string')) {
      return 1
   }
   # String => ''.*''
   # attribute => 'string'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\'.*\'', 0, 0, 0, undef, 0, '#stay', 'string')) {
      return 1
   }
   # String => '^[|>]\s*[|>]\s*[|>]\s*[|>]\s*[|>]\s*[|>].*'
   # attribute => 'indent6'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[|>]\\s*[|>]\\s*[|>]\\s*[|>]\\s*[|>]\\s*[|>].*', 0, 0, 0, undef, 0, '#stay', 'indent6')) {
      return 1
   }
   # String => '^[|>]\s*[|>]\s*[|>]\s*[|>]\s*[|>].*'
   # attribute => 'indent5'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[|>]\\s*[|>]\\s*[|>]\\s*[|>]\\s*[|>].*', 0, 0, 0, undef, 0, '#stay', 'indent5')) {
      return 1
   }
   # String => '^[|>]\s*[|>]\s*[|>]\s*[|>].*'
   # attribute => 'indent4'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[|>]\\s*[|>]\\s*[|>]\\s*[|>].*', 0, 0, 0, undef, 0, '#stay', 'indent4')) {
      return 1
   }
   # String => '^[|>]\s*[|>]\s*[|>].*'
   # attribute => 'indent3'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[|>]\\s*[|>]\\s*[|>].*', 0, 0, 0, undef, 0, '#stay', 'indent3')) {
      return 1
   }
   # String => '^[|>]\s*[|>].*'
   # attribute => 'indent2'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[|>]\\s*[|>].*', 0, 0, 0, undef, 0, '#stay', 'indent2')) {
      return 1
   }
   # String => '^[|>].*'
   # attribute => 'indent1'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[|>].*', 0, 0, 0, undef, 0, '#stay', 'indent1')) {
      return 1
   }
   # String => '^([A-Za-z0-9+/][A-Za-z0-9+/][A-Za-z0-9+/][A-Za-z0-9+/]){10,20}$'
   # attribute => 'base64'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^([A-Za-z0-9+/][A-Za-z0-9+/][A-Za-z0-9+/][A-Za-z0-9+/]){10,20}$', 0, 0, 0, undef, 0, '#stay', 'base64')) {
      return 1
   }
   # String => '^[A-Za-z0-9+=/]+=$'
   # attribute => 'base64'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^[A-Za-z0-9+=/]+=$', 0, 0, 0, undef, 0, '#stay', 'base64')) {
      return 1
   }
   # String => '^(- )?--(--.*)?'
   # attribute => 'marker'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^(- )?--(--.*)?', 0, 0, 0, undef, 0, '#stay', 'marker')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Email - a Plugin for Email syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Email;
 my $sh = new Syntax::Highlight::Engine::Kate::Email([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Email is a  plugin module that provides syntax highlighting
for Email to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author