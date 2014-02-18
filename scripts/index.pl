#!/usr/bin/perl -w

# UTF-8 encoded file

#use strict;
#use warnings;

print "Content-type: text/html; charset=utf-8\n\n";

print "<html>\n";

print "<head>\n";

print "<title>Perl Executing Browser - Dynamic Startpage</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";

print "</head>\n";

print "<body bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/perlinfo.pl'>Perl Info</a>\n";
print "</font>\n";
print "<p align='center'><font size='3' face='SansSerif'>\n";
print "Non-core module loaded from directory, without system-wide installation.<br>\n";
print "<a href='http://search.cpan.org/dist/HTML-Perlinfo/lib/HTML/Perlinfo/HTML.pod'>http://search.cpan.org/dist/HTML-Perlinfo/lib/HTML/Perlinfo/HTML.pod</a><br>\n";
print "Copyright (c) 2009, Mike Accardo\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/index.pl' target='_blank'>Dynamic Start Page in a New Window</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/index.htm' target='_blank'>Static Start Page in a New Window</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/get.htm'>Form of a Locally Executed Perl Script - GET method</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/post.htm'>Form of a Locally Executed Perl Script - POST method</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='file:///home/knoppix/github/peb/peb.ini'>External Document</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='external:/gedit peb.ini'>External Program with an Argument</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://www.perl.org/index.html'>Allowed External Link in This Browser</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://www.perl.org/index.html' target='_blank'>Allowed External Link in a New Window of This Browser</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='https://www.google.com/'>External Link in Default Browser</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='openfile://now'>Open Existing File</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='openfolder://now'>Open Existing Folder</a>\n";
print "</font></p>\n";

#~ print "<p align='center'><font size='5' face='SansSerif'>\n";
#~ print "<a href='newfile://now'>Create New File</a>\n";
#~ print "</font></p>\n";

#~ print "<p align='center'><font size='5' face='SansSerif'>\n";
#~ print "<a href='newfolder://now'>Create New Folder</a>\n";
#~ print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='perl_debugger_list_modules://now'>List All Modules of a Perl Script using<br>Built-in Perl Debugger</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='perl_debugger_list_subroutine_names://now'>List All Subroutine Names of a Perl Script using<br>Built-in Perl Debugger</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='perl_debugger_list_variables_in_package://now'>List All Variables of a Perl Script using<br>Built-in Perl Debugger</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='print://now'>Print</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/sqlite.pl'>SQLite Example</a>\n";
print "</font></p>\n";

#~ print "<p align='center'><font size='5' face='SansSerif'>\n";
#~ print "<a href='http://perl-executing-browser-pseudodomain/html/bgvol/index.htm'>BG Volumina</a>\n";
#~ print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://localhost:8080'>Localhost</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/env.pl'>Environment Test</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl'>Long-Running Script in This Window</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl' target='_blank'>Long-Running Script in a New Window</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='closewindow://now'>Close Window</a>\n";
print "</font></p>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='quit://now'>Quit Application</a>\n";
print "</font></p>\n";

print "</body>\n";

print "</html>\n";
 
