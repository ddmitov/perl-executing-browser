#!/usr/bin/perl

use strict;
use warnings;

my $directory_name = <STDIN>;
chomp $directory_name;

my @files;

traverse ($directory_name);

print "Listing all files in $directory_name:<br>";

foreach my $file (@files) {
  print "$file<br>";
}

my $number_of_files = scalar @files;
print "$number_of_files files<br>";

sub traverse {
  my ($entry) = @_;

  return if not -d $entry;
  opendir (my $directory_handle, $entry) or die $!;
  while (my $subentry = readdir $directory_handle) {
    next if $subentry eq '.' or $subentry eq '..';

    my $full_path = $entry."/".$subentry;

    if (-f $full_path) {
      push @files, $full_path;
    }

    traverse ("$entry/$subentry");
  }
  close $directory_handle;

  return;
}
