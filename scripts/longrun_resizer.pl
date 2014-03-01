#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT FILE_TO_OPEN NEW_FILE FOLDER_TO_OPEN QUERY_STRING REQUEST_METHOD CONTENT_LENGTH);
use CGI qw (:standard);

# http://perlmeme.org/faqs/file_io/directory_listing.html
opendir (DIR, $FOLDER_TO_OPEN) or die $!;

while (my $file = readdir (DIR)) {
	# We only want files
	next unless (-f "$FOLDER_TO_OPEN/$file");
	# Use a regular expression to find files ending in .jpg
	next unless ($file =~ m/\.jpg$/);

	my $slash = "/";
	my $filepath = $FOLDER_TO_OPEN.$slash.$file;
	my $converted = "_converted.jpg";
	my $file_converted = $filepath.$converted;
	header();
	print "Converting $file ...\n";
	my $result = `convert $filepath -resize 20% $file_converted`;
	footer();
}

closedir(DIR);
header();
print "Conversion successfully completed!\n";
footer();

sub header() {
	print "<html>\n";

	print "<head>\n";
	print "<title>Perl Executing Browser - Image Resizer Test</title>\n";
	print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
	print "</head>\n";

	print "<body bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>\n";

	print "<p align='center'><font size='5' face='SansSerif'>\n";
}

sub footer() {
	print "</font></p>\n";
	print "</body>\n";
	print "</html>\n";
}
