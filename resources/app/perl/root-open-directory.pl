#!/usr/bin/perl

use strict;
use warnings;

my @files;
my $directory_name = "/root";
my $path_separator = "/";

traverse ($directory_name);

print "<!DOCTYPE html>
<html>

  <head>
    <title>Perl Executing Browser - Linux Root Directory Lister</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <meta charset='utf-8'>
    <link rel='stylesheet' type='text/css' href='http://local-pseudodomain/bootstrap/css/themes/darkly-theme.css' media='all'>
    <style type='text/css'>
      body {
        text-align: left;
        font-size: 22px;
        -webkit-text-size-adjust: 100%;
      }
      pre {
        font-size: 14px;
        font-family: monospace;
      }
    </style>
  </head>

  <body>
    <p align='center'>
      $directory_name
    </p>

    <pre>\n";

foreach my $file (@files) {
  print "$file<br>";
}

print "</pre>

  </body>

</html>\n";

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
