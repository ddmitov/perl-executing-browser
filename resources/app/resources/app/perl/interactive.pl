#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use feature ':5.10';

# CORE MODULES:
use POSIX qw(strftime);
use Encode qw(decode);

# CPAN MODULE:
use AnyEvent;

# Disable built-in buffering:
$| = 1;

# UTF-8 encoding for the STDOUT:
binmode STDOUT, ":utf8";

# Global variables:
my $input_text = "";

# Set the event loop:
my $event_loop = AnyEvent->condvar;

my $wait_for_input = AnyEvent->io (
  fh => \*STDIN,
  poll => "r",
  cb => sub {
    my $stdin = <STDIN>;
    chomp $stdin;
    $input_text = decode('UTF-8', $stdin);

    message();

    # Close after '_close_' commmand is received:
    if ($stdin =~ "_close_") {
      exit(0);
    }
  }
);

# Print local time every second:
my $wait_one_second = AnyEvent->timer (
  after => 0,
  interval => 1,
  cb => sub {
    message();
  },
);

$event_loop->recv;

sub message() {
  my $formatted_time = strftime('%d %B %Y %H:%M:%S', localtime);
  if (length($input_text) == 0) {
    print "Local time: ".$formatted_time;
  } else {
    print "Local time: ".$formatted_time."<br>Last input: ".$input_text;
  }
}
