  
Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a limited C++ Qt4/5 WebKit browser capable of executing local CGI-like and long-running Perl 5 scripts without a web server. Local scripts can be fed from HTML forms using CGI protocol GET and POST methods and their execution is separated from the traditional browser access to local or remote servers. HTML-based interface for interaction with the built-in Perl debugger is also available.  
  
## Design Objectives
  
* **1. Easy GUI for local scripts:**  
    use HTML, CSS and JavaScript to craft and deploy rapidly beautiful interfaces for custom Perl 5 scripts;  

* **2. Zero installation when needed:**  
    put together your Perl 5 scripts and modules and even your version of Perl 5 with a copy of PEB and its Qt libraries and run your applications from every folder, even from USB sticks;  

* **3. Cross-platform availability:**  
    use it on every platform, where Perl 5 and Qt are available;  

* **4. User-space solution:**  
    no daemons or services are installed or started, no privileged ports are opened, no firewall notifications should be triggered and no need for administrative privileges to run the program.  

* **5. No user-specific logic or data in the compiled executable:**  
    no programming logic or data specific to a given user or online service should be part of the compiled Qt executable of the browser. All C++ code must comply with Qt open source license(s) and PEB should be fit for the widest possible array of tasks without recompilation.  
  
## Features
  
**No feature or implementation should be considered final at this early stage of development!**
  
**Scripting:**  
* CGI-like scripts can be executed locally in a serverless mode, feeding them from standard HTML forms using CGI protocol GET and POST methods.  
* Long-running scripts, or scripts running for arbitrary long time, can also be executed locally in a serverless mode.  
* Perl modules can be loaded from a custom directory without system-wide installation using PERLLIB environment variable.  
* Any version of Perl 5 can be selected from configuration file or by clicking a special URL.  
* Multiple directories can be added to the PATH environment variable of every locally executed script.  
  
**Networking:**  
* PEB can open pages from localhost or from a predefined list of allowed websites.  
* User agent name can be changed easily from configuration file.  
  
**Local filesystem:**  
* PEB can open or create a single file or folder on the local file system by clicking special URLs. Any locally executed script has access to the custom environment variables FILE_TO_OPEN, FILE_TO_CREATE and FOLDER_TO_OPEN.  
  
**Development goodies:**  
* WebKit Web Inspector can be invoked from context menu.  
* Local scripts and pages can be edited in external editor using context menu entry.  
* PEB can interact with the built-in Perl 5 debugger. Any Perl script can be selected and loaded for debugging in an HTML graphical interface. Output from debugger commands is displayed together with the syntax highlighted source code of the debugged script and it's included modules. Different versions of Perl can be selected for every debugging session. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.  
* Every Perl 5 script can be displayed as syntax highlighted source code.  
* Extensive optional logging of all browser activities, including the execution of local scripts.  
  
**Configuration:**  
* All settings are stored in an INI file with comments included.  
* Browser root folder can be any folder.  
* Program functions are accessible from special URLs or from a right-click context menu.  
* Themable - a common CSS theme for both static and dynamic pages can be configured from configuration file or selected using a special URL.  
* Use your favorite logo as a custom icon to be displayed on windows and message boxes.  
* 100% of the browser screen area are dedicated to HTML, CSS and JavaScript interfaces.  
* Multi-window application with resizable, fixed size or fullscreen mode windows.  
  
## Possible Applications
  
* Perl 5 desktop applications with HTML4/5, CSS2/3 & JavaScript GUI.  
* GUI for the Perl debugger.  
  
## Target Audience
  
* Advanced users and Perl enthusiasts willing to create rapidly custom desktop scripting solutions for internal use, which can not be easily implemented using other software.  
* Perl developers willing to use the built-in Perl debugger in graphical mode.  

## Compile-time Requirements
  
Qt headers and GCC compiler from any standard Qt4 or Qt5 development bundle are the only compile-time requirements of the project.  
  
Compiled and tested successfully using:  
* Qt Creator 2.5.0 and Qt 4.8.2 on 32-bit Debian Linux,  
* Qt Creator 2.8.1 and Qt 5.1.1 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Debian Linux,  
* Qt Creator 3.2.1 and Qt 4.8.6 on 32-bit Debian Linux  
(main development and testing platform - Dimitar D. Mitov),  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Windows XP,  
* Qt Creator 3.0.1 and Qt 5.2.1 on 64-bit OS X 10.9.1, i5  
(main development and testing platform - Valcho Nedelchev),  
  
## Runtime Requirements
  
* Qt libraries - Qt4 libraries, if you compiled the program using Qt4 classes, or Qt5 libraries, if you compiled the program using Qt5 classes.  
* Perl 5 distribution - any standard Linux or Mac Perl distribution or Strawberry Perl for Windows.  
  
## Limitations
  
* No history, no cache and no 'Previous Page' or 'Next Page' from JavaScript or from context menu. Only latest output from every script is displayed! User navigation has to be based on working hyperlinks.  
  
