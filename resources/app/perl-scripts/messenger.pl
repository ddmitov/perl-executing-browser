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
# Dimitar D. Mitov, 2013 - 2019
# Valcho Nedelchev, 2014 - 2016
# https://github.com/ddmitov/perl-executing-browser

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
