#!/usr/bin/perl

use strict;
use warnings;
use Cwd;
use English;

my $cwd = cwd();

print "Perl $PERL_VERSION<br>";
print "Working Directory: $cwd<br><br>";

print "\@INC Array:<br>";
print join "<br>", @INC;
