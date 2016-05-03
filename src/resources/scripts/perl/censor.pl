#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;
no lib ".";

BEGIN {
	##############################
	# BAN ALL PROHIBITED CORE FUNCTIONS:
	##############################
	no ops qw(:dangerous :subprocess :sys_db sysopen);

	##############################
	# ENVIRONMENT:
	##############################
	my $PEB_DATA_DIR = $ENV{'PEB_DATA_DIR'};

	my %CLEAN_ENV;
	$CLEAN_ENV{'PEB_DATA_DIR'} = $PEB_DATA_DIR;

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

	##############################
	# OVERRIDE POTENTIALY DANGEROUS
	# CORE FUNCTIONS:
	##############################
	*CORE::GLOBAL::require = sub (*;$@) {
		(my $package, my $filename, my $line) = caller();
		my $module = $_[0];
		if (($module =~ "Registry" and $module =~ "Win32") or
			$module =~ "lib") {
			die "Use of an insecure module detected at package '$package', line: $line.<br>The use of module '$module' is prohibited!\n";
		} else {
			return CORE::require $_[0];
		}
	};

	*CORE::GLOBAL::unlink = sub (*;$@) {
		(my $package, my $filename, my $line) = caller();
		my $entry = $_[0];
		if ($entry =~ $PEB_DATA_DIR) {
			return CORE::unlink $_[0];
		} else {
			die "Insecure 'unlink' call intercepted from package '$package', line: $line.<br>Deleting '$entry' is not allowed!\n";
		}
	};
}

##############################
# REDIRECT STDERR TO A VARIABLE:
##############################
CORE::open (my $saved_stderr_filehandle, '>&', \*STDERR)  or die "Can not duplicate STDERR: $!";
close STDERR;
my $stderr;
CORE::open (STDERR, '>', \$stderr) or die "Unable to open STDERR: $!";

##############################
# READ USER SCRIPT FROM
# THE FIRST COMMAND LINE ARGUMENT:
##############################
my $filepath = shift @ARGV;
CORE::open my $filehandle, '<', $filepath or die;
my @user_code = <$filehandle>;
close $filehandle;

##############################
# STATIC CODE ANALYSIS:
##############################
my $line_number;
my %problematic_lines;
my %explanations;
foreach my $line (@user_code) {
	$line_number++;

	if ($line =~ m/CORE::(require|unlink)/) {
		if ($line =~ m/#.*CORE::(require|unlink)/) {
			next;
		} else {
			$problematic_lines{$line_number} = $line;
			$explanations{$line_number} = "Forbidden invocation of core function detected!";
		}
	}

	if ($line =~ m/\@INC\s{0,}(,|=)/) {
		if ($line =~ m/#.*\@INC\s{0,}(,|=)/) {
			next;
		} else {
			$problematic_lines{$line_number} = $line;
			$explanations{$line_number} = "Forbidden \@INC array manipulation detected!";
		}
	}

	if ($line =~ m/\s{1,}eval/) {
		if ($line =~ m/#.*\s{1,}eval/) {
			next;
		} else {
			$problematic_lines{$line_number} = $line;
			$explanations{$line_number} = "Forbidden 'eval' function detected!";
		}
	}
}

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
if (scalar (keys %problematic_lines) == 0) {
	my $user_code = join ('', @user_code);
	eval ($user_code);

	close (STDERR) or die "Can not close STDERR: $!";
	CORE::open (STDERR, '>&', $saved_stderr_filehandle) or die "Can not restore STDERR: $!";
} elsif (scalar (keys %problematic_lines) > 0) {
	close (STDERR) or die "Can not close STDERR: $!";
	CORE::open (STDERR, '>&', $saved_stderr_filehandle) or die "Can not restore STDERR: $!";

	if ($filepath !~ "ajax") {
		print STDERR $header;
		print STDERR "<div class='title'>";
		print STDERR "$filepath\n";
		print STDERR "</div>\n";
		print STDERR "<div class='title'>";
	}
	print STDERR "Script execution was not attempted due to security violation";
	if (scalar (keys %problematic_lines) == 1) {
		print STDERR ":\n";
	} elsif (scalar (keys %problematic_lines) > 1) {
		print STDERR "s:\n";
	}
	if ($filepath !~ "ajax") {
		print STDERR "</div>\n";
	}

	foreach my $line_number (sort {$a <=> $b} (keys(%problematic_lines))) {
		if ($filepath !~ "ajax") {
			print STDERR "<pre>";
		}
		print STDERR "Line $line_number: $problematic_lines{$line_number}";
		print STDERR "$explanations{$line_number}\n";
		if ($filepath !~ "ajax") {
			print STDERR "</pre>";
		}
	}

	if ($filepath !~ "ajax") {
		print STDERR $footer;
	}
	exit;
}

##############################
# PRINT SAVED STDERR, IF ANY:
##############################
if ($@) {
	if ($@ =~ m/trapped/ or $@ =~ m/insecure/i) {
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
