#!/usr/bin/perl -w

use strict;
use warnings;

my @files;

traverse ($ENV{DOCUMENT_ROOT});

print "<!DOCTYPE html>
<html>

	<head>
		<title>Environment and \@INC array</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<style type='text/css'>body {text-align: left}</style>
	</head>

	<body>
		<p align='center'><font size='5'>DOCUMENT_ROOT Recursive File Lister</font></p>\n";

foreach my $file (@files) {
	print "$file<br>";
	open (my $filehandle, "<", $file);
}

print "\n</body>

</html>\n";

sub traverse {
	my ($entry) = @_;

	return if not -d $entry;
	opendir (my $directory_handle, $entry) or die $!;
	while (my $subentry = readdir $directory_handle) {
		next if $subentry eq '.' or $subentry eq '..';
		my $full_path = $entry."/".$subentry;
		if (-f $full_path) {
			$full_path =~ s/\/\//\//;
			push @files, $full_path;
		}
		traverse ("$entry/$subentry");
	}
	close $directory_handle;

	return;
}
