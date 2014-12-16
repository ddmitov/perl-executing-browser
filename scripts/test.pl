#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT FILE_TO_OPEN FILE_TO_CREATE FOLDER_TO_OPEN QUERY_STRING REQUEST_METHOD CONTENT_LENGTH);
use CGI::Simple::Standard qw (:standard);

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

my %form;
foreach my $p (param()) {
	$form{$p} = param($p);
	print "$p = $form{$p}<br>\n";
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
