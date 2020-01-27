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

# UTF-8 encoded file

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

if (eval("require DBI;")) {
  require DBI;
  DBI->import();
} else {
  print "DBI module is missing in this Perl distribution.";
  exit 1;
}

my $db = DBI->connect("dbi:SQLite:dbname=:memory:","","", {sqlite_unicode => 1}) or
  die "Could not connect to database";

$db->do("CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT, surname TEXT)");
$db->do("INSERT INTO user(name, surname) VALUES('Linus', 'Torvalds')");
$db->do("INSERT INTO user(name, surname) VALUES('Richard', 'Stallman')");
$db->do("INSERT INTO user(name, surname) VALUES('Линус', 'Торвалдс')");
$db->do("INSERT INTO user(name, surname) VALUES('Ричард', 'Столман')");

my $all_records = $db->selectall_arrayref("SELECT * FROM user");
$db->disconnect;

print "SQLite Test: <br>";

foreach my $row (@$all_records) {
  my ($id, $name, $surname) = @$row;
  print "$id $name $surname <br>";
}
