#!/usr/bin/perl -w

use strict;
use warnings;

print "Content-type: text/html; charset=utf-8\n\n";

print "<html>\n";

print "<head>\n";

print "<title>Perl Executing Browser - Test Results</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";

print "</head>\n";

print "<body>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "Test Results\n";
print "</font></p>\n";

print "<p align='left'><font size='4' face='SansSerif'>\n";
print "FORM DATA:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";

# Read input:
my ($buffer, @pairs, $pair, $name, $value, %FORM);
$ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
if ($ENV{'REQUEST_METHOD'} eq "POST") {
	read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
} else {
	$buffer = $ENV{'QUERY_STRING'};
}

# Split information into name/value pairs:
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;
	$FORM{$name} = $value;
	print "$name = $value<br>\n";
}

print "</font></p>\n";

print "<p align='left'><font size='4' face='SansSerif'>\n";
print "ENVIRONMENT VARIABLES:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";

foreach my $key (sort(keys(%ENV))) {
	print "$key = $ENV{$key}<br>\n";
}

print "</font></p>\n";

print "</body>\n";
print "</html>\n";
