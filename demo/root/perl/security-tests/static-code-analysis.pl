#!/usr/bin/perl -w

# STATIC CODE ANALYSIS TEST:
CORE::opendir (my $directory_handle, "/tmp/test") or die $!;
CORE::chdir "/tmp/test/";
CORE::open my $filehandle, "<", "/tmp/test/foo.txt";
CORE::unlink "/tmp/test/foo.txt";

BEGIN {unshift @INC, qw(/tmp/test);}

BEGIN {push @INC, "/tmp/test";}

BEGIN {
	push
		(@INC, "/tmp/test");
}
