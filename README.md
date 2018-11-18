Perl Executing Browser
--------------------------------------------------------------------------------

[![GitHub Version](https://img.shields.io/github/release/ddmitov/perl-executing-browser.svg)](https://github.com/ddmitov/perl-executing-browser/releases)
[![GitHub License](http://img.shields.io/badge/License-LGPL%20v3-blue.svg)](./LICENSE.md)
[![Travis CI Build Status](https://travis-ci.org/ddmitov/perl-executing-browser.svg?branch=master)](https://travis-ci.org/ddmitov/perl-executing-browser)
[![Coverity Scan Build Status](https://scan.coverity.com/projects/11334/badge.svg)](https://scan.coverity.com/projects/ddmitov-perl-executing-browser)  

Perl Executing Browser (PEB) is an HTML5 user interface for [Perl 5](https://www.perl.org/) desktop applications. By default it runs local Perl 5 scripts as child processes with no server and is implemented as a C++ executable based on the [Qt 5](https://www.qt.io/) libraries. Inspired by [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/), PEB is another reuse of web technologies in desktop applications with Perl doing the heavy lifting instead of [Node.js](https://nodejs.org/en/).

![PEB Screenshot](https://github.com/ddmitov/perl-executing-browser/raw/master/doc/screenshot.png "PEB Screenshot")  

## Contents
* [Quick Start](#quick-start)
* [Design Objectives](#design-objectives)
* [Features](#features)
* [Security](#security)
* [What PEB Is Not](#what-peb-is-not)
* [Limitations](#limitations)
* [REQUIREMENTS](./doc/REQUIREMENTS.md)
  * [Compile-Time Requirements](./doc/REQUIREMENTS.md#compile-time-requirements)
  * [Compile-Time Settings](./doc/REQUIREMENTS.md#compile-time-settings)
  * [Runtime Requirements](./doc/REQUIREMENTS.md#runtime-requirements)
* [CONSTANTS](./doc/CONSTANTS.md)
  * [Files and Folders](./doc/CONSTANTS.md#files-and-folders)
  * [Functional Pseudo Filenames](./doc/CONSTANTS.md#functional-pseudo-filenames)
  * [Specific Keyboard Shortcuts](./doc/CONSTANTS.md#specific-keyboard-shortcuts)
* [SETTINGS](./doc/SETTINGS.md)
  * [Application Filename](./doc/SETTINGS.md#application-filename)
  * [HTML Page API](./doc/SETTINGS.md#html-page-api)
  * [Perl Scripts API](./doc/SETTINGS.md#perl-scripts-api)
  * [Interactive Perl Scripts](./doc/SETTINGS.md#interactive-perl-scripts)
  * [Starting Local Server](./doc/SETTINGS.md#starting-local-server)
  * [Selecting Files and Folders](./doc/SETTINGS.md#selecting-files-and-folders)
* [PACKAGING](./doc/PACKAGING.md)
  * [Minimal Relocatable Perl Distribution for PEB](./doc/PACKAGING.md#minimal-relocatable-perl-distribution-for-peb)
  * [AppImage Support](./doc/PACKAGING.md#appimage-support)
* [DEBUGGING](./doc/DEBUGGING.md)
* [History](#history)
* [License](./LICENSE.md)
* [Thanks and Credits](./doc/CREDITS.md)
* [Authors](#authors)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",  
"SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY" and "OPTIONAL"  
in the documentation of this project are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).  

## Quick Start
These are the basic steps for building your first PEB-based serverless application:  

* **1.** Download PEB.  
* **2.** Select your Perl distribution.  
* **3.** Write your Perl application reading user input on STDIN:  

  ```perl
  my $input = <STDIN>;
  chomp $input;
  ```

* **4.** Write an appropriate HTML interface with a [settings JavaScript object](./doc/SETTINGS.md#perl-scripts-api) for your Perl application.  
  Triggering a Perl script from a local HTML page is configured using [one of the three possible methods](./doc/SETTINGS.md#perl-scripts-api).  
  [Selecting files or folders with their full paths](./doc/SETTINGS.md#selecting-files-and-folders) is also possible.  

These are the basic steps for building your first PEB-based application using a local Perl server:  

* **1.** Download PEB.  
* **2.** Select your Perl distribution.  
* **3.** Write your Perl server application.  
* **4.** Write [local-server.json](./doc/SETTINGS.md#starting-local-server) for your local Perl server.  
* **5.** Write an appropriate HTML interface and connect it to your server application by traditional web  communication protocols.

## Design Objectives
* **1. Easy and beautiful graphical user interface for Perl 5 desktop applications**  
* **2. Fast, zero-installation software**  
* **3. Cross-platform availability**  
* **4. Secure solution, serverless by default**  
* **5. Maximal reuse of existing web technologies and standards**

## Features
* PEB can be started from any folder without installation procedure.
* [Perl script output is seamlessly inserted in any local page.](./doc/SETTINGS.md#perl-scripts-api)
* [Perl scripts with STDIN event loops can be repeatedly fed with data (Linux and Macintosh builds only).](./doc/SETTINGS.md#interactive-perl-scripts)
* [Perl local servers can be started.](./doc/SETTINGS.md#starting-local-server)
* [Any version of Perl 5 can be used.](./doc/REQUIREMENTS.md#runtime-requirements)
* [Single file or multiple files, new filename, existing or new directory can be selected by user.](./doc/SETTINGS.md#selecting-files-and-folders)  
* Unified logging of Perl scripts and JavaScript in the JavaScript console  
* [Optional labels for all JavaScript popup boxes and context menus](./doc/SETTINGS.md#html-page-api)
* [Optional icon for the main window and all dialog boxes](./doc/CONSTANTS.md#icon)
* [Optional warning for unsaved data in HTML forms](./doc/SETTINGS.md#html-page-api)

## Security
* PEB does not need administrative privileges, but will not refuse to use them if needed.
* PEB does not need and does not implement any server, but will start one if so configured.  
* Local Perl 5 scripts are executed with no sandbox and they have direct access to local files.
* PEB starts Perl scripts only from its application directory.
* Cross-site scripting is disabled.
* Calling local Perl scripts from a web page is blocked.
* Files or folders can not be selected with their full paths from web pages.

## What PEB Is Not
* PEB is not a general-purpose web browser and does not have all traditional features of general-purpose web browsers.
* PEB does not embed any Perl interpreter in itself and depends on an external, supposedly relocatable, Perl distribution.

## Limitations
* Only single-page applications are supported with no pop-up windows and no Perl scripting inside frames.
* No files can be downloaded.
* ``QtWebEngine`` builds do not support printing and ``window.print()`` is not supported.
* Windows builds of PEB do no support [interactive Perl Scripts](./doc/SETTINGS.md#interactive-perl-scripts).

## History
PEB was started in 2013 by Dimitar D. Mitov as a simple GUI for personal database applications.

## [Thanks and Credits](CREDITS.md)

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
