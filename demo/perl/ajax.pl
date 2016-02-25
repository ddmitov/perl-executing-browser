#!/usr/bin/perl -w

use strict;
use warnings;

my @files;

traverse ($ENV{DOCUMENT_ROOT});

print join(",", @files);

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
