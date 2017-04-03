## Compile-time Requirements
* GCC compiler
* Qt 5.1 - 5.5 (including ``QtWebKit`` libraries and headers)  
  ``QtWebKit`` is deprecated and replaced by the Blink-based ``QtWebEngine`` in all later versions of Qt.  
  Compiling ``QtWebKit`` for a recent Qt version is possible, but not trivial or tested with PEB.  

Compiled and tested successfully using:
* [Qt Creator 2.8.1 and Qt 5.1.1](http://download.qt.io/archive/qt/5.1/5.1.1/) on 32-bit Debian Linux,
* [Qt Creator 3.0.0 and Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Debian Linux,
* [Qt Creator 3.0.0 and Qt 5.2.0](http://download.qt.io/archive/qt/5.2/5.2.0/) on 32-bit Windows XP,
* [Qt Creator 3.0.1 and Qt 5.2.1](http://download.qt.io/archive/qt/5.2/5.2.1/) on 64-bit OS X 10.9.1, i5,
* [Qt Creator 3.1.1 and Qt 5.3.0](http://download.qt.io/archive/qt/5.3/5.3.0/) on 64-bit Lubuntu 14.10 Linux,
* [Qt Creator 3.1.1 and Qt 5.4.1](http://download.qt.io/archive/qt/5.4/5.4.1/) on 64-bit Lubuntu 15.04 Linux,
* [Qt Creator 3.5.1 and Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 15.04 Linux,
* [Qt Creator 3.5.1 and Qt 5.5.1](http://download.qt.io/archive/qt/5.5/5.5.1/) on 64-bit Lubuntu 16.04 Linux.

To compile PEB type in a terminal inside the ``src`` folder:

```
qmake
make
```

## Runtime Requirements
* Qt 5 libraries - their full Linux list can be found inside the ``start-peb.sh`` script,
* Perl 5 distribution - any Linux, Mac or Windows Perl distribution.  
  [Strawberry Perl](http://strawberryperl.com/) PortableZIP editions are successfully used with all Windows builds of PEB.  
  [Perlbrew](https://perlbrew.pl/) Perl distributions (5.18.4, 5.23.7) are successfully used with many Linux builds of PEB.  
  PEB can also use any Perl on PATH.
