#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;
no lib ".";

BEGIN {
	##############################
	# BAN ALL PROHIBITED CORE FUNCTIONS:
	##############################
	#no ops qw(syscall dump chroot fork);
	no ops qw(:dangerous fork);

	##############################
	# ENVIRONMENT:
	##############################
	my %CLEAN_ENV;

	if ($ENV{'REQUEST_METHOD'}) {
		$CLEAN_ENV{'REQUEST_METHOD'} = $ENV{'REQUEST_METHOD'};
	}

	if ($ENV{'QUERY_STRING'}) {
		$CLEAN_ENV{'QUERY_STRING'} = $ENV{'QUERY_STRING'};
	}

	if ($ENV{'CONTENT_LENGTH'}) {
		$CLEAN_ENV{'CONTENT_LENGTH'} = $ENV{'CONTENT_LENGTH'};
	}

	%ENV = %CLEAN_ENV;
}

##############################
# REDIRECT STDERR TO A VARIABLE:
##############################
open (my $saved_stderr_filehandle, '>&', \*STDERR)  or die "Can not duplicate STDERR: $!";
close STDERR;
my $stderr;
open (STDERR, '>', \$stderr) or die "Unable to open STDERR: $!";

##############################
# READ USER SCRIPT FROM
# THE FIRST COMMAND LINE ARGUMENT:
##############################
my $filepath = shift @ARGV;
open my $filehandle, '<', $filepath or die "Unable to open file: $!";;
$/ = undef;
my $user_code = <$filehandle>;
close $filehandle;

##############################
# HTML HEADER AND FOOTER:
##############################
my $header = "
<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - Errors</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>

		<style type='text/css'>
			body {
				text-align: left;
				font-family: sans-serif;
				font-size: 22px;
				color: #ffffff;
				background-color: #222222;
				-webkit-text-size-adjust: 100%;
			}

			pre {
				display: block;
				padding: 10px;
				margin: 0 0 10.5px;
				font-size: 14px;
				word-break: break-all;
				word-wrap: break-word;
				color: #333333;
				background-color: #f5f5f5;
				border: 1px solid #cccccc;
				border-radius: 3px;
			}

			div.title {
				text-align: center;
				padding: 10px 0px 10px 0px;
			}
		</style>\n
	</head>

	<body>";

my $footer = "
	</body>

</html>";

##############################
# EXECUTE USER CODE IN 'EVAL' STATEMENT:
##############################
eval ($user_code);

##############################
# PRINT SAVED STDERR, IF ANY:
##############################
close (STDERR) or die "Can not close STDERR: $!";
open (STDERR, '>&', $saved_stderr_filehandle) or die "Can not restore STDERR: $!";

if ($@) {
	if ($@ =~ m/trapped/) {
		if ($filepath !~ "ajax") {
			print STDERR $header;
			print STDERR "<div class='title'>\n";
			print STDERR "$filepath\n";
			print STDERR "</div>\n";
			print STDERR "<div class='title'>";
		}
		print STDERR "Insecure code was blocked:\n";
		if ($filepath !~ "ajax") {
			print STDERR "</div>\n";
		}
	} else {
		if ($filepath !~ "ajax") {
			print STDERR $header;
			print STDERR "<div class='title'>\n";
			print STDERR "$filepath\n";
			print STDERR "</div>\n";
			print STDERR "<div class='title'>";
		}
		print STDERR "Errors were found during script execution:\n";
		if ($filepath !~ "ajax") {
			print STDERR "</div>\n";
		}
	}
	if ($filepath !~ "ajax") {
		print STDERR "<pre>";
	}
	print STDERR "$@";
	if ($filepath !~ "ajax") {
		print STDERR "</pre>";
		print STDERR $footer;
	}
	exit;
}

if (defined($stderr)) {
	if ($filepath !~ "ajax") {
		print STDERR $header;
		print STDERR "<div class='title'>\n";
		print STDERR "$filepath\n";
		print STDERR "</div>\n";
		print STDERR "<div class='title'>";
	}
	print STDERR "Errors were found during script execution:\n";
	if ($filepath !~ "ajax") {
		print STDERR "</div>\n";
		print STDERR "<pre>";
	}
	print STDERR "$stderr";
	if ($filepath !~ "ajax") {
		print STDERR "</pre>";
		print STDERR $footer;
	}
}
