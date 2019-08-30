#!/usr/bin/perl

use strict;
use warnings;

use Encode qw(decode);
use JSON::PP;

my $stdin = <STDIN>;
chomp $stdin;

my $json_object = new JSON::PP;
my $input = $json_object->decode($stdin);

my $tempfile = $input->{tempfile};
my $user_input = decode('UTF-8', $input->{user_input});

my $output = {
  user_input => $user_input
};

my $output_json = JSON::PP->new->utf8->encode($output);

open my $filehandle, '>', $tempfile or warn "Unable to open $!";
print $filehandle $output_json;
close $filehandle;
