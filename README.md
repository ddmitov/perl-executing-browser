  
Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a Qt4/5 WebKit browser capable of executing Perl scripts locally with or even without a webserver. Serverless execution of local scripts can go side by side with a traditional access to local or remote webservers. CGI protocol GET and POST methods are used for communication with scripts executed without a webserver.  
  
Design Objectives
----------------------------------------------------------------------------------------
  
* **1. Easy GUI for scripts:**  
    use HTML, CSS and JavaScript to craft and deploy rapidly beautifull interfaces for your Perl, PHP, Python or other scripts;  
* **2. Zero installation when needed:**  
    pack your Perl modules and even your version of Perl with a copy of PEB and its Qt libraries and run your application from every folder, even from USB sticks;  
* **3. Cross-platform availability:**  
    use it on every platform and device (desktop, tablet, smartphone), where Perl and Qt can be compiled;  
* **4. Flexible network access:**  
    **a)** if no network connectivity is wanted or needed, no services are started, no ports are opened, no firewall notifications are triggered, no need for administrative privileges and everything remains in the userspace, but  
    **b)** if network connection is essential, PEB can be configured as a client or both as a client and server for network services in a variety of combinations and topologies.  
    Local webserver functionality, if needed, is provided by a separate binary, which can be easily changed or independently modified.  
  
Features
----------------------------------------------------------------------------------------
  
* **No feature or implementation should be considered final at this early stage of development!**  
**Scripting:**  
* Can execute CGI scripts locally in a serverless mode, feeding them from standard forms using CGI protocol GET and POST methods.  
* Can execute long-running scripts - i.e. scripts running for arbitrary long time. Output can be displayed in the same or in a new window.  
* Can load Perl modules from a custom directory when they are not installed system-wide using PERLLIB environment variable. These modules are available for all scripts executed in serverless mode, as well as for all scripts executed by the local webserver (Mongoose).  
**Networking:**  
* Can start local webserver and load scripts and pages from localhost. Mongoose 5.1 webserver with an URI handler that can stop the server is used.  
* Can ping local and remote web servers and notify when network connectivity is lost. Local webserver is automatically restarted if accidentally terminated. Local webserver is shut down simultaneously with the browser.  
* Can load a predefined website in the same or in a new window and be used as a site-specific browser or client for a web service.  
**Local filesystem:**  
* Can open single file or folder on the local file system by clicking special URLs. Any locally executed script has access to environment variables FILE_TO_OPEN and FOLDER_TO_OPEN.  
* Can open local documents using default applications and start user-specified programs.  
**Development goodies:**  
* WebKit Web Inspector can be invoked from context menu.  
* Local scripts and pages can be edited in external editor using context menu entry.  
* Can interact with the built-in Perl debugger (Linux and Mac for now). An arbitrary Perl script can be selected by clicking special URLs and separate output from three debugger commands can be displayed in the browser. These commands are: "Show module versions", "List subroutine names" and "List Variables in Package". Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.  
**Configuration & usability:**  
* Configurable from INI file.  
* Can print current page by clicking a special URL.  
* Browser can also be closed by clicking a special URL.  
* Rebrandable - program icon can be changed without recompilation, user agent can also be changed.  
* Can be used in normal or frameless window in resizable, fixed size or fullscreen mode. 100% of the browser screen area are dedicated to HTML, CSS and JavaScript interfaces. Basic program functions are accessible from a right-click context menu.  
* Output from local scripts, local and allowed web pages can be opened in new window; 'Open in new window' from context menu.  
* System tray icon & menu.  
  
Runtime Requirements
----------------------------------------------------------------------------------------
  
* Qt libraries - Qt4 libraries, if you compiled the program using Qt4 classes or Qt5 libraries, if you compiled the program using Qt5 classes.  
* Perl 5 distribution - any standard Linux or Mac Perl distribution or Strawberry Perl for Windows.  
* Only if you want to run PHP scripts - standard PHP distribution including ```php-cgi``` executable.  
* Only if you want to run Python scripts - standard Python distribution for your operating system.  
  
Limitations
----------------------------------------------------------------------------------------
  
* No history, no cache and no 'Previous Page' or 'Next Page' from JavaScript or from context menu. Only latest output from every script is displayed! User navigation has to be based on working hyperlinks.  
* No 'Reload' action from context menu, but auto-reload using ```<meta http-equiv='refresh' content='XX'>``` is supported.  
* No opening of new windows from JavaScript, although opening new windows from hyperlinks using ```target = '_blank'``` attribute is supported.  
* No support for serverless execution of scripts based on PSGI, WSGI, SCGI or FastCGI protocols.  
  
Security Considerations
----------------------------------------------------------------------------------------
  
Locally executed scripts are not executed in an isolated environment, but have the same privileges and access to system resources as the user, who started the browser.  However, downloading locally executed scripts from remote locations is not supported because of the huge security risks involved. If implemented at all, such a feature has to be subject to special restrictions, limiting the source of locally executed scripts to a trusted location with the use of a secure connection and other authentication measures.  
  
History
----------------------------------------------------------------------------------------
  
PEB was started as a simple GUI for personal databases. This small project is still in its very beginning and current version (0.1) should be considered alpha pre-release. Do not use it for production purposes! Proper documentation is still missing and current examples are basic.  
  
Compiling
----------------------------------------------------------------------------------------
  
Compiled and tested successfully using:  
* Qt Creator 2.5.0 and Qt 4.8.2 on 32-bit Debian Linux  
(main development and testing platform),  
* Qt Creator 2.8.1 and Qt 5.1.1 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Windows XP,  
* Qt Creator 3.0.1 and Qt 5.2.1 on 64-bit OS X 10.9.1, i5.  
Qt Creator, Qt headers and GCC compiler from any standard Qt4 or Qt5 development bundle are the only compile-time requirements of the project.  
  
License
----------------------------------------------------------------------------------------
  
This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU General Public License,  
as published by the Free Software Foundation; either version 3 of the License,  
or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
  
Name
----------------------------------------------------------------------------------------
  
'Perl Executing Browser' is a descriptive, technical name, but not quite exact, because the program is capable of executing Python and PHP scripts too. Although it was started as a tool for the Perl programming language, the program is not limited by design to Perl scripting only. It is developed as a flexible, adaptable and multi-purpose software, serving different people with different scripting needs and qualifications.  
Possible new names: **QtCamel Browser, QtKangoroo Browser, Qangoroo Browser**  
Kangoroo-based name was first proposed by Stefan Chekanov and supported by other members of Hackafe, the hackerspace of Plovdiv. (http://hackafe.org/).  
  
Authors
----------------------------------------------------------------------------------------
  
Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com  
Valcho Nedelchev, 2014  
  