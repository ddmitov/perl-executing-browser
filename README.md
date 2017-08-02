Perl Executing Browser
--------------------------------------------------------------------------------

[![GitHub Version](https://img.shields.io/github/release/ddmitov/perl-executing-browser.svg)](https://github.com/ddmitov/perl-executing-browser/releases)
[![GitHub License](http://img.shields.io/badge/License-LGPL%20v3-blue.svg)](./LICENSE.md)
[![Travis CI Build Status](https://travis-ci.org/ddmitov/perl-executing-browser.svg?branch=master)](https://travis-ci.org/ddmitov/perl-executing-browser)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ddmitov/perl-executing-browser?branch=master&svg=true)](https://ci.appveyor.com/project/ddmitov/perl-executing-browser)
[![Coverity Scan Build Status](https://scan.coverity.com/projects/11334/badge.svg)](https://scan.coverity.com/projects/ddmitov-perl-executing-browser)  

Perl Executing Browser (PEB) is an HTML5 user interface for [Perl 5](https://www.perl.org/) desktop applications. It runs local Perl 5 scripts as child processes with no server or execution timeout and is implemented as a C++ executable based on the [Qt 5](https://www.qt.io/) libraries.  

Inspired by [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/), PEB is another reuse of web technologies in desktop applications with Perl doing the heavy lifting. In contrast to Electron and NW.js, PEB does not depend on [Node.js](https://nodejs.org/en/), always runs JavaScript in a sandbox and blocks cross-origin requests.

## Contents
* [Quick Start](#quick-start)
* [Design Objectives](#design-objectives)
* [Features](#features)
* [Security](#security)
* [Compiling](#compiling)
* [Macintosh Binary Type](#macintosh-binary-type)
* [Runtime Requirements](#runtime-requirements)
* [Preparing a Perl Distribution for PEB](#preparing-a-perl-distribution-for-peb)
* [Perl Scripts API](#perl-scripts-api)
* [Interactive Perl Scripts](#interactive-perl-scripts)
* [Selecting Files and Folders](#selecting-files-and-folders)
* [Application Filename](#application-filename)
* [Hard Coded Files and Folders](#hard-coded-files-and-folders)
* [Data Directory](#data-directory)
* [Log Files](#log-files)
* [Page Settings](#page-settings)
* [Functional Pseudo Filenames](#functional-pseudo-filenames)
* [Specific Keyboard Shortcuts](#specific-keyboard-shortcuts)
* [What PEB Is Not](#what-peb-is-not)
* [Limitations](#limitations)
* [History](#history)
* [License](#license)
* [Authors](#authors)

## Quick Start
These are the basic steps for building your first PEB-based application:

* **1.** Write your ``index.html`` with appropriate HTML forms for user data input.  
  [Selecting files or folders with their full paths](#selecting-files-and-folders) is also possible.

* **2.** Write [a settings JavaScript object](#perl-scripts-api) for every Perl script you are going to run.

* **3.** Write your Perl scripts.  
  Input from local HTML forms is read just like reading POST or GET requests in a Perl CGI script.  
  You may use the [get-post-test.pl](resources/app/perl/get-post-test.pl) file as an example.

* **4.** Connect your Perl scripts to your local HTML page using [one of the three possible methods](#perl-scripts-api).  

PEB is created to work from any folder without installation and all your local HTML files and Perl scripts should be located in the ``{PEB_binary_directory}/resources/app`` directory.  

## Design Objectives
* **1. Fast, easy and beautiful graphical user interface for Perl 5 desktop applications**  
* **2. Zero installation**  
* **3. Cross-platform availability**  
* **4. Secure serverless solution**  
* **5. Maximal reuse of existing web technologies and standards**

## Features
* [Perl script output is seamlessly inserted in any local page.](#perl-scripts-api)
* [Perl scripts with STDIN event loops can be repeatedly fed with data.](#interactive-perl-scripts)
* [Any version of Perl 5 can be used.](#runtime-requirements)
* PEB can be started from any folder.
* [Single file or multiple files, new filename, existing or new directory can be selected by user.](#selecting-files-and-folders)  
* [Optional warning for unsaved data in HTML forms](#page-settings)
* [Custom labels for dialogs and context menu](#page-settings)
* [Custom icon for windows and message boxes](#icon)
* [Optional logging](#log-files)

## Security
* PEB does not need administrative privileges, but does not refuse to use them if needed.
* PEB does not use any kind of server.
* PEB executes with no sandbox only local Perl 5 scripts and
  users have full access to their local files.
* Cross-origin requests and cross-site scripting are disabled.
  Calling web scripts from a local page is blocked.  
  Calling local Perl scripts from a web page is blocked.  
* Files or folders can not be selected with their full paths from web pages.

## Compiling
The only compile-time requirement of PEB is a Qt development bundle version 5.2 or any later version.

Compiled and tested successfully using:
* [Qt Creator 3.0.0 and Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Debian and 32-bit Windows XP
* [Qt Creator 3.0.1 and Qt 5.2.1](http://download.qt.io/archive/qt/5.2/5.2.1/) on 64-bit OS X 10.9.1, i5
* [Qt Creator 3.1.1 and Qt 5.3.0](http://download.qt.io/archive/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10
* [Qt Creator 3.1.1 and Qt 5.4.1](http://download.qt.io/archive/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04
* [Qt Creator 3.5.1 and Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04 and 16.04
* [Qt Creator 4.2.1 and Qt 5.8.0](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 16.04

To compile PEB type in a terminal started in the ``src`` folder:

```
qmake -qt=qt5
make
```

## Macintosh Binary Type
To change the Macintosh binary type edit the ``src/peb.pro`` project file before compiling the binary.

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

## Runtime Requirements
* Qt 5 libraries.  
  Their full list for a QtWebKit Linux build of PEB can be found inside the [start-peb-webkit.sh](start-peb-webkit.sh) script.  
  Their full list for a QtWebEngine Linux build of PEB can be found inside the [start-peb-webengine.sh](start-peb-webengine.sh) script.  

* Perl 5 distribution - any Linux, Mac or Windows Perl distribution.  

  Tested successfully using the following Perl distributions:  
  Linux 64-bit [Perlbrew](https://perlbrew.pl/) Perl versions 5.18.4, 5.23.7  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) version 5.24.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP versions 5.12.2.0, 5.16.1.1, 5.20.2.1  

  To use a Perlbrew Perl with PEB create a symlink to the wanted Perl interpreter named:  
  ``{PEB_binary_directory}/perl/bin/perl``  

  PEB can also use any Perl on PATH.

## Preparing a Perl Distribution for PEB
Sometimes it is important to minimize the size of the relocatable (or portable) Perl distribution used by a PEB-based application. [Perl Distribution Compactor](sdk/compactor.pl) is one solution to this problem. It finds all dependencies of all Perl scripts in the ``{PEB_binary_directory}/resources/app`` directory and copies them in a new ``{PEB_binary_directory}/perl/lib`` folder; a new ``{PEB_binary_directory}/perl/bin`` is also created. The original ``bin`` and ``lib`` folders are saved as ``bin-original`` and ``lib-original`` respectively. These directories should be manually archived for future use or removed.  

Perl Distribution Compactor should be started from the directory of the browser binary using [compactor.sh](compactor.sh) on a Linux or a Mac machine or [compactor.cmd](compactor.cmd) on a Windows machine to ensure that only the Perl distribution of PEB is used. This is necessary to avoid dependency mismatches with any other Perl on PATH.  

Perl Distribution Compactor depends on [Module::ScanDeps](https://metacpan.org/pod/Module::ScanDeps) and [File::Copy::Recursive](https://metacpan.org/pod/File::Copy::Recursive) CPAN modules, which are included in the ``{PEB_binary_directory}/sdk/lib`` folder.  

## Perl Scripts API
Every Perl script run by PEB is called by clicking a link or submitting a form to a pseudo filename composed from the name of the JavaScript object with the settings of the Perl script and a ``.settings`` extension.  

A minimal example of a Perl script settings object:  

```javascript
var perl_test = {};
perl_test.scriptFullPath = '{app}/perl/test.pl';
perl_test.stdoutFunction = function (stdout) {
  var container = document.getElementById('tests');
  container.innerHTML = stdout;
}
```

Three methods to start a local Perl script:  

```html
<a href="perl_test.settings">Start Perl script</a>
```

```html
<form action="perl_test.settings">
  <input type="text" name="input" id="test-script-input">
  <input type="submit" value="Start Perl script">
</form>
```

```javascript
peb.startScript('perl_test.settings');
```

* ``scriptFullPath``  
  This is the path of the Perl script that is going to be executed.  
  The keyword ``{app}`` will be replaced by the the full path of the application directory.  
  PEB does not check the filename extension or the shebang line of the supplied Perl script.  
  Scripts without a filename extension can also be used.  
  *This object property is mandatory.*  

* ``stdoutFunction``  
  Every piece of script output is passed to this function as its only argument.  
  *This object property is mandatory.*  

* ``requestMethod``  
  Only ``GET`` or ``POST`` are recognized.  

* ``inputData``  
  This object property is useless if ``requestMethod`` is not set.  

* ``inputDataHarvester``  
  This object property is a function that can get input data from an HTML form and supply it to PEB.  

  Single input box example with no dependencies:  

  ```javascript
  perlScriptObject.inputDataHarvester = function() {
    var data = document.getElementById('input-box-id').value;
    return data;
  }
  ```

  Whole form example using [jQuery](https://jquery.com/):  

  ```javascript
  perlScriptObject.inputDataHarvester = function() {
    var formData = $('#form-id').serialize();
    return formData;
  }
  ```

* ``scriptExitCommand``  
  The ``scriptExitCommand`` object property designates the command used to gracefully shut down an interactive script when PEB is going to be closed. Upon receiving it, the interactive script must start its shutdown procedure.

* ``scriptExitConfirmation``  
  Just before exiting an interactive script must print on STDOUT its ``scriptExitConfirmation`` to signal PEB that it completed its shutdown. All interactive scripts must exit in 3 seconds after ``scriptExitCommand`` is given or any unresponsive scripts will be killed and PEB will exit.

Perl scripts running for a long time should have ``$|=1;`` among their first lines to disable the built-in buffering of the Perl interpreter. Some builds of Perl may not give any output until the script is finished when buffering is enabled.

## Interactive Perl Scripts
Each PEB interactive Perl script must have its own event loop waiting constantly for new data on STDIN for a bidirectional connection with PEB. Many interactive scripts can be started simultaneously in one browser window. One script may be started in many instances provided that it has an unique JavaScript settings object with and unique ``stdoutFunction`` object property. Interactive scripts should also have the ``scriptExitCommand`` and ``scriptExitConfirmation`` object properties.  

The following code shows how to start an interactive Perl script right after a local page is loaded:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Interactive Script Demo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">

    <script>
      var pebSettings = {};
      pebSettings.autoStartScripts = ['interactive_script'];

      var interactive_script = {};
      interactive_script.scriptFullPath = '{app}/perl/interactive.pl';
      interactive_script.requestMethod = 'POST';
      interactive_script.inputDataHarvester = function() {
        return document.getElementById('interactive-script-input').value;
      }
      interactive_script.stdoutFunction = function (stdout) {
        var container = document.getElementById('interactive-script-output');
        container.innerHTML = stdout;
      }
      interactive_script.scriptExitCommand = '_close_';
      interactive_script.scriptExitConfirmation = '_closed_';
    </script>
  </head>

  <body>
    <form action="interactive_script.settings">
      <input type="text" name="input" id="interactive-script-input">
      <input type="submit" value="Submit">
    </form>

    <div id="interactive-script-output"></div>
  </body>
</html>
```

The [index.htm](resources/app/index.html) file of the demo package demonstrates how to start one script in two instances immediately after a page is loaded.

## Selecting Files and Folders
Selecting files or folders with their full paths is performed by clicking a link to a pseudo filename composed from the name of the JavaScript object with the settings of the wanted dialog and a ``.dialog`` extension. Selected files or folders are seamlessly inserted in any local page by the ``receiverFunction`` taking all selected files or folders as its only argument.  

```html
<a href="select_file.dialog">Select existing file</a>
```

```javascript
var select_file = {};
// Type of the dialog, one of the following:
// 'single-file', 'multiple-files', 'new-file-name' or 'directory'.
select_file.type = 'single-file';
select_file.receiverFunction = function (file) {
  var container = document.getElementById('single-file-test');
  container.innerHTML = file;
}
```

* The actual opening of any existing file is performed by a Perl script and not by PEB.  
* The actual creation of any new file is performed by a Perl script and not by PEB.  
* When multiple files are selected, different filenames are separated by a semicolon - ``;``
* When using the ``directory`` type of dialog, an existing or a new directory may be selected.  
  Any new directory will be created immediately by PEB.

## Application Filename
The binary file of the browser, ``peb``, ``peb.app``, ``peb.dmg`` or ``peb.exe`` by default, can be renamed with no restrictions or additional adjustments. It can take the name of the PEB-based application it is going to run. If log files are wanted, they will take the name of the binary file without the filename extension, whatever the name may be.

## Hard Coded Files and Folders
* **Perl interpreter:**  
  PEB expects to find Perl interpreter in ``{PEB_binary_directory}/perl/bin`` folder. The interpreter must be named ``perl`` on Linux and Mac machines and ``perl.exe`` on Windows machines. If Perl interpreter is not found in the above location, PEB will try to find the first Perl interpreter on PATH. If no Perl interpreter is found, an error page is displayed instead of the start page. No Perl interpreter is a showstopper for PEB.

* **Application directory:**  
  Application directory is ``{PEB_binary_directory}/resources/app``.  
  All files used by PEB, with the exception of data files, should be located within this folder.  

  Application directory is hard coded in C++ code for compatibility with the [Electron](http://electron.atom.io/) framework.  
  [Epigraphista](https://github.com/ddmitov/epigraphista) is an example of a PEB-based application, that is also compatible with [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/).  

* **Start page:**  
  PEB starts always with ``{PEB_binary_directory}/resources/app/index.html``. If this file is missing, an error message is displayed. No start page is a showstopper for PEB.  
  Note that start page pathname is case sensitive.

  <a name="icon"></a>
* **Icon:**
  A PEB-based application can have its own icon and it must be located at ``{PEB_binary_directory}/resources/app/app.png``. If this file is found during application startup, it will be used as the icon of all windows and dialog boxes. If this file is not found, the default icon embedded into the resources of the browser binary will be used.

## Data Directory
Data directory is not hard coded in C++ code, but a separation of data files and code is generally a good practice. Data directory should contain any files, that a PEB-based application is going to use or produce. The recommended data directory is ``{PEB_binary_directory}/resources/data``. Perl scripts can access this folder using the following code:

```perl
use Cwd;

my $current_working_directory = cwd();
my $data_directory = "$current_working_directory/resources/data";
```

Note that by default the working directory of all Perl scripts run by PEB is the directory of the browser binary.

## Log Files
If log files are needed for debugging of PEB or a PEB-based application, they can easily be turned on by manually creating ``{PEB_binary_directory}/logs``. If this directory is found during application startup, the browser assumes that logging is required and a separate log file is created for every browser session following the naming convention: ``{application_name}-started-at-{four_digit_year}-{month}-{day}--{hour}-{minute}-{second}.log``. PEB will not create ``{PEB_binary_directory}/logs`` on its own and if this directory is missing no logs will be written.

## Page Settings

```javascript
var pebSettings = {}; // 'pebSettings' object name is hard-coded.
pebSettings.autoStartScripts = ['interactive_one', 'interactive_two'];
pebSettings.cutLabel = "Custom Cut Label";
pebSettings.copyLabel = "Custom Copy Label";
pebSettings.pasteLabel = "Custom Paste Label";
pebSettings.selectAllLabel = "Custom Select All Label";
pebSettings.okLabel = "Custom Ok Label";
pebSettings.cancelLabel = "Custom Cancel Label";
pebSettings.yesLabel = "Custom Yes Label";
pebSettings.noLabel = "Custom No Label";
pebSettings.closeConfirmation =
  'Text was entered in a form and it is going to be lost!\n' +
  'Are you sure you want to close the window?';
```

* ``autoStartScripts``  
  These are Perl scripts that are started immediately after a local page is loaded.  

* ``closeConfirmation``  
  This text is displayed when the close button is pressed, but unsaved data in local HTML forms is detected. If no warning text is found, PEB exits immediately.

## Functional Pseudo Filenames
* **About PEB dialog:** ``about-browser.function``

* **About Qt dialog:** ``about-qt.function``

## Specific Keyboard Shortcuts
All specific keyboard shortcuts are available only in the QtWebKit builds of PEB.
* <kbd>Ctrl</kbd> + <kbd>I</kbd> - start QWebInspector
* <kbd>Ctrl</kbd> + <kbd>P</kbd> - get printer selection dialog. If no printer is configured, no dialog is displayed.
* <kbd>Ctrl</kbd> + <kbd>R</kbd> - get print preview

## What PEB Is Not
* PEB is not a general purpose web browser and does not have all traditional features of general purpose web browsers.
* PEB is not a server and is not an implementation of the CGI protocol.  
``REQUEST_METHOD``, ``QUERY_STRING`` and ``CONTENT_LENGTH`` environment variables are borrowed from the CGI protocol to start local Perl scripts as child processes without any exposure to other applications.
* PEB does not embed any Perl interpreter in itself and relies on an external Perl distribution, which could be easily changed or upgraded independently.

## Limitations
* Only single-page applications are supported with no pop-up windows.
* Local Perl scripting inside frames is not supported.
* No files can be downloaded.
* QtWebEngine builds do not support printing.
* ``window.print()`` is not supported.

## History
PEB was started as a simple GUI for personal databases in 2013 by Dimitar D. Mitov.

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