## What Perl Executing Browser Is Not
* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers. It can be configured as a site specific browser to open only a predefined list of domain names if this is necessary for interaction with a specific web service.  
* PEB does not embed a Perl interpreter in itself and does not run Perl scripts in a full-fledged sandbox like JavaScript is run in general purpose web browsers. PEB uses Perl for desktop-oriented scripts created to manipulate local data with an optional network access and does not compete JavaScript in HTML DOM manipulation.  
* PEB is not a product for end-users with no understanding of the Perl programming language. It should not be used without knowing of what exactly local scripts are going to do. Inspect your scripts before use for possible security vulnerabilities and best programming practices!  
  
## Security Features & Considerations
  
* Local scripts are executed with the minimum of necessary environment variables. These are:  
1) ```PERL5LIB``` - long-established Perl environment variable used to add Perl modules in non-standard locations;  
2) environment variables borrowed from the CGI protocol and used for finding local files and communication between HTML forms and local Perl scripts:  
```DOCUMENT_ROOT```, ```REQUEST_METHOD```, ```QUERY_STRING``` and ```CONTENT_LENGTH```;  
3) custom environment variables used for passing names of selected files and folders to local Perl scripts:  
```FILE_TO_OPEN```, ```FILE_TO_CREATE``` and ```FOLDER_TO_OPEN```.  
All other environment variables are removed, including user's ```PATH```, but a custom ```PATH``` can be inserted in the environment of the local Perl scripts.  
* Local scripts are executed only after a security check, implemented in the special ```censor.pl``` script, which bans or limits potentially unsafe core functions and restricts the use of modules to a predefined list.  
* Starting the browser as root on Linux is not allowed - it exits with a warning message.  
* PEB does not download locally executed scripts from any remote locations and it does not use any Perl interpreter as helper application for online content. This is not going to be implemented due to the huge security risks involved!  
* Users have no dialog to select arbitrary local scripts for execution by PEB - only scripts within the root folder of the browser can be executed if they are invoked from a special URL (currently ```http://perl-executing-browser-pseudodomain/```).  
* If user is not administrator of his/her machine and configuration file and root folder are owned by root/administrator and read-only for all others, user will be effectively prevented from executing untrusted code. Executing as root on a Linux machine:  
```chown --recursive root peb-root-folder```  
```chgrp --recursive root peb-root-folder```  
```chmod --recursive 755 peb-root-folder```  
is enough to do the job. The same commands could be applied to the folder of the binary file to prevent it's unauthorized replacing or modification. Locally executed scripts don't have to be made executable because they are always given as an argument to the interpreter, but mode 755 is necessary to avoid ```cannot read directory``` error.  
Essentially the same protection on a Windows(TM) machine could be achieved by installing PEB from the administrator's account in a location that is read-only for all other users.  
Note however, that a copy of PEB running from a flash drive or external harddisk and owned by an ordinary user will not have this extra protection.  
* Perl scripts, which are selected for debugging, are also executed and, in contrast with all other local scripts, there are no restrictions on which scripts could be debugged. This means that a potential security risk from a debugged Perl script does exist and future versions will probably have a compile-time option to switch off Perl debugger interaction in end-user binaries.  
* It is not a good idea to make any folders containing locally executed scripts available to web servers or file sharing applications due to the risk of executing locally malicious or unsecure code uploaded from outside. Securing configuration file and root folder as mentioned above should prevent file upload and modification, but will expose local files in read-only mode, which also has to be avoided.  
  
## Windows Patch for the built-in Perl Debugger 
  
Tests showed, that the operation of the built-in Perl debugger within PEB on Windows(TM) is impossible without a small, one-line modification of the ```perl5db.pl``` file, which makes ```$console``` variable ```undef``` on Windows platforms. Modifying the debugger itself was not wanted initially due to the conviction that changes in the debugger have to be avoided to prevent introducing bugs in an instrument created to hunt them down. However, tests showed that undef-ing the ```$console``` variable is a minor change, which does not affect the normal operation and output of the built-in debugger. This alteration is necessary because Qprocess class doesn't use the default console of the underlying operating system to start processes, including the Perl debugger, and without the modification the debugger is unable to find a console and hangs. You could easily patch your Windows version of perl5db.pl file using ```{perl-executing-browser-root}/perl/debugger/perl5db-win32.patch```.
  
## History
  
PEB was started as a simple GUI for personal databases. This small project is still in its very beginning and current version (0.1) should be considered alpha pre-release. Do not use it for production purposes! Exhaustive documentation is still missing and current examples are basic.  
  
## License
  
This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU General Public License,  
as published by the Free Software Foundation; either version 3 of the License,  
or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
  
## Name
  
'Perl Executing Browser' is a descriptive, technical name, probably not the shortest one.  
Possible new name: **QtCamel Browser**  
  
## Authors
  
Dimitar D. Mitov, 2013 - 2015,  
Valcho Nedelchev, 2015  
  
