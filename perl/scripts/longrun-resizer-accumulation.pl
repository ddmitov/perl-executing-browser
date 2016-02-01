#!/usr/bin/perl -w

use strict;
use warnings;
use Image::Magick;
use Env qw (FOLDER_TO_OPEN);

print <<HEADER
<html>

	<head>
		<title>Perl Executing Browser - Image Resizer with Accumulation of Results</title>
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
		<script type="text/javascript">
			function scrollDown() {
				window.scrollTo(0, document.body.scrollHeight);
			}
		</script>
	</head>

	<body onload="scrollDown()">
		<p align='center'>
			<font size='5'>
HEADER
;

opendir (my $directory_handle, $FOLDER_TO_OPEN) or die $!;

my $output_directory_name = "peb-converted-images";
my $output_directory_full_path = $FOLDER_TO_OPEN."/".$output_directory_name;
unless (-e $output_directory_full_path or mkdir $output_directory_full_path) {
	die "Unable to create $output_directory_full_path <br>\n";
}

while (my $file = readdir ($directory_handle)) {
	# Only files are selected:
	next unless (-f "$FOLDER_TO_OPEN/$file");
	# Regular expression is used to find files ending in .jpg:
	next unless ($file =~ m/\.jpg$/i);

	my $filepath_to_read = $FOLDER_TO_OPEN."/".$file;
	my $filepath_to_write = $output_directory_full_path."/".$file;

	my $image=Image::Magick->new();
	print "Resizing $file ...<br>\n";
	$image->Read($filepath_to_read);
	$image->AdaptiveResize('20%');
	$image->Write($filepath_to_write);
}

closedir ($directory_handle);

print <<FOOTER
				Resizing successfully completed!
			</font>
		</p>
	</body>

</html>
FOOTER
;
