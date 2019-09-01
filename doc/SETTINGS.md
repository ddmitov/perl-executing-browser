# Perl Executing Browser - Settings

## Application Filename

The executable binary file of the browser, ``peb``, ``peb.app``, ``peb.dmg`` or ``peb.exe`` by default, can be renamed with no restrictions or additional adjustments. It can take the name of the PEB-based application it is going to run.

## HTML Page API

All local HTML page settings are stored in a single JavaScript object named ``pebSettings``. This name is mandatory and hard-coded in C++ code. If ``pebSettings`` JavaScript object is not found, no Perl scripts are started automatically, default labels are used for all context menus and JavaScript pop-up boxes and no warning is displayed for unsaved data in local HTML forms.

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

Every Perl script run by PEB has a JavaScript settings object with an arbitrary name and fixed object properties. The name of the JavaScript settings object with a ``.script`` extension forms a pseudo link used to start the Perl script.  

There are three methods to start a local Perl script:  

* **Clicking a link to a script pseudo link:**  

  ```html
  <a href="test.script">Start Perl script</a>
  ```

* **Submitting a form to a script pseudo link:**  

  ```html
  <form action="test.script">
    <input type="submit" value="Start Perl script">
  </form>
  ```

* **Calling a JavaScript function with a script pseudo link:**  

  ```javascript
  peb.startScript('test.script');
  ```

  This method creates an invisible form and submits it to the script pseudo link.  

An example of a JavaScript settings object for a Perl script run by PEB:  

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
  The relative path of a script is converted to a full path using the  
  ``{PEB_executable_directory}/resources/app`` as a root folder.  
  PEB does not check filename extensions or shebang lines of Perl scripts.  
  Scripts without filename extensions can also be used.  
  *This object property is mandatory.*  

  ```javascript
  perl_script.script = "relative/path/to/script.pl";
  ```

* **stdoutFunction**  
  executed every time data is available on STDOUT  
  The only parameter passed to the ``stdoutFunction`` is the STDOUT ``String``.  

  An example of an immediate STDOUT data display without accumulation:

  ```javascript
  perl_script.stdoutFunction = function (stdout) {
    document.getElementById("DOM-element-id").textContent = stdout;
  };
  ```

  Please note that many Perl scripts do not give their STDOUT data in a single shot.  
  If several chunks of output have to be combined, this should also be done at JavaScript level:  

  ```javascript
  var accumulatedOutput;

  perl_script.stdoutFunction = function (stdout) {
    accumulatedOutput = accumulatedOutput + stdout;
    document.getElementById("DOM-element-id").textContent = accumulatedOutput;
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

Each PEB interactive Perl script must have its own event loop waiting constantly for new data on STDIN for a bidirectional connection with PEB. Many interactive scripts can be started simultaneously in one PEB instance. One script may be started in many instances, provided that each of them has a uniquely named JavaScript settings object.  

Please note that interactive Perl scripts are not supported by the Windows builds of PEB.  

A PEB interactive Perl script should have the following features:

* **No buffering**  
  PEB interactive scripts should have ``$|=1;`` among their first lines to disable the built-in buffering of the Perl interpreter, which prevents any output before the script has ended.

* **Failsafe print**  
  Failsafe print is necessary for a graceful shutdown of Perl scripts on normal PEB exit and when PEB unexpectedly crashes. PEB closes the STDOUT and STDERR channels of all running Perl scripts when the close button is pressed - they must exit in 3 seconds or any unresponsive scripts are killed.

  Failsafe print could be implemented using the following code:

  ```perl
  print "output string" or shutdown_procedure();

  sub shutdown_procedure {
    # your shutdown code goes here...
    exit();
  }
  ```

The following code shows how to start a PEB interactive Perl script right after a local page is loaded:

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

The [index.htm of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/index.html) shows how to start one Perl script in two instances right after the PEB index page is loaded.  

The [interactive.pl](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl/interactive.pl) script of the demo package is an example of a Perl interactive script for PEB.

## Long-Running Windows Perl Scripts

Long-running Windows Perl scripts are supported provided that they also have ``$|=1;`` among their first lines to disable the built-in buffering of the Perl interpreter.  

Windows Perl scripts can not receive the ``SIGTERM`` signal and if they are still running when PEB is closed, they can only be killed with no mechanism for a graceful shutdown.

## Selecting Files and Folders

Selecting files or folders with their full paths is performed by clicking a pseudo link composed of the name of a JavaScript settings object and a ``.dialog`` extension.  

Selecting files or folders with their full paths is possible only from local HTML files.  

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
