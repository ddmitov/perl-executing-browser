#!/usr/bin/perl

use strict;
use warnings;
use POSIX qw(strftime);

if (eval("require AnyEvent;")) {
  require AnyEvent;
  AnyEvent->import();
} else {
  print "AnyEvent module is missing in this Perl distribution.";
  exit 0;
}

# Disable built-in buffering:
$| = 1;

# Detect the mode of the script from initial STDIN when the script is started:
my $mode = <STDIN>;
chomp $mode;

# Set the event loop:
my $event_loop = AnyEvent->condvar;

my $half_second_wait = AnyEvent->timer (
  after => 0,
  interval => 0.5,
  cb => sub {
    if ($mode =~ "unix-epoch") {
	  print "Seconds from the Unix epoch: ".time;
	}

    if ($mode =~ "local-time") {
      my $formatted_time = strftime('%d.%m.%Y %H:%M:%S', localtime);
      print "Local date and time: ".$formatted_time;
    }
  },
);

$event_loop->recv;
