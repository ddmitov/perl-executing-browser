  
Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a minimalistic C++ Qt5 WebKit graphical framework for local CGI-like or AJAX Perl5 scripts executed without a web server as desktop applications. Local scripts can be fed from HTML forms using CGI protocol GET and POST methods or using jQuery AJAX requests. HTML-based interface for interaction with the built-in Perl debugger is also available.  
  
## Design Objectives
  
* **1. Fast and easy graphical framework for desktop scripts:**  
    use Perl5, JavaScript, HTML5 and CSS to craft and deploy rapidly beautiful desktop applications;  

* **2. Zero installation when needed:**  
    put together your Perl5 scripts and your version of Perl5 with a copy of PEB and its Qt5 libraries and run your applications from any folder;  

* **3. Cross-platform availability:**  
    use it on every platform, where Perl5, Qt5 and QtWebKit are available;  

* **4. Secure user-space solution:**  
    no daemons or services are installed or started, no privileged ports are opened, no firewall notifications are triggered and no need for administrative privileges to run the program;  

* **5. Maximal (re)use of existing web technologies and standards:**  
    use as much as possible from existing web technologies, standards and their documentation to build desktop applications.  

## Features
  
**No feature or implementation should be considered final at this stage of development!**
  
**Local Scripting:**  
* CGI-like scripts can be executed locally in a serverless mode, feeding them from standard HTML forms using CGI protocol GET and POST methods.  
* jQuery AJAX requests to local scripts can also be made and all returned data can be seamlessly inserted into the DOM tree using standard jQuery methods.  
* Any version of Perl5 can be selected inside the settings file.  
  
**Web Access:**  
* PEB can open web pages with cross-site scripting disabled.  
  
**Configurability:**  
* All settings are stored in a single INI file.  
* Browser root folder can be any folder.  
* All browser functions are accessible from special URLs.  
* Use your favorite logo as a custom icon to be displayed on windows and message boxes.  
* 100% of the browser screen area are dedicated to your HTML interface.  
* Single-page or multiple-pages application with an option to start in fullscreen mode.  
  
**Development goodies:**  
* PEB can interact with the built-in Perl5 debugger. Any Perl script can be selected and loaded for debugging in an HTML graphical interface. Output from debugger commands is displayed together with the syntax highlighted source code of the debugged script and it's included modules. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.  
* WebKit Web Inspector can be invoked using keyboard shortcut.  
* Extensive optional logging of all browser activities, including the execution of local scripts.  

## Compile-time Requirements
  
GCC compiler and Qt5.1 - Qt5.5 headers (including QtWebKit headers).  
  
Compiled and tested successfully using:  
* Qt Creator 2.8.1 and Qt 5.1.1 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Debian Linux,  
* Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Windows XP,  
* Qt Creator 3.0.1 and Qt 5.2.1 on 64-bit OS X 10.9.1, i5,  
(main development and testing platform - Valcho Nedelchev).  
* Qt Creator 3.1.1 and Qt 5.3.0 on 64-bit Lubuntu 14.10 Linux,
* Qt Creator 3.1.1 and Qt 5.4.1 on 64-bit Lubuntu 15.04 Linux  
(main development and testing platform - Dimitar D. Mitov).  
  
## Runtime Requirements
  
* Qt5 libraries,  
* Perl5 distribution - any standard Linux, Mac or Windows Perl distribution.  
  
## Target Audience
  
* Perl and JavaScript enthusiasts willing to create rapidly data-driven desktop applications with HTML4/5 & CSS2/3 GUI.  
* Perl developers willing to use the built-in Perl debugger in graphical mode.  
  
## Applications using Perl Executing Browser
  
