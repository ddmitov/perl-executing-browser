# Perl Executing Browser - Logging

PEB supports unified logging of Perl and JavaScript errors in the JavaScript console.  
All you need to read error logs is to open the JavaScript console.  

## Opening the JavaScript Console on QtWebkit Builds

Start the QWebInspector using the keyboard shortcut <kbd>Ctrl</kbd> + <kbd>I</kbd> and go to the ``Console`` tab.  

## Opening the JavaScript Console on QtWebEngine Builds

Start PEB with the following command-line argument supplying an arbitrary private port:

```bash
peb --remote-debugging-port=8080
```

and open the following URL using any browser:

``http://localhost:8080``

to access the QtWebEngine Developer Tools and go to the ``Console`` tab.  
