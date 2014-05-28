#!/usr/bin/env python

# https://wiki.python.org/moin/CgiScripts

import cgi
import cgitb; cgitb.enable()  # for troubleshooting

print "Content-type: text/html"
print

print """
<html>

<head>
<title>Sample CGI Script from wiki.python.org</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
</head>

<body>

<font face='SansSerif'>

	<h3>Sample CGI Script from wiki.python.org</h3>
"""

form = cgi.FieldStorage()
message = form.getvalue ("message", "(no message)")

print """

	<p>Previous message: %s</p>

	<form method="post" action="http://perl-executing-browser-pseudodomain/scripts/cgi-test.py">
	<p>New message: <input type="text" name="message"/></p>
	</form>

</body>

</html>
""" % cgi.escape(message) 
