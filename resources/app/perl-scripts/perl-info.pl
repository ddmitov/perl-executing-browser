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
use Cwd;
use English;

my $cwd = cwd();

print "Perl $PERL_VERSION<br>";
print "Working Directory: $cwd<br><br>";

print "\@INC Array:<br>";
print join "<br>", @INC;
