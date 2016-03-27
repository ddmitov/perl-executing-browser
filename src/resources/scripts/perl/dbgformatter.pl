#!/usr/bin/perl -w

use strict;
use warnings;
use Term::ANSIColor;
use Syntax::Highlight::Engine::Kate;

my $debugger_command = "DEBUGGER_COMMAND";

##############################
# EMBEDDED HTML TEMPLATE:
##############################
my $html = "
<!DOCTYPE html>
<html>

	<head>

		<title>Perl Debugger GUI</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<meta charset='utf-8'>

		<style type='text/css'>
			body {
				text-align: center;
				font-family: sans-serif;
				font-size: 14px;
				color: #ffffff;
				background-color: #222222;
				-webkit-text-size-adjust: 100%;
				}
			div.source {
				width: 100%;
				SOURCE_BOX_HEIGHT
				overflow: auto;
			}
			ol {
				text-align: left;
				font-family: monospace;
				font-size: 14px;
				background-color: #FFFFFF;
				color: #000000;
				-webkit-user-select: none;
				list-style-type: decimal;
				background-color: #C0C0C0;
				padding-left: 6%;
				text-indent: 1%;
				margin: 4px 4px 4px 4px;
				border: transparent 3px;
			}
			li {
				background-color: #FFFFFF;
			}
			div.line {
				-webkit-user-select: auto;
			}
			input[type=text] {
				font-family: sans-serif;
				font-size: 14px;
				appearance: none;
				box-shadow: none;
				display: block;
				margin: 2px 2px 2px 2px;
				border: 1px solid white;
				width: 99%;
				border-radius: 3px;
				padding: 3px 3px 3px 3px;
			}
			input[type=text]:focus {
				outline: none;
			}
			div.btn-area {
				text-align: left;
				padding: 10px 0px 10px 0px;
			}
			.btn {
				background: #3498db;
				background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
				background-image: -o-linear-gradient(top, #3498db, #2980b9);
				background-image: linear-gradient(to bottom, #3498db, #2980b9);
				color: #ffffff;
				font-family: sans-serif;
				font-size: 14px;
				text-decoration: none;
				-webkit-border-radius: 3;
				border-radius: 3px;
				padding: 3px 5px 3px 5px;
			}
			.btn:hover {
				background: #3cb0fd;
				background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
				background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
				background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
				text-decoration: none;
			}
			div.debugger {
				text-align: left;
				font-family: monospace;
				font-size: 14px;
				color: #00FF00;
				background-color: #000000;
				padding: 16px;
				width: 99%;
				DEBUGGER_OUTPUT_BOX_HEIGHT
				overflow: auto;
				-webkit-border-radius: 3;
				border-radius: 3px;
				padding: 3px 5px 3px 5px;
			}
		</style>

	</head>

	<body>

		<div class='source'>
			<b>Debugging SCRIPT</b>
			<ol>
HIGHLIGHTED_SOURCE
			</ol>
		</div>

		<form action='http://perl-executing-browser-pseudodomain/perl-debugger.function' method='get'>

			<b>FILE_TO_HIGHLIGHT</b>
			<input type='text' name='command' placeholder='Type Perl debugger command and press Enter' title='Debugger Command'/>

			<div class='btn-area'>
				<input type='submit' style='visibility: hidden; width: 0px; height: 0px; opacity: 0; border: none; padding: 0px;'/>
				Commands: 
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=n' class='btn' title='Next line'>n</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=r' class='btn' title='Return from subroutine'>r</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=c' class='btn' title='Continue'>c</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=M' class='btn' title='List All Modules'>M</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=S' class='btn' title='List All Subroutine Names'>S</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=V' class='btn' title='List All Variables'>V</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=X' class='btn' title='List Variables in Current Package'>X</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=s' class='btn' title='Step Into...'>s</a>
				<a href='http://perl-executing-browser-pseudodomain/perl-debugger.function?command=R' class='btn' title='Restart debugger'>R</a>
				&nbsp; DEBUGGER_COMMAND_MESSAGE
			</div>
		</form>

		<div class='debugger'>
DEBUGGER_OUTPUT
		</div>

		<script type='text/javascript'>
		var scrollToLine = document.getElementById('SCROLL_TO_LINE');
		scrollToLine.scrollIntoView();
		</script>

	</body>

</html>
";

##############################
# READING PERL DEBUGGER OUTPUT:
##############################
my $perl_debugger_output;
read (STDIN, $perl_debugger_output, $ENV{'CONTENT_LENGTH'});

my $lineinfo;
my @debugger_output = split /\n/, $perl_debugger_output;
foreach my $debugger_output_line (@debugger_output) {
	if ($debugger_output_line =~ m/[\(\[].*\:{1,1}\d{1,5}[\)\]]/) {
		$lineinfo = $debugger_output_line;
	}
}

# Purely aesthetic replacement:
$perl_debugger_output =~ s/\`/\'/g;
# Editor support is not available within the Perl debugger GUI:
$perl_debugger_output =~ s/Editor support available.\n//g;
# Remove debugger command prompt line:
$perl_debugger_output =~ s/\s{1,}DB\<\d{1,}\>\s//g;
# Escape any angled brackets from HTML tags so that
# any HTML output from the debugger is not rendered;
# sequence of substitute statements is important here:
$perl_debugger_output =~ s/\</&lt;/g;
$perl_debugger_output =~ s/\</&gt;/g;
# Replace any tabs with spaces:
$perl_debugger_output =~ s/\t/ /g;
# Replace three or more newline characters with two newline characters and HTML <br> tags;
# sequence of substitute statements is important here too:
$perl_debugger_output =~ s/\n{3,}/\n<br>\n<br>/g;
# Replace any still not replaced newline characters with a newline character and an HTML <br> tag.
$perl_debugger_output =~ s/\n/\n<br>/g;
# Replace two spaces with two HTML whitespace entities:
$perl_debugger_output =~ s/  /\&nbsp\;\&nbsp\;/g;

my $file_to_highlight;
my $line_to_underline;
if (defined $lineinfo) {
	chomp $lineinfo;
	$lineinfo =~ s/^.*[\(\[]//g;
	$lineinfo =~ s/[\)\]].*//g;

	# Split-based solution is good for Unix-like systems,
	# but what about Windows machines, where filepaths are like
	# "C:\Perl\lib" or something like that?
	#my ($file_to_highlight, $line_to_underline) = split /:/, $lineinfo;

	$file_to_highlight = $lineinfo;
	$line_to_underline = $lineinfo;
	$file_to_highlight =~ s/\:\d{1,}$//g;
	$line_to_underline =~ s/^.*\://g;
}

##############################
# SYNTAX HIGHLIGHTING:
##############################
my $formatted_perl_source_code;
my $scroll_to_line;
if (defined $lineinfo) {
	# Open the file to highlight read-only:
	my $file_to_highlight_filehandle;
	open ($file_to_highlight_filehandle, "<", "$file_to_highlight");

	# Read the file and push it into an array:
	my @source_to_highlight_lines = <$file_to_highlight_filehandle>;
	my $total_lines = scalar @source_to_highlight_lines;

	# Close the file to highlight:
	close ($file_to_highlight_filehandle);

	# Syntax-highlight the necessary part of the debugged Perl code:
	my $start_line = $line_to_underline - 15;
	my $end_line = $line_to_underline + 15;
	$scroll_to_line = $line_to_underline - 5;

	my $line_number;
	foreach my $source_to_highlight_line (@source_to_highlight_lines) {
		$line_number++;

		if ($line_number >= $start_line and $line_number <= $end_line) {
			my $source_code_language = "Perl";
			my $source_code_highlighter = source_code_highlighter($source_code_language);
			my $highlighted_line = $source_code_highlighter->highlightText ($source_to_highlight_line);

			my $formatted_perl_source_line;
			if ($line_number eq $line_to_underline) {
				$formatted_perl_source_line =
					"<li style='background-color: #CCCCCC;' value='${line_number}'><div class='line'>${highlighted_line}</div></li>\n";
				$formatted_perl_source_code = $formatted_perl_source_code.$formatted_perl_source_line;
			} elsif ($line_number eq $scroll_to_line) {
				$formatted_perl_source_line =
					"<li value='${line_number}'><div id='${line_number}' class='line'>${highlighted_line}</div></li>\n";
				$formatted_perl_source_code = $formatted_perl_source_code.$formatted_perl_source_line;
			} else {
				$formatted_perl_source_line =
					"<li value='${line_number}'></a><div class='line'>${highlighted_line}</div></li>\n";
				$formatted_perl_source_code = $formatted_perl_source_code.$formatted_perl_source_line;
			}
		}
	}
}

##############################
# TEMPLATE MANIPULATION:
##############################
my $source_box_height;
my $debugger_output_box_height;
if (defined $lineinfo) {
	my $file_to_highlight_message = "Highlighting ${file_to_highlight}";
	$html =~ s/FILE_TO_HIGHLIGHT/$file_to_highlight_message/g;
	$html =~ s/HIGHLIGHTED_SOURCE/$formatted_perl_source_code/g;
	$html =~ s/SCROLL_TO_LINE/$scroll_to_line/g;
	$source_box_height = "height: 42%;";
	$html =~ s/SOURCE_BOX_HEIGHT/$source_box_height/g;
	$debugger_output_box_height = "height: 34%;";
	$html =~ s/DEBUGGER_OUTPUT_BOX_HEIGHT/$debugger_output_box_height/g;
	$html =~ s/DEBUGGER_OUTPUT/$perl_debugger_output/g;
} else {
	$source_box_height = "height: 0%;";
	$html =~ s/SOURCE_BOX_HEIGHT/$source_box_height/g;
	$debugger_output_box_height = "height: 75%;";
	$html =~ s/DEBUGGER_OUTPUT_BOX_HEIGHT/$debugger_output_box_height/g;
	$html =~ s/DEBUGGER_OUTPUT/$perl_debugger_output/g;
	$html =~ s/FILE_TO_HIGHLIGHT//g;
	$html =~ s/HIGHLIGHTED_SOURCE//g;
	$html =~ s/SCROLL_TO_LINE//g;
}

my $debugger_command_message = "Last command: ${debugger_command}";
if (length ($debugger_command) >= 1) {
	$html =~ s/DEBUGGER_COMMAND_MESSAGE/$debugger_command_message/g;
} else {
	$html =~ s/DEBUGGER_COMMAND_MESSAGE//g;
}

print $html;

##############################
# SYNTAX HIGHLIGHTING SETTINGS SUBROUTINE:
##############################
sub source_code_highlighter {
	# Syntax::Highlight::Engine::Kate settings:
	my ($source_code_language) = @_;
	my $source_code_highlighter = new Syntax::Highlight::Engine::Kate(
	language =>  $source_code_language,
		substitutions => {
		"<" => "&lt;",
		">" => "&gt;",
		"&" => "&amp;",
		" " => "&nbsp;",
		"\t" => "&nbsp;&nbsp;&nbsp;",
		"\n" => "",
	},
	format_table => {
		Alert => ["<font color=\"#0000ff\">", "</font>"],
		BaseN => ["<font color=\"#007f00\">", "</font>"],
		BString => ["<font color=\"#c9a7ff\">", "</font>"],
		Char => ["<font color=\"#ff00ff\">", "</font>"],
		Comment => ["<font color=\"#7f7f7f\"><i>", "</i></font>"],
		DataType => ["<font color=\"#0000ff\">", "</font>"],
		DecVal => ["<font color=\"#00007f\">", "</font>"],
		Error => ["<font color=\"#ff0000\"><b><i>", "</i></b></font>"],
		Float => ["<font color=\"#00007f\">", "</font>"],
		Function => ["<font color=\"#007f00\">", "</font>"],
		IString => ["<font color=\"#ff0000\">", ""],
		Keyword => ["<b>", "</b>"],
		Normal => ["", ""],
		Operator => ["<font color=\"#ffa500\">", "</font>"],
		Others => ["<font color=\"#b03060\">", "</font>"],
		RegionMarker => ["<font color=\"#96b9ff\"><i>", "</i></font>"],
		Reserved => ["<font color=\"#9b30ff\"><b>", "</b></font>"],
		String => ["<font color=\"#ff0000\">", "</font>"],
		Variable => ["<font color=\"#0000ff\"><b>", "</b></font>"],
		Warning => ["<font color=\"#0000ff\"><b><i>", "</b></i></font>"],
		},
	 );
	return $source_code_highlighter;
}
