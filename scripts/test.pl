#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT QUERY_STRING REQUEST_METHOD);
use CGI qw(:standard);

print "<br>TEST<br>\n";

print "<br><a href='local://script/startpage.pl'>Back to the dynamic startpage</a><br>\n";

print "<br>FILE AND/OR FOLDER TO OPEN:<br>\n";
if (defined @ARGV){
	my ($file, $folder) = @ARGV;
	print "ARGV 0 - FILE: $file<br>\n";
	print "ARGV 1 - FOLDER: $folder<br>\n";
}

print "<br>FORM DATA:<br>\n";
my %form;
foreach my $p (param()) {
	$form{$p} = param($p);
	print "$p = $form{$p}<br>\n";
}

print "<br>ENVIRONMENT:<br>\n";
if (defined $PATH){
	print "PATH = $PATH<br>\n";
}
if (defined $PERL5LIB){
	print "PERL5LIB = $PERL5LIB<br>\n";
}
if (defined $DOCUMENT_ROOT){
	print "DOCUMENT_ROOT = $DOCUMENT_ROOT<br>\n";
}
if (defined $QUERY_STRING){
	print "QUERY_STRING = $QUERY_STRING<br>\n";
}
if (defined $REQUEST_METHOD){
	print "REQUEST_METHOD = $REQUEST_METHOD<br>\n";
}

#~ foreach my $key (sort(keys(%ENV))) {
	#~ print "$key = $ENV{$key}<br>\n";
#~ }
