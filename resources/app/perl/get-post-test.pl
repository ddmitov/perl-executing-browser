#!/usr/bin/perl

use strict;
use warnings;

print "<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - GET or POST Test</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<link rel='stylesheet' type='text/css' href='http://local-pseudodomain/bootstrap/css/themes/darkly-theme.css' media='all'>
		<style type='text/css'>
			body {
				text-align: left;
				font-size: 22px;
				-webkit-text-size-adjust: 100%;
			}
			pre {
				font-size: 14px;
				font-family: monospace;
			}
		</style>
	</head>

	<body>
		<p align='center'>
			GET and POST Test
		</p>
<pre>
FORM DATA:\n";

# Read input:
my ($buffer, @pairs, $pair, $name, $value);
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
	print "$name = $value\n";
}

print "\nENVIRONMENT VARIABLES:\n";

foreach my $key (sort(keys(%ENV))) {
	print "$key = $ENV{$key}\n";
}

print "</pre>

	</body>

</html>\n";
