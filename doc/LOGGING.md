# Perl Executing Browser - Logging

PEB has unified logging of Perl and JavaScript errors in the JavaScript console.  
All you need to read Perl errors is to open the JavaScript console.  

## Using the JavaScript Console on QtWebkit Builds

Start the ``QWebInspector`` using the keyboard shortcut <kbd>Ctrl</kbd> + <kbd>I</kbd> and go to the ``Console`` tab.  

## Using the JavaScript Console on QtWebEngine Builds

Start PEB with the following command-line argument supplying an arbitrary private port:

```bash
peb --remote-debugging-port=8080
```

and open the following URL using another browser:

``http://localhost:8080``

to access the ``QtWebEngine Developer Tools``, then go to the ``Console`` tab.  
