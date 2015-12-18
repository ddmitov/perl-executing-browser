  
Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a limited C++ Qt4/5 WebKit browser capable of executing local CGI-like, AJAX or long-running Perl 5 scripts without a web server. Local scripts can be fed from HTML forms using CGI protocol GET and POST methods or using jQuery AJAX requests and their execution is separated from the traditional browser access to local or remote servers. HTML-based interface for interaction with the built-in Perl debugger is also available.  
  
## Design Objectives
  
* **1. Fast and easy GUI for local scripts:**  
    use HTML, CSS and JavaScript to craft and deploy rapidly beautiful Perl 5 desktop applications;  

* **2. Zero installation when needed:**  
    put together your Perl 5 scripts and modules and even your version of Perl 5 with a copy of PEB and its Qt libraries and run your applications from every folder, even from USB sticks;  

* **3. Cross-platform availability:**  
    use it on every platform, where Perl 5, Qt and QtWebKit are available;  

* **4. User-space solution:**  
    no daemons or services are installed or started, no privileged ports are opened, no firewall notifications should be triggered and no need for administrative privileges to run the program.  
  
## Features
  
**No feature or implementation should be considered final at this early stage of development!**
  
**Scripting:**  
* CGI-like scripts can be executed locally in a serverless mode, feeding them from standard HTML forms using CGI protocol GET and POST methods.  
* jQuery AJAX requests to local scripts can also be made and all returned data can be seamlessly inserted into the DOM tree using standard jQuery methods.  
* Long-running scripts, or scripts running for arbitrary long time, can also be executed locally in a serverless mode.  
* Perl modules can be loaded from a custom directory without system-wide installation using PATH and/or PERLLIB environment variables.  
* Any version of Perl 5 can be selected from configuration file or by clicking a special URL.  
* Multiple directories can be added to the PATH environment variable of every locally executed script.  
* Scripts and their HTML-based interfaces can be extracted and run from standard ZIP packages.  
  
**Networking:**  
* PEB will open only pages from a predefined list of allowed domain names.  
* User agent name can be changed easily from configuration file.  
  
**Local filesystem:**  
* PEB can open or create a single file or folder on the local file system by clicking special URLs. Any locally executed script has access to the custom environment variables FILE_TO_OPEN, FILE_TO_CREATE and FOLDER_TO_OPEN.  
  
**Development goodies:**  
* PEB can interact with the built-in Perl 5 debugger. Any Perl script can be selected and loaded for debugging in an HTML graphical interface. Output from debugger commands is displayed together with the syntax highlighted source code of the debugged script and it's included modules. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.  
* WebKit Web Inspector can be invoked from context menu.  
* Local scripts and pages can be edited in external editor using context menu entry.  
* Every Perl 5 script can be displayed as syntax highlighted source code.  
* Extensive optional logging of all browser activities, including the execution of local scripts.  
  
**Configuration:**  
* All settings are stored in a single INI file with comments included.  
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
  
* Advanced users and Perl enthusiasts willing to create rapidly custom GUI scripting solutions, which can not be easily implemented using other software.  
* Perl developers willing to use the built-in Perl debugger in graphical mode.  

## Compile-time Requirements
  
Qt headers and GCC compiler from any standard Qt4 or Qt5 development bundle are the only compile-time requirements of the project.  
  
Compiled and tested successfully using:  
* Qt Creator 2.5.0 and Qt 4.8.2 on 32-bit Debian Linux,  
* Qt Creator 2.8.1 and Qt 5.1.1 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Debian Linux,  
* Qt Creator 3.2.1 and Qt 4.8.6 on 32-bit Debian Linux,  
* Qt Creator 3.1.1 and Qt 5.3.0 on 64-bit Lubuntu 14.10 Linux  
(main development and testing platform - Dimitar D. Mitov),  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Windows XP,  
* Qt Creator 3.0.1 and Qt 5.2.1 on 64-bit OS X 10.9.1, i5  
(main development and testing platform - Valcho Nedelchev),  
  
## Runtime Requirements
  
* Qt libraries - Qt4 libraries, if you compiled the program using Qt4 classes, or Qt5 libraries, if you compiled the program using Qt5 classes.  
* Perl 5 distribution - any standard Linux, Mac or Windows Perl distribution.  
* ```unzip``` binary - only if you want to run scripts from ZIP packages.  
  
## Limitations
  
* No history, no cache and no 'Previous Page' or 'Next Page' from JavaScript or from context menu. Only latest output from every script is displayed! User navigation has to be based on working hyperlinks.  
* No means of communication between the browser and a script that is already started. Once you have started a script, you can only wait for it to finish or kill it.  
  
