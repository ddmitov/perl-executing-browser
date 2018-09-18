#!/usr/bin/perl

use strict;
use warnings;

my $input = <STDIN>;
chomp $input;
my @files = split(/;/, $input);

my $number_of_lines;

foreach my $file (@files) {
  open my $filehandle, '<', $file or die "Unable to open file: $!";
  my @file_contents = <$filehandle>;
  close $filehandle;

  my $number_of_lines = scalar(@file_contents);
  print "File: $file Lines: $number_of_lines<br>";
}
