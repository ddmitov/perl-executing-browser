#!/usr/bin/perl

use strict;
use warnings;

my @files;
my $directory_name = "/root";
my $path_separator = "/";

traverse ($directory_name);

print "<pre>";
print "Listing all files in the /root directory:<br";

foreach my $file (@files) {
  print "$file<br>";
}

print "</pre>";

sub traverse {
  my ($entry) = @_;

  return if not -d $entry;
  opendir (my $directory_handle, $entry) or die $!;
  while (my $subentry = readdir $directory_handle) {
    next if $subentry eq '.' or $subentry eq '..';
    my $full_path = $entry.$path_separator.$subentry;
    if (-f $full_path) {
      push @files, $full_path;
    }
    traverse ("$entry$path_separator$subentry");
  }
  close $directory_handle;

  return;
}
