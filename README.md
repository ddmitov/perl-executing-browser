  
Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a Qt4/5 WebKit browser capable of executing Perl scripts locally without a webserver. Serverless execution of local scripts can go side by side with a traditional access to local or remote webservers. CGI protocol GET and POST methods are used for communication with scripts executed without a webserver.  
  
## Design Objectives
  
* **1. Easy GUI for scripts:**  
    use HTML, CSS and JavaScript to craft and deploy rapidly beautifull interfaces for custom Perl, Python or PHP scripts;  

* **2. Specialised client for web services:**  
    use locally executed Perl, Python or PHP scripts to convert or verify large amounts of user data before upload;  

* **3. Zero installation when needed:**  
    pack your Perl modules and even your version of Perl with a copy of PEB and its Qt libraries and run your application from every folder, even from USB sticks;  

* **4. Cross-platform availability:**  
    use it on every platform and device (desktop, tablet, smartphone), where Perl and Qt can be compiled;  

* **5. User space solution:**  
    no daemons or services are installed or started, no privileged ports are opened, no firewall notifications should be triggered, no need for administrative privileges and everything remains in the userspace.  
  
## Features
  
**No feature or implementation should be considered final at this early stage of development!**
  
**Scripting:**  
* Can execute CGI scripts locally in a serverless mode, feeding them from standard forms using CGI protocol GET and POST methods.  
* Can execute long-running scripts - i.e. scripts running for arbitrary long time. Output can be displayed in the same or in a new window.  
* Can load Perl modules from a custom directory without system-wide installation using PERLLIB environment variable.  
* Any version of Perl/Python/PHP can be selected from INI file or by clicking a special URL.  
* Several absolute or relative path directories can be added to the PATH environment variable of every locally executed script.  
  
**Networking:**  
* Can load scripts and pages from localhost or from a predefined list of allowed websites.  
* Can be used as a site-specific browser or a specialised web client.  
  
**Local filesystem:**  
* Can open or create a single file or folder on the local file system by clicking special URLs. Any locally executed script has access to environment variables FILE_TO_OPEN, FILE_TO_CREATE and FOLDER_TO_OPEN.  
* Can open local documents using default applications and start user-specified programs.  
  
**Development goodies:**  
* WebKit Web Inspector can be invoked from context menu.  
* Local scripts and pages can be edited in external editor using context menu entry.  
* Can interact with the built-in Perl debugger. An arbitrary Perl script can be selected by clicking special URLs and separate output from three debugger commands can be displayed in the browser. These commands are: "Show module versions", "List subroutine names" and "List Variables in Package". Different version of Perl can be selected for every debugger session. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.  
* Can display every Perl/Python/PHP script as a source code.  
* Extensive logging of any browser activity and the execution of local scripts.  
  
**Configuration:**  
* Configurable from INI file and command line.  
* Themable - a common CSS theme for both static and dynamic pages can be configured from INI file or selected using a special URL.  
* Browser root folder can be any folder and this is configurable from INI file or command line.  
* Basic program functions are accessible from special URLs or from right-click context menu.  
* Rebrandable - program icon can be changed without recompilation, user agent can also be changed.  
* 100% of the browser screen area are dedicated to HTML, CSS and JavaScript interfaces.  
* Multi-window application with normal or frameless windows in resizable, fixed size or fullscreen mode.  
  
## Compile-time Requirements
  
Compiled and tested successfully using:  
* Qt Creator 2.5.0 and Qt 4.8.2 on 32-bit Debian Linux  
(main development and testing platform),  
* Qt Creator 2.8.1 and Qt 5.1.1 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Windows XP,  
* Qt Creator 3.0.1 and Qt 5.2.1 on 64-bit OS X 10.9.1, i5.  
Qt Creator, Qt headers and GCC compiler from any standard Qt4 or Qt5 development bundle are the only compile-time requirements of the project.  
  
## Runtime Requirements
  
* Qt libraries - Qt4 libraries, if you compiled the program using Qt4 classes or Qt5 libraries, if you compiled the program using Qt5 classes.  
* Perl 5 distribution - any standard Linux or Mac Perl distribution or Strawberry Perl for Windows.  
* Only if you want to run PHP scripts - standard PHP distribution including ```php-cgi``` executable.  
* Only if you want to run Python scripts - standard Python distribution for your operating system.  
  
## Limitations
  
* No history, no cache and no 'Previous Page' or 'Next Page' from JavaScript or from context menu. Only latest output from every script is displayed! User navigation has to be based on working hyperlinks.  
  
## Security Considerations
  
Locally executed scripts are not executed in an isolated environment, but have the same privileges and access to system resources as the user, who started the browser. However, downloading locally executed scripts from remote locations or using Perl/Python/PHP as helper applications for online content are not going to be implemented because of the huge security risks involved!  
  
## History
  
PEB was started as a simple GUI for personal databases. This small project is still in its very beginning and current version (0.1) should be considered alpha pre-release. Do not use it for production purposes! Proper documentation is still missing and current examples are basic.  
  
## License
  
This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU General Public License,  
as published by the Free Software Foundation; either version 3 of the License,  
or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
  
## Name
  
'Perl Executing Browser' is a descriptive, technical name, but not quite exact, because the program is capable of executing Python and PHP scripts too.  
Possible new names: **QtCamel Browser, Qangoroo Browser**  
Kangoroo-based name was first proposed by Stefan Chekanov and supported by other members of Hackafe, the hackerspace of Plovdiv. (http://hackafe.org/).  
  
## Authors
  
Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com  
Valcho Nedelchev, 2014  
  