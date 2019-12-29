# Perl Executing Browser - AppImage Support

## PEB AppImager

Any PEB-based application with a PEB executable, Qt libraries and a relocatable Perl distribution can be easily packed as a 64-bit single-file Linux [AppImage](https://appimage.org/) executable by the [PEB AppImager](https://github.com/ddmitov/perl-executing-browser/blob/master/appimager.sh) script, which uses the [linuxdeployqt](https://github.com/probonopd/linuxdeployqt/releases/) tool to detect all Qt dependencies of PEB and build an AppImage.  

The PEB AppImager must be started from the ``{PEB_executable_directory}``.

## PEB AppImage Configuration Files

``{PEB_executable_directory}/resources/app/appimage/{application_name}.desktop``  
``{PEB_executable_directory}/resources/app/appimage/{application_name}.appdata.xml``  

``{PEB_executable_directory}/resources/app/{application_name}.desktop``  
is mandatory for any PEB-based application which is to be packed by the PEB AppImager.  
A minimal example of а ``.desktop`` file is available [here](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/appimage/peb-demo.desktop).  
``Icon=app`` in the ``.desktop`` file must not be changed for the proper display of the application icon.  
All registered categories in a ``.desktop`` file are available [here](https://standards.freedesktop.org/menu-spec/latest/apa.html).  
Any ``.desktop`` file can be validated using the ``desktop-file-validate`` tool from the  ``desktop-file-utils`` package in all major Linux distributions.  

The [AppStream Generator](http://output.jsbin.com/qoqukof) of [probonopd](https://github.com/probonopd) is the recommended tool for generating AppStream ``.appdata.xml`` files for PEB-based applications. An example AppStream file is available [here](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/appimage/peb-demo.appdata.xml). An AppStream file is not mandatory, but is highly recommended.  

Both PEB AppImage configuration files are put on their places in the AppImage directory tree structure by the [PEB AppImager](https://github.com/ddmitov/perl-executing-browser/blob/master/appimager.sh) script.  

## PEB AppImage Builder Docker Container

An easy building environment for PEB AppImage executables is the [PEB AppImage Builder Docker Container](https://github.com/ddmitov/perl-executing-browser/blob/master/sdk/Dockerfile).  
To start it, run the following commands in the ``{PEB_executable_directory}``:  

```bash
sudo docker build -t peb-appimage-builder .
sudo docker container run --rm -it -v $(pwd):/opt --user $(id -u):$(id -g) peb-appimage-builder
```

When PEB AppImage Builder Docker Container is running, type:

```bash
cd /opt/src && qmake -qt=qt5 && make && cd .. && export VERSION="1.1.1" && ./appimager.sh && exit
```

## AppImageHub

Perl Executing Browser is also listed at the [AppImageHub](https://appimage.github.io/perl-executing-browser/).  
Any authors of PEB-based Linux applications are encouraged to list their AppImage executables in the same manner.
