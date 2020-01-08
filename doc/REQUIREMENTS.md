# Perl Executing Browser - Requirements

## Compile-Time Requirements

* Qt development bundle version 5.2 to or higher  
* ``QtWebKit`` library and headers  

PEB for Windows must be compiled by a GCC-based MinGW Qt development bundle.  

Compiled and tested successfully using:

* [Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Debian 7 and 32-bit Windows XP
* [Qt 5.2.1](http://download.qt.io/archive/qt/5.2/5.2.1/) on 64-bit Ubuntu 14.04 and 64-bit OS X 10.9.1, i5
* [Qt 5.3.0](http://download.qt.io/archive/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10
* [Qt 5.4.1](http://download.qt.io/archive/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04
* [Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04/16.04 and 64-bit Windows 10
* [Qt 5.9.5](http://download.qt.io/archive/qt/5.9/5.9.5/) on 64-bit Lubuntu 18.04.3  

To compile PEB run the following commands in the root directory of the PEB project:

```bash
cd src
qmake -qt=qt5
make
```

## Runtime Requirements

* Qt 5 libraries.  
* Perl 5 distribution - any Linux or Windows Perl relocatable or standard distribution.  

  Recommended for use and tested with:  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) versions 5.24.1, 5.26.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) PortableZIP versions 5.12.2.0, 5.16.1.1, 5.20.2.1, 5.30.0.1  

  PEB will use the first Perl on PATH if a relocatable Perl distribution is not available.
