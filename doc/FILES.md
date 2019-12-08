# Perl Executing Browser - Files and Folders

PEB is created to work from any directory without installation and all paths used by PEB are relative to the directory of the PEB executable, labeled as ``{PEB_executable_directory}`` within this documentation. Only one folder and two file names are hard-coded in C++ code for compatibility with the [Electron](http://electron.atom.io/) framework.  

A minimal ``{PEB_executable_directory}`` looks like this:

```bash
.
├── {PEB_executable}
└── resources
    └── app
        ├── index.html
        └── app.png
```

* **Application Directory:**  
  The application directory path must be: ``{PEB_executable_directory}/resources/app``  
  All Perl scripts started by PEB must be located within this directory and its subdirectories.  
  The working directory of all PEB Perl scripts is the application directory.  

  * **Start Page:**  
    Start page pathname must be: ``{PEB_executable_directory}/resources/app/index.html``  
    If start page is missing, an error message is displayed.  

  <a name="icon"></a>
  * **Icon:**
    Icon pathname must be: ``{PEB_executable_directory}/resources/app/app.png``  
    If icon file is found on application startup, it is used as application icon.  
    If icon file is not found, the default icon embedded in the resources of the browser binary is used.
