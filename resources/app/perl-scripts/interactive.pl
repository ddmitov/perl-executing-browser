#!/usr/bin/perl

# Perl Executing Browser Demo

# This program is free software;
# you can redistribute it and/or modify it under the terms of the
# GNU Lesser General Public License,
# as published by the Free Software Foundation;
# either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.
# Dimitar D. Mitov, 2013 - 2020
# Valcho Nedelchev, 2014 - 2016
# https://github.com/ddmitov/perl-executing-browser

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
my $mode = "unix_epoch";
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
    $user_input = decode('UTF-8', $input->{user_input});

    if ($user_input =~ "exit") {
      shutdown_procedure();
    }
  }
);

my $clock = AnyEvent->timer(
  after => 0,
  interval => 0.5,
  cb => sub {
    my $time;

    if ($mode =~ "unix_epoch") {
      $time = "Seconds from the Unix epoch: ".time;
    }

    if ($mode =~ "local_time") {
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

# This function is called if PEB unexpectedly crashes and
# script loses its STDOUT stream.
# It must not be named 'shutdown' -
# this is a reserved name for a Perl prototype function!
sub shutdown_procedure {
  exit(0);
}
