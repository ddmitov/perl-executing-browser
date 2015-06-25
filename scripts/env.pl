#!/usr/bin/env perl

use strict;
use warnings;
use Cwd;

print "Content-Type: text/html\r\n\r\n";

print "<html>\n";

print "<head>\n";

print "<title>Environment and \@INC array</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "<link href='http://perl-executing-browser-pseudodomain/html/current.css' media='all' rel='stylesheet'/>\n";
print "<style type='text/css'>body {text-align: left}</style>\n";
print "</head>\n";

print "<body>";
print "<p align='center'><font size='5' face='SansSerif'>Environment and \@INC array</font></p>";

print "<pre>\n";
foreach my $key (sort keys %ENV) {
	print "$key=$ENV{$key}\n";
}

print "\n";

print "\@INC:\n";
print join "\n", @INC;

print "\n";

print 'CURRENT_DIR='.getcwd()."\n";
print "</pre>\n";

print "</body>\n";

print "</html>\n";
