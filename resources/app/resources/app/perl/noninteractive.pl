#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use feature ':5.10';

# CORE MODULE:
use Encode qw(decode);

# UTF-8 encoding for the STDOUT:
binmode STDOUT, ":utf8";

my $stdin = <STDIN>;
chomp $stdin;
my $input_text = decode('UTF-8', $stdin);

print $input_text;
