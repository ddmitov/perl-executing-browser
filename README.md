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
* Single file or multiple files, new filename, existing or new directory can be selected by user and supplied with their full paths to local Perl scripts.
* Basic security restrictions are imposed on every Perl script.
* Any version of Perl 5 can be used.
* PEB can be started from any folder.
* Cross-site scripting is disabled for all web pages.
* Browser functions are accessible from special URLs.
* Any icon can be displayed on windows and message boxes.
* Every aspect of the graphical user interface can be customized using HTML & JavaScript.
* Usefull for both single-page or multi-page applications.
* Optional JavaScript translation of context menu and dialog boxes.
* Optional warning for unsaved data in HTML forms before closing a window to prevent accidental data loss.
  
**Development goodies:**
* PEB can interact with the built-in Perl 5 debugger. Any Perl script can be selected for debugging in an HTML user interface. The debugger output is displayed together with the syntax highlighted source code of the debugged script and it's modules. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev.
* WebKit Web Inspector can be invoked using Ctrl+I keyboard shortcut.
* Extensive optional logging of all browser activities.
  
## Compile-time Requirements
  
GCC compiler and Qt 5.1 - Qt 5.5 headers (including QtWebKit headers).  
Later versions of Qt are unusable due to the deprecation of QtWebKit.  
  
The most important Qt dependency of PEB is actually not ```QtWebkit```, but ```QNetworkAccessManager``` class, which is subclassed to implement CGI-like POST and AJAX GET and POST requests to local Perl scripts. The removal of this class from the ecosystem of ```QtWebEngine```, the new Blink-based web engine of Qt, means that transition to ```QtWebEngine``` remains problematic.  
  
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
  
## Settings
  
**Settings based on the existence of certain files and folders:**  
PEB is designed to run from any directory without setting anything beforehand and every file or directory, that is checked during program start-up, is relative to the directory where the PEB binary file is located, further labeled as ```{PEB_binary_directory}```.
* **Name of the binary file:**  
    The binary file of the browser, ```peb``` or ```peb.exe``` by default, can be renamed at will. It can take the name of the PEB-based application it is going to run. No additional adjustments are necessary after renaming the binary. If log files are wanted, they will take the name of the binary file (without the extension), whatever the name may be.
