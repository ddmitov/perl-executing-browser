#!/usr/bin/perl -w

use strict;
use warnings;

#~ unlink "/tmp/test.pl";

#~ chdir "/home/dimitar/";

#~ my $filehandle;
#~ open $filehandle, "<", "/home/dimitar/foo.txt";


#~ print STDERR "STDERR printing test is successfull.\n";

print <<HTML
<html>

	<head>
		<title>Perl Executing Browser - Security Test</title>
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	</head>

	<body>
		<p align='center'><font size='5'>Security Test</font></p>
	</body>
</html>
HTML
;
