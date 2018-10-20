Perl Executing Browser - Settings
--------------------------------------------------------------------------------

## Application Filename
The executable binary file of the browser, ``peb``, ``peb.app``, ``peb.dmg`` or ``peb.exe`` by default, can be renamed with no restrictions or additional adjustments. It can take the name of the PEB-based application it is going to run. If log files are wanted, they will take the name of the binary file without the filename extension, whatever the name may be.

## HTML Page API

```javascript
var pebSettings = {}; // 'pebSettings' object name is hard-coded.
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

* **autoStartScripts**  
  ``Array`` of Perl scripts that are started immediately after a local page is loaded  

* **closeConfirmation**  
  ``String`` displayed when the close button is pressed, but unsaved data in local HTML forms is detected.  
  If no warning text is found, PEB exits immediately.

## Perl Scripts API
Every Perl script run by PEB is called by clicking a link or submitting a form to a pseudo filename composed of the name of the JavaScript object with the settings of the Perl script and a ``.settings`` extension.  

A minimal example of a Perl script settings object:  

```javascript
var perl_script = {};
perl_script.scriptRelativePath = 'perl/test.pl';
perl_script.stdoutFunction = function (stdout) {
  var container = document.getElementById('tests');
  container.innerHTML = stdout;
}
```

Three methods to start a local Perl script:  

```html
<a href="perl_script.settings">Start Perl script</a>
```

```html
<form action="perl_script.settings">
  <input type="text" name="input" id="test-script-input">
  <input type="submit" value="Start Perl script">
</form>
```

```javascript
peb.startScript('perl_script.settings');
```

* **script**  
  ``String`` for the relative path of a Perl script run by PEB  
  The script relative path is converted to a full path using the PEB application directory as a root folder.  
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

* **scriptExitCommand**  
  ``String`` containing the command used to gracefully shut down an interactive Perl script when PEB is closed  
  Upon receiving it, an interactive script must start its shutdown procedure.

* **scriptExitConfirmation**  
  ``String`` used to signal PEB that an interactive Perl script completed its shutdown  
  All interactive scripts must exit in 3 seconds after ``scriptExitCommand`` is given or any unresponsive scripts will be killed and PEB will exit.

Perl scripts running for a long time should have ``$|=1;`` among their first lines to disable the built-in buffering of the Perl interpreter. Some builds of Perl may not give any output until the script is finished when buffering is enabled.

## Interactive Perl Scripts
Each PEB interactive Perl script must have its own event loop waiting constantly for new data on STDIN for a bidirectional connection with PEB. Many interactive scripts can be started simultaneously in one browser window. One script may be started in many instances, provided that it has a JavaScript settings object with a unique name. Interactive scripts must also have the ``scriptExitCommand`` object property. The ``scriptExitConfirmation`` object property is not mandatory, but highly recommended for a quick shutdown of PEB.  

Please note that interactive Perl scripts are not supported by all Windows builds of PEB.  

Please also note that if a PEB instance crashes, it will leave its interactive scripts as zombie processes and they will start consuming large amounts of memory! Exhaustive stability testing has to be done when interactive scripts are selected for use with PEB! Even during normal operation interactive scripts use more memory than non-interactive scripts and their use should be carefully considered.

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
        container.innerHTML = stdout;
      }
      interactive_script.scriptExitCommand = '_close_';
      interactive_script.scriptExitConfirmation = '_closed_';
    </script>
  </head>

  <body>
    <form action="interactive_script.settings">
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
A [Mojolicious](http://mojolicious.org/) application or other local Perl server can be started by PEB provided that a ``{PEB_binary_directory}/resources/app/local-server.json`` file is found instead of ``{PEB_binary_directory}/resources/app/index.html`` with the following structure:

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
  ``String`` resolved to a full pathname using the ``{PEB_binary_directory}/resources/app`` folder  
  All Perl servers started by PEB must be up and running within 5 seconds from being launched or PEB will display a timeout message. Servers being unable to start will also timeout.  
  *This element is mandatory.*

* **ports**  
  ``Array`` holding a single port or the lowest and the highest ports in a port range  
  *This element is mandatory.*

  Privileged ports below or equal to port 1024 are not allowed.  
  The following Google Chrome unsafe ports used by various services are also not allowed:  

  ```
  2049 - nfs
  3659 - apple-sasl / PasswordServer
  4045 - lockd
  6000 - X11
  6665 - Alternate IRC [Apple addition]
  6666 - Alternate IRC [Apple addition]
  6667 - Standard IRC [Apple addition]
  6668 - Alternate IRC [Apple addition]
  6669 - Alternate IRC [Apple addition]
  ```

* **command-line-arguments**  
``Array`` holding all command-line arguments that have to be passed to a local Perl server  
The ``#PORT#`` keyword within the command-line arguments is substituted with the first available safe port when a port range is given. It is not possible to supply the first available safe port to the local server application if the ``#PORT#`` keyword is missing within the command line arguments.

* **shutdown_command**  
``String`` appended to the base URL of the local server to make a special URL which is invoked just before PEB is closed to shut down the local server and prevent it from becoming a zombie process  
``shutdown_command`` is not needed if the local server uses a WebSocket connection to detect when PEB is disconnected and shut down on its own - see the [Tabula](https://github.com/ddmitov/tabula) application for an example.

## Selecting Files and Folders
Selecting files or folders with their full paths is performed by clicking a link to a pseudo filename composed from the name of the JavaScript object with the settings of the wanted dialog and a ``.dialog`` extension.  

A JavaScript settings object for a filesystem dialog takes only two arguments:

* **type**  
``String`` containing one of the following:
  * ``single-file``  
  The actual opening of any existing file is performed by a Perl script and not by PEB.  

  * ``multiple-files``  
  When multiple files are selected, different filenames are separated by a semicolon ``;``  

  * ``new-file-name``  
  The actual creation of any new file is performed by a Perl script and not by PEB.  

  * ``directory``  
  When using the ``directory`` type of dialog, an existing or a new directory may be selected.  
  Any new directory will be created immediately by PEB.

* **receiverFunction**  
executed by PEB after the user has selected files or folders, takes selected files or folders as its only argument  

```html
<a href="select_file.dialog">Select existing file</a>
```

```javascript
var select_file = {};
select_file.type = 'single-file';
select_file.receiverFunction = function (file) {
  var container = document.getElementById('single-file-test');
  container.innerHTML = file;
}
```

## Log Files
If log files are needed for debugging of PEB or a PEB-based application, they can be easily turned on by manually creating logging directory - ``{PEB_binary_directory}/resources/logs`` or ``{AppImage_binary_directory}/resources/logs`` for a PEB-based application packed as an [AppImage](https://appimage.org/). When logging directory is found during application startup, PEB assumes that logging is required and a separate log file is created for every browser session following the naming convention: ``{application_name}-started-at-{four_digit_year}-{month}-{day}--{hour}-{minute}-{second}.log``. PEB will not create logging directory on its own and if it is missing, no logs will be written.
