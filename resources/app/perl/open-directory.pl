#!/usr/bin/perl -w

use strict;
use warnings;

my @files;
my $directory_name;
my $path_separator;

# Determine the right path separator:
if ($^O eq "MSWin32") {
	$path_separator = "\\";
} else {
	$path_separator = "/";
}

# Read input:
my ($buffer, @pairs, $pair, $name, $value);
read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

# Split information into name/value pairs:
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;

	if ($name =~ "directoryname") {
		$directory_name = $value;
	}
}

traverse ($directory_name);

print "<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - Open Directory Test</title>
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
			$directory_name
		</p>

		<pre>\n";

foreach my $file (@files) {
	print "$file<br>";
}

print "</pre>

	</body>

</html>\n";

sub traverse {
	my ($entry) = @_;

	return if not -d $entry;
	opendir (my $directory_handle, $entry) or die $!;
	while (my $subentry = readdir $directory_handle) {
		next if $subentry eq '.' or $subentry eq '..';
		my $full_path = $entry.$path_separator.$subentry;
		if (-f $full_path) {
			push @files, $full_path;
		}
		traverse ("$entry$path_separator$subentry");
	}
	close $directory_handle;

	return;
}
