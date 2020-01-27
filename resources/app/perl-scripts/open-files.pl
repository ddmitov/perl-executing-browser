#!/usr/bin/perl

# Perl Executing Browser Demo

# This program is free software;
# you can redistribute it and/or modify it under the terms of the
# GNU Lesser General Public License,
# as published by the Free Software Foundation;
# either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.
# Dimitar D. Mitov, 2013 - 2020
# Valcho Nedelchev, 2014 - 2016
# https://github.com/ddmitov/perl-executing-browser

use strict;
use warnings;

my $input = <STDIN>;
chomp $input;

my @files = split(/;/, $input);

my $number_of_lines;

foreach my $file (@files) {
  open my $filehandle, '<', $file or warn "Unable to open $!";
  my @file_contents = <$filehandle>;
  close $filehandle;

  my $number_of_lines = scalar(@file_contents);
  print "File: $file Lines: $number_of_lines<br>";
}
