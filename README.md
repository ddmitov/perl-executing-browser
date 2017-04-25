Perl Executing Browser
--------------------------------------------------------------------------------

[![GitHub Version](https://img.shields.io/github/release/ddmitov/perl-executing-browser.svg)](https://github.com/ddmitov/perl-executing-browser/releases)
[![GitHub License](http://img.shields.io/badge/License-LGPL%20v3-blue.svg)](./LICENSE.md)
[![Build Status](https://travis-ci.org/ddmitov/perl-executing-browser.svg?branch=master)](https://travis-ci.org/ddmitov/perl-executing-browser)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/ddmitov/perl-executing-browser?branch=master&svg=true)](https://ci.appveyor.com/project/ddmitov/perl-executing-browser)  

Perl Executing Browser (PEB) is an HTML user interface for [Perl 5](https://www.perl.org/) desktop applications. It runs local Perl 5 scripts without server and with no timeout and is implemented as a C++ compiled executable based on [Qt 5](https://www.qt.io/) and [QtWebKit](https://trac.webkit.org/wiki/QtWebKit) libraries. PEB Perl scripts are fed from HTML forms using GET or POST requests to a built-in pseudo-domain.  

Inspired by [NW.js](http://nwjs.io/) and [Electron](http://electron.atom.io/), PEB is another reuse of web technologies in desktop applications with Perl doing the heavy lifting. In contrast to [NW.js](http://nwjs.io/) and [Electron](http://electron.atom.io/), PEB enforces strict separation between trusted and untrusted content in different browser windows.

## Contents
* [Quick Start](#quick-start)
* [Design Objectives](#design-objectives)
* [Target Audience](#target-audience)
* [Features](#features)
* [Compile-time Requirements](#compile-time-requirements)
* [Compile-time Variables](#compile-time-variables)
* [Runtime Requirements](#runtime-requirements)
* [Supported Perl Script Types](#supported-perl-script-types)
* [Non-interactive Perl Scripts](#non-interactive-perl-scripts)
* [Interactive Perl Scripts](#interactive-perl-scripts)
* [AJAX Perl Scripts](#ajax-perl-scripts)
* [Linux Superuser Perl Scripts](#linux-superuser-perl-scripts)
* [Settings](#settings)
* [Security](#security)
* [Special URLs](#special-urls)
* [Local File Types](#local-file-types)
* [Keyboard Shortcuts](#keyboard-shortcuts)
* [What PEB Is Not](#what-peb-is-not)
* [Limitations](#limitations)
* [History](#history)
* [Applications Based on PEB](#applications-based-on-peb)
* [License](#license)
* [Authors](#authors)

## Quick Start
  These are the basic steps for building your first PEB-based application:
* **1.** Write your local HTML file(s) that will serve as a GUI for your application.  
* **1.1.** If your users will have to enter data manually, don't forget to make appropriate HTML forms for them.
* **1.2.** If your users will have to open local files or folders, see section *Special URLs for Users* for information on [how to open single file](#select-single-file) or [multiple files](#select-multiple-files), [how to prompt for a new filename](#select-new-file-name) and [how to select an existing folder or create a new one](#select-directory) from PEB. You may also see the ``filesystem.html`` file within the PEB demo package.
* **1.3.** Connect your local HTML file(s) to your Perl 5 scripts. See section [Supported Perl Script Types](#supported-perl-script-types).
* **2.** Write your Perl scripts.  
    Input from local HTML files is read just like reading POST or GET requests in a Perl CGI script. You may see the ``get-post-test.pl`` file within the PEB demo package.  

  Note that PEB is created to work from any folder without installation and all files and directories used by PEB are relational to the directory where the PEB binary is located. All your local HTML files and Perl scripts must be located inside the ``{PEB_binary_directory}/resources/app`` directory - see section [Settings](#settings).  

## Design Objectives
* **1. Fast and easy graphical user interface for Perl 5 desktop applications:**  
    use Perl 5, JavaScript, HTML and CSS to create beautiful desktop applications

* **2. Zero installation:**  
    run from any folder

* **3. Cross-platform availability:**  
    usable on every platform, where Perl 5, Qt 5 and QtWebKit are available

* **4. Secure serverless solution:**  
    no server of any kind is installed or started

* **5. Maximal reuse of existing web technologies and standards**

## Target Audience
* Perl 5 enthusiasts and developers creating custom desktop applications including rich/thick/fat clients
* DevOps people in need of custom Perl-based GUI monitoring and administration solutions

## Features
* [Perl scripts can be fed from HTML forms using GET and POST requests to a built-in pseudo-domain.](#feeding-from-forms)
* [Perl scripts featuring STDIN event loops can be repeatedly fed with data.](#interactive-perl-scripts)
* [Linux superuser Perl scripts can be started.](#linux-superuser-perl-scripts)
* [Perl script output can be seamlessly inserted into the calling local page.](#data-only-scripts)
* [Untrusted web content is never mixed with trusted local content.](#security)
* Cross-site scripting is disabled for all web and local pages.
* [Any version of Perl 5 can be used.](#runtime-requirements)
* [PEB can be started from any folder.](#settings)
* PEB is useful for both single-page (including multi-frame) or multi-page applications.
* [Single file or multiple files, new filename, existing or new directory can be selected by user.](#special-urls-for-users)  
  Their full paths are easily supplied to local Perl scripts.
* [Browser functions are accessible from special URLs.](#browser-functions)
* [Optional context menu translation using JavaScript ](#custom-or-translated-context-menu-labels)
* [Optional translation of the JavaScript *Alert*, *Confirm* and *Prompt* dialog boxes using JavaScript](#custom-or-translated-labels-for-javascript-dialog-boxes)
* [Optional warning for unsaved data in HTML forms before closing a window to prevent accidental data loss](#warning-for-unsaved-user-input-before-closing-a-window)
* [Any icon can be displayed on windows and message boxes.](#icon)
* ``QWebInspector`` window can be invoked using <kbd>Ctrl</kbd> + <kbd>I</kbd> keyboard shortcut.
* [Optional logging of all browser actions](#log-files)

## Compile-time Requirements
* GCC compiler
* Qt 5.1 - 5.5 (including ``QtWebKit`` libraries and headers)  
  ``QtWebKit`` is deprecated and replaced by the Blink-based ``QtWebEngine`` in all later versions of Qt.  
  Compiling ``QtWebKit`` for a recent Qt version is possible, but not trivial or tested with PEB.  

The implementation of the local pseudo-domain and all requests to local content depend on the ``QNetworkAccessManager`` class, which is incompatible with ``QtWebEngine``. If you want to render the HTML user interface of your Perl desktop application using the Blink web engine, you may use [Electron](http://electron.atom.io/) or [NW.js](http://nwjs.io/) combined with [camel-harness](https://github.com/ddmitov/camel-harness).  

Compiled and tested successfully using:
* [Qt Creator 2.8.1 and Qt 5.1.1](http://download.qt.io/archive/qt/5.1/5.1.1/) on 32-bit Debian Linux,
* [Qt Creator 3.0.0 and Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Debian Linux,
* [Qt Creator 3.0.0 and Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Windows XP,
* [Qt Creator 3.0.1 and Qt 5.2.1](http://download.qt.io/archive/qt/5.2/5.2.1/) on 64-bit OS X 10.9.1, i5,
* [Qt Creator 3.1.1 and Qt 5.3.0](http://download.qt.io/archive/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10 Linux,
* [Qt Creator 3.1.1 and Qt 5.4.1](http://download.qt.io/archive/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04 Linux,
* [Qt Creator 3.5.1 and Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04 Linux,
* [Qt Creator 3.5.1 and Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 16.04 Linux.

To compile PEB type in a terminal inside the ``src`` folder:

```
qmake
make
```

If you are using the Qt Creator IDE, go to 'Projects' and disable the 'Shadow Build' option to produce the binary in the root folder of the project and test the demo package.

## Compile-time Variables
Changing PEB compile-time variables requires editing the ``src/peb.pro`` project file before compiling the binary.

* **Macintosh binary type:** ``BUNDLE``  
  To make a bundle-less binary, which is the default setting:  

  ```QMake
  BUNDLE = 0
  CONFIG -= app_bundle
  ```

  To make a bundled binary (peb.app):  

  ```QMake
  BUNDLE = 1
  CONFIG += app_bundle
  ```

<a name="security-compile-time-variable"></a>
The following compile-time variable can tighten further the security of PEB.

* **Administrative privileges check:** ``ADMIN_PRIVILEGES_CHECK``  
  To disable administrative privileges check: ``ADMIN_PRIVILEGES_CHECK = 0``  
  By default administrative privileges check is disabled.  
  To enable administrative privileges check: ``ADMIN_PRIVILEGES_CHECK = 1``  
  If administrative privileges check is enabled and PEB is started with administrative privileges, a warning page is displayed and no scripts can be executed. Starting Linux superuser scripts is not possible in this scenario.  

## Runtime Requirements
* Qt 5 libraries - their full Linux list can be found inside the ``start-peb.sh`` script,
* Perl 5 distribution - any Linux, Mac or Windows Perl distribution.  

  Tested successfully using the following Perl distributions:  
  Linux 64-bit [Perlbrew](https://perlbrew.pl/) Perl versions 5.18.4, 5.23.7  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) version 5.24.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP versions 5.12.2.0, 5.16.1.1, 5.20.2.1  

  To use a Perlbrew Perl with PEB create a symlink to the wanted Perl interpreter named:  
  ``{PEB_binary_directory}/perl/bin/perl``  

  PEB can also use any Perl on PATH.

## Supported Perl Script Types
  PEB recognizes four main types of local Perl scripts and does not impose execution timeouts on them:  
* [**non-interactive scripts**](#non-interactive-perl-scripts)
* [**interactive scripts**](#interactive-perl-scripts)
* [**AJAX scripts**](#ajax-perl-scripts)
* [**Linux superuser scripts**](#linux-superuser-perl-scripts)

## Non-interactive Perl Scripts
They can not receive any user input once they are started and are divided into the following two subtypes:  

* **Page-producing scripts:**  
  They produce complete HTML pages and no special settings are necessary when they are called from a local page. There can be multiple chunks of output from such a script - PEB accumulates them all and displays everything when the script is finished.  

* **Data-only scripts:**<a name="data-only-scripts"></a>  
  They don't produce a complete HTML page, but only pieces of data that are inserted one after the other into the HTML DOM of the calling page. The special query string item ``stdout`` should be added to the script URL in this case.  

  Example: ``http://local-pseudodomain/perl/counter.pl?stdout=script-results``  

  The ``stdout`` query string item should point to a valid HTML DOM element or JavaScript function of the calling page. It is removed from the query string before the script is started. Every piece of script output is immediately inserted into the specified DOM element or passed to the specified JavaScript function as its only function argument. The calling page must not be reloaded during the script execution or no script output will be inserted.  

  Two or more non-interactive scripts can be started within a single page. They will be executed independently and their output will be updated in real time using different DOM elements or JavaScript functions. This could be convenient for all sorts of long-running monitoring scripts.  

  **Windows caveat:** All data-only scripts should have ``$|=1;`` among their first lines to disable the built-in buffering of the Perl interpreter. Windows builds of Perl may not give any output until the script is finished when buffering is enabled.  

  <a name="feeding-from-forms"></a>
  There is no special naming convention for non-interactive scripts. They can be called from hyperlinks or HTML forms using a full HTTP URL with the PEB pseudo-domain or a relative path. If a relative path is used, the PEB pseudo-domain will be added automatically. The following code is an example of a POST request to a local Perl script from an HTML form with no use of JavaScript:

  ```html
  <form action="http://local-pseudodomain/perl/test.pl" method="post">
      <input type="text" id="value1" name="value1" placeholder="Value 1" title="Value 1">
      <input type="text" id="value2" name="value2" placeholder="Value 2" title="Value 2">
      <input type="submit" value="Submit">
  </form>
  ```

## Interactive Perl Scripts
Each PEB interactive Perl script has its own event loop waiting constantly for new data on STDIN effectively creating a bidirectional connection with PEB. Many interactive scripts can be started simultaneously in one browser window. One script may be started in many instances, but each of them must have an unique identifier in the form of an URL pseudo-password. Interactive scripts must be started with the special pseudo-user ``interactive`` and with the query string items ``stdout``, ``close_command`` and ``close_confirmation``.  

The URL pseudo-user ``interactive`` is the token used by PEB to detect interactive scripts.  

The ``stdout`` query string item should point to a valid HTML DOM element or JavaScript function of the calling page. It is removed from the query string before the script is started. Every piece of script output is immediately inserted into the specified DOM element or passed to the specified JavaScript function as its only function argument. The calling page must not be reloaded during the script execution or no script output will be inserted.  

The ``close_command`` query string item designates the command used to shut down an interactive script when the containing PEB window is going to be closed. Upon receiving it, the interactive script must start its shutdown procedure. Immediately before exiting, the interactive script must print on STDOUT its ``close_confirmation`` to signal PEB that it completed normally its shutdown. All interactive scripts in a window that is going to be closed must exit in 5 seconds after ``close_command`` is given or the unresponsive scripts will be killed and the window will be closed.  

The following JavaScript code demonstrates how to start an interactive Perl script immediately after its calling HTML page is loaded:

```javascript
document.addEventListener("DOMContentLoaded", function(event) {
    var request = new XMLHttpRequest();
    var parameters = {
        stdout: "output",
        close_command: "_close_",
        close_confirmation: "_closed_"
    }
    request.open('GET', 'http://interactive@local-pseudodomain/perl/interactive-script.pl' +
            formatParameters(parameters), true);
    request.send();
});

function formatParameters(parameters) {
    return "?" + Object
        .keys(parameters)
        .map(function(key){
            return key + "=" + parameters[key]
        })
    .join("&")
}
```

The following JavaScript code demonstrates how to start one script in two instances immediately after the calling HTML page is loaded:

```javascript
document.addEventListener("DOMContentLoaded", function(event) {
  var scriptOneRequest = new XMLHttpRequest();
  var scriptOneParameters = {
    stdout: "script-one-output",
    close_command: "_close_",
    close_confirmation: "_closed_"
  }
  scriptOneRequest.open('GET', 'http://interactive:one@local-pseudodomain/perl/interactive-script.pl' +
          formatParameters(scriptOneParameters), true);
  scriptOneRequest.send();

  var scriptTwoRequest = new XMLHttpRequest();
  var scriptTwoParameters = {
    stdout: "script-two-output",
    close_command: "_close_",
    close_confirmation: "_closed_"
  }
  scriptTwoRequest.open('GET', 'http://interactive:two@local-pseudodomain/perl/interactive-script.pl' +
          formatParameters(scriptTwoParameters), true);
  scriptTwoRequest.send();
});

function formatParameters(parameters) {
  return "?" + Object
    .keys(parameters)
    .map(function(key){
      return key + "=" + parameters[key]
    })
  .join("&")
}
```

## AJAX Perl Scripts
Local AJAX Perl scripts executed by PEB must have the pseudo-user ``ajax`` in their URLs so that PEB is able to distinguish between AJAX and all other scripts.  

The following example based on [jQuery](https://jquery.com/) calls a local AJAX Perl script and inserts its output into the ``ajax-results`` HTML DOM element of the calling page:  

```javascript
$(document).ready(function() {
    $('#ajax-button').click(function() {
        $.ajax({
            url: 'http://ajax@local-pseudodomain/perl/ajax-test.pl',
            method: 'GET',
            dataType: 'text',
            success: function(data) {
                $('#ajax-results').html(data);
            }
        });
    });
});
```

## Linux Superuser Perl Scripts
Linux superuser Perl scripts can be started using the special pseudo-user ``root``. So if PEB finds an URL like: ``http://root@local-pseudodomain/perl/root-open-directory.pl``, it will ask the user for the root password and then call ``sudo``, which will start the script. Root password is saved for 5 minutes inside the memory of the running PEB and is deleted afterwards. Output from superuser scripts is displayed inside PEB like the output from any other non-interactive Perl script. User data from HTML forms is supplied to superuser Perl scripts as the first command line argument without ``STDIN`` input or ``QUERY_STRING`` environment variable like in the user-level Perl scripts.

## Settings
**Settings based on the existence of certain files and folders:**  
PEB is designed to run from any directory without setting anything beforehand and every file or directory that is checked during program startup is relative to the directory where the PEB binary file is located, further labeled as ``{PEB_binary_directory}``.
* **Name of the binary file:**  
  The binary file of the browser, ``peb``, ``peb.app``, ``peb.dmg`` or ``peb.exe`` by default, can be renamed without restrictions. It can take the name of the PEB-based application it is going to run. No additional adjustments are necessary after renaming the binary. If log files are wanted, they will take the name of the binary file (without the filename extension), whatever the name may be.
* **Application directory:**  
  Application directory is ``{PEB_binary_directory}/resources/app``. All files used by PEB, with the exception of data files, must be located within this folder. Application directory is hard-coded in C++ code for compatibility with the [Electron](http://electron.atom.io/) framework. [Epigraphista](https://github.com/ddmitov/epigraphista) provides an example of a PEB-based application, that is also compatible with [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/).
* **Data directory:**  
  Data directory is not hard-coded in C++ code, but a separation of data files from code is generally a good practice. Data directory should contain any SQLite or flat file database or other data files, that a PEB-based application is going to use or produce. The recommended path for data directory is inside the ``{PEB_binary_directory}/resources`` directory. ``data`` is a good directory name, although not mandatory. Perl scripts can access this folder using the following code:

  ```perl
  use Cwd;

  my $current_working_directory = cwd();
  my $data_directory = "$current_working_directory/resources/data";
  ```

* **Perl interpreter:**  
  PEB expects to find Perl interpreter in ``{PEB_binary_directory}/perl/bin`` folder. The interpreter must be named ``perl`` on Linux and Mac machines and ``perl.exe`` on Windows machines. If Perl interpreter is not found in the above location, PEB will try to find the first Perl interpreter on PATH. If no Perl interpreter is found, an error page is displayed instead of the start page. No Perl interpreter is a showstopper for PEB.
* **Start page:**  
  PEB can start with a static HTML start page or with a start page that is produced dynamically by a Perl script. When PEB is started, it will first try to find ``{PEB_binary_directory}/resources/app/index.html``. If this file is found, it will be used as a start page. If this file is missing, PEB will try to find ``{PEB_binary_directory}/resources/app/index.pl``. If this script is found, it will be executed and the resulting HTML output will be displayed as a start page. If both ``index.html`` and ``index.pl`` are not found, an error message will be displayed. No start page is a showstopper for PEB.  
  Note that both static and dynamic start page pathnames are case sensitive.
* **Icon:**
<a name="icon"></a>  
  A PEB-based application can have its own icon and it must be located at ``{PEB_binary_directory}/resources/app/app.png``. If this file is found during application startup, it will be used as the icon of all windows and dialog boxes. If this file is not found, the default icon embedded into the resources of the browser binary will be used.
* **Trusted domains:**  
  If PEB is able to read ``{PEB_binary_directory}/resources/app/trusted-domains.json``, all domains listed in this file are considered trusted. Only the local pseudo-domain ``http://local-pseudodomain/`` is trusted if ``trusted-domains.json`` is missing. This setting should be used with care - see section [Security](#security).
* **Log files:**
<a name="log-files"></a>  
  If log files are needed for debugging of PEB or a PEB-based application, they can easily be turned on by manually creating ``{PEB_binary_directory}/logs``. If this directory is found during application startup, the browser assumes that logging is required and a separate log file is created for every browser session following the naming convention: ``{application_name}-started-at-{four_digit_year}-{month}-{day}--{hour}-{minute}-{second}.log``. PEB will not create ``{PEB_binary_directory}/logs`` on its own and if this directory is missing, no logs will be written, which is the default behavior. Please note that every requested link is logged and log files can grow rapidly. If disc space is an issue, writing log files can be turned off by simply removing or renaming ``{PEB_binary_directory}/logs``.

**Settings based on JavaScript code:**  
They have two functions:  
**1.** to facilitate the development of fully translated and multilanguage applications by providing labels for the context menu and JavaScript dialog boxes with no dependency on compiled Qt translation files and  
**2.** to prevent data loss when user tries to close a local page containing unsaved data in an HTML form.
* **Custom or translated context menu labels:**
<a name="custom-or-translated-context-menu-labels"></a>  
  Using the following code any local HTML page can have custom labels on the default right-click context menu (if the ``contextmenu`` event is not already intercepted):  

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
<a name="custom-or-translated-labels-for-javascript-dialog-boxes"></a>  
  Using the following code any local HTML page can have custom labels on the default JavaScript *Alert*, *Confirm* and *Prompt* dialog boxes:

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

* **Warning for unsaved user input before closing a window:**
<a name="warning-for-unsaved-user-input-before-closing-a-window"></a>  
  PEB users can enter a lot of data in local HTML forms and it is often important to safeguard this information from accidental deletion if PEB window is closed without first saving the user data. When user starts closing a PEB window, the browser checks for any unsaved data in all forms of the HTML page that is going to be closed. This is achieved using internal JavaScript code compiled in the resources of the browser binary.  

  If any unsaved data is detected, PEB tries to determine what kind of JavaScript routine has to be displayed to warn the user and ask for final confirmation. Two types of JavaScript warning routines are possible in this scenario: **synchronous** and **asynchronous**.  

  If a local HTML page going to be closed contains a JavaScript function called ``pebCloseConfirmationAsync()``, then this asynchronous routine is going to be executed. If it is not found, then the browser tries to find and execute a synchronous warning function called ``pebCloseConfirmationSync()``. If none of the above functions is found, then PEB assumes that no warning has to be displayed and closes the window immediately.  

  What are the differences between the two routines?  

  The synchronous warning function is implemented using standard JavaScript Confirm dialog, which stops the execution of all JavaScript code within the page and waits until 'Yes' or 'No' is finally pressed. The Confirm dialog looks like a normal native dialog.  

  The asynchronous warning function does not rely on JavaScript Confirm dialog, does not stop the execution of any JavaScript code within the page and does not wait for the user's decision. If the user chooses to close the window, a special window-closing URL, ``http://local-pseudodomain/close-window.function``, has to be sent to the browser. Upon receiving this URL, PEB closes the window from where the window-closing URL was requested. The warning dialog can be styled to blend with the rest of the HTML interface or to attract attention and this is the main advantage of using an asynchronous warning dialog. Developers can implement it using any suitable JavaScript library or custom code.  

  The following code is an example of both synchronous and asynchronous warning functions. It is expected that one of them will be present in a PEB-based application where user data is to be protected against accidental loss. If both functions are present, the asynchronous one will take precedence. The asynchronous function in the example code is implemented using [Alertify.js](http://alertifyjs.com/).  

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
              window.location.href = "http://local-pseudodomain/close-window.function";
          }
      });
  }
  ```

## Security
Being a desktop GUI, PEB executes with no sandbox local Perl 5 scripts in its application directory.

**PEB security principles:**
* Users have full access to their local data using PEB.
* PEB does not need administrative privileges, but does not refuse to use them if needed.
* Trusted and untrusted content are not mixed together in one browser window.  
  Trusted content is any content originating from the local pseudo-domain ``http://local-pseudodomain/`` or from a trusted domain listed in ``{PEB_binary_directory}/resources/app/trusted-domains.json``. This file is read only once at application startup and can not be manipulated remotely. It allows mixing local and remote content and has to be manually created by a developer of a PEB-based application if needed.  
  Untrusted content is any content not coming from the local pseudo-domain or from a domain listed in the ``trusted-domains.json`` file.

**Hard-coded security features:**
* PEB can not execute Perl scripts from remote locations.
* If untrusted page is called from a trusted one,  
  it is automatically displayed in a separate browser window.
* If untrusted JavaScript is called from a trusted page,  
  a warning message blocks the entire browser window until user goes to the start page to restore local Perl scripting.
* Local Perl scripts can not be started from untrusted pages.
* Files or folders can not be selected with their full paths from untrusted pages.
* Cross-site scripting is disabled for all web and local pages.

**[Optional security feature based on compile-time variable](#security-compile-time-variable)**

## Special URLs
* **PEB pseudo-domain:** ``http://local-pseudodomain/``  
  The  pseudo-domain is used to call all local files and all special URLs representing browser functions.  
  It is intercepted inside PEB and is not passed to the underlying operating system.  

* **Select single file:** ``http://local-pseudodomain/open-file.function?target=DOM_element``
<a name="select-single-file"></a>  
  The full path of the selected file will be inserted in the target DOM element of the calling local page or passed to the target JavaScript function as its first and only function argument.  
  Having a target query string item is mandatory when using this special URL.  
  The actual opening of the selected file is performed by the designated Perl script and not by PEB itself.  

  Please note that for security reasons full paths of local files or folders are inserted only inside local pages!  

  The following code is an example of how to select a local file and transmit its full path to a local Perl script using [jQuery](https://jquery.com/):  

  ```javascript
  function fileSelection(file) {
      $.ajax({
          url: 'http://local-pseudodomain/perl/open-file.pl',
          data: {filename: file},
          method: 'POST',
          dataType: 'text',
          success: function(data) {
              document.write(data);
          }
      });
  }
  ```

* **Select multiple files:** ``http://local-pseudodomain/open-files.function?target=DOM_element``
<a name="select-multiple-files"></a>  
  The full paths of the selected files will be inserted in the target DOM element of the calling local page or passed to the target JavaScript function as its first and only function argument.  
  Having a target query string item is mandatory when using this special URL.  
  Different file names are separated by a semicolon - ``;``  

* **Select new file name:** ``http://local-pseudodomain/new-file-name.function?target=DOM_element``
<a name="select-new-file-name"></a>  
  The new file name will be inserted in the target DOM element of the calling local page or passed to the target JavaScript function as its first and only function argument.  
  Having a target query string item is mandatory when using this special URL.  

  The actual creation of the new file is performed by the designated Perl script and not by PEB itself.  

* **Select directory:** ``http://local-pseudodomain/open-directory.function?target=DOM_element``
<a name="select-directory"></a>  
  The full path of the selected directory will be inserted in the target DOM element of the calling local page or passed to the target JavaScript function as its first and only function argument.  
  Having a target query string item is mandatory when using this special URL.  

  Please note that if you choose to create a new directory, it will be created immediately by PEB.  
  It will be already existing when passed to a local Perl script.  

<a name="browser-functions"></a>
* **Print:** ``http://local-pseudodomain/print.function?action=print``  
  Printing is not immediately performed, but a native printer selection dialog is displayed first.  
  If no printer is configured, no dialog is displayed and no action is taken.

* **Print Preview:** ``http://local-pseudodomain/print.function?action=preview``

* **About PEB embedded page:** ``http://local-pseudodomain/about.function?type=browser``

* **About Qt dialog box:** ``http://local-pseudodomain/about.function?type=qt``

* **Close current window:** ``http://local-pseudodomain/close-window.function``  
  Please note that the window from where this URL was called will be closed immediately without any check for unsaved user data in HTML forms. Window-closing URL was implememented to enable asynchronous JavaScript routines for window closing confirmation - see section *Settings*, paragraph [Warning for unsaved user input before closing a window](#warning-for-unsaved-user-input-before-closing-a-window).  

## Local File Types
  All file types not listed here are unsupported. If they are linked from local pages, they will be opened using the default application of the operating system.  

  PEB is case-insensitive for all local filename extensions with the exception of the start page filename extensions.  
  All local files can have multi-dotted names.  

  Perl scripts are usually recognized by PEB using the ``.pl`` filename extension.  
  Perl scripts without filename extensions are recognized using a Perl shebang line like:  
  ``#!/usr/bin/perl`` or ``#!/usr/bin/env perl``  
  No shebang line can change the Perl distribution used by PEB. Shebang arguments are not honored by PEB.  
  PEB finds Perl interpreter at application startup and uses shebang line only to detect Perl scripts without filename extension.  

  All other supported local file types are recognized using the following filename extensions:  
* **CSS files:** ``.css``
* **Font files:** ``.eot`` ``.otf`` ``.ttf`` ``.woff`` ``.woff2``
* **HTML files:** ``.htm`` ``.html``
* **Image files:** ``.gif`` ``.jpeg`` ``.jpg`` ``.png`` ``.svg``
* **JavaScript files:** ``.js``
* **JSON files:** ``.json``
* **XML files:** ``.xml``

## Keyboard Shortcuts
* <kbd>Alt</kbd> + <kbd>F4</kbd> - Close window
* <kbd>Ctrl</kbd> + <kbd>A</kbd> - Select All
* <kbd>Ctrl</kbd> + <kbd>C</kbd> - Copy
* <kbd>Ctrl</kbd> + <kbd>I</kbd> - debug current page using ``QWebInspector``
* <kbd>Ctrl</kbd> + <kbd>P</kbd> - Print
* <kbd>Ctrl</kbd> + <kbd>V</kbd> - Paste
* <kbd>F11</kbd> - toggle Fullscreen

## What PEB Is Not
* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers.
* PEB does not act as a server and is not an implementation of the CGI protocol. Only three environment variables are borrowed from the CGI protocol: ``REQUEST_METHOD``, ``QUERY_STRING`` and ``CONTENT_LENGTH`` and they are used for communication between local HTML forms and local Perl scripts in a purely local context without any attempt to communicate with the outside world.
* PEB does not embed any Perl interpreter in itself and relies on an external Perl distribution, which could be easily changed or upgraded independently.  

## Limitations
* No page produced by a local Perl script can be reloaded because no temporary files are written.  
  Local HTML pages, as well as web pages, can be reloaded using the JavaScript function ``location.reload()``.
* No history and cache.  
  JavaScript functions ``window.history.back()``, ``window.history.forward()`` and ``window.history.go()`` are disabled.
* No file can be downloaded on hard disk.
* No plugins and HTML 5 video.

## History
PEB was started as a simple GUI for personal databases in 2013 by Dimitar D. Mitov.

## Applications Based on PEB
* [Epigraphista](https://github.com/ddmitov/epigraphista) is an [EpiDoc](https://sourceforge.net/p/epidoc/wiki/Home/) XML file creator. It is a hybrid desktop or server application using [Perl Executing Browser](https://github.com/ddmitov/perl-executing-browser), [Electron](http://electron.atom.io/) or [NW.js](http://nwjs.io/) as a desktop GUI framework.
* [Camel Doctor](https://github.com/ddmitov/camel-doctor) is a Linux and Mac serverless HTML user interface for the [default Perl debugger](http://perldoc.perl.org/perldebug.html).

## License
This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License,  
as published by the Free Software Foundation;  
either version 3 of the License, or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

## Authors
Dimitar D. Mitov, 2013 - 2017,  
Valcho Nedelchev, 2014 - 2016.  
