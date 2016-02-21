#!/usr/bin/env perl

use strict;
use warnings;

print "Content-Type: text/html\r\n\r\n";

print "<html>

	<head>
		<title>Environment and \@INC array</title>
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
		<style type='text/css'>body {text-align: left}</style>
	</head>

	<body>
		<p align='center'><font size='5'>Environment and \@INC array</font></p>

<pre>\n";

foreach my $key (sort keys %ENV) {
	print "$key=$ENV{$key}\n";
}

print "\n\@INC:\n";

print join "\n", @INC;

print "\n</pre>

	</body>

</html>\n";
