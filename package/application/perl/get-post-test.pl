#!/usr/bin/perl -w

use strict;
use warnings;

print "<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - Test Results</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<link rel='stylesheet' type='text/css' href='http://perl-executing-browser-pseudodomain/bootstrap/css/themes/darkly-theme.css' media='all'/>
	</head>

	<body>

		<p align='center'><font size='5'>
		Test Results
		</font></p>

		<p align='left'><font size='4'>
		FORM DATA:
		</font></p>
		<p align='left'><font size='3'>\n";

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

print "</font></p>

		<p align='left'><font size='4'>
			ENVIRONMENT VARIABLES:
		</font></p>

		<p align='left'><font size='3'>\n";

foreach my $key (sort(keys(%ENV))) {
	print "$key = $ENV{$key}<br>\n";
}

print "</font></p>

	</body>

</html>\n";
