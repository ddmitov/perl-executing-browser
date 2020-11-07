# Perl Executing Browser - Requirements

## Compile-Time Requirements

* Qt development bundle versions 5.2 - 5.5  
  
* ``QtWebKit`` library and headers  

PEB for Windows must be compiled by a GCC-based MinGW Qt development bundle.  

Compiled and tested successfully using Qt [5.2.0](https://download.qt.io/new_archive/qt/5.2/5.2.0/), [5.2.1](https://download.qt.io/new_archive/qt/5.2/5.2.1/), [5.3.0](https://download.qt.io/new_archive/qt/5.3/5.3.0/), [5.4.1](https://download.qt.io/new_archive/qt/5.4/5.4.1/), [5.5.1](https://download.qt.io/new_archive/qt/5.5/5.5.1/).  

To compile PEB run the following commands in the root directory of the PEB project:

```bash
cd src
qmake -qt=qt5
make
```

## Runtime Requirements

* Base Qt5 libraries:
  * Qt5Core  
  * Qt5Gui  
  * Qt5Network  
  * Qt5Widgets  
* QtWebKit libraries:
  * Qt5WebKit  
  * Qt5WebKitWidgets  

* Perl 5 distribution - any Linux or Windows Perl relocatable or standard distribution  

  Tested with:  
  Linux 64-bit [Relocatable Perl](https://github.com/skaji/relocatable-perl) versions 5.24.1, 5.26.1  
  Windows 32-bit [Strawberry Perl](http://strawberryperl.com/) Portable versions [5.12.2.0](http://strawberryperl.com/download/5.12.2.0/strawberry-perl-5.12.2.0-portable.zip), [5.16.1.1](http://strawberryperl.com/download/5.16.1.1/strawberry-perl-5.16.1.1-64bit-portable.zip), [5.20.2.1](), [5.30.0.1](http://strawberryperl.com/download/5.20.2.1/strawberry-perl-5.20.2.1-64bit-portable.zip)  

  PEB will use the first Perl on PATH if a relocatable Perl distribution is not available.
