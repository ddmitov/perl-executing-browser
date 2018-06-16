Perl Executing Browser - Constants
--------------------------------------------------------------------------------

## Hard Coded Files and Folders
* **Perl interpreter:**  
  PEB expects to find a Perl interpreter in the ``{PEB_binary_directory}/perl/bin`` folder. The interpreter must be named ``perl`` on Linux and Mac machines and ``perl.exe`` on Windows machines. If Perl interpreter is not found in the above location, PEB will use the first Perl interpreter on PATH.  

* **Resources directory:**  
  Resources directory is ``{PEB_binary_directory}/resources`` or ``{AppImage_binary_directory}/resources`` if a PEB-based application is packed as an [AppImage](https://appimage.org/). Application, data and logs directories, as well as icon file of a PEB application must be located in this folder.  

* **Application directory:**  
  Application directory is ``{PEB_binary_directory}/resources/app``.  
  All files used by PEB, with the exception of data files, must be located within this folder.  

  Application directory is hard coded in C++ code for compatibility with the [Electron](http://electron.atom.io/) framework.  
  [Epigraphista](https://github.com/ddmitov/epigraphista) is an example of a PEB-based application, that is also compatible with [Electron](http://electron.atom.io/) and [NW.js](http://nwjs.io/).  

  By default the working directory of all Perl scripts run by PEB is the application directory.

* **Data Directory:**
  Data directory must contain any writable files used or produced by a PEB-based application.  
  The data directory path is ``{PEB_binary_directory}/resources/data`` or ``{AppImage_binary_directory}/resources/data`` if a PEB-based application is packed as an [AppImage](https://appimage.org/). Perl scripts can access this folder using the environment variable ``PEB_DATA_DIR``:

  ```perl
  my $data_directory = $ENV{'PEB_DATA_DIR'};
  ```

* **Entry point:**  
  PEB starts with one of the following entry files:  
  ``{PEB_binary_directory}/resources/app/index.html`` or  
  ``{PEB_binary_directory}/resources/app/local-server.json``.  

  If both entry files are present, ``index.html`` takes precedence.  
  If ``index.html`` is missing, ``local-server.json`` is used, if available.  
  If both entry files are missing, an error message is displayed.  

  Note that entry files pathnames are case sensitive.

  <a name="icon"></a>
* **Icon:**
  A PEB-based application can have its own icon and it must be located at ``{PEB_binary_directory}/resources/app/app.png``. If this file is found during application startup, it is used as the icon of the application and all dialog boxes. If this file is not found, the default icon embedded into the resources of the browser binary is used.

## Functional Pseudo Filenames
* **About PEB dialog:** ``about-browser.function``

* **About Qt dialog:** ``about-qt.function``

## Specific Keyboard Shortcuts
All specific keyboard shortcuts are available only in the QtWebKit builds of PEB.
* <kbd>Ctrl</kbd> + <kbd>I</kbd> - start QWebInspector
* <kbd>Ctrl</kbd> + <kbd>P</kbd> - get printer selection dialog. If no printer is configured, no dialog is displayed.
* <kbd>Ctrl</kbd> + <kbd>R</kbd> - get print preview
