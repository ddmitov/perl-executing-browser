#!/usr/bin/perl

print "<html>\n";

print "<head>\n";

print "<title>Perl Executing Browser - Dynamic Startpage</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";

print "</head>\n";

print "<body bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://script/perlinfo.pl'>Perl Info</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://script/form.htm'>Form of a Locally Executed Perl Script</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='file:///home/knoppix/peb/peb.ini'>External Document</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='https://www.google.com/'>External Link</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='external:/gedit peb.ini'>External Program with an argument</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://openfile/now'>Open File</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://openfolder/now'>Open Folder</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://script/index.pl'>Reload - link to itself</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://script/sqlite.pl'>SQLite example</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://print/now'>Print</a>\n";
print "</font></p>\n";

print "<hr width='95%'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "<a href='local://close/now'>Close</a>\n";
print "</font></p>\n";

print "</body>\n";

print "</html>\n";
