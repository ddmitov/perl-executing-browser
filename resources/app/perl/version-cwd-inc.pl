#!/usr/bin/perl

use strict;
use warnings;
use Cwd;

print "<!DOCTYPE html>
<html>

  <head>
    <title>Perl Executing Browser - Perl Basic Information</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <meta charset='utf-8'>
    <link rel='stylesheet' type='text/css' href='http://local-pseudodomain/bootstrap/css/themes/darkly-theme.css' media='all'>
    <style type='text/css'>
      body {
        text-align: left;
        font-size: 22px;
        -webkit-text-size-adjust: 100%;
      }
      pre {
        font-size: 14px;
        font-family: monospace;
      }
    </style>
  </head>

  <body>
    <p align='center'>
      Perl Basic Information
    </p>
<pre>\n";

print "Perl $^V\n\n";

my $cwd = cwd();
print "Working Directory:\n$cwd\n";

print "\n\@INC Array:\n";

print join "\n", @INC;

print "\n</pre>
  </body>

</html>\n";
