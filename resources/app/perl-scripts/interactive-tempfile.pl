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
use File::Temp;
use JSON::PP;

# Disable output buffering:
$OUTPUT_AUTOFLUSH = 1;

# Global defaults:
my $mode = "unix_epoch";
my $user_input = "";

# Detect mode from initial STDIN:
my $stdin = <STDIN>;
chomp $stdin;

my $initial_input = get_input($stdin);
eval{
  $mode = $initial_input->{mode};
} or do {
  1;
};

# Send the full pathname of the temporary file:
my $tempfile_handle = File::Temp->new();
$tempfile_handle->unlink_on_destroy(1);
my $tempfile = $tempfile_handle->filename;

my $tempfile_output = {tempfile => "$tempfile"};

my $tempfile_output_json = JSON::PP->new->utf8->encode($tempfile_output);
print $tempfile_output_json or shutdown_procedure();

# Set the event loop:
my $event_loop = AnyEvent->condvar;

my $timer = AnyEvent->timer(
  after => 0,
  interval => 0.5,
  cb => sub {
    my $data;

    # Open tempfile, if it exists,
    # read it, if it is readable,
    # delete it to prevent any garbage left in case of a crash
    # and continue without errors if tempfile is missing or corrupted:
    if (-e $tempfile) {
      eval{
        open $tempfile_handle, '<', $tempfile;
        $data = <$tempfile_handle>;
        close $tempfile_handle;
        unlink $tempfile;
      } or do {
        1;
      }
    }

    my $input = get_input($data);
    eval{
      $user_input = decode('UTF-8', $input->{user_input});
    } or do {
      1;
    };

    if ($user_input =~ "exit") {
      shutdown_procedure();
    }

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
  my ($data) = @_;
  my $json_object = new JSON::PP;
  my $input;
  # Do not give errors if JSON data is corrupted:
  eval{
    $input = $json_object->decode($data);
  } or do {
    $input = "";
  };
  return $input;
}

# This function is called if PEB unexpectedly crashes and
# script loses its STDOUT stream.
# It must not be named 'shutdown' -
# this is a reserved name for a Perl prototype function!
sub shutdown_procedure {
  exit(0);
}
