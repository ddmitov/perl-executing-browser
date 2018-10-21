Perl Executing Browser - Constants
--------------------------------------------------------------------------------

## Hard Coded Files and Folders

All names of PEB hard coded files and folders are case-sensitive!  

* **Perl interpreter:**  
  PEB expects to find a Perl interpreter in the ``{PEB_executable_directory}/perl/bin`` folder.  
  The Perl interpreter must be named ``perl`` on Linux and Mac machines and ``wperl.exe`` on Windows machines.  
  If Perl interpreter is not found in the above location, PEB will use the first Perl interpreter on PATH.  

* **Resources directory:**  
  Resources directory must contain the ``application`` subdirectory with all necessary application files.  
  ``data`` and ``logs`` subdirectories are optional, as well as the application icon file - ``app.png``.  

  The resources directory path is:
  * ``{AppImage_executable_directory}/resources`` for Linux [AppImage](https://appimage.org/) single executable builds or
  * ``{PEB_executable_directory}/resources`` for all other PEB builds.

* **Application directory:**  
  All Perl application files must be located within this folder.  

  The application directory path is:
  * ``{AppImage_executable_directory}/resources/app`` for Linux [AppImage](https://appimage.org/) single executable builds or
  * ``{PEB_executable_directory}/resources/app`` for all other PEB builds.

  Application directory is hard coded in C++ code for compatibility with the [Electron](http://electron.atom.io/) framework.  
  [Epigraphista](https://github.com/ddmitov/epigraphista) is an example of a PEB-based application compatible with [Electron](http://electron.atom.io/).  

  By default the working directory of all Perl scripts run by PEB is the application directory.

* **Data Directory:**  
  Data directory must contain any writable files used or produced by a PEB-based application.  

  The data directory path is:
  * ``{AppImage_executable_directory}/resources/data`` for Linux [AppImage](https://appimage.org/) single executable builds or
  * ``{PEB_executable_directory}/resources/data`` for all other PEB builds.

  Perl scripts can access this folder using the environment variable ``PEB_DATA_DIR``:

  ```perl
  my $data_directory = $ENV{'PEB_DATA_DIR'};
  ```

* **Entry point:**  
  PEB starts with one of the following entry files:  
  ``{PEB_executable_directory}/resources/app/index.html`` or  
  ``{PEB_executable_directory}/resources/app/local-server.json``.  

  If both entry files are present, ``index.html`` takes precedence.  
  If ``index.html`` is missing, ``local-server.json`` is used, if available.  
  If both entry files are missing, an error message is displayed.  

  <a name="icon"></a>
* **Icon:**
  A PEB-based application can have its own icon and it must be located at ``{PEB_executable_directory}/resources/app/app.png``.  
  If this file is found during application startup, it is used as the icon of the application and all dialog boxes.  
  If this file is not found, the default icon embedded in the resources of the browser binary is used.

## Functional Pseudo Filenames
* **About PEB dialog:** ``about-browser.function``

* **About Qt dialog:** ``about-qt.function``

## Specific Keyboard Shortcuts
All specific keyboard shortcuts are available only in the QtWebKit builds of PEB.
* <kbd>Ctrl</kbd> + <kbd>I</kbd> - start QWebInspector
* <kbd>Ctrl</kbd> + <kbd>P</kbd> - get printer selection dialog. If no printer is configured, no dialog is displayed.
* <kbd>Ctrl</kbd> + <kbd>R</kbd> - get print preview
