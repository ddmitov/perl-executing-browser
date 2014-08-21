  
Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a Qt4/5 WebKit browser capable of executing local CGI and long-running Perl, Python or PHP scripts without a web server. Local scripts can be fed from HTML forms using CGI protocol GET and POST methods and their execution is separated from the traditional browser access to local or remote servers. HTML-based interface for interaction with the built-in Perl debugger is also available.  
  
## Design Objectives
  
* **1. Easy GUI for local scripts:**  
    use HTML, CSS and JavaScript to craft and deploy rapidly beautiful interfaces for custom Perl, Python or PHP scripts  

* **2. Special purpose web client:**  
    use locally executed Perl, Python or PHP scripts to convert or verify large amounts of user data before upload;  

* **3. Zero installation when needed:**  
    put together your Perl scripts and modules and even your version of Perl, Python or PHP with a copy of PEB and its Qt libraries and run your applications from every folder, even from USB sticks;  

* **4. Cross-platform availability:**  
    use it on every platform and device (desktop, tablet, smartphone), where Perl and Qt are available;  

* **5. Secure user space solution:**  
    no daemons or services are installed or started, no privileged ports are opened, no firewall notifications should be triggered and no need for administrative privileges to run the program. Administrative privileges may be needed only to install or update the browser and it's files with an increased level of security, if so desired.  

* **6. Avoiding dependency hell:**  
    if some functionality outside of the standard Qt classes is needed for the browser, all the necessary source code must be included in the source package and all external libraries must be statically linked within the binary. If Qt libraries are also linked statically, a single file executable has to be possible.  

* **7. No user-specific logic or data in the compiled executable:**  
    no programming logic or data specific to a given user or task should be part of the compiled Qt executable of the browser. All C++ code must comply with Qt open source license(s) and PEB should be fit for the widest possible array of tasks without recompilation.  
  
## Features
  
**No feature or implementation should be considered final at this early stage of development!**
  
**Scripting:**  
* CGI scripts can be executed locally in a serverless mode, feeding them from standard HTML forms using CGI protocol GET and POST methods.  
* Long-running scripts, or scripts running for arbitrary long time, can also be executed locally in a serverless mode.  
* Perl modules can be loaded from a custom directory without system-wide installation using PERLLIB environment variable.  
* Any version of Perl, Python or PHP can be selected from configuration file or by clicking a special URL.  
* Multiple directories can be added to the PATH environment variable of every locally executed script.  
  
**Networking:**  
* PEB can open pages from localhost or from a predefined list of allowed websites.  
* User agent name can be changed easily from configuration file.  
  
**Local filesystem:**  
* PEB can open or create a single file or folder on the local file system by clicking special URLs. Any locally executed script has access to the custom environment variables FILE_TO_OPEN, FILE_TO_CREATE and FOLDER_TO_OPEN.  
* PEB can open local documents using default applications and start user-specified programs.  
  
**Development goodies:**  
* WebKit Web Inspector can be invoked from context menu.  
* Local scripts and pages can be edited in external editor using context menu entry.  
* PEB can interact with the built-in Perl debugger. Any Perl script can be selected and loaded for debugging in an HTML graphical interface. Output from debugger commands is displayed together with the syntax highlighted source code of the debugged script and it's included modules. Different versions of Perl can be selected for every debugging session. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.  
* Every Perl, Python or PHP script can be displayed as syntax highlighted source code.  
* Extensive logging of all browser activities, including the execution of local scripts.  
  
**Configuration:**  
* All settings are stored in one single INI file with comments included.  
* Browser root folder can be any folder.  
* Basic program functions are accessible from special URLs or from a right-click context menu.  
* Themable - a common CSS theme for both static and dynamic pages can be configured from configuration file or selected using a special URL.  
* Use your favorite logo as a custom icon to be displayed on windows and message boxes.  
* 100% of the browser screen area are dedicated to HTML, CSS and JavaScript interfaces.  
* Multi-window application with resizable, fixed size or fullscreen mode windows.  
  
## Possible Applications
  
* Perl, Python or PHP desktop applications with HTML4/5, CSS2/3 & JavaScript GUI;  
* Web clients or site-specific browsers with enhanced scripting capabilities based on Perl, Python, PHP & JavaScript;  
* GUI for the Perl debugger.  
  
## Compile-time Requirements
  
