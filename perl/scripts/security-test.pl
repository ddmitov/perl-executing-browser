#!/usr/bin/perl -w

use strict;
use warnings;

#~ print STDERR "STDERR printing test is successfull.\n";

#~ my $test = `uname -r`;
#~ unlink "/tmp/test.txt";

#~ opendir (my $directory_handle, "/tmp/test") or die $!;
#~ chdir "/tmp/test/";
#~ chdir ("/tmp/test/");
#~ open my $filehandle, "<", "/tmp/test/foo.txt";
#~ open my $filehandle, "</tmp/test/foo.txt";

#~ CORE::opendir (my $directory_handle, "/tmp/test") or die $!;
#~ CORE::chdir "/tmp/test/";
#~ CORE::open my $filehandle, "<", "/tmp/test/foo.txt";

#~ use lib "/tmp/test";

#~ BEGIN {
	#~ unshift @INC,
		#~ qw(/tmp/test1
			#~ /tmp/test2
		#~ );
#~ }

#~ BEGIN {
	#~ push @INC, '/tmp/test';
#~ }

#~ BEGIN {
	#~ push (@INC, "/tmp/test");
#~ }