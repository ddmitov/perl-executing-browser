#!/usr/bin/perl -w

# UTF-8 encoded file

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use DBI;

my $database_relative_pathname = "/db/test.db";
my $db = DBI->connect ("dbi:SQLite:$ENV{'DOCUMENT_ROOT'}$database_relative_pathname","","", {sqlite_unicode => 1}) or
	die "Could not connect to database";

$db->do ("CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT, surname TEXT)");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Linus', 'Torvalds')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Richard', 'Stallman')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Линус', 'Торвалдс')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Ричард', 'Столман')");

my $all = $db->selectall_arrayref ("SELECT * FROM USER");

print "<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - SQLite Example</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<link rel='stylesheet' type='text/css' href='http://perl-executing-browser-pseudodomain/ui/bootstrap/themes/darkly-theme.css' media='all' />
	</head>

	<body>

		<p align='left'><font size='3'>\n";

foreach my $row (@$all) {
	my ($id, $name, $surname) = @$row;
	print "$id $name $surname <br>\n";
}

print "\n
		</font></p>

	</body>

</html>\n";

$db->disconnect;
