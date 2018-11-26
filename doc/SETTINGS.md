# Perl Executing Browser - Settings

## Application Filename

The executable binary file of the browser, ``peb``, ``peb.app``, ``peb.dmg`` or ``peb.exe`` by default, can be renamed with no restrictions or additional adjustments. It can take the name of the PEB-based application it is going to run. If log files are wanted, they will take the name of the executable file without the filename extension, whatever the name may be.

## HTML Page API

All local HTML page settings are stored in a single JavaScript object named ``pebSettings``. This name is mandatory and hard-coded in C++ code. If ``pebSettings`` JavaScript object is not found, no Perl scripts are started automatically, default labels are used for all context menus and JavaScript popup boxes and no warning is displayed for unsaved data in local HTML forms.

```javascript
var pebSettings = {};
pebSettings.autoStartScripts = ['interactive_one', 'interactive_two'];
pebSettings.cutLabel = "Custom Cut Label";
pebSettings.copyLabel = "Custom Copy Label";
pebSettings.pasteLabel = "Custom Paste Label";
pebSettings.selectAllLabel = "Custom Select All Label";
pebSettings.okLabel = "Custom Ok Label";
pebSettings.cancelLabel = "Custom Cancel Label";
pebSettings.yesLabel = "Custom Yes Label";
pebSettings.noLabel = "Custom No Label";
pebSettings.closeConfirmation =
  'Text was entered in a form and it is going to be lost!\n' +
  'Are you sure you want to close the window?';
```

The ``pebSettings`` JavaScript object may have the following properties:

* **autoStartScripts**  
  ``Array`` of Perl scripts that are started immediately after a local page is loaded  

* **cutLabel**  
  ``String`` displayed as a label for the 'Cut' action on context menus.

* **copyLabel**  
  ``String`` displayed as a label for the 'Copy' action on context menus.

* **pasteLabel**  
  ``String`` displayed as a label for the 'Paste' action on context menus.

* **selectAllLabel**  
  ``String`` displayed as a label for the 'Select All' action on context menus.

* **okLabel**  
  ``String`` displayed as a label for the 'Ok' button on JavaScript Alert and Prompt popup boxes.

* **cancelLabel**  
  ``String`` displayed as a label for the 'Cancel' button on JavaScript Prompt popup box.

* **yesLabel**  
  ``String`` displayed as a label for the 'Yes' button on JavaScript Confirm popup box.

* **noLabel**  
  ``String`` displayed as a label for the 'No' button on JavaScript Confirm popup box.

* **closeConfirmation**  
  ``String`` displayed in a JavaScript Confirm popup box when the close button is pressed, but unsaved data in local HTML forms is detected. If no ``closeConfirmation`` object property is found, PEB exits immediately.

## Perl Scripts API

Every Perl script run by PEB has a JavaScript settings object with an arbitrary name and fixed object properties. The name of the JavaScript settings object with a ``.script`` extension forms settings pseudo link used to start the Perl script.  

There are three methods to start a local Perl script:  

* **Clicking a link to a script settings pseudo link:**  

  ```html
  <a href="test.script">Start Perl script</a>
  ```

* **Submitting a form to a script settings pseudo link:**  

  ```html
  <form action="test.script">
    <input type="submit" value="Start Perl script">
  </form>
  ```

* **Calling a JavaScript function with a script settings pseudo link:**  

  ```javascript
  peb.startScript('test.script');
  ```

  This method creates an invisible form and submits it to the script settings pseudo link.  

A minimal example of a JavaScript settings object for a Perl script run by PEB:  

```javascript
var perl_script = {};
perl_script.scriptRelativePath = 'perl/test.pl';
perl_script.stdoutFunction = function (stdout) {
  var container = document.getElementById('tests');
  container.innerText = stdout;
}
```

A JavaScript settings object for a Perl script run by PEB has the following properties:

* **scriptRelativePath**  
  ``String`` for the relative path of a Perl script run by PEB  
  The script relative path is converted to a full path using the ``{PEB_app_directory}`` as a root folder.  
  PEB does not check filename extensions or shebang lines of Perl scripts.  
  Scripts without filename extensions can also be used.  
  *This object property is mandatory.*  

  ```javascript
  perl_script.script = "relative/path/to/script.pl";
  ```

* **stdoutFunction**  
  executed every time data is available on STDOUT  
  The only parameter passed to the ``stdoutFunction`` is the STDOUT ``String``.  
  *This object property is mandatory.*  

  ```javascript
  perl_script.stdoutFunction = function (stdout) {
    document.getElementById("DOM-element-id").textContent = stdout;
  };
  ```

* **inputData**  
  ``String`` or ``Function`` supplying user data as its return value  
  ``inputData`` is written on script STDIN.  

  ``inputData`` function with no dependencies:  

  ```javascript
  perl_script.inputData = function () {
    var data = document.getElementById("input-box-id").value;
    return data;
  }
  ```

## Interactive Perl Scripts

Each PEB interactive Perl script must have its own event loop waiting constantly for new data on STDIN for a bidirectional connection with PEB. Many interactive scripts can be started simultaneously in one browser window. One script may be started in many instances, provided that it has a JavaScript settings object with an unique name.  

Please note that interactive Perl scripts are not supported by the Windows builds of PEB.  

PEB interactive Perl script should also have the following features:

