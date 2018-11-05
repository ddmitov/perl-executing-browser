#!/usr/bin/perl

use strict;
use warnings;
use POSIX qw(strftime);
use Encode qw(decode);
binmode STDOUT, ":utf8";

if (eval("require AnyEvent;")) {
  require AnyEvent;
  AnyEvent->import();
} else {
  print "AnyEvent module is missing in this Perl distribution.";
  exit 0;
}

# Disable built-in buffering:
$| = 1;

# Global variables:
my $input_text = "";
my $mode = "unix-epoch";

# Detect the mode of the script from initial STDIN when the script is started:
my (@pairs, $pair, $name, $value);
my $stdin = <STDIN>;
@pairs = split(/&/, $stdin);

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

      if ($name =~ "input" and length($value) > 0) {
        $input_text  = decode('UTF-8', $value);
      }
    }
  }
);

my $half_second_wait = AnyEvent->timer (
  after => 0,
  interval => 0.5,
  cb => sub {
    if ($mode =~ "unix-epoch") {
      if (length($input_text) == 0) {
        print "Seconds from the Unix epoch: ".time or die;
      } else {
        print "Seconds from the Unix epoch: ".time."<br>Last input: ".$input_text or die;
      }
    }

    if ($mode =~ "local-time") {
      my $formatted_time = strftime('%d %B %Y %H:%M:%S', localtime);
      if (length($input_text) == 0) {
        print "Local date and time: ".$formatted_time or die;
      } else {
        print "Local date and time: ".$formatted_time."<br>Last input: ".$input_text or die;
      }
    }
  },
);

$event_loop->recv;
