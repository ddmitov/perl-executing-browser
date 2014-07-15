#!/usr/bin/perl -w

# UTF-8 encoded file

use strict;
use warnings;

print "Content-type: text/html; charset=utf-8\n\n";

print <<HTML
<html>

<head>
<title>Perl Executing Browser - Dynamic Startpage</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link href='http://perl-executing-browser-pseudodomain/html/current.css' media='all' rel='stylesheet'/>
</head>

<body>

<div class="container">

<p align='center'><font size='5'>
Local Scripting Examples
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/longrun_perlinfo.pl?theme=disabled'>Perl Info</a>
</font><br>
<font size='3'>
Based on <a href='https://metacpan.org/pod/HTML::Perlinfo'>HTML::Perlinfo</a> by Michael Accardo,<br>
a non-core module loaded from directory, without system-wide installation.</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/env.pl'>Perl Environment Test</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/sqlite.pl'>Perl SQLite Example</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/sqlite.pl?source=enabled' target='_blank'>Perl SQLite Example as source code</a>
</font><br>
<font size='3'>
(will open in a new window)<br>
Based on <a href='https://metacpan.org/pod/Syntax::Highlight::Engine::Kate'>
Syntax::Highlight::Engine::Kate</a> by Hans Jeuken and Gábor Szabó,<br>
also a non-core module loaded from directory, without system-wide installation.</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/env.py'>Python Environment Test</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/cgi-test.py'>Python CGI Example</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/phpinfo.php?theme=disabled'>phpinfo()</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
Local Scripting Tests
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/get.htm'>Form of a Locally Executed Perl Script - GET method</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/post.htm'>Form of a Locally Executed Perl Script - POST method</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/noextpl'>Perl Extensionless Script</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/noextpy'>Python Extensionless Script</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/dummy'>Unrecognizable File Type Test</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/timeout_test.pl'>Script Timeout Test</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
Long-Running Scripts
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl?output=latest'>Long-Running Script in This Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl?output=latest' target='_blank'>Long-Running Script in a New Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/resizer.htm'>Resizer Long Running Example</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
Perl Debugger Interaction
</font></p>

<p align='center'><font size='5'>
<a href='perl-debugger://select-file?command=M'>List All Modules</a>
</font></p>

<p align='center'><font size='5'>
<a href='perl-debugger://select-file?command=S'>List All Subroutine Names</a>
</font></p>

<p align='center'><font size='5'>
<a href='perl-debugger://select-file?command=V'>List All Variables</a>
</font></p>

<p align='center'><font size='5'>
<a href='perl-debugger://select-file'>Step-by-Step Debugging in This Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='perl-debugger://select-file' target='_blank'>Step-by-Step Debugging in a New Window</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
Web Interaction
</font></p>

<p align='center'><font size='5'>
<a href='https://www.google.com/doodles/finder/'>Allowed External Link Nr.1</a>
</font></p>

<p align='center'><font size='5'>
<a href='https://www.google.com/doodles/finder/' target='_blank'>Allowed External Link Nr.1 in a New Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://www.perl.org/'>Allowed External Link Nr.2</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://www.perl.org/' target='_blank'>Allowed External Link Nr.2 in a New Window</a>
</font></p>

<script>
function allowedContent() {
	window.open ('https://www.google.bg');
}
</script>

<p align='center'><font size='5'>
<button onclick='allowedContent()' class='btn btn-primary'>Open Allowed Content in a New Window from JavaScript</button>
</font></p>

<script>
function notAllowedContent() {
	window.open ('http://www.yahoo.com');
}
</script>

<p align='center'><font size='5'>
<button onclick='notAllowedContent()' class='btn btn-primary'>Not Allowed Content in a New Window from JavaScript - Blocked</button>
</font></p>

<p align='center'><font size='5'>
<a href='https://www.yahoo.com/'>Not Allowed External Link in Default Browser</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
Filesystem Interaction
</font></p>

<p align='center'><font size='5'>
<a href='newfile://'>Create New File</a>
</font></p>

<p align='center'><font size='5'>
<a href='openfile://'>Open Existing File</a>
</font></p>

<p align='center'><font size='5'>
<a href='openfolder://'>Open Existing Folder or Create a New One</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
Printing & PDF Creation
</font></p>

<p align='center'><font size='5'>
<a href='printpreview://'>Print Preview</a>
</font></p>

<p align='center'><font size='5'>
<a href='printing://'>Print</a>
</font></p>

<p align='center'><font size='5'>
<a href='pdf://'>Save as PDF</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
Settings
</font></p>

<p align='center'><font size='5'>
<a href='selectperl://'>Select Perl Interpreter</a>
</font></p>

<p align='center'><font size='5'>
<a href='selectpython://'>Select Python Interpreter</a>
</font></p>

<p align='center'><font size='5'>
<a href='selectphp://'>Select PHP Interpreter</a>
</font></p>

<p align='center'><font size='5'>
<a href='selecttheme://'>Select Browser Theme</a>
</p>

<hr width='95%'>

<p align='center'><font size='5'>
New Windows
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/main.pl' target='_blank'>Dynamic Start Page in a New Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/index.htm' target='_blank'>Static Start Page in a New Window</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='quit://'>Quit Application</a>
</font></p>

</div>

</body>

</html>
HTML
;
