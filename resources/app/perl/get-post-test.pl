#!/usr/bin/perl

use strict;
use warnings;

my $input = "";
my (@pairs, $pair, $name, $value);

# Read input:
if ($ENV{'REQUEST_METHOD'}) {
  $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
  if ($ENV{'REQUEST_METHOD'} eq "POST") {
    read (STDIN, $input, $ENV{'CONTENT_LENGTH'});
  } else {
    $input = $ENV{'QUERY_STRING'};
  }
}

print "<pre>";
print "REQUEST_METHOD: $ENV{'REQUEST_METHOD'}<br><br>";
print "FORM DATA:<br>";

# Split information into name/value pairs:
@pairs = split(/&/, $input);
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $value =~ tr/+/ /;
  $value =~ s/%(..)/pack("C", hex($1))/eg;
  print "$name = $value<br>";
}

print "</pre>";
