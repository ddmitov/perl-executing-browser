Perl Executing Browser - Requirements
--------------------------------------------------------------------------------

## Compile-Time Requirements
The only Linux and Macintosh compile-time requirement of PEB is a Qt development bundle version 5.2 or any later version.  

PEB Windows binary can be compiled using any MinGW (GCC-based) Qt development bundle version 5.2.x - 5.8.x.  

Compiling Windows binaries of PEB is subject to the following restrictions:  

* The source code of PEB is not MSVC-compatible and Windows builds of PEB can only be compiled by a MinGW (GCC-based) Qt development bundle.
*  Only MSVC-based Qt development bundles version 5.6.x or higher include the ```QtWebEngine``` on the Windows platform and Windows builds of PEB can only use the ```QtWebKit``` web engine.
* Windows MinGW Qt development bundles version 5.6.x - 5.8.x have neither ```QtWebEngine```, nor ```QtWebKit``` and an updated ``QtWebKit`` has to be manually added from the [QtWebKit repository of Konstantin Tokarev (annulen)](https://github.com/annulen/webkit/releases).
* There are no MinGW Qt development bundles for any version 5.9.x or higher.

Compiled and tested successfully using:
* [Qt 5.2.0 and Qt Creator 3.0.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Debian and 32-bit Windows XP
* [Qt 5.2.1 and Qt Creator 3.0.1](http://download.qt.io/archive/qt/5.2/5.2.1/) on 64-bit OS X 10.9.1, i5
* [Qt 5.3.0 and Qt Creator 3.1.1](http://download.qt.io/archive/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10
* [Qt 5.4.1 and Qt Creator 3.1.1](http://download.qt.io/archive/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04
* [Qt 5.5.1 and Qt Creator 3.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04 and 16.04
* [Qt 5.8.0 and Qt Creator 4.2.1](http://download.qt.io/archive/qt/5.8/5.8.0/) on 64-bit Lubuntu 16.04
* [Qt 5.9.1 and Qt Creator 4.3.1](http://download.qt.io/archive/qt/5.9/5.9.1/) on 64-bit Lubuntu 16.04

To compile PEB type in a terminal started in the ``src`` folder:

```
qmake -qt=qt5
make
```

## Compile-Time Settings
All compile-time settings require editing the ``src/peb.pro`` project file according to the following instructions.  

* Updated QtWebKit  
  To use ```QtWebKit``` or ```QtWebEngine``` depending on the Qt version, which is the default setting:  

  ```QMake
  ANNULEN_QTWEBKIT = 0
  ```

  The default web engine for Qt versions up to 5.5.x is ```QtWebKit```.  
  The default web engine for Qt versions 5.6.x or higher is ```QtWebEngine```.

  To use [an updated QtWebKit version from the repository of Konstantin Tokarev (annulen)](https://github.com/annulen/webkit/releases) with a Qt version 5.6.x or higher:

  ```QMake
  ANNULEN_QTWEBKIT = 1
  ```

  Setting ```ANNULEN_QTWEBKIT``` to ```1``` has no effect on Qt versions 5.5 or lower.  

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

* Perl 5 distribution - any Linux, Mac or Windows Perl standard or relocatable distribution.  

  Tested successfully using the following Perl distributions:  
  Linux 64-bit [Perlbrew](https://perlbrew.pl/) Perl versions 5.18.4, 5.23.7  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) version 5.24.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP versions 5.12.2.0, 5.16.1.1, 5.20.2.1  

  To use a Perlbrew Perl with PEB create a symlink to the wanted Perl interpreter named:  
  ``{PEB_binary_directory}/perl/bin/perl``  

  PEB can also use any Perl on PATH.
