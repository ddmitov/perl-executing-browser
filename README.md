  
Perl Executing Browser, v.0.1  
peb-webkit  
  
Perl Executing Browser (PEB) is a Qt4/5 WebKit-powered browser,  
which is capable of executing Perl (possibly PHP/Python) scripts locally without a webserver,  
providing them with a nice HTML4/5 interface for both input and output and  
using CGI protocol GET method for communication between HTML forms and scripts.  
  
PEB can be used as a fast and easy GUI framework for Perl (possibly PHP/Python) scripts and  
has the following design objectives:  
1. Easy creation of nice and reusable HTML/CSS/JavaScript-powered GUIs for scripts;  
2. Zero installation solution:  
    pack your Perl modules or even your version of Perl with your copy of PEB browser and  
    the necessary Qt libraries and run your application from everywhere, even from USB sticks;  
3. Cross-platform availability:  
    use it on every platform and device (desktop, tablet, smartphone) where Perl and Qt4 or Qt5 could be compiled;  
4. More security for private data that does not need to be accessible over a network:  
    no services are started, no ports are opened, no firewall notifications,  
    no need to have administrative privileges, everything remains in the userspace.  
  
PEB also exposes some desktop functionalities to the user of the hosted scripts.  
These are accessible from special URLs and currently are:  
open file, open folder and close browser.  
File to open and folder to open are accessible for every script as $ARGV[0] and $ARGV[1].  
Printing current page by clicking a special URL is also supported.  
  
PEB is primarily intended as a basic framework for small personal databases,  
but many other use cases are also possible.  
Network connections are in no way out of reach, but they have to be  
implemented entirely in the scripts that PEB is going to execute.  
  
This small project is still in its very beginning and  
current version should be considered alpha pre-release.  
Do not use it for production purposes!  
Many features have to be polished and some have to be created from scratch.  
Documentation and proper examples are still missing...  
Compiled and tested successfully using:  
1. Qt Creator 2.5.0 and Qt 4.8.2 under 32 bit Debian Linux,  
2. Qt Creator 2.8.1 and Qt 5.1.1 under 32 bit Debian Linux.  
  
This software is licensed under the terms of GNU GPL v.3 and  
is provided without warranties of any kind!  
Dimitar D. Mitov, 2013, ddmitov (at) yahoo (dot) com  
  