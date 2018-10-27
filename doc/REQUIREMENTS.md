Perl Executing Browser - Requirements
--------------------------------------------------------------------------------

## Compile-Time Requirements
The only Linux and Macintosh compile-time requirement of PEB is a Qt development bundle version 5.2 or any later version.  

Compiling Windows binaries of PEB is subject to the following restrictions:  

* Windows builds of PEB can only be compiled by a GCC-based MinGW Qt using the ``QtWebKit`` web engine,  
  but only MSVC-based Qt versions 5.6.x or higher include the ``QtWebEngine`` on the Windows platform.
* The source code of PEB is not MSVC-compatible and can not use the ``QtWebEngine``.
* Windows MinGW Qt versions 5.6.x - 5.8.x have neither ``QtWebEngine``, nor ``QtWebKit`` and an updated ``QtWebKit`` has to be manually added from the [QtWebKit repository of Konstantin Tokarev (annulen)](https://github.com/annulen/webkit/releases).
* Windows builds of PEB do no support [interactive Perl Scripts](SETTINGS.md#interactive-perl-scripts) with STDIN event loops.

Compiled and tested successfully using:
* [Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Debian 7 and 32-bit Windows XP
* [Qt 5.2.1](http://download.qt.io/archive/qt/5.2/5.2.1/) on 64-bit Ubuntu 14.04 and 64-bit OS X 10.9.1, i5
* [Qt 5.3.0](http://download.qt.io/archive/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10
* [Qt 5.4.1](http://download.qt.io/archive/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04
* [Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04 and 16.04
* [Qt 5.8.0](http://download.qt.io/archive/qt/5.8/5.8.0/) on 64-bit Lubuntu 16.04
* [Qt 5.9.1](http://download.qt.io/archive/qt/5.9/5.9.1/) on 64-bit Lubuntu 16.04

To compile PEB type in a terminal started in the ``src`` folder:

```bash
qmake -qt=qt5
make
```

Please note that PEB builds using the ``QtWebKit`` web engine are single-process applications consuming less memory than PEB builds using the ``QtWebEngine`` which are multiprocess applications.  

## Compile-Time Settings
All compile-time settings require editing the ``src/peb.pro`` project file according to the following instructions.  

* Updated QtWebKit  
  To use ``QtWebKit`` or ``QtWebEngine`` depending on the Qt version, which is the default setting:  

  ```QMake
  ANNULEN_QTWEBKIT = 0
  ```

  The default web engine for Qt versions up to 5.5.x is ``QtWebKit``.  
  The default web engine for Qt versions 5.6.x or higher is ``QtWebEngine``.

  To use [an updated QtWebKit version from the repository of Konstantin Tokarev (annulen)](https://github.com/annulen/webkit/releases) with a Qt version 5.6.x or higher:

  ```QMake
  ANNULEN_QTWEBKIT = 1
  ```

  Setting ``ANNULEN_QTWEBKIT`` to ``1`` has no effect on Qt versions 5.5 or lower.  

* Macintosh Bundle  
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

  To make automatically a bundled binary (peb.app) use the [dmg-maker.sh](sdk/dmg-maker.sh) script by Valcho Nedelchev.

## Runtime Requirements
* Qt 5 libraries.  

  The ``ldd`` Linux command can show all dependencies of a PEB executable.  

* Perl 5 distribution - any Linux, Mac or Windows Perl standard or relocatable distribution.  

  Tested successfully using the following Perl distributions:  

  Linux 64-bit [Perlbrew](https://perlbrew.pl/) Perl versions 5.18.4, 5.23.7  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) version 5.24.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP versions 5.12.2.0, 5.16.1.1, 5.20.2.1  

  To use a Perlbrew Perl with PEB create a symlink to the wanted Perl interpreter named:  
  ``{PEB_executable_directory}/perl/bin/perl``  

  PEB can also use any Perl on PATH.
