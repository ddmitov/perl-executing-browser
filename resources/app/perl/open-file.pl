#!/usr/bin/perl

use strict;
use warnings;

my $filename;
read (STDIN, $filename, $ENV{'CONTENT_LENGTH'});

open my $filehandle, '<', $filename or die "Unable to open file: $filename\n$!";
my @file_contents = <$filehandle>;
close $filehandle;

my $number_of_lines = scalar(@file_contents);

print "<pre>Opening single file: $filename Lines: $number_of_lines</pre>";
