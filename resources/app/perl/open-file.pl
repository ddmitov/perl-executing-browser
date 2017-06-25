#!/usr/bin/perl

use strict;
use warnings;

# Read input:
my (@pairs, $pair, $name, $value);

my $file;

# Split information into name/value pairs:
@pairs = split(/&/, $ENV{'QUERY_STRING'});
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $value =~ tr/+/ /;
  $value =~ s/%(..)/pack("C", hex($1))/eg;

  if ($name =~ "file") {
    $file = $value;
  }
}

open my $filehandle, '<', $file or die "Unable to open file: $!";
my @file_contents = <$filehandle>;
close $filehandle;

my $number_of_lines = scalar(@file_contents);

print "<pre>Opening single file: $file Lines: $number_of_lines</pre>";
