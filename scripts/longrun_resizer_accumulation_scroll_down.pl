#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (FOLDER_TO_OPEN);

opendir (DIR, $FOLDER_TO_OPEN) or die $!;

print <<HEADER
<html>

<head>
<title>Perl Executing Browser - Image Resizer Test</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>

<script type="text/javascript">
function scrollDown()
{
	window.scrollTo(0, document.body.scrollHeight);
}
</script>

</head>

<body onload="scrollDown()">

<p align='center'><font size='5'>

<br>
<a href='http://perl-executing-browser-pseudodomain/scripts/longrun_resizer_accumulation.pl?action=kill'><button type='button' autofocus>Kill Script</button></a>
<br><br>

Conversion started.<br>
HEADER
;

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

	print "Converting $file ...<br>\n";
	my $result = `/usr/bin/convert $filepath_to_read -resize 20% $filepath_to_write`;
}

closedir (DIR);

print <<FOOTER
<br>Conversion successfully completed!<br><br>

</font></p>

</body>

</html>
FOOTER
;
