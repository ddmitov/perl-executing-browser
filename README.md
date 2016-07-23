Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a C++ Qt 5 WebKit implementation of a minimalistic HTML framework for local Perl 5 scripts executed without server as desktop data-driven applications. Perl 5 scripts can be fed from HTML forms using GET and POST methods or from AJAX requests. HTML interface for interaction with the built-in Perl debugger is also available.
  
## Design Objectives
  
* **1. Fast and easy graphical framework for Perl 5 desktop applications:**  
    use Perl 5, JavaScript, HTML 5 and CSS to create beautiful desktop data-driven applications,
  
* **2. Zero installation:**  
    run from any folder,
  
* **3. Cross-platform availability:**  
    use it on every platform, where Perl 5, Qt 5 and QtWebKit are available,
  
* **4. Secure user-space solution:**  
    no server of any kind is installed or started,
  
* **5. Maximal (re)use of existing web technologies and standards:**  
    use as much as possible from existing web technologies, standards and their documentation.
  
## Features
  
**Usability:**
* Perl 5 scripts can be fed from HTML forms using GET or POST methods or from AJAX requests.
* Basic security restrictions are imposed on every Perl script.
* Any version of Perl 5 can be used.
* PEB can be started from any folder.
* Cross-site scripting is disabled for all web pages.
* Browser functions are accessible from special URLs.
* Any icon can be displayed on windows and message boxes.
* Every aspect of the graphical user interface can be customized using HTML & JavaScript.
* Usefull for both single-page or multi-page applications.
* Optional JavaScript translation of context menu and dialog boxes.
* Optional JavaScript check for unsaved data in HTML forms before closing a window to prevent accidental data loss.
  
**Development goodies:**
* PEB can interact with the built-in Perl 5 debugger. Any Perl script can be selected for debugging in an HTML user interface. The debugger output is displayed together with the syntax highlighted source code of the debugged script and it's modules. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.
* WebKit Web Inspector can be invoked using Ctrl+I keyboard shortcut.
* Extensive optional logging of all browser activities.
  
## Compile-time Requirements
  
GCC compiler and Qt 5.1 - Qt 5.5 headers (including QtWebKit headers).  
Later versions of Qt are unusable due to the deprecation of QtWebKit.
  
Compiled and tested successfully using:
* Qt Creator 2.8.1 and [Qt 5.1.1] (http://download.qt.io/official_releases/qt/5.1/5.1.1/) on 32-bit Debian Linux,
* Qt Creator 3.0.0 and [Qt 5.2.0] (http://download.qt.io/official_releases/qt/5.2/5.2.0/) on 32-bit Debian Linux,
* Qt Creator 3.0.0 and [Qt 5.2.0] (http://download.qt.io/official_releases/qt/5.2/5.2.0/) on 32-bit Windows XP,
* Qt Creator 3.0.1 and [Qt 5.2.1] (http://download.qt.io/official_releases/qt/5.2/5.2.1/) on 64-bit OS X 10.9.1, i5  
(main development and testing platform - Valcho Nedelchev),
* Qt Creator 3.1.1 and [Qt 5.3.0] (http://download.qt.io/official_releases/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10 Linux,
* Qt Creator 3.1.1 and [Qt 5.4.1] (http://download.qt.io/official_releases/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04 Linux,
* Qt Creator 3.5.1 and [Qt 5.5.1] (http://download.qt.io/official_releases/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04 Linux  
(main development and testing platform - Dimitar D. Mitov).
  
## Runtime Requirements
  
* Qt 5 libraries,
* Perl 5 distribution - any Linux, Mac or Windows Perl distribution.
  
## Target Audience
  
* Perl and JavaScript enthusiasts creating custom data-driven desktop applications
* Perl developers willing to use the built-in Perl debugger in graphical mode
  
## Application(s) using Perl Executing Browser
  
* [Epigraphista](https://github.com/ddmitov/epigraphista) - Epigraphista is an EpiDoc XML file creator using Perl Executing Browser, Electron or NW.js as a desktop GUI framework, HTML 5 and Bootstrap for a themable user interface, JavaScript for on-screen text conversion and Perl 5 for a file-writing backend.
  
## What Perl Executing Browser Is Not
  
* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers.
* Unlike JavaScript in general purpose web browsers, Perl scripts executed by PEB have no access to the HTML DOM tree of any page.
* PEB is not an implementation of the CGI protocol. It uses only three environment variables (see below) together with the GET and POST methods from the CGI protocol in a purely local context without any attempt to communicate with the outside world.
* PEB does not embed any Perl interpreter in itself and rellies on an external Perl distribution, which could be easily changed or upgraded independently.
* PEB has no sandbox for Perl scripts - they are treated like and executed as ordinary desktop applications with normal user privileges. Basic security is implemented in C++ and Perl code, but without warranties of any kind!
  
## Security
  
**Security features based on C++ code:**
* Starting PEB with administrative privileges is not allowed - it exits with a message.
* Perl 5 scripts are executed in a clean environment and only ```REQUEST_METHOD```, ```QUERY_STRING``` and ```CONTENT_LENGTH``` environment variables (borrowed from the CGI protocol) are used for communication between local HTML forms and local Perl scripts.
* PEB can not and does not download remote files and can not execute locally Perl scripts from remote locations.
* Users have no dialog to select arbitrary local scripts for execution by PEB. Only scripts within the ```resources/app``` subfolder of the browser directory can be executed if they are invoked from a special URL (```http://perl-executing-browser-pseudodomain/```).
  
**Security features based on Perl code:**
* Perl scripts are executed in an ```eval``` function after banning potentially unsafe core functions. This feature is implemented in a special script named ```censor.pl```, which is compiled into the resources of the browser binary and is executed from memory when Perl script is started. All core functions from the :dangerous group - ```syscall```, ```dump``` and ```chroot```, as well as ```fork``` are banned.
* The environment of all Perl scripts is once again filtered in the ```BEGIN``` block of ```censor.pl``` to ensure no unwanted environment variables are inserted from the operating system.
  
**Perl Debugger Interaction:**
* Any Perl script can be selected for debugging, which is also a security risk. So if Perl debugger interaction is not needed, it can be turned off by a compile-time variable. Just change ```PERL_DEBUGGER_INTERACTION = 1``` to ```PERL_DEBUGGER_INTERACTION = 0``` in the project file of the browser (peb.pro) and compile the binary.  
  
## Keyboard Shortcuts
* Ctrl+A - Select All
* Ctrl+C - Copy  
* Ctrl+V - Paste  
* F11 - toggle Fullscreen
* Alt+F4 - Close window
* Ctrl+P - Print
* Ctrl+I - debug current page using QWebInspector
  
## Limitations
  
* No history and cache. JavaScript functions ```window.history.back()```, ```window.history.forward()``` and ```window.history.go()``` are disabled.
* No reloading from JavaScript of a page that is produced by local script, but local static pages, as well as web pages, can be reloaded from JavaScript using ```location.reload()```.
* No file can be downloaded on hard disk.
* No support for plugins and HTML 5 video.
  
## History
  
PEB was started as a simple GUI for personal databases.
  
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
  
