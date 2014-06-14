#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT FILE_TO_OPEN FILE_TO_CREATE FOLDER_TO_OPEN QUERY_STRING REQUEST_METHOD CONTENT_LENGTH);
use CGI qw (:standard);

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

print "<p align='left'><font size='3' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/index.pl'>Back to the dynamic startpage</a>\n";
print "</font></p>\n";

print "<p align='left'><font size='3' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/index.htm'>Back to the static startpage</a>\n";
print "</font></p>\n";

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
print "MODIFIED AND NEW ENVIRONMENT VARIABLES:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";

if (defined $PATH){
	print "PATH = $PATH<br>\n";
}
if (defined $DOCUMENT_ROOT){
	print "DOCUMENT_ROOT = $DOCUMENT_ROOT<br>\n";
}
if (defined $FILE_TO_OPEN){
	print "FILE_TO_OPEN = $FILE_TO_OPEN<br>\n";
}
if (defined $FILE_TO_CREATE){
	print "FILE_TO_CREATE = $FILE_TO_CREATE<br>\n";
}
if (defined $FOLDER_TO_OPEN){
	print "FOLDER_TO_OPEN = $FOLDER_TO_OPEN<br>\n";
}
if (defined $PERL5LIB){
	print "PERL5LIB = $PERL5LIB<br>\n";
}
if (defined $QUERY_STRING){
	print "QUERY_STRING = $QUERY_STRING<br>\n";
}
if (defined $REQUEST_METHOD){
	print "REQUEST_METHOD = $REQUEST_METHOD<br>\n";
}
if (defined $CONTENT_LENGTH){
	print "CONTENT_LENGTH = $CONTENT_LENGTH<br>\n";
}

print "</font></p>\n";

print "<p align='left'><font size='4' face='SansSerif'>\n";
print "ALL ENVIRONMENT VARIABLES:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";

foreach my $key (sort(keys(%ENV))) {
	print "$key = $ENV{$key}<br>\n";
}

print "</font></p>\n";

print "</body>\n";
print "</html>\n";
