#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT FOLDER_TO_OPEN QUERY_STRING REQUEST_METHOD CONTENT_LENGTH);
use CGI::Simple::Standard qw (:standard);

sub html_header() {
	print "<html>\n";

	print "<head>\n";
	print "<title>Perl Executing Browser - Image Resizer Test</title>\n";
	print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
	print "</head>\n";

	print "<body>\n";

	print "<p align='center'><font size='5'>\n";

	print "<br>\n";
	print "<a href='http://perl-executing-browser-pseudodomain/scripts/longrun_resizer_latest.pl?action=kill'><button type='button' autofocus>Kill Script</button></a>\n";
	print "<br><br>\n";
}

sub html_footer() {
	print "</font></p>\n";
	
	print "</body>\n";
	
	print "</html>\n";
}

opendir (DIR, $FOLDER_TO_OPEN) or die $!;

my $output_directory_name = "peb-converted-images";
my $output_directory = $FOLDER_TO_OPEN."/".$output_directory_name;
unless (-e $output_directory or mkdir $output_directory) {
	die "Unable to create $output_directory <br>\n";
}

while (my $file = readdir (DIR)) {
	# We only want files
	next unless (-f "$FOLDER_TO_OPEN/$file");
	# Use a regular expression to find files ending in .jpg
	next unless ($file =~ m/\.jpg$/);

	my $filepath_to_read = $FOLDER_TO_OPEN."/".$file;
	my $filepath_to_write = $FOLDER_TO_OPEN."/".$output_directory_name."/".$file;

	html_header();
	print "Converting $file ...<br>\n";
	my $result = `/usr/bin/convert $filepath_to_read -resize 20% $filepath_to_write`;
	html_footer();
}

closedir (DIR);

html_header();
print "Conversion successfully completed!\n";
html_footer();
