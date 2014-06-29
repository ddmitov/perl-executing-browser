#!/usr/bin/env python

# http://www.tutorialspoint.com/python/python_cgi_programming.htm

import os

print "Content-type: text/html\r\n\r\n"

print "<html>"
print "<head>"
print "<title>Python Environment Test</title>"
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "<style type='text/css'>body {text-align: left}</style>\n";
print "</head>\n";

print "<body>";
print "<p align='center'><font size='5' face='SansSerif'>Python Environment Test</font></p>";

for param in os.environ.keys():
	print "<b>%20s:</b> %s<br>\n" % (param, os.environ[param])

print "</body>"
print "</html>"
