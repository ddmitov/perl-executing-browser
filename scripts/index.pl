#!/usr/bin/perl -w

# UTF-8 encoded file

use strict;
use warnings;


print "Content-Type: text/html\r\n\r\n";


print "<html>\n";

print "<head>\n";

print "<title>Perl Executing Browser - Dynamic Startpage</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";

print "</head>\n";

print "<body bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/perlinfo.pl'>Perl Info</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/get.htm'>Form of a Locally Executed Perl Script - GET method</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/post.htm'>Form of a Locally Executed Perl Script - POST method</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='file:///home/knoppix/github/peb/peb.ini'>External Document</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://www.youtube.com/'>Allowed External Link</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='https://www.google.com/'>External Link in Default Browser</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='external:/leafpad peb.ini'>External Program with an argument</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='openfile://now'>Open File</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='openfolder://now'>Open Folder</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/sqlite.pl'>SQLite example</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://perl-executing-browser-pseudodomain/html/bgvol/index.htm'>BG Volumina</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";


print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='http://localhost:8080'>Localhost</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
#print "<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl' target='_blank'>Long-running</a>\n";
print "<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl'>Long-Running Script</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='print://now'>Print</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='close://now'>Quit</a>\n";
print "</font></p>\n";

print "</body>\n";

print "</html>\n";
 
