#!/usr/bin/perl -w

use strict;
use warnings;

require 'syscall.ph';
my $pid = syscall(&SYS_getpid);
print "PID is $pid\n";
