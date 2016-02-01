#!/usr/bin/env perl

use strict;
use warnings;

#~ use FindBin;
#~ use File::HomeDir;

print "Content-Type: text/html\r\n\r\n";

print "<html>\n";

print "<head>\n";

print "<title>Environment and \@INC array</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "<style type='text/css'>body {text-align: left}</style>\n";
print "</head>\n";

print "<body>";
print "<p align='center'><font size='5' face='SansSerif'>Environment and \@INC array</font></p>";

print "<pre>\n";
foreach my $key (sort keys %ENV) {
	print "$key=$ENV{$key}\n";
}

print "\n";

#~ print "Home:\n";
#~ my $home = File::HomeDir->my_home;
#~ print $home;
#~ print "\n";

#~ print "Script directory:\n";
#~ my $script_directory = $FindBin::Bin;
#~ print $script_directory;
#~ print "\n";

print "\@INC:\n";
print join "\n", @INC;

print "\n";

print "</pre>\n";

print "</body>\n";

print "</html>\n";
