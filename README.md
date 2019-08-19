# Perl Executing Browser

[![GitHub Version](https://img.shields.io/github/release/ddmitov/perl-executing-browser.svg)](https://github.com/ddmitov/perl-executing-browser/releases)
[![GitHub License](http://img.shields.io/badge/License-LGPL%20v3-blue.svg)](./LICENSE.md)
[![Travis CI Build Status](https://travis-ci.org/ddmitov/perl-executing-browser.svg?branch=master)](https://travis-ci.org/ddmitov/perl-executing-browser)  

Perl Executing Browser (PEB) is an HTML5 user interface for [Perl 5](https://www.perl.org/) desktop applications. It is a C++ executable based on the [Qt 5](https://www.qt.io/) libraries running local Perl 5 scripts as child processes without server. Inspired by [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/), PEB is another reuse of web technologies in desktop applications with Perl doing the heavy lifting instead of [Node.js](https://nodejs.org/en/).

![PEB Screenshot](https://github.com/ddmitov/perl-executing-browser/raw/master/doc/screenshot.png "PEB Screenshot")  

## Contents

* [Quick Start](#quick-start)
* [Design Objectives](#design-objectives)
* [Features](#features)
* [Security](#security)
* [Limitations](#limitations)
* [REQUIREMENTS](./doc/REQUIREMENTS.md)
  * [Compile-Time Requirements](./doc/REQUIREMENTS.md#compile-time-requirements)
  * [Compile-Time Settings](./doc/REQUIREMENTS.md#compile-time-settings)
  * [Runtime Requirements](./doc/REQUIREMENTS.md#runtime-requirements)
* [CONSTANTS](./doc/CONSTANTS.md)
  * [Files and Folders](./doc/CONSTANTS.md#files-and-folders)
  * [Functional Pseudo Filenames](./doc/CONSTANTS.md#functional-pseudo-filenames)
* [SETTINGS](./doc/SETTINGS.md)
  * [Application Filename](./doc/SETTINGS.md#application-filename)
  * [HTML Page API](./doc/SETTINGS.md#html-page-api)
  * [Perl Scripts API](./doc/SETTINGS.md#perl-scripts-api)
  * [Interactive Perl Scripts](./doc/SETTINGS.md#interactive-perl-scripts)
  * [Long-Running Windows Perl Scripts](./doc/SETTINGS.md#long-running-windows-perl-scripts)
  * [Selecting Files and Folders](./doc/SETTINGS.md#selecting-files-and-folders)
* [LOGGING](./doc/LOGGING.md)
* [PACKAGING](./doc/PACKAGING.md)
  * [AppImage Support](./doc/PACKAGING.md#appimage-support)
* [History](#history)
* [License](./LICENSE.md)
* [Thanks and Credits](./CREDITS.md)
* [Authors](#authors)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",  
"SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY" and "OPTIONAL"  
in the documentation of this project are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).  

## Quick Start

* **1.** [Download PEB](https://github.com/ddmitov/perl-executing-browser/releases/latest).  
  Linux 64-bit single-file [AppImage](https://appimage.org/) executable and  
  Windows 32-bit zipped executable with its Qt libraries are available.  

* **2.** [Select your Perl distribution](./doc/REQUIREMENTS.md#runtime-requirements).  
  You can choose between a relocatable Perl distribution and the first Perl on PATH.  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) or  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP distributions are available by third-party vendors.  

  Place your relocatable Perl distribution in:  
  ``{PEB_executable_directory}/resources/perl``  
  Your relocatable Perl interpreter must be:  
  ``{PEB_executable_directory}/resources/perl/bin/perl`` on a Linux or Mac macine or  
  ``{PEB_executable_directory}/resources/perl/bin/wperl.exe`` on a Windows macine.  

* **3.** Write your Perl application reading user input on STDIN:

  ```perl
  my $input = <STDIN>;
  chomp $input;
  ```

* **4.** Write a ``{PEB_executable_directory}/resources/app/index.html`` with  
  a [settings JavaScript object](./doc/SETTINGS.md#perl-scripts-api) for your Perl application.  
  Local Perl scripts can be called from your HTML page by [three methods](./doc/SETTINGS.md#perl-scripts-api).  
  [Selecting files or folders with their full paths](./doc/SETTINGS.md#selecting-files-and-folders) is also possible.

## Design Objectives

* **1. Easy and beautiful graphical user interface for Perl 5 desktop applications**  
* **2. Fast and zero-installation software**  
* **3. Cross-platform availability**  
* **4. Secure solution with no server**  
* **5. Maximal reuse of existing web technologies and standards**

## Features

* PEB can be started from any folder without installation procedure.
* [Perl script output is seamlessly inserted in an HTML user interface.](./doc/SETTINGS.md#perl-scripts-api)
* [Perl scripts with STDIN event loops can be repeatedly fed with data (Linux and Mac builds only).](./doc/SETTINGS.md#interactive-perl-scripts)
* [Any version of Perl 5 can be used.](./doc/REQUIREMENTS.md#runtime-requirements)
* [Single file or multiple files, new filename, existing or new directory can be selected by user.](./doc/SETTINGS.md#selecting-files-and-folders)  
* [Unified logging of Perl and JavaScript errors in the JavaScript console](./doc/LOGGING.md)  
* [Optional warning for unsaved data in HTML forms](./doc/SETTINGS.md#html-page-api)
* [Optional labels for all JavaScript popup boxes and context menus](./doc/SETTINGS.md#html-page-api)
* [Optional icon for the main window and all dialog boxes](./doc/CONSTANTS.md#icon)

## Security

* PEB does not need administrative privileges or installation procedure.
* PEB does not need and does not implement any server.
* Local Perl 5 scripts are executed with no sandbox and they have direct access to local files.
* PEB starts Perl scripts only from its application directory.
* Calling local Perl scripts from web pages is blocked.
* Files or folders can not be selected with their full paths from web pages.
* Cross-site scripting is disabled.

## Limitations

* Only single-page applications are supported with no pop-up windows and no Perl scripting inside frames.
* No files can be downloaded.
* Printing is not supported.
* Windows builds of PEB do not support [interactive Perl Scripts](./doc/SETTINGS.md#interactive-perl-scripts).

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

Dimitar D. Mitov, 2013 - 2019  
Valcho Nedelchev, 2014 - 2016  
