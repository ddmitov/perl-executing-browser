#!/usr/bin/perl

use strict;
use warnings;
use POSIX qw(strftime);
binmode STDOUT, ":utf8";

if (eval("require AnyEvent;")) {
  AnyEvent->import();
} else {
  print "AnyEvent module is missing in this Perl distribution.";
  exit 0;
}

# Disable built-in buffering:
$| = 1;

# Global variables:
my $input_text = "";
my $mode = "";

# Detect the mode of the script
# from a query string item when the script is started:
my $query_string = "";
my (@pairs, $pair, $name, $value);

if ($ENV{'REQUEST_METHOD'}) {
  $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
  if ($ENV{'REQUEST_METHOD'} eq "GET") {
    $query_string = $ENV{'QUERY_STRING'};
  }
}

@pairs = split(/&/, $query_string);

foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $value =~ tr/+/ /;
  $value =~ s/%(..)/pack("C", hex($1))/eg;
  if ($name =~ "mode") {
    $mode = $value;
  }
}

# Set the event loop:
my $event_loop = AnyEvent->condvar;

my $wait_for_input = AnyEvent->io (
  fh => \*STDIN,
  poll => "r",
  cb => sub {
    my $stdin = <STDIN>;
    chomp $stdin;

    # Close after close commmand is received,
    # but first print a confirmation for a normal exit.
    if ($stdin =~ "_close_") {
      print "_closed_";
      exit();
    }

    # Read input text from STDIN:
    my (@pairs, $pair, $name, $value);
    @pairs = split(/&/, $stdin);

    foreach $pair (@pairs) {
      ($name, $value) = split(/=/, $pair);

      if ($value) {
        $value =~ tr/+/ /;
        $value =~ s/%(..)/pack("C", hex($1))/eg;
      }

      if ($name =~ "input") {
        $input_text = $value;
      }
    }
  }
);

my $wait_one_second = AnyEvent->timer (
  after => 0,
  interval => 1,
  cb => sub {
    if ($mode =~ "unix-epoch") {
      print "Seconds from the Unix epoch: ".time."<br>Last input: ".$input_text;
    }
    if ($mode =~ "local-time") {
      my $formatted_time = strftime('%d %B %Y %H:%M:%S', localtime);
      print "Local time: ".$formatted_time."<br>Last input: ".$input_text;
    }
  },
);

$event_loop->recv;
