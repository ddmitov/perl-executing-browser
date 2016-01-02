#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (FOLDER_TO_OPEN);

sub html_header() {
print <<HEADER
<html>

	<head>
	<title>Perl Executing Browser - Image Resizer with Only Latest Results</title>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	</head>

	<body>
		<p align='center'><font size='5'>
HEADER
;
}

sub html_footer() {
print <<FOOTER
		</font></p>
	</body>
</html>
FOOTER
;
}

opendir (DIR, $FOLDER_TO_OPEN) or die $!;

my $output_directory_name = "peb-converted-images";
my $output_directory_full_path = $FOLDER_TO_OPEN."/".$output_directory_name;
unless (-e $output_directory_full_path or mkdir $output_directory_full_path) {
	die "Unable to create $output_directory_full_path <br>\n";
}

while (my $file = readdir (DIR)) {
	# Only files are selected:
	next unless (-f "$FOLDER_TO_OPEN/$file");
	# Regular expression is used to find files ending in .jpg:
	next unless ($file =~ m/\.jpg$/);

	my $filepath_to_read = $FOLDER_TO_OPEN."/".$file;
	my $filepath_to_write = $output_directory_full_path."/".$file;

	html_header();
	print "Resizing $file ...<br>\n";
	my $result = `/usr/bin/convert $filepath_to_read -resize 20% $filepath_to_write`;
	html_footer();
}

closedir (DIR);

html_header();
print "Resizing successfully completed!\n";
html_footer();
