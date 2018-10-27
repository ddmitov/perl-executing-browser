Perl Executing Browser - Constants
--------------------------------------------------------------------------------

## Files and Folders

PEB is created to work from any directory without installation and all file paths are relative to the directory of the PEB executable, which is labeled as ``{PEB_executable_directory}`` within this documentation. ``{PEB_executable_directory}`` may contain only a C++ PEB executable or a Linux [AppImage](https://appimage.org/) with a C++ PEB executable and its Qt libraries all packed in a single file. All names of PEB files and folders are hard coded in C++ code and they are case-sensitive!  

* **Perl Directory:**  
  The Perl directory, if present, must contain the ``bin`` and ``lib`` subdirectories.  
  The ``bin`` subdirectory must contain the Perl interpreter.  
  The ``lib`` subdirectory must contain all Perl modules used by PEB Perl applications.  

* **Perl interpreter:**  
  Relocatable Perl interpreter, if present, must be located in the ``{PEB_executable_directory}/perl/bin`` folder.  
  The Perl interpreter must be named ``perl`` on Linux and Mac machines and ``wperl.exe`` on Windows machines.  
  If a relocatable Perl interpreter is not found, PEB will use the first Perl interpreter on PATH.  

* **PERL5LIB:**  
  All Perl modules found in the ``{PEB_executable_directory}/perl/lib`` folder are accessible via the ``PERL5LIB`` environment variable for all Perl applications executed by PEB.  

* **Resources Directory:**  
  The resources directory must contain the ``app`` subdirectory with all necessary application files.  
  ``data`` and ``logs`` subdirectories are optional, as well as the application icon file: ``app.png``  
  The resources directory path must be: ``{PEB_executable_directory}/resources``  

* **Application Directory:**  
  All Perl application files must be located within this folder.  
  The application directory path must be: ``{PEB_executable_directory}/resources/app``  
  PEB application directory is labeled as ``{PEB_app_directory}`` within this documentation.  
  By default the working directory of all Perl scripts run by PEB is the application directory.  

  PEB application directory pathname is compatible with the [Electron](http://electron.atom.io/) framework.  
  [Epigraphista](https://github.com/ddmitov/epigraphista) is an application which is runnable by both PEB and [Electron](http://electron.atom.io/).  

* **Data Directory:**  
  Data directory must contain any writable files used or produced by a PEB-based application.  
  The data directory path must be: ``{PEB_executable_directory}/resources/data``  
  Perl scripts can access this folder using the environment variable ``PEB_DATA_DIR``:

  ```perl
  my $data_directory = $ENV{'PEB_DATA_DIR'};
  ```
<a name="log-files-directory"></a>
* **Log Files Directory:**  
  When logging directory is found during application startup, PEB assumes that logging is required and a separate log file is created for every browser session following the naming convention:  
  ``{executable_name}-started-at-{four_digit_year}-{month}-{day}--{hour}-{minute}-{second}.log``  

  The log files directory path must be: ``{PEB_executable_directory}/resources/logs``  
  PEB will not create logging directory on its own and if it is missing, no logs will be written.

* **Entry File:**  
  PEB starts with one of the following files:  
  * ``{PEB_executable_directory}/resources/app/index.html``  
  * ``{PEB_executable_directory}/resources/app/local-server.json``  

  If both files are present, ``index.html`` takes precedence.  
  If ``index.html`` is missing, ``local-server.json`` is used if available.  
  If both entry files are missing, an error message is displayed.  

<a name="icon"></a>
* **Icon:**
  A PEB-based application can have its own icon and the pathname must be:  
  ``{PEB_executable_directory}/resources/app/app.png``  

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
