#!/usr/bin/env perl

use strict;
use warnings;
use Cwd;

print "<!DOCTYPE html>
<html>

	<head>
		<title>Working Directory and \@INC Array</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<link rel='stylesheet' type='text/css' href='http://perl-executing-browser-pseudodomain/bootstrap/css/themes/darkly-theme.css' media='all' />
		<style type='text/css'>body {text-align: left}</style>
	</head>

	<body>
		<p align='center'><font size='5'>Working Directory and \@INC Array</font></p>
<pre>\n";

my $cwd = cwd();
print "Working Directory: $cwd\n";

print "\n\@INC Array:\n";

print join "\n", @INC;

print "\n</pre>

	</body>

</html>\n";