* **No buffering**  
  PEB interactive scripts should have ``$|=1;`` among their first lines to disable the built-in buffering of the Perl interpreter, which prevents any output before the script has ended.

* **SIGTERM handling**  
  PEB sends the ``SIGTERM`` signal to all interactive scripts on exit for a graceful shutdown and to prevent them from becoming zombie processes. All interactive scripts must exit in 3 seconds after the ``SIGTERM`` signal is given by PEB. All unresponsive scripts are killed before PEB exits. The  ``SIGTERM`` signal may be handled by any interactive script for a graceful shutdown using the following code:

  ```perl
  $SIG{TERM} = sub {
    # your shutdown code goes here...
    exit();
  };
  ```

* **Failsafe print**  
  If a PEB instance crashes, it can still leave its interactive scripts as zombie processes consuming large amounts of memory. To prevent this scenario, all interactive scripts should test for a successful ``print`` on the STDOUT. This could be implemented using the following code:

  ```perl
  print "output string" or shutdown_procedure();

  sub shutdown_procedure {
    # your shutdown code goes here...
    exit();
  }
  ```

The following code shows how to start an interactive Perl script right after a local page is loaded:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Interactive Script Demo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">

    <script>
      var pebSettings = {};
      pebSettings.autoStartScripts = ['interactive_script'];

      var interactive_script = {};
      interactive_script.scriptRelativePath = 'perl/interactive.pl';
      interactive_script.inputData = function() {
        return document.getElementById('interactive-script-input').value;
      }
      interactive_script.stdoutFunction = function (stdout) {
        var container = document.getElementById('interactive-script-output');
        container.innerText = stdout;
      }
    </script>
  </head>

  <body>
    <form action="interactive_script.script">
      <input type="text" name="input" id="interactive-script-input">
      <input type="submit" value="Submit">
    </form>

    <div id="interactive-script-output"></div>
  </body>
</html>
```

The [index.htm](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/index.html) page of the demo package demonstrates how to start one script in two instances immediately after local page is loaded.  

The [interactive.pl](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl/interactive.pl) script of the demo package is an example of a Perl interactive script for PEB.

## Starting Local Server

A [Mojolicious](http://mojolicious.org/) application or other local Perl server can be started by PEB provided that  
a ``{PEB_app_directory}/local-server.json`` file is found instead of ``{PEB_app_directory}/index.html``  
with the following structure:

```json
{
  "file": "tabula",
  "ports":
  [
    3000,
    6000
  ],
  "command-line-arguments":
  [
    "--browser=none",
    "--port=#PORT#",
    "--no-port-test"
  ],
  "shutdown_command": "shutdown"
}
```

* **file**  
  ``String`` resolved to a full pathname using the ``{PEB_app_directory}``  
  All Perl servers started by PEB must be up and running within 5 seconds from being launched or PEB will display a timeout message. Servers being unable to start will also timeout.  
  *This element is mandatory.*

* **ports**  
  ``Array`` holding a single port or the lowest and the highest ports in a port range  
  *This element is mandatory.*

  Privileged ports below or equal to port 1024 are not allowed.  
  The following Google Chrome unsafe ports used by various services are also not allowed:  

  2049 - nfs  
  3659 - apple-sasl / PasswordServer  
  4045 - lockd  
  6000 - X11  
  6665 - Alternate IRC [Apple addition]  
  6666 - Alternate IRC [Apple addition]  
  6667 - Standard IRC [Apple addition]  
  6668 - Alternate IRC [Apple addition]  
  6669 - Alternate IRC [Apple addition]  

* **command-line-arguments**  
``Array`` holding all command-line arguments that have to be passed to a local Perl server  
The ``#PORT#`` keyword within the command-line arguments is substituted with the first available safe port when a port range is given. It is not possible to supply the first available safe port to the local server application if the ``#PORT#`` keyword is missing within the command line arguments.

* **shutdown_command**  
``String`` appended to the base URL of the local server to make a special URL which is invoked just before PEB is closed to shut down the local server and prevent it from becoming a zombie process  
``shutdown_command`` is not needed if the local server uses a WebSocket connection to detect when PEB is disconnected and shut down on its own - see the [Tabula](https://github.com/ddmitov/tabula) application for an example.

## Selecting Files and Folders

Selecting files or folders with their full paths is performed by clicking a pseudo link composed of the name of a JavaScript settings object and a ``.dialog`` extension.  

Selecting files or folders with their full paths is possible only from local HTML files or localhost pages.  

A JavaScript settings object for a filesystem dialog has only two object properties:

* **type**  
  ``String`` containing one of the following:

  * ``single-file``  
  The actual opening of an existing file is performed by a Perl script and not by PEB.  

  * ``multiple-files``  
  When multiple files are selected, different filenames are separated by a semicolon ``;``  

  * ``new-file-name``  
  The actual creation of a new file is performed by a Perl script and not by PEB.  

  * ``directory``  
  When ``directory`` type of dialog is used, an existing or a new directory may be selected.  
  Any new directory will be immediately created by PEB.

* **receiverFunction**  
  It is executed by PEB after the user has selected files or folders and takes them as its only argument.  

An example code of a dialog for selecting a single file:  

```html
<a href="select_file.dialog">Select existing file</a>
```

```javascript
var select_file = {};
select_file.type = 'single-file';
select_file.receiverFunction = function (file) {
  var container = document.getElementById('single-file-test');
  container.innerText = file;
}
```
