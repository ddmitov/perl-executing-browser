# Perl Executing Browser - Requirements

## Compile-Time Requirements

The only Linux and Mac compile-time requirement of PEB is a Qt development bundle version 5.2 or higher.  

PEB on Windows can be compiled only with a GCC-based MinGW Qt versions 5.2 to 5.6.

Compiled and tested successfully using:

* [Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Debian 7 and 32-bit Windows XP
* [Qt 5.2.1](http://download.qt.io/archive/qt/5.2/5.2.1/) on 64-bit Ubuntu 14.04 and 64-bit OS X 10.9.1, i5
* [Qt 5.3.0](http://download.qt.io/archive/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10
* [Qt 5.4.1](http://download.qt.io/archive/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04
* [Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04/16.04 and 64-bit Windows 10
* [Qt 5.8.0](http://download.qt.io/archive/qt/5.8/5.8.0/) on 64-bit Lubuntu 16.04
* [Qt 5.9.1](http://download.qt.io/archive/qt/5.9/5.9.1/) on 64-bit Lubuntu 16.04

To compile PEB from the command line ``cd`` to the ``src`` folder and type:

```bash
qmake -qt=qt5
make
```

Please note that PEB builds using the standard ``QtWebKit`` web engine are single-process applications and they consume less memory than PEB builds using the multiprocess ``QtWebEngine``.  

## Compile-Time Settings

PEB compile-time settings can be changed by editing the ``src/peb.pro`` project file according to the following instructions.  

* Mac Bundle  
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

  The ``ldd`` Linux command shows all dependencies of a PEB executable.  

* Perl 5 distribution - any Linux, Mac or Windows Perl relocatable or standard distribution.  

  Tested successfully using:  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) versions 5.24.1, 5.26.1  
  Linux 64-bit [Perlbrew](https://perlbrew.pl/) Perl versions 5.18.4, 5.23.7  
  Linux 64-bit Perl version 5.22.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP versions 5.12.2.0, 5.16.1.1, 5.20.2.1, 5.30.0.1  

  To use a Perlbrew Perl with PEB create a symlink at:  
  ``{PEB_executable_directory}/resources/perl/bin/perl``  

  PEB will use the first Perl on PATH if a relocatable Perl distribution is not found in the  
  ``{PEB_executable_directory}/resources/app/perl`` folder.
