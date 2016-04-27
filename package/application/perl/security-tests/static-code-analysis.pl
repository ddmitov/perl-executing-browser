#!/usr/bin/perl -w

# STATIC CODE ANALYSIS TEST:
CORE::opendir (my $directory_handle, "/tmp/test") or die $!;
CORE::chdir "/tmp/test/";
CORE::open my $filehandle, "<", "/tmp/test" or die $!;
CORE::unlink "/tmp/test/foo.txt";

eval ("print 'Test'");

BEGIN {unshift @INC, qw(/tmp/test);}

BEGIN {push @INC, "/tmp/test";}

BEGIN {
	push
		(@INC, "/tmp/test");
}

my @NEW_INC;
@INC = @NEW_INC;
