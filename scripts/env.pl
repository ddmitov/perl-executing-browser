#!/usr/bin/env perl

use Cwd;

print "Content-Type: text/html\r\n\r\n";

print "<html>\n";

print "<head>\n";

print "<title>Environment Test</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "<link href='http://perl-executing-browser-pseudodomain/html/current.css' media='all' rel='stylesheet'/>\n";
print "<style type='text/css'>body {text-align: left}</style>\n";
print "</head>\n";

print "<body>";
print "<p align='center'><font size='5' face='SansSerif'>Perl Environment Test</font></p>";

print "<pre>\n";
foreach my $key (sort keys %ENV) {
	print "$key=$ENV{$key}\n";
}

print "\n";

print 'CURRENT_DIR=' . getcwd() . "\n";
print "</pre>\n";

print "</body>\n";

print "</html>\n";
