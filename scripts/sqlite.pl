#!/usr/bin/perl -w

# http://lauraliparulo.altervista.org/first-steps-in-sqlite-and-perl/
# UTF-8 encoded file

use strict;
use warnings;
use DBI;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT QUERY_STRING REQUEST_METHOD);

my $database_relative_pathname = "/db/test.db";
my $database_full_pathname = $DOCUMENT_ROOT.$database_relative_pathname;
my $db = DBI->connect("dbi:SQLite:$database_full_pathname","","", {sqlite_unicode => 1}) or die "Could not connect to database";

$db->do ("CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT, surname TEXT)");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Linus', 'Torvalds')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Richard', 'Stallman')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Петър', 'Петров')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Иван', 'Иванов')");

my $all = $db->selectall_arrayref ("SELECT * FROM USER");

print  <<HEADER;

<html>

<head>

<title>Perl Executing Browser - SQLite Example</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>

</head>

<body text='#000000' bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>

<p align='left'><font size='3' face='SansSerif'>

HEADER

foreach my $row (@$all) {
	my ($id, $name, $surname) = @$row;
	print "$id $name $surname <br>\n";
}

print  <<FOOTER;

</font></p>

</body>

</html>

FOOTER

$db->disconnect; 
