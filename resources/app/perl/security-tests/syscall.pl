#!/usr/bin/perl -w

use strict;
use warnings;

$new_directory = "/tmp/test";
syscall(&SYS_mkdir, $new_directory);
