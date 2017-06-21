#!/usr/bin/perl

use strict;
use warnings;

my @files;
my $directory_name;
my $path_separator;

# Determine the right path separator:
if ($^O eq "MSWin32") {
  $path_separator = "\\";
} else {
  $path_separator = "/";
}

# Read input:
my ($buffer, @pairs, $pair, $name, $value);
read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

# Split information into name/value pairs:
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $value =~ tr/+/ /;
  $value =~ s/%(..)/pack("C", hex($1))/eg;

  if ($name =~ "directory") {
    $directory_name = $value;
  }
}

traverse ($directory_name);

print "<pre>Directory: $directory_name<br><br>";
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
