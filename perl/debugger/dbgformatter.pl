#!/usr/bin/perl -w

use strict;
use warnings;
use Term::ANSIColor;
use Syntax::Highlight::Engine::Kate;

my $debugger_command = "DEBUGGER_COMMAND";

##############################
# EMBEDDED HTML TEMPLATE:
##############################
my $html = "<html>

    <head>
        <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
        <link rel='stylesheet' type='text/css' href='http://perl-executing-browser-page-pseudodomain/html/current.css' media='all' />
        <title>Perl Debugger GUI</title>

        <style type='text/css'>
            body {
                text-align: left;
            }
            ol {
                font-family: monospace;
                font-size: 12px;
                background-color: #FFFFFF;
                color: #000000;
                -webkit-user-select: none;
                list-style-type: decimal;
                background-color: #C0C0C0;
                padding-left: 6%;
                text-indent: 1.5%;
                border: transparent 3px;
            }
            li {
                background-color: #FFFFFF;
            }
            div.centered {
                text-align: center;
            }
            div.source {
                width: 100%;
                SOURCE_BOX_HEIGHT
                overflow: auto;
            }
            div.line {
                -webkit-user-select: auto;
            }
            div.debugger {
                background-color: #000000;
                color: #00FF00;
                font-family: monospace;
                font-size: 14px;
                padding: 16px;
                width: 100%;
                DEBUGGER_OUTPUT_BOX_HEIGHT
                overflow: auto;
            }
            div.html {
                width: 100%;
                HTML_BOX_HEIGHT
                overflow: auto;
            }
        </style>

        <script type='text/javascript'>
        function sendCommand (cmd) {
            document.getElementById ('command').value = cmd;
        }
        function scrollTo (hash) {
            location.hash = '#' + hash;
        }
        </script>

    </head>

    <body onload='scrollTo(SCROLL_TO_LINE)'>

    <div class='centered'>
            <b>Debugging SCRIPT</b>
    </div>

    <div class='source'>
        <ol>
HIGHLIGHTED_SOURCE
        </ol>
    </div>

        <form action='file://SCRIPT' method='get'>
            <div class='form-group'>
                <div class='centered'>
                <b>FILE_TO_HIGHLIGHT</b>
                </div>
                <div class='input-prepend'>
                    <input type='text' id='command'
                        name='command' class='form-control'
                        placeholder='Type Perl debugger command and press Enter' title='Debugger Command'/>
                </div>
            </div>

            <div class='form-group'>
                <input type='submit' style='visibility: hidden; width: 0px; height: 0px; opacity: 0; border: none; padding: 0px;' />
                Commands: 
                <button onClick=\"sendCommand('n')\" class='btn btn-info btn-xs' title='Next line'>n</button>
                <button onClick=\"sendCommand('r')\" class='btn btn-info btn-xs' title='Return from subroutine'>r</button>
                <button onClick=\"sendCommand('c')\" class='btn btn-info btn-xs' title='Continue'>c</button>
                <button onClick=\"sendCommand('M')\" class='btn btn-info btn-xs' title='List All Modules'>M</button>
                <button onClick=\"sendCommand('S')\" class='btn btn-info btn-xs' title='List All Subroutine Names'>S</button>
                <button onClick=\"sendCommand('V')\" class='btn btn-info btn-xs' title='List All Variables'>V</button>
                <button onClick=\"sendCommand('X')\" class='btn btn-info btn-xs' title='List Variables in Current Package'>X</button>
                <button onClick=\"sendCommand('s')\" class='btn btn-info btn-xs' title='Step Into...'>s</button>
                <button onClick=\"sendCommand('R')\" class='btn btn-info btn-xs' title='Restart debugger for SCRIPT'>R</button>
                &nbsp;DEBUGGER_COMMAND_MESSAGE
            </div>
        </form>

        <div class='debugger'>
DEBUGGER_OUTPUT
        </div>

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
                    "<li value='${line_number}'><a name='${line_number}'></a><div class='line'>${highlighted_line}</div></li>\n";
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
