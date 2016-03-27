#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;
no lib ".";

BEGIN {
	##############################
	# BAN ALL PROHIBITED CORE FUNCTIONS:
	##############################
	no ops qw(:dangerous sysopen :subprocess :sys_db unlink);

	##############################
	# ENVIRONMENT VARIABLES:
	##############################
	my $DOCUMENT_ROOT = $ENV{'DOCUMENT_ROOT'};

	##############################
	# OVERRIDE POTENTIALY DANGEROUS
	# CORE FUNCTIONS:
	##############################

	#~ my @allowed_domains = qw (www.perl.org www.perl.com);

	#~ *CORE::GLOBAL::gethostbyname = sub (*;$@) {
		#~ (my $package, my $filename, my $line) = caller();
		#~ my $hostname = $_[0];

		#~ my $domain_matched = 0;
		#~ foreach my $allowed_domain (@allowed_domains) {
			#~ if (($hostname =~ $allowed_domain)) {
				#~ $domain_matched = 1;
				#~ return CORE::gethostbyname $_[0];
			#~ } else {
				#~ next;
			#~ }
		#~ }

		#~ if ($domain_matched == 0) {
			#~ die "Attempted connection to a prohibited domain '$hostname' detected at package '$package', line: $line.\n";
		#~ }
	#~ };

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

	*CORE::GLOBAL::opendir = sub (*;$@) {
		(my $package, my $filename, my $line) = caller();
		my $dir = $_[1];
		if ($dir =~ $DOCUMENT_ROOT) {
			return CORE::opendir $_[0], $_[1];
		} else {
			die "Intercepted insecure 'opendir' call from package '$package', line: $line.<br>Opening directory '$dir' is not allowed!\n";
		}
	};

	*CORE::GLOBAL::chdir = sub (*;$@) {
		(my $package, my $filename, my $line) = caller();
		my $dir = $_[0];
		if ($dir =~ $DOCUMENT_ROOT) {
			CORE::chdir $_[0];
		} else {
			die "Intercepted insecure 'chdir' call from package '$package', line: $line.<br>Changing directory to '$dir' is not allowed!\n";
		}
	};

	*CORE::GLOBAL::open = sub (*;$@) {
		(my $package, my $filename, my $line) = caller();
		my $handle = shift;
		if (@_ == 1) {
			my $filepath = $_[0];
			if ($_[0] =~ $DOCUMENT_ROOT) {
				return CORE::open ($handle, $_[0]);
			} else {
				$filepath =~ s/(\<|\>)//;
				die "Intercepted insecure 'open' call from package '$package', line: $line.<br>Opening '$filepath' is not allowed!\n";
			}
		} elsif (@_ == 2) {
			my $filepath = $_[1];
			if ($_[1] =~ $DOCUMENT_ROOT) {
				return CORE::open ($handle, $_[1]);
			} else {
				die "Intercepted insecure 'open' call from package '$package', line: $line.<br>Opening '$filepath' is not allowed!\n";
			}
		} elsif (@_ == 3) {
			if (defined $_[2]) {
				my $filepath = $_[2];
				if ($_[2] =~ $DOCUMENT_ROOT) {
					CORE::open $handle, $_[1], $_[2];
				} else {
					die "Intercepted insecure 'open' call from package '$package', line: $line.<br>Opening '$filepath' is not allowed!\n";
				}
			} else {
				my $filepath = $_[1];
				if ($_[1] =~ $DOCUMENT_ROOT) {
					CORE::open $handle, $_[1], undef; # special case
				} else {
					die "Intercepted insecure 'open' call from package '$package', line: $line.<br>Opening '$filepath' is not allowed!\n";
				}
			}
		} else {
			my $filepath = $_[1];
			if ($_[1] =~ $DOCUMENT_ROOT or $_[2] =~ $DOCUMENT_ROOT) {
				CORE::open $handle, $_[1], $_[2], @_[3..$#_];
			} else {
				die "Intercepted insecure 'open' call from package '$package', line: $line.<br>Opening '$filepath' is not allowed!\n";
			}
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
my $file = $ARGV[0];
CORE::open my $filehandle, '<', $file or die;
my @user_code = <$filehandle>;
close $filehandle;

##############################
# STATIC CODE ANALYSIS:
##############################
my %problematic_lines;
my $line_number;
foreach my $line (@user_code) {
	$line_number++;

	if ($line =~ m/CORE::/) {
		if ($line =~ m/#.*CORE::(opendir|chdir|open|require|gethostbyname)/) {
			next;
		} else {
			$problematic_lines{"Line ".$line_number.": ".$line} = "Forbidden invocation of non-overriden core function detected!";
		}
	}

	if ($line =~ m/unshift\s*\@INC/ or $line =~ m/push\s*\(\s*\@INC/ or $line =~ m/push\s*\@INC/) {
		if ($line =~ m/#.*unshift\s*\@INC/ or $line =~ m/#.*push\s*\(\s*\@INC/ or $line =~ m/#.*push\s*\@INC/) {
			next;
		# Necessary exception for fatpacked scripts:
		} elsif ($line =~ m/unshift \@INC\, bless \\\%fatpacked\, \$class\;/) {
			next;
		} else {
			$problematic_lines{"Line ".$line_number.": ".$line} = "Forbidden \@INC array manipulation detected!";
		}
	}
}

##############################
# HTML HEADER AND FOOTER:
##############################
my $header = "<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - Errors</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
		<style type='text/css'>body {text-align: left}</style>\n
	</head>

	<body>";

my $footer = "</body>

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

	print STDERR $header;
	print STDERR "<p align='center'><font size='5' face='SansSerif'>";
	print STDERR "Script execution was not attempted due to security violation";
	if (scalar (keys %problematic_lines) == 1) {
		print STDERR ":</font></p>\n";
	} elsif (scalar (keys %problematic_lines) > 1) {
		print STDERR "s:</font></p>\n";
	}

	while ((my $line, my $explanation) = each (%problematic_lines)){
		print STDERR "<pre>";
		print STDERR "$line";
		print STDERR "$explanation";
		print STDERR "</pre>";
	}
	
	print STDERR $footer;
	exit;
}

##############################
# PRINT SAVED STDERR, IF ANY:
##############################
if ($@) {
	if ($@ =~ m/trapped/ or $@ =~ m/insecure/i) {
		print STDERR $header;
		print STDERR "<p align='center'><font size='5' face='SansSerif'>Insecure code was blocked:</font></p>\n";
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
