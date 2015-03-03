#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;

use utf8;
use open ':std', ':encoding(UTF-8)';

#my $relative_filepath = $ARGV[0];
#open my $filehandle, '<', "$ENV{'DOCUMENT_ROOT'}$relative_filepath" or die "Missing file!\n";
#close $filehandle;

#unlink "/tmp/test.pl";

#open my $filehandle, '<', "/tmp/test.pl" or die;
#close $filehandle;

use Tralala;

$ENV{'DOCUMENT_ROOT'} = "/tmp/test";
$ENV{'FILE_TO_OPEN'} = "/tmp/test";
$ENV{'FILE_TO_CREATE'} = "/tmp/test";
$ENV{'FOLDER_TO_OPEN'} = "/tmp/test";

#print STDERR "STDERR printing test\n";

print "<html>

<head>
<title>Perl Executing Browser - Security Test</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
</head>

<body>

<p align='left'><font size='3' face='SansSerif'>\n
Perl Executing Browser security test is successfull!<br>\n
</font></p>

</body>

</html>\n";
