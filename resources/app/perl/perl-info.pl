#!/usr/bin/perl

use strict;
use warnings;
use Cwd;

my $cwd = cwd();

print "Perl $^V<br>";
print "Working Directory: $cwd<br><br>";

print "\@INC Array:<br>";
print join "<br>", @INC;
