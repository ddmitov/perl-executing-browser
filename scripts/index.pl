#!/usr/bin/perl -w

# UTF-8 encoded file

use strict;
use warnings;

print "Content-type: text/html; charset=utf-8\n\n";

print "<html>\n";

print "<head>\n";

print "<title>Perl Executing Browser - Dynamic Startpage</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "<link href='../html/current.css' media='all' rel='stylesheet' />\n";
print "</head>\n";

print "<body>\n";

print '<div class="container">'.$/;
print "<h3 align=\"center\">\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/perlinfo.pl'>Perl Info</a>\n";
print "</h3>\n";
print "<p align='center'><font size='3'>\n";
print "Non-core module loaded from directory, without system-wide installation.<br>\n";
print "<a href='http://search.cpan.org/dist/HTML-Perlinfo/lib/HTML/Perlinfo/HTML.pod'>http://search.cpan.org/dist/HTML-Perlinfo/lib/HTML/Perlinfo/HTML.pod</a><br>\n";
print "Copyright (c) 2009, Mike Accardo\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/sqlite.pl'>Perl SQLite Example</a>\n";
print "</font></p>\n";

#~ print "<p align='center'><font size='5'>\n";
#~ print "<a href='http://perl-executing-browser-pseudodomain/html/bgvol/index.htm'>BG Volumina</a>\n";
#~ print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/env.pl'>Perl Environment Test</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/phpinfo.php'>phpinfo()</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/env.py'>Python Environment Test</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/cgi-test.py'>Python CGI Example</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/index.pl' target='_blank'>Dynamic Start Page in a New Window</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/index.htm' target='_blank'>Static Start Page in a New Window</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/get.htm'>Form of a Locally Executed Perl Script - GET method</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/post.htm'>Form of a Locally Executed Perl Script - POST method</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='file:///home/knoppix/github/peb/peb.ini'>External Document</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='external:/gedit peb.ini'>External Program with an Argument</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
#print "<a href='http://www.perl.org/index.html'>Allowed External Link in This Browser</a>\n";
print "<a href='https://www.google.com/doodles/finder/'>Allowed External Link in This Browser</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
#print "<a href='http://www.perl.org/index.html' target='_blank'>Allowed External Link in a New Window of This Browser</a>\n";
print "<a href='https://www.google.com/doodles/finder/' target='_new'>Allowed External Link in a New Window of This Browser</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='https://www.google.com/'>External Link in Default Browser</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='selectperl://now'>Select Perl Interpreter</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='selectpython://now'>Select Python Interpreter</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='selectphp://now'>Select PHP Interpreter</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='selectskin://now'>Select Browser Skin</a>\n";
print "</p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='newfile://now'>Create New File</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='openfile://now'>Open Existing File</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='openfolder://now'>Open Existing Folder or Create a New One</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='perl_debugger_list_modules://now'>List All Modules of a Perl Script using<br>Built-in Perl Debugger</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='perl_debugger_list_subroutine_names://now'>List All Subroutine Names of a Perl Script using<br>Built-in Perl Debugger</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='perl_debugger_list_variables_in_package://now'>List All Variables of a Perl Script using<br>Built-in Perl Debugger</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='print://now'>Print</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://localhost:8080'>Localhost</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl'>Long-Running Script in This Window</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl' target='_blank'>Long-Running Script in a New Window</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/resizer.htm'>Resizer Long Running Example</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='closewindow://now'>Close Window</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5'>\n";
print "<a href='quit://now'>Quit Application</a>\n";
print "</font></p>\n";


print "</div>\n";
print "</body>\n";

print "</html>\n";