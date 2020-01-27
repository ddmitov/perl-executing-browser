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

my $directory_name = <STDIN>;
chomp $directory_name;

my $files = 0;
my $subdirectories = 0;

traverse ($directory_name);

print "Selected directory: $directory_name<br>";
print "Subdirectories: $subdirectories<br>";
print "Files: $files<br>";

sub traverse {
  my ($entry) = @_;

  return if not -d $entry;

  opendir (my $directory_handle, $entry) or die $!;
  while (my $subentry = readdir $directory_handle) {
    next if $subentry eq '.' or $subentry eq '..';

    my $full_path = $entry."/".$subentry;

    if (-f $full_path) {
      $files++;
    }

    if (-d $full_path) {
      $subdirectories++;
    }

    traverse ("$entry/$subentry");
  }

  close $directory_handle;

  return;
}
