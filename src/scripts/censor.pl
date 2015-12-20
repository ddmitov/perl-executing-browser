#!/usr/bin/perl -w

use strict;
use warnings;
use POSIX qw(strftime);
use 5.010;

BEGIN {
	my $DOCUMENT_ROOT = $ENV{'DOCUMENT_ROOT'};

	my $FOLDER_TO_OPEN = rand().strftime '%d-%m-%Y--%H-%M-%S', gmtime();;
	if (defined($ENV{'FOLDER_TO_OPEN'})) {
		$FOLDER_TO_OPEN = $ENV{'FOLDER_TO_OPEN'};
	}

	my $FILE_TO_OPEN = rand().strftime '%d-%m-%Y--%H-%M-%S', gmtime();
	if (defined($ENV{'FILE_TO_OPEN'})) {
		$FILE_TO_OPEN = $ENV{'FILE_TO_OPEN'};
	}

	*CORE::GLOBAL::chdir = sub (*;$@) {
		(my $package, my $filename, my $line) = caller();
		my $dir = shift;
		if ($dir =~ $DOCUMENT_ROOT or $dir =~ $FOLDER_TO_OPEN) {
			CORE::chdir $dir;
		} else {
			die "Intercepted insecure 'chdir' call from (package: '$package', file: '$filename', line: '$line'). Directory change not allowed for $dir!\n";
		}
	};

	*CORE::GLOBAL::open = sub (*;$@) {
		(my $package, my $filename, my $line) = caller();
		my $handle =shift;
		if (@_ == 1) {
			my $filepath = $_[0];
			if ($_[0] =~ $DOCUMENT_ROOT or $_[0] =~ $FOLDER_TO_OPEN or $_[0] =~ $FILE_TO_OPEN) {
				return CORE::open($handle, $_[1]);
			} else {
				die "Intercepted insecure 'open' call from (package: '$package', file: '$filename', line: '$line'). File open not allowed for $filepath!\n";
			}
		} elsif (@_ == 2) {
			my $filepath = $_[1];
			if ($_[1] =~ $DOCUMENT_ROOT or $_[1] =~ $FOLDER_TO_OPEN or $_[1] =~ $FILE_TO_OPEN) {
				return CORE::open($handle, $_[1]);
			} else {
				die "Intercepted insecure 'open' call from (package: '$package', file: '$filename', line: '$line'). File open not allowed for $filepath!\n";
			}
		} elsif (@_ == 3) {
			if (defined $_[2]) {
				my $filepath = $_[2];
				if ($_[2] =~ $DOCUMENT_ROOT or $_[2] =~ $FOLDER_TO_OPEN or $_[2] =~ $FILE_TO_OPEN) {
					CORE::open $handle, $_[1], $_[2];
				} else {
					die "Intercepted insecure 'open' call from (package: '$package', file: '$filename', line: '$line'). File open not allowed for $filepath!\n";
				}
			} else {
				my $filepath = $_[1];
				if ($_[1] =~ $DOCUMENT_ROOT or $_[1] =~ $FOLDER_TO_OPEN or $_[1] =~ $FILE_TO_OPEN) {
					CORE::open $handle, $_[1], undef; # special case
				} else {
					die "Intercepted insecure 'open' call from (package: '$package', file: '$filename', line: '$line'). File open not allowed for $filepath!\n";
				}
			}
		} else {
			my $filepath = $_[1];
			if ($_[1] =~ $DOCUMENT_ROOT or $_[1] =~ $FOLDER_TO_OPEN or $_[1] =~ $FILE_TO_OPEN or
				$_[2] =~ $DOCUMENT_ROOT or $_[2] =~ $FOLDER_TO_OPEN or $_[2] =~ $FILE_TO_OPEN) {
				CORE::open $handle, $_[1], $_[2], @_[3..$#_];
			} else {
				die "Intercepted insecure 'open' call from (package: '$package', file: '$filename', line: '$line'). File open not allowed for $filepath!\n";
			}
		}
	};

}

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
CORE::open (my $saved_stderr_filehandle, '>&', \*STDERR)  or die "Can't duplicate STDERR: $!";
close STDERR;
my $stderr;
CORE::open (STDERR, '>', \$stderr) or die "Unable to open STDERR: $!";

##############################
# READ USER SCRIPT FROM
# THE FIRST COMMAND LINE ARGUMENT:
##############################
my $file = $ARGV[0];
CORE::open my $filehandle, '<', $file or die;
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
CORE::open (STDERR, '>&', $saved_stderr_filehandle) or die "Can't restore STDERR: $!";

##############################
# PRINT SAVED STDERR, IF ANY:
##############################
if ($@) {
	if ($@ =~ m/trapped/) {
		print STDERR $header;
		print STDERR "<p align='center'><font size='5' face='SansSerif'>insecure code was blocked:</font></p>\n";
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
