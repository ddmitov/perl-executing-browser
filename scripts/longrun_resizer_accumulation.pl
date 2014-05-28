#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT FOLDER_TO_OPEN QUERY_STRING REQUEST_METHOD CONTENT_LENGTH);
use CGI qw (:standard);

# http://perlmeme.org/faqs/file_io/directory_listing.html
opendir (DIR, $FOLDER_TO_OPEN) or die $!;

print "<html>\n";

print "<head>\n";
print "<title>Perl Executing Browser - Image Resizer Test</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "</head>\n";

print "<body>\n";

print "<p align='center'><font size='5'>\n";

print "Conversion started.<br>\n";

while (my $file = readdir (DIR)) {
	# We only want files
	next unless (-f "$FOLDER_TO_OPEN/$file");
	# Use a regular expression to find files ending in .jpg
	next unless ($file =~ m/\.jpg$/);

	my $slash = "/";
	my $filepath = $FOLDER_TO_OPEN.$slash.$file;
	my $converted = "_converted.jpg";
	my $file_converted = $filepath.$converted;

	print "Converting $file ...<br>\n";
	my $result = `convert $filepath -resize 20% $file_converted`;
}

closedir (DIR);

print "Conversion successfully completed!\n";

print "</font></p>\n";

print "</body>\n";

print "</html>\n";
