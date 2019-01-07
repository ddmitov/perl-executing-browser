# Perl Executing Browser - Packaging

## Minimal Relocatable Perl Distribution for PEB

Minimizing the size of a relocatable (or portable) Perl distribution used by a PEB-based application is vital for reducing the size of its distribution package. [Perl Distribution Compactor](https://github.com/ddmitov/perl-executing-browser/blob/master/sdk/compactor.pl) is one solution for this problem. It finds all dependencies of all Perl scripts run by PEB and copies them in a new ``{PEB_executable_directory}/resources/app/perl/lib`` folder. Any unnecessary modules are left behind and the original ``bin`` and ``lib`` folders are saved as ``bin-original`` and ``lib-original``.  

Perl Distribution Compactor must be started from the ``{PEB_executable_directory}/sdk/lib`` folder using [compactor.sh](https://github.com/ddmitov/perl-executing-browser/blob/master/sdk/compactor.sh) on a Linux machine or [compactor.cmd](https://github.com/ddmitov/perl-executing-browser/blob/master/sdk/compactor.cmd) on a Windows machine to make sure that only a relocatable Perl distribution is used.  

Perl Distribution Compactor depends on [Module::ScanDeps](https://metacpan.org/pod/Module::ScanDeps) and [File::Copy::Recursive](https://metacpan.org/pod/File::Copy::Recursive) CPAN modules, which are included in the ``{PEB_executable_directory}/sdk/lib`` directory.

## AppImage Support

* **PEB AppImage Maker**

  PEB or any PEB-based application can be easily packed as a 64-bit single-file Linux [AppImage](https://appimage.org/) executable by the [PEB AppImage Maker](https://github.com/ddmitov/perl-executing-browser/blob/master/sdk/appimage-maker.sh) script, which has two modes of operation:  

  * packing a Perl application together with a PEB executable, its Qt libraries and a relocatable Perl distribution:  

    ```bash
    ./appimage-maker.sh --include-resources
    ```

    In this case the PEB AppImage invokes the [Perl Distribution Compactor](https://github.com/ddmitov/perl-executing-browser/blob/master/sdk/compactor.pl), which finds all dependencies of all Perl scripts in the ``{PEB_executable_directory}/resources/app`` directory and copies only the necessary Perl modules.

  * packing only a PEB executable with its Qt libraries:  

    ```bash
    ./appimage-maker.sh --no-resources
    ```

    In this case a PEB executable from an AppImage will try to find its application files and folders in the directory of the AppImage.  

  In both modes of operation, the PEB AppImage uses the [linuxdeployqt](https://github.com/probonopd/linuxdeployqt/releases/) tool to detect all Qt dependencies of PEB and build the final image.  

  The PEB AppImage Maker script must be started from the ``{PEB_executable_directory}/sdk`` directory.  

* **PEB AppImage Builder Docker Container**

  An easy building environment for PEB AppImage executables is the provided [PEB AppImage Builder Docker Container](https://github.com/ddmitov/perl-executing-browser/blob/master/sdk/Dockerfile).  
  To build it, type the following command in the PEB project root directory (the directory of the README.md):  

  ```bash
  sudo docker build -t peb-appimage-builder .
  ```

  To start the PEB AppImage Builder Docker Container, type the following command in the PEB project root directory:  

  ```bash
  sudo docker container run --rm -it -v $(pwd):/opt --user $(id -u):$(id -g) peb-appimage-builder
  ```

  When PEB AppImage Builder Docker Container is running, type:

  ```bash
  cd /opt/sdk
  ```

  To start the PEB AppImage Maker, type either:

  ```bash
  ./appimage-maker.sh --no-resources
  ```

  or

  ```bash
  ./appimage-maker.sh --include-resources
  ```