## What Perl Executing Browser Is Not
* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers. It can be configured as a site specific browser to open only a predefined list of domain names if this is necessary for interaction with a specific web service.  
* PEB does not embed any Perl interpreter in itself and rellies on an external Perl distribution, which could be easily changed or upgraded independently if needed.  
* PEB has no sandbox for local Perl scripts. A work-in-progress security system is implemented in the ```censor.pl``` script (see below), which is created to protect local files from malicious or poorly written Perl scripts, but currently no claims are made for it's effectiveness and stability. It is still recommended to inspect your scripts before use for possible security vulnerabilities and best programming practices!  
* PEB is not an implementation of the CGI protocol. It uses only four environment variables (see below) together with the GET and POST methods from the CGI protocol in a purely local context without opening any ports or any other means of communication with the outside world.  
* Unlike JavaScript in general purpose web browsers, local Perl scripts executed by PEB have no access to HTML DOM.  
  
## Security Features & Considerations
  
* Local scripts are executed with the minimum of necessary environment variables. These are:  
1) ```PERL5LIB``` - long-established Perl environment variable used to add Perl modules in non-standard locations;  
2) environment variables borrowed from the CGI protocol and used for finding local files and communication between HTML forms and local Perl scripts:  
```DOCUMENT_ROOT```, ```REQUEST_METHOD```, ```QUERY_STRING``` and ```CONTENT_LENGTH```;  
3) custom environment variables used for passing names of selected files and folders to local Perl scripts:  
```FILE_TO_OPEN```, ```FILE_TO_CREATE``` and ```FOLDER_TO_OPEN```.  
All other environment variables are removed, including user's ```PATH```, but a custom ```PATH``` can be inserted in the environment of the local Perl scripts.  
* Local scripts are executed in an ```eval``` function and only after banning of potentially unsafe core functions. This feature is implemented in a special script named ```censor.pl```. By default ```censor.pl``` is compiled in the resources of the browser binary and is executed from memory whenever a local Perl script is started. ```censor.pl``` can be turned off by a compile-time variable. Just change ```SCRIPT_CENSORING = 1``` to ```SCRIPT_CENSORING = 0``` in the project file of the browser (peb.pro) before compiling the binary.  
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
* Perl scripts, which are selected for debugging, are also executed and, in contrast with all other local scripts, there are no restrictions on which scripts could be debugged. This means that a potential security risk from a debugged Perl script does exist and if Perl debugger interaction is not needed, it can be turned off by a compile-time variable. Just change ```PERL_DEBUGGER_INTERACTION = 1``` to ```PERL_DEBUGGER_INTERACTION = 0``` in the project file of the browser (peb.pro) and compile the binary.  
* It is not a good idea to make any folders containing locally executed scripts available to web servers or file sharing applications due to the risk of executing locally malicious or unsecure code uploaded from outside. Securing configuration file and root folder as mentioned above should prevent file upload and modification, but will expose local files in read-only mode, which also has to be avoided.  
  
## Windows Patch for the built-in Perl Debugger
  
Tests showed, that the operation of the built-in Perl debugger within PEB on Windows(TM) is impossible without a small, one-line modification of the ```perl5db.pl``` file, which makes ```$console``` variable ```undef``` on Windows platforms. Modifying the debugger itself was not wanted initially due to the conviction that changes in the debugger have to be avoided to prevent introducing bugs in an instrument created to hunt them down. However, tests showed that undef-ing the ```$console``` variable is a minor change, which does not affect the normal operation and output of the built-in debugger. This alteration is necessary because Qprocess class doesn't use the default console of the underlying operating system to start processes, including the Perl debugger, and without the modification the debugger is unable to find a console and hangs. You could easily patch your Windows version of perl5db.pl file using ```{perl-executing-browser-root}/perl/debugger/perl5db-win32.patch```.  
  
## Keyboard Shortcuts
  
* Escape - minimize current window  
* Ctrl+M - maximize current window  
* F11 - toggle fullscreen on current window  
* F12 - go to start page  
* Ctrl+R - reload current page  
* Ctrl+P - print current page  
* Ctrl+Q - exit application  
  
## History
  
PEB was started as a simple GUI for personal databases. This small project is still in its very beginning and the current version 0.1, code name "Camel Calf", should be considered alpha pre-release. Do not use it for production purposes! Exhaustive documentation is still missing and current examples are basic.  
  
## License
  
This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU General Public License,  
as published by the Free Software Foundation; either version 3 of the License,  
or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
  
## Name
  
'Perl Executing Browser' is a descriptive, technical name, probably not the shortest one.  
Possible new names: **QtCamel Browser**, **QtCamelKit**, **QtCamel**.  
  
## Authors
  
Dimitar D. Mitov, 2013 - 2015,  
Valcho Nedelchev, 2014 - 2015.  
  
