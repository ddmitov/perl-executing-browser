#!/usr/bin/perl -w

use strict;
use warnings;

# Read input:
my ($buffer, @pairs, $pair, $name, $value);
read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

my $filename;

# Split information into name/value pairs:
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;

	if ($name =~ "filename") {
		$filename = $value;
	}
}

open my $filehandle, '<', $filename or die "Unable to open file: $!";
$/ = undef;
my $file_contents = <$filehandle>;
close $filehandle;

print "<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - Open File</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<link rel='stylesheet' type='text/css' href='http://perl-executing-browser-pseudodomain/bootstrap/css/themes/darkly-theme.css' media='all'/>
		<style type='text/css'>pre {text-align: left}</style>
	</head>

	<body>

		<p align='center'><font size='4'>$filename</font></p>

		<pre>\n";

print $file_contents;

print "</pre>

	</body>

</html>\n";
