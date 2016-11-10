#!/usr/bin/perl

use strict;
use warnings;
use AnyEvent;

$| = 1;

my $input_text = "";

my $event_loop = AnyEvent->condvar;

my $wait_for_input = AnyEvent->io (
	fh => \*STDIN,
	poll => "r",
	cb => sub {
		my $input = <STDIN>;
		chomp $input;

		if ($input =~ "_close_") {
			print "_closed_";
			exit();
		}

		my (@pairs, $pair, $name, $value);
		@pairs = split(/&/, $input);
		foreach $pair (@pairs) {
			($name, $value) = split(/=/, $pair);

			if ($value) {
				$value =~ tr/+/ /;
				$value =~ s/%(..)/pack("C", hex($1))/eg;
			}

			if ($name =~ "input") {
				$input_text = $value;
			}
		}
	}
);

my $wait_one_second = AnyEvent->timer (
	after => 0,
	interval => 1,
	cb => sub {
		print "Seconds from the Unix epoch: ".time."<br>Last input: ".$input_text;
	},
);

$event_loop->recv;
