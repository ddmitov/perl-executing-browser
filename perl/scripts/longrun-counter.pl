#!/usr/bin/perl -w

use strict;
use warnings;

$|=1; # Disable in-built Perl buffering

sub html_header() {
print <<HEADER
<!DOCTYPE html>
<html>

	<head>
		<title>Perl Executing Browser - Simple Perl 35 Seconds Counter</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>
	</head>

	<body>
		<p align='center'><font size='5'>Simple Perl 35 Seconds Counter</font></p>
		<p align='center'><font size='5'>
		
HEADER
;
}

sub html_footer() {
print <<FOOTER
		</font></p>
		<p align='center'><font size='5'>
		<a href='http://perl-executing-browser-pseudodomain/perl/scripts/longrun-counter.pl?action=kill' class="btn btn-danger btn-sm">Kill Script</a>
		</font></p>
	</body>

</html>
FOOTER
;
}

html_header();
print "Just starting...\n";
html_footer();

for (my $counter=1; $counter <= 35; $counter++){
	sleep (1);
	html_header();
	if ($counter == 1) {
		print "1 second elapsed.\n";
	}
	if ($counter > 1 and $counter < 35) {
		print "$counter seconds elapsed.\n";
	}
	if ($counter == 35) {
		print "35 seconds elapsed.<br>\n";
		print "Script has finished.\n";
	}
	html_footer();
}
