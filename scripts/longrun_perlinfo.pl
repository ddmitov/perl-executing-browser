#!/usr/bin/perl -w

use HTML::Perlinfo;

my $info_page = perlinfo (INFO_GENERAL);
$info_page =~ s/\<\!--//ig;
$info_page =~ s/\>--//ig;
print $info_page;
