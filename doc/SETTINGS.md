# Perl Executing Browser - Settings

## Global Settings API

All global PEB settings are stored in a single JavaScript object named ``pebSettings``. This name is mandatory and hard-coded in C++ code. If ``pebSettings`` JavaScript object is not found, no Perl scripts can be started.

```javascript
var pebSettings = {};
pebSettings.perlInterpreter = 'perl/bin/perl';
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

* **perlInterpreter**  
  ``String`` for the relative path of a Perl interpreter used by PEB  
  The relative path of a Perl interpreter is converted to a full path using the  
  ``{PEB_executable_directory}/resources/app`` as a root folder.  
  If a relocatable Perl interpreter is not configured, PEB will use the first Perl interpreter on PATH.  

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
  ``String`` displayed in a JavaScript Confirm popup box when the close button is pressed, but unsaved data in local HTML forms is detected. If no ``closeConfirmation`` object property is found, PEB shuts down all running Perl scripts and exits.  

## Perl Scripts API

Every Perl script run by PEB has a JavaScript settings object with an arbitrary name and fixed object properties. The name of the JavaScript settings object with a ``.script`` extension forms a pseudo link used to start the Perl script.  

There are two methods to start a local Perl script:  

* **Clicking a pseudo link:**  

  ```html
  <a href="test.script">Start Perl script</a>
  ```

* **Submitting a form to a pseudo link:**  

  ```html
  <form action="test.script">
    <input type="submit" value="Start Perl script">
  </form>
  ```

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
  If several chunks of output have to be combined, this should be done at JavaScript level:  

  ```javascript
  var accumulatedOutput;

  perl_script.stdoutFunction = function (stdout) {
    accumulatedOutput = accumulatedOutput + stdout;
    document.getElementById("DOM-element-id").textContent = accumulatedOutput;
  };
  ```

* **inputData**  
  ``String`` or ``Function`` supplying user data as its return value  
  ``inputData`` is written on script STDIN or in temporary file.  

  ``inputData`` function with no dependencies:  

  ```javascript
  perl_script.inputData = function () {
    var data = document.getElementById("input-box-id").value;
    return data;
  }
  ```

* **exitData**  
  ``String`` or ``Function`` supplying script exit command as its return value  
  ``exitData`` is written on script STDIN or in temporary file.  

## Files and Folders Dialogs API

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
