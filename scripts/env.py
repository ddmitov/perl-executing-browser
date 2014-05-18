#!/usr/bin/env python

# http://www.tutorialspoint.com/python/python_cgi_programming.htm

import os

print "Content-type: text/html\r\n\r\n"

print "<html>"
print "<head>"
print "<title>Python Environment Test</title>"
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";
print "</head>\n";

#print "<body bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>\n";
print "<p align='center'><font size='5' face='SansSerif'>Python Environment Test</p>";
print "<p align='center'><font size='3' face='SansSerif'>";
for param in os.environ.keys():
	print "<b>%20s:</b> %s<br>" % (param, os.environ[param])
print "</font></p>";
print "</body>"
print "</html>"
