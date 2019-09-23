# Perl Executing Browser - Logging

PEB has unified logging of Perl and JavaScript errors in the JavaScript console.  
All you need to read Perl errors is to open the JavaScript console.  

* To view the JavaScript console on QtWebkit builds  
  use the keyboard shortcut <kbd>Ctrl</kbd> + <kbd>I</kbd>  
  to open the ``QWebInspector`` and go to the ``Console`` tab.

* To view the JavaScript console on QtWebEngine builds  
  start PEB with the following command-line argument supplying an arbitrary private port:

  ```bash
  peb --remote-debugging-port=8080
  ```

  and open the local URL with the supplied port using another browser  

  ``http://localhost:8080``

  to access the ``QtWebEngine Developer Tools``, then go to the ``Console`` tab.
