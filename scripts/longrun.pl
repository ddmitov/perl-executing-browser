#!/usr/bin/perl -w

use strict;
use warnings;

############
my $waiting = 35;
############

$|=1; # Disable in-built Perl buffering

print <<WAITING
<html>

<head>

<title>Perl Executing Browser - Long-Running Script Test</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>

</head>

<body>

<p align='center'><font size='5' face='SansSerif'>

<center>
<br>
<!--http://www.javascriptkit.com/script/cut19.shtml-->
<form name='d'>Waiting for output <input type='text' name='d2' size='3'> seconds...</form>
</center>

<script>
<!--
/*By George Chiang. (JK's ultimate JavaScript tutorial and free JavaScripts site!)
http://www.javascriptkit.com
Credit MUST stay intact for use*/
var milisec=0
var seconds=0
document.d.d2.value='0'
function display(){
if (milisec>=9){
milisec=0
seconds+=1
}
else
milisec+=1
document.d.d2.value=seconds+'.'+milisec
setTimeout('display()',100)
}
display()
//-->
</script>

</font></p>

<hr width='95%'>

</body>

</html>

WAITING
;

sleep ($waiting);

print <<HTML;
<html>

<head>

<title>Perl Executing Browser - Long-Running Script Test</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>

</head>

<body text='#000000' bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>

<p align='center'><font size='5' face='SansSerif'>
<br>
Waited for output $waiting seconds!


<br><a href='https://www.google.com/doodles'>Allowed External Link</a><br>
<a href='closewindow://now'>Close window</a>


</font></p>

</body>

</html>
HTML
;