* [Epigraphista](https://github.com/ddmitov/epigraphista) - Epigraphista is an EpiDoc XML file creator using Perl Executing Browser as a desktop GUI framework, HTML5 and Bootstrap for a themable user interface, JavaScript for on-screen text conversion and Perl5 for file-writing backend.  
  
## What Perl Executing Browser Is Not

* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers.  
* Unlike JavaScript in general purpose web browsers, local Perl scripts executed by PEB have no access to the HTML DOM of any pages.  
* PEB is not an implementation of the CGI protocol. It uses only three environment variables (see below) together with the GET and POST methods from the CGI protocol in a purely local context without any attempt to communicate with the outside world.  
* PEB does not embed any Perl interpreter in itself and rellies on an external Perl distribution, which could be easily changed or upgraded independently if needed.  
* PEB has no sandbox for local Perl scripts. Basic security is implemented in the ```censor.pl``` embedded Perl script (see below). It bans scripts using potentially dangerous core functions, but can not protect every file and every user from every poorly written or malicious script! So it is recommended to inspect your scripts before use for possible security vulnerabilities and best programming practices!  
  
## Security Features & Considerations
  
* Security features based on C++ code:  
  1.) Starting the browser with administrative privileges is not allowed - it exits with a warning message.  
  2.) Local scripts are executed in a clean environment with only a minimum of necessary environment variables.  
  These are:  
    ```REQUEST_METHOD```, ```QUERY_STRING``` and ```CONTENT_LENGTH``` - environment variables borrowed from the CGI protocol and used for communication between local HTML forms and local Perl scripts;  
    ```DATA_ROOT``` - custom environment variable used to locate data files from local Perl scripts.  
  3.) Local Perl scripts are executed without a working directory and they can not open files using relative paths.  
  4.) PEB does not download locally executed scripts from any remote locations.  
  5.) Users have no dialog to select arbitrary local scripts for execution by PEB - only scripts within the root folder of the browser can be executed if they are invoked from a special URL (```http://perl-executing-browser-pseudodomain/```).  
* Security features based on Perl code:  
  1.) Local scripts are executed in an ```eval``` function and only after banning of potentially unsafe core functions. This feature is implemented in a special script named ```censor.pl```. It is compiled into the resources of the browser binary and is executed from memory whenever a local Perl script is started. The following core functions are banned:  
    1.1.) :dangerous group - ```syscall```, ```dump```, ```chroot```,  
    1.2.) :subprocess group - ```system```, ```fork```, ```wait```, ```waitpid```, the backtick operator, ```glob```,  
    1.3.) :sys_db group - all 30 functions from this group,  
    1.4.) ```sysopen```.  
  2.) Some important core functions for directory traversal and file manipulation are overriden. These are:  
    2.1.) ```opendir```,  
    2.2.) ```chdir```,  
    2.3.) ```open```,  
    2.4.) ```unlink```.  
  Only files and directories inside the ```DATA_ROOT```folder can be opened and read, every attempt to manipulate other directories and files will throw an error and the script will be aborted.  
  3.) Default module loading using ```require``` and ```use``` is also overriden.  
    3.1.) ```use lib``` is banned to prevent loading of Perl modules from arbitrary locations.  
    3.2.) The following Windows registry manipulation modules are also banned:  
      3.2.1.) ```Win32::Registry```,  
      3.2.2.) ```Win32API::Registry```,  
      3.2.3.) ```Win32::TieRegistry```,  
      3.2.4.) ```Win32::Registry::File```,  
      3.2.5.) ```Tree::Navigator::Node::Win32::Registry```,  
      3.2.6.) ```Parse::Win32Registry```  
      and probably others containing the keywords 'Win32' and 'Registry'.  
  4.) In order for the overriden core functions to act like a security barrier for unsafe operations, a statical code analysis is performed before the execution of every script.  
    4.1.) Even a single occurence of a call to one of the original core function starting with the ```CORE::``` invocation will prevent the script from being executed.  
    4.2.) Direct adding of directories to the ```@INC``` array is also prohibited and results in aborting the script execution.  
    However, statical code analysis is not performed on modules to avoid performance degradation. So to balance between performance and security ```use lib``` and ```PERLLIB``` environment variables are not allowed, as well as manual adding of directories to the ```@INC``` array from user code. You should either use the core modules of your Perl distribution or install your modules in a perlbrew Perl or a portable version of Strawberry Perl on Windows.  
* Every Perl script can be selected for debugging and debugging means execution, which is also a security risk. So if Perl debugger interaction is not needed, it can be turned off by a compile-time variable. Just change ```PERL_DEBUGGER_INTERACTION = 1``` to ```PERL_DEBUGGER_INTERACTION = 0``` in the project file of the browser (peb.pro) and compile the binary.  
  
## Keyboard Shortcuts
* Ctrl+A - select all  
* Ctrl+C - copy  
* Ctrl+V - paste  
* F11 - toggle fullscreen  
* Alt+F4 - close current window  
* Ctrl+P - print current page  
* Ctrl+I - debug current page using QWebInspector  
  
## Limitation
  
* No reloading from JavaScript of a page that was produced by local script, but local static pages, as well as web pages, can be reloaded from JavaScript using ```location.reload()```.  
  
## History
  
PEB was started as a simple GUI for personal databases. Exhaustive documentation is still missing.  
  
## License
  
This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU General Public License,  
as published by the Free Software Foundation; either version 3 of the License,  
or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
  
## Authors
  
Dimitar D. Mitov, 2013 - 2016,  
Valcho Nedelchev, 2014 - 2016.  
  
