# Perl Executing Browser

[![GitHub Version](https://img.shields.io/github/release/ddmitov/perl-executing-browser.svg)](https://github.com/ddmitov/perl-executing-browser/releases)
[![GitHub License](http://img.shields.io/badge/License-LGPL%20v3-blue.svg)](./LICENSE.md)
[![Travis CI Build Status](https://travis-ci.org/ddmitov/perl-executing-browser.svg?branch=master)](https://travis-ci.org/ddmitov/perl-executing-browser)  

Perl Executing Browser (PEB) is an HTML5 user interface for [Perl 5](https://www.perl.org/) desktop applications. It is a C++ [Qt 5](https://www.qt.io/) application running local Perl 5 scripts as child processes without server. Inspired by [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/), PEB is another reuse of web technologies in desktop applications with Perl doing the heavy lifting instead of [Node.js](https://nodejs.org/en/).

![PEB Screenshot](https://github.com/ddmitov/perl-executing-browser/raw/master/doc/screenshot.png "PEB Screenshot")  

## Contents

* [Quick Start](#quick-start)
* [Design Objectives](#design-objectives)
* [Features](#features)
* [Security](#security)
* [Limitations](#limitations)
* REQUIREMENTS
  * [Compile-Time Requirements](./doc/REQUIREMENTS.md#compile-time-requirements)
  * [Runtime Requirements](./doc/REQUIREMENTS.md#runtime-requirements)
* FILES AND FOLDERS
  * [Application Executable](./doc/FILES.md#application-executable)
  * [Application Files and Folders](./doc/FILES.md#application-files-and-folders)
* SETTINGS
  * [Global Settings API](./doc/SETTINGS.md#global-settings-api)
  * [Perl Scripts API](./doc/SETTINGS.md#perl-scripts-api)
  * [Files and Folders Dialogs API](./doc/SETTINGS.md#files-and-folders-dialogs-api)
* INTERACTIVE PERL SCRIPTS
  * [PEB Interactive Perl Scripts](./doc/INTERACTIVE.md#peb-interactive-perl-scripts)
  * [Requirements for Interactive Perl Scripts](./doc/INTERACTIVE.md#requirements-for-interactive-perl-scripts)
  * [Examples of Interactive Perl Scripts](./doc/INTERACTIVE.md#examples-of-interactive-perl-scripts)
* APPIMAGE SUPPORT
  * [PEB AppImager](./doc/APPIMAGE.md#peb-appimager)
  * [PEB AppImage Configuration Files](./doc/APPIMAGE.md#peb-appimage-configuration-files)
  * [PEB AppImage Builder Docker Container](./doc/APPIMAGE.md#peb-appimage-builder-docker-container)
  * [AppImageHub](./doc/APPIMAGE.md#appimagehub)
* [Logging](#logging)
* [History](#history)
* [License](./LICENSE.md)
* [Thanks and Credits](./CREDITS.md)
* [Authors](#authors)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",  
"SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY" and "OPTIONAL"  
in the documentation of this project are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).  

## Quick Start

* **1.** [Download the PEB Demo Application](https://github.com/ddmitov/perl-executing-browser/releases/latest).  
  64-bit Linux single-file [AppImage](https://appimage.org/) executable and  
  32-bit Windows ZIP archive are available.  
  They include everything you need to start developing PEB-based applications.

* **2.** Unpack:

  64-bit Linux:
  ```bash
  ./peb-demo-*.AppImage --appimage-extract
  ```

  Windows:  
  Unzip using any Windows unzip utility.

* **3.** Optionally install any CPAN modules you may need:

  64-bit Linux:
  ```bash
  cd squashfs-root/resources/app/perl/bin
  ./perl ./cpanm YourModule
  ```

  Windows - from the extracted ``peb-demo`` directory:
  ```batchfile
  cd resources\app\perl
  .\portableshell.bat
  cpanm YourModule
  ```

* **4.** Write your Perl application reading user input on STDIN:

  ```perl
  my $input = <STDIN>;
  chomp $input;
  ```

* **5.** Write a ``{PEB_executable_directory}/resources/app/index.html`` with  
  a [settings JavaScript object](./doc/SETTINGS.md#perl-scripts-api) for every Perl script you want to use.  
  Start local Perl scripts by [clicking a link or submitting a form to a special URL](./doc/SETTINGS.md#perl-scripts-api).  
  [Select files or folders with their full paths by clicking a link to a special URL](./doc/SETTINGS.md#selecting-files-and-folders).

* **6.** Optionally change the [PEB AppImage configuration files](./doc/APPIMAGE.md#peb-appimage-configuration-files).

* **7.** Optionally pack your application:

  64-bit Linux - from the extracted ``squashfs-root`` directory:
  ```bash
  export VERSION="X.X.X" && ./appimager.sh
  ```
  The resulting AppImage will be produced in the ``squashfs-root`` directory.  

  Windows:  
  Zip your PEB-based application using any Windows zip utility.

## Design Objectives

* **1. Easy and beautiful graphical user interface for Perl 5 desktop applications**  
* **2. Fast and zero-installation software**  
* **3. Cross-platform availability**  
* **4. Secure solution with no server**  
* **5. Maximal reuse of existing web technologies and standards**

## Features

* [PEB can be started from any folder without installation procedure.](./doc/CONSTANTS.md#files-and-folders)
* [Perl script output is seamlessly inserted in a nice HTML user interface.](./doc/SETTINGS.md#perl-scripts-api)
* [Event-driven interactive Perl scripts can be repeatedly fed with data.](./doc/INTERACTIVE.md)
* [Any version of Perl 5 can be used.](./doc/REQUIREMENTS.md#runtime-requirements)
* [Single file or multiple files, new filename, existing or new directory can be selected by user.](./doc/SETTINGS.md#selecting-files-and-folders)  
* [Unified logging of Perl and JavaScript errors in the JavaScript console](./doc/LOGGING.md)  
* [Optional warning for unsaved data in HTML forms](./doc/SETTINGS.md#html-page-api)
* [Optional labels for all JavaScript popup boxes and context menus](./doc/SETTINGS.md#html-page-api)
* [Optional icon for the main window and all dialog boxes](./doc/FILES.md#icon)

## Security

* PEB does not need administrative privileges or installation procedure.
* PEB does not need and does not implement any server.
* Local Perl 5 scripts are executed with no sandbox and they have access to full file paths.
* Calling local Perl scripts from web pages is blocked.
* Files or folders can not be selected with their full paths from web pages.
* Cross-site scripting is disabled.

## Limitations

* No Perl scripting inside frames
* Limited HTML5 support
* No pop-up windows
* No file downloads
* No printing

## Logging

PEB has unified logging of JavaScript and Perl errors in the JavaScript console.  
Press <kbd>Ctrl</kbd> + <kbd>I</kbd> to open the ``QWebInspector`` and go to the ``Console`` tab.

## History

PEB was started in 2013 by Dimitar D. Mitov as a simple user interface for personal database applications.

## [Thanks and Credits](CREDITS.md)

## [License](./LICENSE.md)

This program is free software;  
you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License,  
as published by the Free Software Foundation;  
either version 3 of the License, or (at your option) any later version.  
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

## Authors

Dimitar D. Mitov, 2013 - 2020  
Valcho Nedelchev, 2014 - 2016  
