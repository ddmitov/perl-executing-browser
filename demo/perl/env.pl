#!/usr/bin/env perl

use strict;
use warnings;

print "<!DOCTYPE html>
<html>

	<head>
		<title>Environment and \@INC array</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<link rel='stylesheet' type='text/css' href='http://perl-executing-browser-pseudodomain/ui/bootstrap/themes/darkly-theme.css' media='all' />
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
