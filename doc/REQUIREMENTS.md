# Perl Executing Browser - Requirements

## Compile-Time Requirements

* Qt development bundle versions 5.2 - 5.5  
* ``QtWebKit`` library and headers  

PEB for Windows must be compiled by a GCC-based MinGW Qt development bundle.  

Compiled and tested successfully using Qt 5.2.0, 5.2.1, 5.3.0, 5.4.1, 5.5.1.  

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
