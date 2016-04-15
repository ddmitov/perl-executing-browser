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

# OVERRIDEN CORE FUNCTIONS TEST:
#~ use Win32::Registry;
#~ use Win32API::Registry
#~ use Win32::TieRegistry;
#~ use Win32::Registry::File;
#~ use Tree::Navigator::Node::Win32::Registry;
#~ use Parse::Win32Registry;
#~ use lib "/tmp/test";

#~ my $test = `uname -r`;

#~ unlink "/tmp/test";

#~ opendir (my $directory_handle, "/tmp/test") or die $!;
#~ chdir "/tmp/test/";
#~ chdir ("/tmp/test/");
#~ open my $filehandle, "<", "/tmp/test/foo.txt";
#~ open my $filehandle, "</tmp/test/foo.txt";


