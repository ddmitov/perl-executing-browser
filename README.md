Perl Executing Browser, v.0.1  
peb-webkit

Perl Executing Browser is a Qt4/5 WebKit-powered browser,
which is capable of executing Perl (possibly PHP/Python) scripts locally without a webserver,
providing them with a nice HTML4/5 interface for both input and output and
using CGI protocol GET method for communication between web forms and scripts.

PEB can be used as an easy to deploy GUI for Perl (possibly PHP/Python) scripts and could give:
1. Less deployment complexity without additional dependencies;  
2. More security for private data that does not need to be accessible over a network;  
3. Foundation for nice, reusable and recognizable GUIs;  
4. Cross-platform GUI solution;  
5. Physical portability on USB sticks without installation procedures.  

Like similar solutions (node-webkit etc.), PEB exposes a small set of desktop functionalities
to the user of the hosted scripts. These are accessible from special URLs and currently are:
open file, open folder and close browser.  
File to open and folder to open are accessible to every script as $ARGV[0] and $ARGV[1] respectively.
Printing current page by clicking a special URL is also supported.  

This small project is still in its very beginning and  
current version should be considered alpha pre-release!  
Do not use it for production purposes!  
Many features have to be polished and some have to be created from scratch.  
Documentation and proper examples are still missing...  

This software is licensed under the terms of GNU GPL v.3 and  
is provided without warranties of any kind!  
Dimitar D. Mitov, 2013, ddmitov (dot) yahoo (dot) com
 
