Perl Executing Browser - Requirements
--------------------------------------------------------------------------------

## Compile-Time Requirements
The only Linux and Macintosh compile-time requirement of PEB is a GCC-based Qt development bundle version 5.2 or any later version.  

The source code of PEB is not MSVC-compatible and PEB can not be compiled using any MSVC-based Windows version of Qt.   This means that:  
* PEB Windows binaries can be compiled only by a GCC-based Qt development bundle.
* Only ```QtWebKit``` can be used by a Windows binary of PEB.  
  Windows GCC-based Qt development bundles version 5.6.x or higher have neither ```QtWebEngine```, nor ```QtWebKit```.  
* Updated ``QtWebKit`` headers and libraries have to be manually added from the  
  [QtWebKit repository of Konstantin Tokarev (annulen)](https://github.com/annulen/webkit/releases) to all Windows GCC-based Qt development bundles version 5.6.x or higher.

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

## Runtime Requirements
* Qt 5 libraries.  

  Their full list for a QtWebKit Linux build of PEB can be found inside the [start-peb-webkit.sh](start-peb-webkit.sh) script.  
  Their full list for a QtWebEngine Linux build of PEB can be found inside the [start-peb-webengine.sh](start-peb-webengine.sh) script.  

* Perl 5 distribution - any Linux, Mac or Windows Perl standard or relocatable distribution.  

  Tested successfully using the following Perl distributions:  
  Linux 64-bit [Perlbrew](https://perlbrew.pl/) Perl versions 5.18.4, 5.23.7  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) version 5.24.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP versions 5.12.2.0, 5.16.1.1, 5.20.2.1  

  To use a Perlbrew Perl with PEB create a symlink to the wanted Perl interpreter named:  
  ``{PEB_binary_directory}/perl/bin/perl``  

  PEB can also use any Perl on PATH.
