#!/usr/bin/env perl

use Cwd;
use CGI;

use vars '%in';
CGI::ReadParse();

print "Content-Type: text/html\r\n\r\n";

print "<html>\n";

print "<head>\n";

print "<title>Environment Test</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "<link href='../html/current.css' media='all' rel='stylesheet' />\n";

print "</head>\n";

print "<body>\n";


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

print "</body>\n";

print "</html>\n";
 