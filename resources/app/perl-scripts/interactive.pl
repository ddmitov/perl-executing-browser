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

# This code was used to test handling of the SIGTERM signal from a Perl script:
# $SIG{TERM} = sub {
#   print "Terminating interactive script...";
#   sleep(2);
#   exit();
# };

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
      my $output_string;

      if (length($input_text) == 0) {
        $output_string = "Seconds from the Unix epoch: ".time;
      } else {
        $output_string =
          "Seconds from the Unix epoch: ".time."<br>Last user input: ".$input_text;
      }

      print $output_string or shutdown_procedure();
    }

    if ($mode =~ "local-time") {
      my $output_string;
      my $formatted_time = strftime('%d %B %Y %H:%M:%S', localtime);

      if (length($input_text) == 0) {
        $output_string = "Local date and time: ".$formatted_time;
      } else {
        $output_string =
          "Local date and time: ".$formatted_time."<br>Last user input: ".$input_text;
      }

      print $output_string or shutdown_procedure();
    }
  },
);

$event_loop->recv;

# Using a function one can implement a much complex shutdown procedure,
# called when a shutdown command is received from PEB or
# when PEB unexpectedly crashes and script loses its STDOUT stream.
# This function must not be named 'shutdown' -
# this is a reserved name for a Perl prototype function!
sub shutdown_procedure {
  exit();
}
