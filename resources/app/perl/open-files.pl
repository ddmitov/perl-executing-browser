#!/usr/bin/perl

use strict;
use warnings;

# Read input:
my (@pairs, $pair, $name, $value);

my @files;

# Split information into name/value pairs:
@pairs = split(/&/, $ENV{'QUERY_STRING'});
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $value =~ tr/+/ /;
  $value =~ s/%(..)/pack("C", hex($1))/eg;

  if ($name =~ "files") {
    @files = split(/;/, $value);
  }
}

my $number_of_lines;

print "<pre>";
print "Opening multiple files:<br>";

foreach my $file (@files) {
  open my $filehandle, '<', $file or die "Unable to open file: $!";
  my @file_contents = <$filehandle>;
  close $filehandle;

  my $number_of_lines = scalar(@file_contents);
  print "File: $file Lines: $number_of_lines<br>";
}

print "</pre>";
