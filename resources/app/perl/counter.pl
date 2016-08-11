#!/usr/bin/perl -w

use strict;
use warnings;

# Disable built-in Perl buffering.
# This is important on Windows for all long running scripts!
$|=1;

my $maximal_time = 10; # seconds

print "Long running Perl script started.";

for (my $counter=1; $counter <= $maximal_time; $counter++){
	sleep (1);
	if ($counter == 1) {
		print "1 second elapsed.";
	}
	if ($counter > 1 and $counter <= $maximal_time) {
		print "$counter seconds elapsed.";
	}
}

sleep (1);
print "Long running Perl script ended.";