Compiled and tested successfully using:  
* Qt Creator 2.5.0 and Qt 4.8.2 on 32-bit Debian Linux  
(main development and testing platform - Dimitar D. Mitov),  
* Qt Creator 2.8.1 and Qt 5.1.1 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Windows XP,  
* Qt Creator 3.0.1 and Qt 5.2.1 on 64-bit OS X 10.9.1, i5  
(main development and testing platform - Valcho Nedelchev),  
Qt Creator, Qt headers and GCC compiler from any standard Qt4 or Qt5 development bundle are the only compile-time requirements of the project.  
  
## Runtime Requirements
  
* Qt libraries - Qt4 libraries, if you compiled the program using Qt4 classes or Qt5 libraries, if you compiled the program using Qt5 classes.  
* Perl 5 distribution - any standard Linux or Mac Perl distribution or Strawberry Perl for Windows.  
* Only if you want to run PHP scripts - standard PHP distribution including ```php-cgi``` executable.  
* Only if you want to run Python scripts - standard Python distribution for your operating system.  
  
## Limitations
  
* No history, no cache and no 'Previous Page' or 'Next Page' from JavaScript or from context menu. Only latest output from every script is displayed! User navigation has to be based on working hyperlinks.  
  
## Security Features & Considerations
  
* Local scripts are executed with only few necessary environment variables (others are removed), but otherwise have the same privileges and access to system resources as the user, who started the browser.  
* Starting the browser as root on Linux is not allowed - it exits with a warning message.  
* PEB does not download locally executed scripts from any remote locations and it does not use Perl, Python or PHP interpreters as helper applications for online content. This is not going to be implemented due to the huge security risks involved!  
* Users have no dialog to select arbitrary local scripts for execution by PEB - only scripts within the root folder of the browser can be executed if they are invoked from a special URL (currently ```http://perl-executing-browser-pseudodomain/```). Securing configuration file and root folder as owned by root/administrator and read-only for all ordinary users effectively prevents the browser from executing untrusted code. Executing as root ```chown --recursive root peb-root-folder```, ```chgrp --recursive root peb-root-folder``` and ```chmod --recursive 755 peb-root-folder``` on a Linux machine is enough to do the job. The same commands should be applied to the binary file to prevent it's unauthorized replacing or modification. Although locally executed scripts don't have to be made executable because they are always given as an argument to their respective interpreters, mode 755 is necessary to avoid 'cannot read directory' error for ordinary users.  
* Perl scripts, which are selected for debugging, are also executed and, in contrast with all other local scripts, there are no restrictions on which scripts could be debugged. This means that a potential security risk from a debugged Perl script does exist and future versions will probably have a compile-time option to switch off Perl debugger interaction in end-user binaries.  
* It is not a good idea to make any folders containing locally executed scripts available to web servers or file sharing applications due to the risk of executing locally malicious or unsecure code uploaded from outside. Securing configuration file and root folder as mentioned above should prevent file upload and modification, but will expose local files in read-only mode, which also has to be avoided.  
  
## Windows Patch for the built-in Perl Debugger 
  
Tests showed, that the operation of the built-in Perl debugger within PEB on Windows(TM) is impossible without a small, one-line modification of the perl5db.pl file, which makes '$console' variable 'undef' on Windows platforms. Modifying the debugger itself was not wanted and avoided initially due to the conviction that changes in a debugger have to be introduced with extreme caution and a lot of testing to prevent introducing bugs in an instrument created to hunt them down. However, tests showed that undef-ing the $console variable is a minor change, which does not affect the normal operation and output of the built-in debugger. This alteration is necessary because Qprocess class doesn't use the default console of the underlying operating system to start processes, including the Perl debugger, and without the modification the debugger is unable to find console and hangs. You could easily patch your Windows version of perl5db.pl file using ```{perl-executing-browser-root}perl/debugger/perl5db-win32.patch```.
  
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
  
'Perl Executing Browser' is a descriptive, technical name, but not quite exact, because the program is capable of executing Python and PHP scripts too.  
Possible new names: **QtCamel Browser, Qangoroo Browser**  
Kangoroo-based name was first proposed by Stefan Chekanov and supported by other members of Hackafe, the hackerspace of Plovdiv. (http://hackafe.org/).  
  
## Authors
  
Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com  
Valcho Nedelchev, 2014  
  