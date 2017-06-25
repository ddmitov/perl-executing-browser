#!/usr/bin/perl

# UTF-8 encoded file

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Cwd;

if (eval("require DBI;")) {
  require DBI;
  DBI->import();
} else {
  print "DBI module is missing in this Perl distribution.";
  exit 0;
}

my $cwd = cwd();
my $database_relative_pathname = "/resources/data/test.db";
my $db = DBI->connect ("dbi:SQLite:$cwd$database_relative_pathname","","", {sqlite_unicode => 1}) or
  die "Could not connect to database";

$db->do ("CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT, surname TEXT)");

my $all_records = $db->selectall_arrayref ("SELECT * FROM USER");

if (scalar @$all_records < 4) {
  $db->do ("INSERT INTO user\(name, surname) VALUES ( 'Linus', 'Torvalds')");
  $db->do ("INSERT INTO user\(name, surname) VALUES ( 'Richard', 'Stallman')");
  $db->do ("INSERT INTO user\(name, surname) VALUES ( 'Линус', 'Торвалдс')");
  $db->do ("INSERT INTO user\(name, surname) VALUES ( 'Ричард', 'Столман')");
}

$all_records = $db->selectall_arrayref ("SELECT * FROM USER");

print "<pre>";
print "SQLite Test:<br>";

foreach my $row (@$all_records) {
  my ($id, $name, $surname) = @$row;
  print "$id $name $surname<br>";
}

print "</pre>";

$db->disconnect;
