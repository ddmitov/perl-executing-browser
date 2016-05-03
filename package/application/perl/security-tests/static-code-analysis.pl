#!/usr/bin/perl -w

CORE::unlink "/tmp/test/foo.txt";

CORE::require Win32::Registry;

eval ("print 'Test'");

BEGIN {unshift @INC, qw(/tmp/test);}

BEGIN {push @INC, "/tmp/test";}

BEGIN {
	push
		(@INC, "/tmp/test");
}

my @NEW_INC;
@INC = @NEW_INC;
