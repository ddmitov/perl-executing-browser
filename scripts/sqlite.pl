#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;

use utf8;
use open ':std', ':encoding(UTF-8)';

use DBI;

#~ unlink "/tmp/test.pl.pl";

#~ my $relative_filepath = $ARGV[0];
#~ open my $filehandle, '<', "$ENV{'DOCUMENT_ROOT'}$relative_filepath" or die "Missing file!\n";
#~ close $filehandle;

#~ open my $filehandle, '<', "/tmp/test.pl" or die;
#~ close $filehandle;

#~ use Tralala;

#~ $ENV{'DOCUMENT_ROOT'} = "/tmp/test";
#~ $ENV{'FILE_TO_OPEN'} = "/tmp/test";
#~ $ENV{'FILE_TO_CREATE'} = "/tmp/test";
#~ $ENV{'FOLDER_TO_OPEN'} = "/tmp/test";

my $database_relative_pathname = "/db/test.db";
my $db = DBI->connect ("dbi:SQLite:$ENV{'DOCUMENT_ROOT'}$database_relative_pathname","","", {sqlite_unicode => 1}) or die "Could not connect to database";

$db->do ("CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT, surname TEXT)");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Linus', 'Torvalds')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Richard', 'Stallman')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Линус', 'Торвалдс')");
$db->do ("INSERT INTO user\(name, surname) VALUES ( 'Ричард', 'Столман')");

my $all = $db->selectall_arrayref ("SELECT * FROM USER");

print  <<HEADER;
<html>

<head>
	<title>Perl Executing Browser - SQLite Example</title>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
</head>

<body>

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
