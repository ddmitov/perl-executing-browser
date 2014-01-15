#!/usr/bin/env perl

use Cwd;
use CGI;

use vars '%in';
CGI::ReadParse();

print "Content-Type: text/html\r\n\r\n";

print "<pre>\n";
foreach my $key (sort keys %ENV) {
	print "$key=$ENV{$key}\n";
}

print "\n";

foreach my $key (sort keys %in) {
	print "$key=$in{$key}\n";
}

print "\n";

print 'CURRENT_DIR=' . getcwd() . "\n";
print "</pre>\n";
