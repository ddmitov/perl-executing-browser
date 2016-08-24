Perl Executing Browser  
--------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is an HTML GUI for local [Perl 5] (https://www.perl.org/) scripts executed without server as desktop applications. It is implemented as a C++ compiled executable based on [Qt 5] (https://www.qt.io/) and [QtWebKit] (https://trac.webkit.org/wiki/QtWebKit) libraries. Perl 5 scripts are run without timeout and they can be fed from HTML forms using direct GET and POST or AJAX requests to a built-in pseudo-domain. HTML interface for [the default Perl debugger] (http://perldoc.perl.org/perldebug.html) is also available. Inspired by [NW.js] (http://nwjs.io/) and [Electron] (http://electron.atom.io/), PEB is another reuse of web technologies in desktop applications with Perl doing the heavy lifting.  
  
## Contents
  
* [Design Objectives] (#design-objectives)
* [Features] (#features)
* [Compile-time Requirements] (#compile-time-requirements)
* [Runtime Requirements] (#runtime-requirements)
* [Calling a Local Perl Script from a Local Page] (#calling-a-local-perl-script-from-a-local-page)
* [Settings] (#settings)
* [Security] (#security)
* [Special URLs for Users and Opening Files and Folders] (#special-urls-for-users-and-opening-files-and-folders)
* [HTML Interface for the Perl Debugger] (#html-interface-for-the-perl-debugger)
* [Special URLs for Interaction with the Perl Debugger] (#special-urls-for-interaction-with-the-perl-debugger)
* [Local File Types] (#local-file-types)
* [Keyboard Shortcuts] (#keyboard-shortcuts)
* [What Perl Executing Browser Is Not] (#what-perl-executing-browser-is-not)
* [Limitations] (#limitations)
* [Target Audience] (#target-audience)
* [History](#history)
* [Application using Perl Executing Browser] (#application-using-perl-executing-browser)
* [License](#license)
* [Authors](#authors)
  
## Design Objectives
  
* **1. Fast and easy graphical user interface for Perl 5 desktop applications:**  
    use Perl 5, JavaScript, HTML 5 and CSS to create beautiful desktop applications,
  
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
* Perl 5 scripts can be fed from HTML forms using direct GET and POST or AJAX requests to a built-in pseudo-domain.
* Output from long running Perl 5 scripts can be seamlessly inserted into the HTML DOM of the calling local page.
* Any version of Perl 5 can be used.
* Basic security restrictions are imposed on every Perl script.
* PEB can be started from any folder.
* PEB is useful for both single-page or multi-page applications.
* Single file or multiple files, new filename, existing or new directory can be selected by user.  
  Their full paths are displayed in the calling local page and they can be supplied to local Perl scripts.
* Browser functions are accessible from special URLs.
* Any icon can be displayed on windows and message boxes.
* Optional JavaScript translation of context menu and dialog boxes.
* Optional warning for unsaved data in HTML forms before closing a window to prevent accidental data loss.
* Cross-site scripting is disabled for all web and local pages.
  
**Development goodies:**
* PEB can interact with the Perl 5 debugger in graphical mode - see section [HTML Interface for the Perl Debugger] (#html-interface-for-the-perl-debugger)  
* ```QWebInspector``` window can be invoked using ```Ctrl+I``` keyboard shortcut.
* Extensive optional logging of all browser actions.
  
## Compile-time Requirements
  
GCC compiler and Qt 5.1 - Qt 5.5 headers (including ```QtWebKit``` headers).  
Later versions of Qt are unusable due to the deprecation of ```QtWebKit```.  
  
The most important Qt dependency of PEB is actually not the ```QtWebkit``` set of classes, but ```QNetworkAccessManager``` class, which is subclassed to implement the local pseudo-domain of PEB together with all POST and AJAX GET requests to local Perl scripts. The removal of this class from the ecosystem of ```QtWebEngine```, the new Blink-based web engine of Qt, means that transition to ```QtWebEngine``` remains problematic.  
  
Compiled and tested successfully using:
* [Qt Creator 2.8.1 and Qt 5.1.1] (http://download.qt.io/official_releases/qt/5.1/5.1.1/) on 32-bit Debian Linux,
* [Qt Creator 3.0.0 and Qt 5.2.0] (http://download.qt.io/official_releases/qt/5.2/5.2.0/) on 32-bit Debian Linux,
* [Qt Creator 3.0.0 and Qt 5.2.0] (http://download.qt.io/official_releases/qt/5.2/5.2.0/) on 32-bit Windows XP,
* [Qt Creator 3.0.1 and Qt 5.2.1] (http://download.qt.io/official_releases/qt/5.2/5.2.1/) on 64-bit OS X 10.9.1, i5  
(main development and testing platform - Valcho Nedelchev),
* [Qt Creator 3.1.1 and Qt 5.3.0] (http://download.qt.io/official_releases/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10 Linux,
* [Qt Creator 3.1.1 and Qt 5.4.1] (http://download.qt.io/official_releases/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04 Linux,
* [Qt Creator 3.5.1 and Qt 5.5.1] (http://download.qt.io/official_releases/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04 Linux  
(main development and testing platform - Dimitar D. Mitov).
  
## Runtime Requirements
  
* Qt 5 libraries - their full Linux list can be found inside the ```start-peb.sh``` script,
* Perl 5 distribution - any Linux, Mac or Windows Perl distribution.  
  [Strawberry Perl] (http://strawberryperl.com/) PortableZIP editions are successfully used with all Windows builds of PEB.  
  [Perlbrew] (https://perlbrew.pl/) Perl distributions (5.18.4, 5.23.7) are successfully used with many Linux builds of PEB.  
  Being unable to start scripts with administrative privileges, PEB can use, but not abuse, any system Perl on PATH.
  
## Calling a Local Perl Script from a Local Page
  PEB recognizes two types of local Perl scripts: long running and AJAX scripts.  
  There is no timeout for all Perl scripts executed by PEB.
* **Long running Perl scripts:**  
    Long running Perl scripts are expected to produce either:  
    **1.** a complete HTML page that will replace the calling page or  
    **2.** pieces of data that will be inserted one after the other into the calling page using JavaScript.  
  
    **1.** If a complete HTML page is expected from the Perl script that is called, no special settings should be added. There can be multiple chunks of output from such a script - PEB accumulates them all and displays everything when the script is finished.  
  
    **2.** If script output is going to be inserted piece by piece into the HTML DOM of the calling page, then a special query item should be inserted into the script URL.  
  
    Example: ```http://local-pseudodomain/perl/counter.pl?target=script-results```  
  
    The ```target``` query item should point to a valid HTML DOM element. It is removed from the query string before the script is started. Every piece of script output is inserted immediately into the target DOM element of the calling page in this scenario. HTML event called ```scriptoutput``` is emitted when script output is inserted into the calling local page. This event can be binded to a JavaScript function for a variety of reasons including daisy chaining of different scripts. The calling page must not be reloaded during the script execution, otherwise no script output will be inserted.  
  
    Two or more long running scripts can be started within a single calling page. They will be executed independently and their output will be updated in real time using separate target DOM elements. This could be convenient for all sorts of monitoring or data conversion scripts that have to run for a long time.  
  
    **Note for Windows developers:** Any long running script producing output that is going to be inserted into the calling page should have ```$|=1;``` among its first lines to disable the built-in buffering of the Perl interpreter. Some Windows builds of Perl may not give any output until the script is finished when buffering is enabled.  
  
    There is no special naming convention for long running scripts. They can be called from hyperlinks or HTML forms using a full HTTP URL with the PEB pseudo-domain or a relative path. If a relative path is used, the PEB pseudo-domain will be added automatically - see section [Special URLs for Interaction with the Perl Debugger] (#special-urls-for-interaction-with-the-perl-debugger). The following code is an example of a direct POST request to a local script from an HTML form:

```html
  <form action="http://local-pseudodomain/perl/test.pl" method="post">
      <input type="text" id="value1" name="value1" placeholder="Value 1" title="Value 1">
      <input type="text" id="value2" name="value2" placeholder="Value 2" title="Value 2">
      <input type="submit" value="Submit">
  </form>
```

* **AJAX Perl scripts:**  
    Inside PEB AJAX scripts have two differences compared to long running scripts.  
  
    **1.** PEB returns all output from an AJAX script in one piece after the script has finished with no timeout.  
  
    **2.** AJAX scripts must have the keyword ```ajax``` (case insensitive) somewhere in their pathnames so that PEB is able to distinguish between AJAX and long running scripts. An AJAX script could be named ```ajax-test.pl``` or all AJAX scripts could be placed in a folder called ```ajax-scripts``` somewhere inside the application directory - see section [Settings] (#settings).
  
    The following example calls a local AJAX Perl script and inserts its output into the ```ajax-results``` HTML DOM element of the calling page:  

```javascript
  $(document).ready(function() {
      $('#ajax-button').click(function() {
          $.ajax({
              url: 'http://local-pseudodomain/perl/ajax-test.pl',
              method: 'GET',
              dataType: 'text',
              success: function(data) {
                  $('#ajax-results').html(data);
              }
          });
      });
  });
```

## Settings
  
**Settings based on the existence of certain files and folders:**  
PEB is designed to run from any directory without setting anything beforehand and every file or directory that is checked during program start-up is relative to the directory where the PEB binary file is located, further labeled as ```{PEB_binary_directory}```.
* **Name of the binary file:**  
    The binary file of the browser, ```peb```, ```peb.app```, ```peb.dmg``` or ```peb.exe``` by default, can be renamed without restrictions. It can take the name of the PEB-based application it is going to run. No additional adjustments are necessary after renaming the binary. If log files are wanted, they will take the name of the binary file (without the filename extension), whatever the name may be.
* **Application directory:**  
    Application directory is ```{PEB_binary_directory}/resources/app```. All files used by PEB, with the exception of data files, must be located within this folder. Application directory is hard-coded in C++ code for compatibility with the [Electron] (http://electron.atom.io/) framework. [Epigraphista] (https://github.com/ddmitov/epigraphista) provides an example of a PEB-based application, that is also compatible with [Electron] (http://electron.atom.io/) and [NW.js] (http://nwjs.io/).
* **Data directory:**  
    Data directory is not hard-coded in C++ code, but a separation of data files from code is generally a good practice. Data directory should contain any SQLite or flat file database or other data files, that a PEB-based application is going to use or produce. The recommended path for data directory is inside the ```{PEB_binary_directory}/resources``` directory. ```data``` is a good directory name, although not mandatory. Perl scripts can access this folder using the following code:

```perl
    use Cwd;
  
    my $current_working_directory = cwd();
    my $data_directory = "$current_working_directory/resources/data";
```

* **Perl interpreter:**  
    PEB expects to find Perl interpreter in ```{PEB_binary_directory}/perl/bin``` folder. The interpreter must be named ```perl``` on Linux and Mac machines and ```perl.exe``` on Windows machines. If Perl interpreter is not found in the above location, PEB will try to find the first Perl interpreter on PATH. If no Perl interpreter is found, an error page is displayed instead of the start page. No Perl interpreter is a showstopper for PEB.
* **Start page:**  
    PEB can start with a static HTML start page or with a start page that is produced dynamically by a Perl script. When PEB is started, it will first try to find ```{PEB_binary_directory}/resources/app/index.html```. If this file is found, it will be used as a start page. If this file is missing, PEB will try to find ```{PEB_binary_directory}/resources/app/index.pl```. If this script is found, it will be executed and the resulting HTML output will be displayed as a start page. If both ```index.html``` and ```index.pl``` are not found, an error message will be displayed. No start page is a showstopper for PEB.  
    Note that both static and dynamic start page pathnames are case sensitive.
* **Icon:**  
    A PEB-based application can have its own icon and it must be located at ```{PEB_binary_directory}/resources/app/app.png```. If this file is found during application start-up, it will be used as the icon of all windows and dialog boxes. If this file is not found, the default icon embedded into the resources of the browser binary will be used.
* **Log files:**  
    If log files are needed for debugging of PEB or a PEB-based application, they can easily be turned on by manually creating ```{PEB_binary_directory}/logs```. If this directory is found during application start-up, the browser assumes that logging is required and a separate log file is created for every browser session following the naming convention: ```{application_name}-started-at-{four_digit_year}-{month}-{day}--{hour}-{minute}-{second}.log```. PEB will not create ```{PEB_binary_directory}/logs``` on its own and if this directory is missing, no logs will be written, which is the default behavior.  
    
    Please note, that log files can rapidly grow in size because every requested link is logged. If disc space is an issue, writing log files can be turned off by simply removing or renaming ```{PEB_binary_directory}/logs```.
  
**Settings based on JavaScript code:**  
JavaScript-based settings are created to facilitate the development of fully translated and multilanguage applications without depending on compiled Qt translation files. JavaScript is also used to prevent data loss when user tries to close a local page containing unsaved data in an HTML form.
* **Custom or translated context menu labels:**  
  Using the following code any local HTML page can have custom labels on the default right-click context menu (if the ```contextmenu``` event is not already intercepted):  

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

* **Checking for unsaved user input before closing a window:**
  PEB users can enter a lot of data in local HTML forms and it is often important to safeguard this information from accidental deletion if PEB window is closed without first saving the user data. When user starts closing a PEB window, the browser checks for any unsaved data in all forms of the HTML page that is going to be closed. This is achieved using internal JavaScript code compiled in the resources of the browser binary.  
  
  If any unsaved data is detected, PEB tries to determine what kind of JavaScript routine has to be displayed to warn the user and ask for final confirmation. Two types of JavaScript warning routines are possible in this scenario: synchronous and asynchronous.  
  
  If the local HTML page, that is going to be closed, contains a JavaScript function called ```pebCloseConfirmationAsync()```, then this asynchronous routine is going to be executed. If it is not found, then the browser tries to find and execute a synchronous warning function called ```pebCloseConfirmationSync()```. If none of the above functions is found, then PEB assumes that no warning has to be displayed and closes the window immediately.  
  
  What are the differences between the two routines?  
  
  The synchronous warning function is implemented using standard JavaScript Confirm dialog, which stops the execution of all JavaScript code within the page and waits until 'Yes' or 'No' is finally pressed. The Confirm dialog looks like a normal native dialog.  
  
  The asynchronous warning function does not rely on JavaScript Confirm dialog, does not stop the execution of any JavaScript code within the page and does not wait for the user's decision. If the user chooses to close the window, a special window closing URL, ```http://local-pseudodomain/close-window.function```, has to be sent to the browser. Upon receiving this URL, PEB closes the window from where the window closing URL was requested. The warning dialog can be styled to blend with the rest of the HTML interface or to attract attention and this is the main advantage of using an asynchronous warning dialog. Developers can implement it using any suitable JavaScript library or custom code.  
  
  The following code is an example of both synchronous and asynchronous warning functions. It is expected, that one of them will be present in a PEB-based application where user data is to be protected against accidental loss. If both functions are present, the asynchronous one will take precedence. The asynchronous function in the example code is implemented using [jQuery] (https://jquery.com/) and [Alertify.js] (http://alertifyjs.com/).  

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
                  url: 'http://local-pseudodomain/close-window.function',
                  method: 'GET'
              });
          }
      });
  }
```

  
## Security
   Being a GUI for Perl 5 desktop applications, PEB executes with normal user privileges only local Perl scripts in its application directory. Reasonable security restrictions are implemented in both C++ and Perl code, but they do not constitute a sandbox for Perl scripts. PEB users have full access to their local files without posing a danger to the underlying operating system or being exposed to remote code execution.  
  
**Security features based on C++ code:**
* PEB can not and does not download remote files on hard disk and can not execute any Perl scripts from remote locations.
* Cross-site scripting is disabled for all web and local pages.
* Plugin support is disabled.
* Users have no dialog to select arbitrary local scripts for execution by PEB. Only scripts within the ```{PEB_binary_directory}/resources/app``` directory can be executed if they are invoked from the PEB pseudo-domain: ```http://local-pseudodomain/```.
* If PEB is started with administrative privileges, it displays a warning page and no scripts can be executed.
* Perl 5 scripts are executed in a clean environment and only ```REQUEST_METHOD```, ```QUERY_STRING``` and ```CONTENT_LENGTH``` environment variables (borrowed from the CGI protocol) are used for communication between local HTML forms and local Perl scripts.
  
**Security features based on Perl code:**
* Perl scripts are executed in an ```eval``` function after banning the ```fork``` core function. This feature is implemented in a special script named ```censor.pl```, which is compiled into the resources of the browser binary and is executed from memory when Perl script is started. ```fork``` is banned to avoid orphan processes, which may be created if this function is carelessly used.  
  ```censor.pl``` also takes care about displaying nicely formatted HTML error page if the use of ```fork``` is prevented or script errors are found.
* The environment of all Perl scripts is once again filtered in the ```BEGIN``` block of ```censor.pl``` to ensure no unwanted environment variables are inserted by the operating system.
  
**Perl Debugger Interaction:**
* Any Perl script can be selected for debugging, which is also a security risk. So if Perl debugger interaction is not needed, it can be turned off by a compile-time variable. Just change ```PERL_DEBUGGER_INTERACTION = 1``` to ```PERL_DEBUGGER_INTERACTION = 0``` in the project file of the browser (peb.pro) and compile the binary.  
  
## Special URLs for Users and Opening Files and Folders
  
* **PEB pseudo-domain:** ```http://local-pseudodomain/```  
  The  pseudo-domain is used to call all local files and all special URLs representing browser functions.  
  It is intercepted inside PEB and is not passed to the underlying operating system.  
  
* **Close current window:** ```http://local-pseudodomain/close-window.function```  
  Please note that the window from where this URL was called will be closed immediately without any check for unsaved user data in HTML forms. Window closing URL can be called not only by clicking a link, but also by using a ```jQuery``` AJAX GET request.  
  
* **Select single file:** ```http://local-pseudodomain/open-file.function?target=DOM_element```  
  The full path of the selected file will be inserted in the target DOM element of the calling local page.  
  Having a target DOM element is mandatory when using this special URL.  
  HTML event called ```inodeselection``` is emitted when the path of the selected file is inserted into the calling local page.  
  This event can be binded to a JavaScript function transmitting the file path to a local Perl script.  
  Actual opening of the selected file is performed only after the selected file is transmitted to and opened from a Perl script.  
  
  Please note that for security reasons full paths of local files or folders are inserted only inside local pages!  
  
  The following code is an example of how to select a local file and transmit its full path to a local Perl script using ```jQuery```:  

```javascript
  $(document).ready(function() {
      $('#file-selection').bind("inodeselection", function(){
          $.ajax({
              url: 'http://local-pseudodomain/perl/open-file.pl',
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

* **Select multiple files:** ```http://local-pseudodomain/open-files.function?target=DOM_element```  
  The full paths of the selected files will be inserted in the target DOM element of the calling local page.  
  Having a target DOM element is mandatory when using this special URL.  
  ```inodeselection``` HTML event is emitted when the paths of the selected files are inserted into the calling local page.  
  Different file names are separated by a semicolon - ```;```  
  
* **Select new file name:** ```http://local-pseudodomain/new-file-name.function?target=DOM_element```  
  The full path of the new file name will be inserted in the target DOM element of the calling local page.  
  Having a target DOM element is mandatory when using this special URL.  
  ```inodeselection``` HTML event is emitted when the new file name is inserted into the calling local page.  
  
  Please note that the actual creation of the new file is not performed directly by PEB. Only after the new file name is transmitted to a Perl script, the script itself will create the new file.  
  
* **Select directory:** ```http://local-pseudodomain/open-directory.function?target=DOM_element```  
  The full path of the selected directory will be inserted in the target DOM element of the calling local page.  
  Having a target DOM element is mandatory when using this special URL.  
  ```inodeselection``` HTML event is emitted when the path of the selected directory is inserted into the calling local page.  
  
  Please note that if you choose to create a new directory, it will be created immediately by PEB and it will be already existing when it will be passed to a local Perl script.  
  
* **Print:** ```http://local-pseudodomain/print.function?action=print```  
  Printing is not immediately performed, but a native printer selection dialog is displayed first.  
  If no printer is configured, no dialog is displayed and no action is taken.
  
* **Print Preview:** ```http://local-pseudodomain/print.function?action=preview```
  
* **About PEB embedded page:** ```http://local-pseudodomain/about.function?type=browser```
  
* **About Qt dialog box:** ```http://local-pseudodomain/about.function?type=qt```
  
## HTML Interface for the Perl Debugger
   Any Perl script can be selected for debugging in an embedded HTML user interface. The debugger output is displayed together with the syntax highlighted source code of the debugged script and its modules. Syntax highlighting is achieved using [Syntax::Highlight::Engine::Kate] (https://metacpan.org/release/Syntax-Highlight-Engine-Kate) CPAN module by Hans Jeuken and Gábor Szabó. Interaction with the built-in Perl debugger is an idea proposed by Valcho Nedelchev and provoked by the scarcity of graphical frontends for the Perl debugger.  
  
   If the debugged script is inside the application directory of PEB (see section [Settings] (#settings)), PEB assumes that this script is going to be executed by PEB and starts the Perl debugger with a clean environment like the one for all other PEB Perl scripts. If the debugged script is outside the application directory, PEB asks for any command line arguments and starts the Perl debugger with the environment of the user who started PEB.  
  
   HTML interface for the Perl debugger is not available in the Windows builds of PEB.  
  
   ![PEB HTML Interface for the Perl Debugger](https://github.com/ddmitov/perl-executing-browser/raw/master/screenshots/peb-perl-debugger.png "PEB HTML Interface for the Perl Debugger")
  
## Special URLs for Interaction with the Perl Debugger
  
* **Select file:** ```http://local-pseudodomain/perl-debugger.function?action=select-file```  
  The selected file will be loaded in the Perl debugger, but no command will be automatically issued. Any command can be given later by buttons or by typing it in an input box inside the HTML user interface of the debugger.
  
* **Send command:** ```http://local-pseudodomain/perl-debugger.function?command=M```  
  
* **Combined Perl Debugger URL:**  
  Selecting file to debug and sending command to the Perl debugger can be combined in a single URL.  
  Example: ```http://local-pseudodomain/perl-debugger.function?action=select-file&command=M```  
  Using the above URL, the selected file will be loaded in the Perl debugger, the ```M``` command ('Display all loaded modules') will be immediately issued and all resulting output will be displayed. Any command can be given later and step-by-step debugging can be performed.
  
## Local File Types
  
  All file types not listed here are unsupported. If they are linked from local pages, they will be opened using the default application of the operating system.  
  
  PEB is case-insensitive for all local filename extensions with the exception of the start page filename extensions.  
  All local files can have multi-dotted names.  
  
  Perl scripts are usually recognized by PEB using the ```.pl``` filename extension.  
  Perl scripts without filename extensions are recognized using a Perl shebang line like:  
  ```#!/usr/bin/perl``` or ```#!/usr/bin/env perl```  
  No shebang line can change the Perl distribution used by PEB. Shebang arguments are not honored by PEB.  
  PEB finds Perl interpreter at start-up and uses shebang line only to detect Perl scripts without filename extension.  
  
  All other supported local file types are recognized using the fllowing filename extensions:  
* **CSS files:** ```.css```
* **Font files:** ```.eot``` ```.otf``` ```.ttf``` ```.woff``` ```.woff2```
* **HTML files:** ```.htm``` ```.html```
* **Image files:** ```.gif``` ```.jpeg``` ```.jpg``` ```.png``` ```.svg```
* **JavaScript files:** ```.js```
* **JSON files:** ```.json```
* **XML files:** ```.xml```
  
## Keyboard Shortcuts
  
* ```Alt+F4``` - Close window
* ```Ctrl+A``` - Select All
* ```Ctrl+C``` - Copy
* ```Ctrl+I``` - debug current page using ```QWebInspector```
* ```Ctrl+P``` - Print
* ```Ctrl+V``` - Paste
* ```F11``` - toggle Fullscreen
  
## What Perl Executing Browser Is Not
  
* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers.
* PEB does not act as a server and is not an implementation of the CGI protocol. It uses only three environment variables borrowed from the CGI protocol in a purely local context without any attempt to communicate with the outside world.
* PEB does not embed any Perl interpreter in itself and relies on an external Perl distribution, which could be easily changed or upgraded independently.  
  
## Limitations
  
* No history and cache.  
  JavaScript functions ```window.history.back()```, ```window.history.forward()``` and ```window.history.go()``` are disabled.
* No page produced by a local Perl script can be reloaded because no temporary files for script output are written.  
  Local HTML pages, as well as web pages, can be reloaded using the JavaScript function ```location.reload()```.
* No file can be downloaded on hard disk.
* No support for plugins and HTML 5 video.
  
## Target Audience
  
* Perl 5 enthusiasts and developers creating custom desktop applications
* Perl 5 enthusiasts and developers willing to use the built-in Perl debugger in graphical mode
  
## History
  
PEB was started as a simple GUI for personal databases in 2013 by Dimitar D. Mitov.
  
## Application using Perl Executing Browser
  
* [Epigraphista](https://github.com/ddmitov/epigraphista) is an [EpiDoc] (https://sourceforge.net/p/epidoc/wiki/Home/) XML file creator. It is implemented as a hybrid desktop and server application using [Perl Executing Browser] (https://github.com/ddmitov/perl-executing-browser), [Electron] (http://electron.atom.io/) or [NW.js] (http://nwjs.io/) as a desktop GUI framework, [Bootstrap] (http://getbootstrap.com/) for a themable HTML 5 user interface, JavaScript for on-screen text conversion and [Perl 5] (https://www.perl.org/) for a file-writing backend.
  
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
  
