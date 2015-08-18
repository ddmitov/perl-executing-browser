#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;

##############################
# CENSOR.PL SETTINGS:
##############################

my @prohibited_core_functions = qw (fork unlink);

##############################
# END OF CENSOR.PL SETTINGS
##############################

my $prohibited_core_functions = join (' ', @prohibited_core_functions);

##############################
# REDIRECT STDERR TO A VARIABLE:
##############################
open (my $saved_stderr_filehandle, '>&', \*STDERR)  or die "Can't duplicate STDERR: $!";
close STDERR;
my $stderr;
open (STDERR, '>', \$stderr) or die "Unable to open STDERR: $!";

##############################
# READ USER SCRIPT FROM
# THE FIRST COMMAND LINE ARGUMENT:
##############################
my $file = $ARGV[0];
open my $filehandle, '<', $file or die;
my @user_code = <$filehandle>;
close $filehandle;

##############################
# INSERT SAFETY LINE IN USER CODE -
# BAN ALL PROHIBITED CORE FUNCTIONS:
##############################
my $line_number;
foreach my $line (@user_code) {
	$line_number++;
	if ($line_number == 1) {
		my $first_line = $line;
		shift @user_code;
		my $safety_line = "no ops qw ($prohibited_core_functions);";
		unshift @user_code, $first_line, $safety_line;
	}
}

##############################
# HTML HEADER AND FOOTER:
##############################
my $header = "<html>

<head>
<title>Perl Executing Browser - Errors</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<style type='text/css'>body {text-align: left}</style>\n
</head>

<body>";

my $footer = "</body>

</html>";

##############################
# EXECUTE USER CODE IN 'EVAL' STATEMENT:
##############################
my $user_code = join ('', @user_code);
eval ($user_code);

close (STDERR) or die "Can't close STDERR: $!";
open (STDERR, '>&', $saved_stderr_filehandle) or die "Can't restore STDERR: $!";

##############################
# PRINT SAVED STDERR, IF ANY:
##############################
if ($@) {
	if ($@ =~ m/trapped/) {
		print STDERR $header;
		print STDERR "<p align='center'><font size='5' face='SansSerif'>Unsecure code was blocked:</font></p>\n";
		print STDERR "<pre>$@</pre>";
		print STDERR $footer;
		exit;
	} else {
		print STDERR $header;
		print STDERR "<p align='center'><font size='5' face='SansSerif'>Errors were found during script execution:</font></p>\n";
		print STDERR "<pre>$@</pre>";
		print STDERR $footer;
		exit;
	}
}

if (defined($stderr)) {
	print STDERR $header;
	print STDERR "<p align='center'><font size='5' face='SansSerif'>Errors were found during script execution:</font></p>\n";
	print STDERR "<pre>$stderr</pre>";
	print STDERR $footer;
}
