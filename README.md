  
Perl Executing Browser  
----------------------------------------------------------------------------------------
  
Perl Executing Browser (PEB) is a Qt4/5 WebKit browser capable of executing Perl scripts locally with or even without a webserver. Serverless execution of local scripts can go side by side with a traditional access to local or remote webservers. CGI protocol GET and POST methods are used for communication with scripts executed without a webserver.  
  
Design Objectives
----------------------------------------------------------------------------------------
  
* **1. Easy GUI for scripts:**  
    use HTML, CSS and JavaScript to craft and deploy rapidly beautifull interfaces for your Perl, PHP, Python or other scripts;  
* **2. Zero installation when needed:**  
    pack your Perl modules and even your version of Perl with a copy of PEB and its Qt libraries and run your application from every folder, even from USB sticks;  
* **3. Cross-platform availability:**  
    use it on every platform and device (desktop, tablet, smartphone), where Perl and Qt can be compiled;  
* **4. Flexible network access:**  
    **a)** if no network connectivity is wanted or needed, no services are started, no ports are opened, no firewall notifications are triggered, no need for administrative privileges and everything remains in the userspace, but  
    **b)** if network connection is essential, PEB can be configured as a client or both as a client and server for network services in a variety of combinations and topologies.  
    Local webserver functionality, if needed, is provided by a minimally modified version of Mongoose web server.  
  
Features
----------------------------------------------------------------------------------------
  
* Can execute CGI scripts locally in a serverless mode, feeding them from standard forms using CGI protocol GET and POST methods.  
* Can execute long-running scripts - i.e. scripts running for arbitrary long time. Output can be displayed in the same or in a new window.  
* Can open a file or a folder on the local file system using special URLs. Selected file and folder are accessible for a locally executed script as environment variables FILE_TO_OPEN and FOLDER_TO_OPEN.  
* Can print current page by clicking a special URL.  
* Browser can also be closed by clicking a special URL.  
* Can open local documents and start user-specified programs.
* Can load Perl modules from directory when they are not installed system-wide.  
* Can start local webserver (Mongoose) and load scripts and pages from localhost.  
* Can load a predefined website and be used as a site-specific browser or a client for a web service.  
* Can ping local and remote web servers and notify when network connectivity is lost. Local webserver is automatically restarted if accidentally terminated. Local webserver is shut down simultaneously with the browser.  
* Configurable from INI file.  
* Can be used in normal or frameless window in resizable, fixed size or fullscreen mode. 100% of the browser screen area is dedicated to HTML, CSS and JavaScript interfaces. Basic program functions are accessible from a right-click context menu.  
* System tray icon & menu.  
... to be continued
  
History
----------------------------------------------------------------------------------------
  
PEB was started as a simple GUI for personal databases. This small project is still in its very beginning and current version (0.1) should be considered alpha pre-release. Do not use it for production purposes! No feature or implementation should be considered final at this point. Proper documentation and examples are still missing.  
  
Compiling
----------------------------------------------------------------------------------------
  
Compiled and tested successfully using:  
1. Qt Creator 2.5.0 and Qt 4.8.2 on 32-bit Debian Linux  
(main development and testing platform),  
2. Qt Creator 2.8.1 and Qt 5.1.1 on 32-bit Debian Linux,  
3. Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Debian Linux,  
4. Qt Creator 3.0.0 and Qt 5.2.0 on 32-bit Windows XP,  
  
Licensing
----------------------------------------------------------------------------------------
  
This software is licensed under the terms of GNU GPL v.3 and is provided without warranties of any kind!  
Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com  
  