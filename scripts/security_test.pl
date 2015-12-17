#!/usr/bin/perl -w

use strict;
use warnings;

#~ unlink "/tmp/test.pl";

my $filehandle;
open $filehandle, "<", "/home/dimitar/foo.txt";

#~ print STDERR "STDERR printing test is successfull.\n";
