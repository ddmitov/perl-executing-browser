# Perl Executing Browser - Constants

## Files and Folders

PEB is created to work from any directory without installation and all file paths are relative to the directory of the PEB executable, which is labeled as ``{PEB_executable_directory}`` within this documentation. ``{PEB_executable_directory}`` may contain only a C++ PEB executable or a Linux [AppImage](https://appimage.org/) with a C++ PEB executable and its Qt libraries all packed in a single file. All names of PEB files and folders are hard coded in C++ code and they are case-sensitive!  

A typical ``{PEB_executable_directory}`` looks like this:

```bash
.
├── {PEB_executable}
└── resources
    ├── app
    │   └── index.html
    ├── data
    │   └── {application_data}
    ├── perl
    │   ├── bin
    │   │   └── perl || wperl.exe
    └── app.png
```

* **Resources Directory:**  
  The resources directory must contain the ``app`` subdirectory with all PEB application files.  
  ``data`` and ``perl`` subdirectories, as well as the PEB application icon file ``app.png`` are optional.  

  The resources directory path must be: ``{PEB_executable_directory}/resources``  

  * **Application Directory:**  
    PEB application files are located within this folder.  
    PEB application directory is labeled as ``{PEB_app_directory}`` within this documentation.  
    By default the working directory of all Perl scripts run by PEB is the application directory.  

    The application directory path must be: ``{PEB_executable_directory}/resources/app``  

    PEB application directory pathname is compatible with the [Electron](http://electron.atom.io/) framework.  
    [Epigraphista](https://github.com/ddmitov/epigraphista) is an application which is runnable by both PEB and [Electron](http://electron.atom.io/).  

    * **Start Page:**  
      ``{PEB_executable_directory}/resources/app/index.html``  

      If start page is missing, an error message is displayed.  

  * **Data Directory:**  
    Data directory may contain any writable files used or produced by a PEB-based application.  
    Perl scripts can access this folder using the environment variable ``PEB_DATA_DIR``:  

    The data directory path must be: ``{PEB_executable_directory}/resources/data``  

    ```perl
    my $data_directory = $ENV{'PEB_DATA_DIR'};
    ```

  * **Perl Interpreter:**  
    Relocatable Perl interpreter, if any, must be located in the ``{PEB_executable_directory}/resources/perl/bin`` folder.  
    The Perl interpreter must be named ``perl`` on Linux and Mac machines and ``wperl.exe`` on Windows machines.  
    If a relocatable Perl interpreter is not found, PEB will use the first Perl interpreter on PATH.  

  <a name="icon"></a>
  * **Icon:**
    A PEB-based application may have its own icon and the pathname must be:  
    ``{PEB_executable_directory}/resources/app.png``  

    If this file is found during application startup, it is used as the icon of the application and all dialog boxes.  
    If this file is not found, the default icon embedded in the resources of the browser binary is used.

## Functional Pseudo Filenames

* **About PEB dialog:** ``about-browser.function``
* **About Qt dialog:** ``about-qt.function``

## Specific Keyboard Shortcut

* <kbd>Ctrl</kbd> + <kbd>I</kbd> - start QWebInspector (QtWebKit builds only)
