#!/usr/bin/perl

# UTF-8 encoded file

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Cwd;
use File::Spec::Functions qw(catdir);

if (eval("require DBI;")) {
  require DBI;
  DBI->import();
} else {
  print "DBI module is missing in this Perl distribution.";
  exit 1;
}

my $sqlite_file = catdir(getcwd, "resources", "data", "test.db");
my $db = DBI->connect("dbi:SQLite:$sqlite_file","","", {sqlite_unicode => 1}) or
  die "Could not connect to database";

my $test_query = "SELECT * FROM user";

my $all_records = $db->selectall_arrayref ($test_query);

if (scalar @$all_records < 4) {
  $db->do("CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT, surname TEXT)");
  $db->do("INSERT INTO user(name, surname) VALUES('Linus', 'Torvalds')");
  $db->do("INSERT INTO user(name, surname) VALUES('Richard', 'Stallman')");
  $db->do("INSERT INTO user(name, surname) VALUES('Линус', 'Торвалдс')");
  $db->do("INSERT INTO user(name, surname) VALUES('Ричард', 'Столман')");
}

$all_records = $db->selectall_arrayref($test_query);

print "SQLite Test: <br>";

foreach my $row (@$all_records) {
  my ($id, $name, $surname) = @$row;
  print "$id $name $surname <br>";
}

$db->disconnect;
