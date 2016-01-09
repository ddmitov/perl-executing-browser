#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;

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

print "<html>

<head>
<title>Perl Executing Browser - SQLite Example</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
</head>

<body>

<p align='left'><font size='3' face='SansSerif'>\n";

foreach my $row (@$all) {
	my ($id, $name, $surname) = @$row;
	print "$id $name $surname <br>\n";
}

print "\n
</font></p>

</body>

</html>\n";

$db->disconnect;
