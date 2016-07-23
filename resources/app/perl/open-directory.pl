#!/usr/bin/perl -w

use strict;
use warnings;

# Read input:
my ($buffer, @pairs, $pair, $name, $value);
read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

my @files;
my $directory_name;

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
		<title>Perl Executing Browser - Open File</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<link rel='stylesheet' type='text/css' href='http://perl-executing-browser-pseudodomain/bootstrap/css/themes/darkly-theme.css' media='all'/>
		<style type='text/css'>pre {text-align: left}</style>
	</head>

	<body>

		<p align='center'><font size='4'>$directory_name</font></p>

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
		my $full_path = $entry."/".$subentry;
		if (-f $full_path) {
			push @files, $full_path;
		}
		traverse ("$entry/$subentry");
	}
	close $directory_handle;

	return;
}
