#!/usr/bin/perl

use strict;
use warnings;
use POSIX qw(strftime);
use Encode qw(decode);
use English;

use AnyEvent;
use JSON::PP;

# Disable output buffering:
$OUTPUT_AUTOFLUSH = 1;

# Defaults:
my $mode = "unix-epoch";
my $user_input = "";

# Detect mode from initial STDIN:
my $stdin = <STDIN>;
chomp $stdin;

my $initial_input = get_input($stdin);
$mode = $initial_input->{mode};

# Set the event loop:
my $event_loop = AnyEvent->condvar;

my $input = AnyEvent->io(
  fh => \*STDIN,
  poll => "r",
  cb => sub {
    my $stdin = <STDIN>;
    chomp $stdin;

    my $input = get_input($stdin);
    $user_input  = decode('UTF-8', $input->{user_input});

    if ($user_input =~ "peb-exit") {
      shutdown_procedure();
    }
  }
);

my $clock = AnyEvent->timer(
  after => 0,
  interval => 0.5,
  cb => sub {
    my $time;

    if ($mode =~ "unix-epoch") {
      $time = "Seconds from the Unix epoch: ".time;
    }

    if ($mode =~ "local-time") {
      my $time_string = strftime('%d %B %Y %H:%M:%S', localtime);
      $time = "Local date and time: ".$time_string;
    }

    my $output = {
      time => $time,
      user_input => $user_input
    };

    my $output_json = JSON::PP->new->utf8->encode($output);
    print $output_json or shutdown_procedure();
  },
);

$event_loop->recv;

# Get JSON input:
sub get_input {
  my ($stdin) = @_;
  my $json_object = new JSON::PP;
  my $input = $json_object->decode($stdin);
  return $input;
}

# This function is called when PEB unexpectedly crashes and
# script loses its STDOUT stream.
# It must not be named 'shutdown' -
# this is a reserved name for a Perl prototype function!
sub shutdown_procedure {
  exit(0);
}
