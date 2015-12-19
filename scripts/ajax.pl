#!/usr/bin/perl -w

use strict;
use warnings;

my $DOCUMENT_ROOT = $ENV{'DOCUMENT_ROOT'};

my @file_entries;
opendir (my $direstory_handle, $DOCUMENT_ROOT) or die $!;
while (my $name = readdir ($direstory_handle)) {
	# Only files are selected:
	next unless (-f "$DOCUMENT_ROOT/$name");
	push @file_entries, $name;
}
closedir ($direstory_handle);

print join(",", @file_entries);