* **Application directory:**  
    Application directory must be ```{PEB_binary_directory}/resources/app```. All files used by PEB, with the exception of data files, must be located within this folder. Application directory is hardcoded in C++ code for compatibility with the [Electron] (http://electron.atom.io/) framework. [Epigraphista] (https://github.com/ddmitov/epigraphista) provides an example of a PEB-based application, that is also compatible with [Electron] (http://electron.atom.io/) and [NW.js] (http://nwjs.io/).
* **Data directory:**  
    Data directory is not hardcoded in C++ code, but a separation of data files from code is generally a good practice. Data directory should contain any SQLite database(s) or other files, that a PEB-based application is going to use or produce. The recommended path for data directory is inside the ```{PEB_binary_directory}/resources``` directory. ```data``` is a good directory name, although not mandatory. Perl scripts can access this folder using the following code:
```perl
    use Cwd;
  
    my $current_working_directory = cwd();
    my $data_directory = "$current_working_directory/resources/data";
```
* **Perl interpreter:**  
    PEB expects to find Perl interpreter in ```{PEB_binary_directory}/perl/bin``` folder. The interpreter must be named ```perl``` on Linux and Mac machines and ```perl.exe``` on Windows machines. If Perl interpreter is not found in the above location, PEB will try to find the first Perl interpreter on PATH. If no Perl interpreter is found, an error message is displayed instead of the start page. No Perl interpreter is a showstopper for PEB.
* **Start page:**  
    PEB can start with a static HTML start page or with a start page, that is produced dynamically by a Perl script. When PEB is started, it will first try to find ```{PEB_binary_directory}/resources/app/index.html```. If this file is found, it will be used as a start page. If this file is missing, PEB will try to find ```{PEB_binary_directory}/resources/app/index.pl```. If this script is found, it will be executed and the resulting HTML output will be displayed as a start page. If ```index.html``` and ```index.pl``` are not found, an error message will be displayed. No start page is a showstopper for PEB.
* **Icon:**  
    A PEB-based application can have it's own icon located at ```{PEB_binary_directory}/resources/app/app.png```. If this file is found during application start-up, it will be used as the icon of all windows and dialog boxes. If this file is not found, the default icon embedded into the resources of the browser binary will be used.
* **Log files:**  
    If log files are needed for debugging PEB or a PEB-based application, they can easily be turned on by manually creating ```{PEB_binary_directory}/logs```. If this directory is found during application start-up, the browser assumes, that logging is required and a separate log file is created for every browser session following the naming convention: ```{application_name}-started-at-{four_digit_year}-{month}-{day}--{hour}-{minute}-{second}.log```. PEB will not create ```{PEB_binary_directory}/logs``` on it's own and if this directory is missing, no logs will be written, which is the default behaviour. Please note, that log files can rapidly grow in size due to the fact that every requested link is logged. If disc space is an issue, writing log files can be turned off by simply removing or renaming ```{PEB_binary_directory}/logs```.
  
**Settings based on JavaScript code:**  
JavaScript-based settings are created to facilitate the development of fully translated and multilanguage applications without depending on compiled Qt translation files. JavaScript is also used to prevent data loss when user tries to close a PEB window containing a local HTML form filled with unsaved data.
* **Custom or translated context menu labels:**  
  Using the following code any local HTML page can have custom labels on the default right-click context menu (if the contextmenu event is not already intercepted):  

```javascript
  function pebContextMenu() {
      var contextMenuObject = new Object();
  
      contextMenuObject.printPreview = "Custom Print Preview Label";
      contextMenuObject.print = "Custom Print Label";
  
      contextMenuObject.cut = "Custom Cut Label";
      contextMenuObject.copy = "Custom Copy Label";
      contextMenuObject.paste = "Custom Paste Label";
      contextMenuObject.selectAll = "Custom Select All Label";
  
      return JSON.stringify(contextMenuObject);
  }
```

* **Custom or translated labels for JavaScript dialog boxes:**  
  Using the following code any local HTML page can have custom labels on the default JavaScript Alert, Confirm and Prompt dialog boxes:

```javascript
  function pebMessageBoxElements() {
      var messageBoxElementsObject = new Object();

      messageBoxElementsObject.alertTitle = "Custom Alert Label";
      messageBoxElementsObject.confirmTitle = "Custom Confirmation Label";
      messageBoxElementsObject.promptTitle = "Custom Prompt Label";

      messageBoxElementsObject.okLabel = "Custom Ok Label";
      messageBoxElementsObject.cancelLabel = "Custom Cancel Label";
      messageBoxElementsObject.yesLabel = "Custom Yes Label";
      messageBoxElementsObject.noLabel = "Custom No Label";

      return  JSON.stringify(messageBoxElementsObject);
  }
```

* **Checking user input before closing a window:**
  PEB users can enter a lot of information in local HTML forms and it is often important to safeguard this information from accidental deletion if PEB window is closed without first saving the user data. When user starts closing a PEB window, the browser checks for any unsaved data in all forms of the HTML page that is going to be closed using internal JavaScript code compiled in the resources of the browser binary.  
  
  If any unsaved data is detected, PEB tries to determine what kind of JavaScript routine has to be displayed to warn the user and ask for final confirmation. Two types of JavaScript warning routines are possible in this scenario: synchronous and asynchronous.  
  
  If the local HTML page, that is going to be closed, contains a JavaScript function called ```pebCloseConfirmationAsync()```, then this routine is going to be executed. If the asynchronous warning routine is missing, then the browser tries to find and execute a synchronous warning function called ```pebCloseConfirmationSync()```. If none of the above functions is found, then PEB assumes that no warning has to be displayed and closes the window immediately.  
  
  What are the differences between the two routines?  
  
  The synchronous warning function is implemented using standard JavaScript Confirm dialog, which stops the execution of all JavaScript code within the page and waits until the user finally presses 'Yes' or 'No'. Visually the Confirm dialog looks like a normal native dialog.  
  
  The asynchronous warning function is implemented using JavaScript, HTML and CSS code, does not stop the execution of other JavaScript code within the page and does not wait for the user's decision. If the user chooses to close the window, a special window closing URL, ```http://perl-executing-browser-pseudodomain/close-window.function```, has to be sent to the browser. Upon receiving this URL, PEB closes the window from where the window closing URL was requested. The warning dialog itself can be styled to blend with the rest of the HTML interface or to distinct itself and attract attention - this is actually the great advantage of using an asynchronous warning dialog. Developers can implement it using any suitable JavaScript library or custom code.  
  
  The following code is an example of both synchronous and asynchronous warning functions. It is expected, that one of them will be present in any PEB-based application, if user data is to be protected against accidental loss. If both functions are present, the asynchronous one will take precedence. The asynchronous function in the example code is implemented using ```jQuery``` and ```Alertify.js```.  

```javascript
  function pebCloseConfirmationSync() {
      var confirmation = confirm("Are you sure you want to close the window?");
      return confirmation;
  }

  function pebCloseConfirmationAsync() {
      alertify.set({labels: {ok : "Ok", cancel : "Cancel"}});
      alertify.set({buttonFocus: "cancel"});
      alertify.confirm("Are you sure you want to close the window?", function (confirmation) {
          if (confirmation) {
              $jQuery.ajax({
                  url: 'http://perl-executing-browser-pseudodomain/close-window.function',
                  method: 'GET'
              });
          }
      });
  }
```

  
## Special URLs and Interaction with Files and Folders
  
* **PEB pseudo-domain:** ```http://perl-executing-browser-pseudodomain/```  
  The  pseudo-domain is used to call all local files and all special URLs representing browser functions.  
  It is intercepted inside PEB and is not passed to the underlying operating system.  
  
* **Close current window:** ```http://perl-executing-browser-pseudodomain/close-window.function```  
  Please note that using this URL the window from where this URL was called will be closed immediately without any check for unsaved user data in HTML forms. Window closing URL can be called not only by clicking a link, but also by using a jQuery AJAX GET request.  
  
* **Select single file:** ```http://perl-executing-browser-pseudodomain/open-file.function?target=DOM_element```  
  The full path of the selected file will be inserted in the target DOM element of the calling local page.  
  Having a target DOM element is mandatory when using this special URL.  
  HTML event called ```inodeselection``` is emitted when the path of the selected file is inserted into the calling local page.  
  This event can be binded to a JavaScript function transmitting the file path to a local Perl script.  
  Actual opening of the selected file is not performed until the selected file is not transmitted to and opened from a Perl script
  Please note that for security reasons full paths of local file or folders are inserted only inside local HTML files!  
  The following code is an example of how to select a local file and transmit it's full path to a local Perl script using jQuery:  

```javascript
  $(document).ready(function() {
      $('#file-selection').bind("inodeselection", function(){
          $.ajax({
              url: 'http://perl-executing-browser-pseudodomain/perl/open-file.pl',
              data: {filename: $('#file-selection').html()},
              method: 'POST',
              dataType: 'text',
              success: function(data) {
                  document.write(data);
              }
          });
      });
  });
```
  
* **Select multiple files:** ```http://perl-executing-browser-pseudodomain/open-files.function?target=DOM_element```  
  The full paths of the selected files will be inserted in the target DOM element of the calling local page.
  Having a target DOM element is mandatory when using this special URL.  
  ```inodeselection``` HTML event is emitted when the paths of the selected files are inserted into the calling local page.  
  Different file names are separated by a semicolon - ```;```  
  
* **Select new file name:** ```http://perl-executing-browser-pseudodomain/new-file.function?target=DOM_element```  
  The full path of the new file name will be inserted in the target DOM element of the calling local page.
  Having a target DOM element is mandatory when using this special URL.  
  ```inodeselection``` HTML event is emitted when the new file name is inserted into the calling local page.  
  Please note that the actual creation of the new file is not performed directly by PEB. Only after the new file name is transmitted to a Perl script, the script itself creates the new file.  
  
* **Select directory or create a new one:** ```http://perl-executing-browser-pseudodomain/open-directory.function?target=DOM_element```  
  The full path of the selected directory will be inserted in the target DOM element of the calling local page.  
  Having a target DOM element is mandatory when using this special URL.  
  ```inodeselection``` HTML event is emitted when the path of the selected directory is inserted into the calling local page.  
  Please note that if you choose to create a new directory, it will be created immediately by PEB and it will be already existing when it will be transmitted to a local Perl script.  
  
* **Print:** ```http://perl-executing-browser-pseudodomain/?action=preview```
  
* **Print Preview:** ```http://perl-executing-browser-pseudodomain/?action=print```
  
* **About PEB dialog box:** ```http://perl-executing-browser-pseudodomain/?type=browser```
  
* **About Qt dialog box:** ```http://perl-executing-browser-pseudodomain/?type=browser```
  
## Keyboard Shortcuts
* Ctrl+A - Select All
* Ctrl+C - Copy  
* Ctrl+V - Paste  
* F11 - toggle Fullscreen
* Alt+F4 - Close window
* Ctrl+P - Print
* Ctrl+I - debug current page using QWebInspector
  
## Security
  
**Security features based on C++ code:**
* PEB can not and does not download remote files and can not execute locally Perl scripts from remote locations.
* Users have no dialog to select arbitrary local scripts for execution by PEB. Only scripts within the ```{PEB_binary_directory}/resources/app``` directory can be executed if they are invoked from the PEB pseudo-domain: ```http://perl-executing-browser-pseudodomain/```.
* Starting PEB with administrative privileges is not allowed - it exits with a warning message.
* Perl 5 scripts are executed in a clean environment and only ```REQUEST_METHOD```, ```QUERY_STRING``` and ```CONTENT_LENGTH``` environment variables (borrowed from the CGI protocol) are used for communication between local HTML forms and local Perl scripts.
  
**Security features based on Perl code:**
* Perl scripts are executed in an ```eval``` function after banning potentially unsafe core functions. This feature is implemented in a special script named ```censor.pl```, which is compiled into the resources of the browser binary and is executed from memory when Perl script is started. All core functions from the :dangerous group - ```syscall```, ```dump``` and ```chroot```, as well as ```fork``` are banned.
* The environment of all Perl scripts is once again filtered in the ```BEGIN``` block of ```censor.pl``` to ensure no unwanted environment variables are inserted from the operating system.
  
**Perl Debugger Interaction:**
* Any Perl script can be selected for debugging, which is also a security risk. So if Perl debugger interaction is not needed, it can be turned off by a compile-time variable. Just change ```PERL_DEBUGGER_INTERACTION = 1``` to ```PERL_DEBUGGER_INTERACTION = 0``` in the project file of the browser (peb.pro) and compile the binary.  
  
## Limitations
  
* No history and cache. JavaScript functions ```window.history.back()```, ```window.history.forward()``` and ```window.history.go()``` are disabled.
* No reloading from JavaScript of a page that is produced by local script, but local static pages, as well as web pages, can be reloaded from JavaScript using ```location.reload()```.
* No file can be downloaded on hard disk.
* No support for plugins and HTML 5 video.
  
## What Perl Executing Browser Is Not
  
* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers.
* Unlike JavaScript in general purpose web browsers, Perl scripts executed by PEB have no access to the HTML DOM tree of any page.
* PEB is not an implementation of the CGI protocol. It uses only three environment variables (see below) together with the GET and POST methods from the CGI protocol in a purely local context without any attempt to communicate with the outside world.
* PEB does not embed any Perl interpreter in itself and rellies on an external Perl distribution, which could be easily changed or upgraded independently.
* PEB has no sandbox for Perl scripts - they are treated like and executed as ordinary desktop applications with normal user privileges.
  
## Target Audience
  
* Perl and JavaScript enthusiasts creating custom data-driven desktop applications
* Perl developers willing to use the built-in Perl debugger in graphical mode
  
## History
  
PEB was started as a simple GUI for personal databases.
  
## Application(s) using Perl Executing Browser
  
* [Epigraphista](https://github.com/ddmitov/epigraphista) - Epigraphista is an EpiDoc XML file creator using Perl Executing Browser, Electron or NW.js as a desktop GUI framework, HTML 5 and Bootstrap for a themable user interface, JavaScript for on-screen text conversion and Perl 5 for a file-writing backend.
  
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
  
