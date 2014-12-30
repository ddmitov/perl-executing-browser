#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;

my $file = $ARGV[0];
open my $filehandle, '<', $file or die;
my @user_code = <$filehandle>;
close $filehandle;

my @allowed_use_pragmas = qw (attributes autodie autouse base bigint bignum bigrat open strict warnings utf8);
my @allowed_modules = qw (CGI::Simple::Standard Cwd DBI Env);
my @allowed_use_pragmas_or_module_names = (@allowed_use_pragmas, @allowed_modules);
my @prohibited_core_functions = qw (fork unlink);
my $prohibited_core_functions = join (' ', @prohibited_core_functions);

my $line_number;
my $real_line_number;
my @problematic_lines;
foreach my $line (@user_code) {
	$line_number++;
	$real_line_number = $line_number - 1;

	if ($line_number == 1) {
		my $first_line = $line;
		shift @user_code;
		my $safety_line = "no ops qw ($prohibited_core_functions);";
		unshift @user_code, $first_line, $safety_line;
	}

if ($line =~ m/\$ENV{'DOCUMENT_ROOT'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'DOCUMENT_ROOT'}/) {
			next;
		} else {
			push @problematic_lines, $line;
			print STDERR "Forbidden manipulation of 'DOCUMENT_ROOT' environment variable detected at line $real_line_number!\n\n";
			print STDERR "Line $real_line_number: $line\n";
		}
	}

	if ($line =~ m/\$ENV{'FILE_TO_OPEN'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'FILE_TO_OPEN'}/) {
			next;
		} else {
			push @problematic_lines, $line;
			print STDERR "Forbidden manipulation of 'FILE_TO_OPEN' environment variable detected at line $real_line_number!\n\n";
			print STDERR "Line $real_line_number: $line\n";
		}
	}

	if ($line =~ m/\$ENV{'FILE_TO_CREATE'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'FILE_TO_CREATE'}/) {
			next;
		} else {
			push @problematic_lines, $line;
			print STDERR "Forbidden manipulation of 'FILE_TO_CREATE' environment variable detected at line $real_line_number!\n\n";
			print STDERR "Line $real_line_number: $line\n";
		}
	}

	if ($line =~ m/\$ENV{'FOLDER_TO_OPEN'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'FOLDER_TO_OPEN'}/) {
			next;
		} else {
			push @problematic_lines, $line;
			print STDERR "Forbidden manipulation of 'FOLDER_TO_OPEN' environment variable detected at line $real_line_number!\n\n";
			print STDERR "Line $real_line_number: $line\n";
		}
	}

	if ($line =~ m/open\s/) {
		# commented 'open' is not a treat and is allowed
		if ($line =~ m/#.*open/) {
			next;
		} else {
			# 'open' from DOCUMENT_ROOT is allowed
			if ($line =~ m/(open my \$filehandle, '<', \"\$ENV{'DOCUMENT_ROOT'}\$relative_filepath\" or)/) {
				next;
			# 'use open' pragma is also allowed
			} elsif ($line =~ "use open") {
				next;
			# every other use of 'open' is not allowed
			} else {
				push @problematic_lines, $line;
				print STDERR "Forbidden use of 'open' function detected at line $real_line_number!\n\n";
				print STDERR "Line $real_line_number: $line\n";
			}
		}
	}

	if ($line =~ m/use\s/) {
		# commented 'use' is not a treat and is allowed
		if ($line =~ m/#.*use/) {
				next;
		} else {
			my $use_pragma_or_module_name = $line;
			$use_pragma_or_module_name =~ s/use\s//;
			$use_pragma_or_module_name =~ s/\sqw.*//;
			$use_pragma_or_module_name =~ s/;//;
			chomp $use_pragma_or_module_name;
			if ($use_pragma_or_module_name =~ m/5\.\d/) { 
				next;
			} elsif (grep (/$use_pragma_or_module_name/, @allowed_use_pragmas_or_module_names)) { 
				next;
			} else {
				push @problematic_lines, $line;
				print STDERR "Forbidden 'use' pragma or unauthorized module detected at line $real_line_number!\n\n";
				print STDERR "Line $real_line_number: $line\n";
			}
		}
	}

}

if (scalar (@problematic_lines) == 0) {
	my $user_code = join ('', @user_code);
	eval ($user_code);
} else {
	print STDERR "Security violations were found and execution of user script was not attempted!\n";
}

if ($@) {
	die "Unsecure code was blocked or script died due to it's own problems!\n$@";
}
