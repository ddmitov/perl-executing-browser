# Perl Executing Browser - Application Directory

PEB is created to work from any directory and all file paths used by PEB are relative to the PEB Application Directory.  

The PEB Application Directory must be one of the following:

* an existing directory submitted as a full or relative path in the only command-line argument of PEB

* an existing directory named ``app`` and located in the current working directory of PEB

All Perl scripts started by PEB must be located within the PEB Application Directory and its subdirectories.  

The working directory of all PEB Perl scripts is the PEB Application Directory.  

When started, PEB is trying to find the following files in its Application Directory:

* **Start Page:**  
  Start page pathname must be: ``{PEB Application Directory}/index.html``  

  Start page is required.  

  If start page is missing, an error message is displayed.  

* **Icon:**  
  Icon pathname must be: ``{PEB Application Directory}/app.png``  

  Icon file is optional.  

  If icon file is found when PEB is started, it is used as an application icon.  
  If icon file is not found, the default icon embedded in the resources of the PEB binary is used as an application icon.
