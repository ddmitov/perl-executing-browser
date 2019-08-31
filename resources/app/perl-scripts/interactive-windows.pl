#!/usr/bin/perl

use strict;
use warnings;
use POSIX qw(strftime);
use Encode qw(decode);

use AnyEvent;
use File::Temp qw(tempfile tempdir);
use JSON::PP;

# Disable built-in buffering:
$| = 1;

# Global defaults:
my $mode = "unix-epoch";
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

# Temporary file:
my $tempfile_handle = File::Temp->new(UNLINK => 0);
my $tempfile = $tempfile_handle->filename;

# Set the event loop:
my $event_loop = AnyEvent->condvar;

my $timer = AnyEvent->timer(
  after => 0,
  interval => 0.5,
  cb => sub {
    my $data;

    if (-e $tempfile) {
      eval{
        open $tempfile_handle, '<', $tempfile;
        $data = <$tempfile_handle>;
        close $tempfile_handle;
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

    my $time;

    if ($mode =~ "unix-epoch") {
      $time = "Seconds from the Unix epoch: ".time;
    }

    if ($mode =~ "local-time") {
      my $time_string = strftime('%d %B %Y %H:%M:%S', localtime);
      $time = "Local date and time: ".$time_string;
    }

    my $output = {
      tempfile => "$tempfile",
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
  eval{
    $input = $json_object->decode($data);
  } or do {
    $input = "";
  };
  return $input;
}

# This function is called when PEB is closed by user or unexpectedly crashes and
# script loses its STDOUT stream.
# It must not be named 'shutdown' -
# this is a reserved name for a Perl prototype function!
sub shutdown_procedure {
  unlink $tempfile;
  exit(0);
}
