Perl Executing Browser
--------------------------------------------------------------------------------

[![GitHub Version](https://img.shields.io/github/release/ddmitov/perl-executing-browser.svg)](https://github.com/ddmitov/perl-executing-browser/releases)
[![GitHub License](http://img.shields.io/badge/License-LGPL%20v3-blue.svg)](./LICENSE.md)
[![Travis CI Build Status](https://travis-ci.org/ddmitov/perl-executing-browser.svg?branch=master)](https://travis-ci.org/ddmitov/perl-executing-browser)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ddmitov/perl-executing-browser?branch=master&svg=true)](https://ci.appveyor.com/project/ddmitov/perl-executing-browser)
[![Coverity Scan Build Status](https://scan.coverity.com/projects/11334/badge.svg)](https://scan.coverity.com/projects/ddmitov-perl-executing-browser)  

Perl Executing Browser (PEB) is an HTML5 user interface for [Perl 5](https://www.perl.org/) desktop applications. By default it runs local Perl 5 scripts as child processes with no server or execution timeout and is implemented as a C++ executable based on the [Qt 5](https://www.qt.io/) libraries.  

Inspired by [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/), PEB is another reuse of web technologies in desktop applications with Perl doing the heavy lifting. In contrast to Electron and NW.js, PEB does not depend on [Node.js](https://nodejs.org/en/), always runs JavaScript in a sandbox and blocks cross-origin requests.

## Contents
* [Quick Start](#quick-start)
* [Design Objectives](#design-objectives)
* [Features](#features)
* [Security](#security)
* [What PEB Is Not](#what-peb-is-not)
* [Limitations](#limitations)
* [REQUIREMENTS](./REQUIREMENTS.md)
  * [Compile-Time Requirements](./REQUIREMENTS.md#compile-time-requirements)
  * [Runtime Requirements](./REQUIREMENTS.md#runtime-requirements)
* [CONSTANTS](./CONSTANTS.md)
  * [Hard Coded Files and Folders](./CONSTANTS.md#hard-coded-files-and-folders)
  * [Functional Pseudo Filenames](./CONSTANTS.md#functional-pseudo-filenames)
  * [Specific Keyboard Shortcuts](./CONSTANTS.md#specific-keyboard-shortcuts)
* [SETTINGS](./SETTINGS.md)
  * [Application Filename](./SETTINGS.md#application-filename)
  * [HTML Page API](./SETTINGS.md#html-page-api)
  * [Perl Scripts API](./SETTINGS.md#perl-scripts-api)
  * [Interactive Perl Scripts](./SETTINGS.md#interactive-perl-scripts)
  * [Starting Local Server](./SETTINGS.md#starting-local-server)
  * [Selecting Files and Folders](./SETTINGS.md#selecting-files-and-folders)
  * [Minimal Portable Perl Distribution for PEB](./SETTINGS.md#minimal-portable-perl-distribution-for-peb)
  * [Log Files](./SETTINGS.md#log-files)
* [History](#history)
* [License](./LICENSE.md)
* [Thanks and Credits](./CREDITS.md)
* [Authors](#authors)

## Quick Start
These are the basic steps for building your first PEB-based serverless application:  

* **1.** Write ``{PEB_binary_directory}/resources/app/index.html`` file with appropriate HTML forms for user data input.  
  [Selecting files or folders with their full paths](./SETTINGS.md#selecting-files-and-folders) is also possible.
* **2.** Write [a settings JavaScript object](./SETTINGS.md#perl-scripts-api) for every Perl script you are going to run.
* **3.** Write your Perl scripts.  
  Input from local HTML forms is read just like reading POST or GET requests in a Perl CGI script.  
  You may use the [get-post-test.pl](resources/app/perl/get-post-test.pl) file as an example.
* **4.** Connect your Perl scripts to your local HTML page using [one of the three possible methods](./SETTINGS.md#perl-scripts-api).  

These are the basic steps for building your first PEB-based application using a local Perl server:  

* **1.** Write your Perl server-based application with an appropriate HTML page.  
* **2.** Write [{PEB_binary_directory}/resources/app/local-server.json](./SETTINGS.md#starting-local-server) for your local Perl server.  

PEB is created to work from any directory without installation meaning that:
* All application files must be located in the ``{PEB_binary_directory}/resources/app`` folder.
* All data files must be located in the ``{PEB_binary_directory}/resources/data`` folder.

## Design Objectives
* **1. Easy and beautiful graphical user interface for Perl 5 desktop applications**  
* **2. Fast, zero-installation software**  
* **3. Cross-platform availability**  
* **4. Secure solution, serverless by default**  
* **5. Maximal reuse of existing web technologies and standards**

## Features
* [Perl script output is seamlessly inserted in any local page.](./SETTINGS.md#perl-scripts-api)
* [Perl scripts with STDIN event loops can be repeatedly fed with data.](./SETTINGS.md#interactive-perl-scripts)
* [Perl scripts implementing local servers can be started](./SETTINGS.md#starting-local-server)
* [Any version of Perl 5 can be used.](./REQUIREMENTS.md#runtime-requirements)
* PEB can be started from any folder.
* [Single file or multiple files, new filename, existing or new directory can be selected by user.](./SETTINGS.md#selecting-files-and-folders)  
* [Optional warning for unsaved data in HTML forms](./SETTINGS.md#html-page-api)
* [Custom labels for dialogs and context menu](./SETTINGS.md#html-page-api)
* [Custom icon for windows and message boxes](./CONSTANTS.md#icon)
* [Optional logging](./SETTINGS.md#html-page-api#log-files)

## Security
* PEB does not need administrative privileges, but will not refuse to use them if needed.
* PEB does not need and does not implement any kind of server, but will start one if so configured.
* PEB executes with no sandbox only local Perl 5 scripts and
  users have full access to their local files.
* Cross-origin requests and cross-site scripting are disabled.
  Calling web scripts from a local page is blocked.  
  Calling local Perl scripts from a web page is blocked.  
* Files or folders can not be selected with their full paths from web pages.

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

## [Thanks and Credits](./CREDITS.md)

## [License](./LICENSE.md)
This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License,  
as published by the Free Software Foundation;  
either version 3 of the License, or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

## Authors
Dimitar D. Mitov, 2013 - 2018  
Valcho Nedelchev, 2014 - 2016  
