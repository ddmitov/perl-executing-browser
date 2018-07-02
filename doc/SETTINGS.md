Perl Executing Browser - Settings
--------------------------------------------------------------------------------

## Application Filename
The binary file of the browser, ``peb``, ``peb.app``, ``peb.dmg`` or ``peb.exe`` by default, can be renamed with no restrictions or additional adjustments. It can take the name of the PEB-based application it is going to run. If log files are wanted, they will take the name of the binary file without the filename extension, whatever the name may be.

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

* ``autoStartScripts``  
  These are Perl scripts that are started immediately after a local page is loaded.  

* ``closeConfirmation``  
  This text is displayed when the close button is pressed, but unsaved data in local HTML forms is detected. If no warning text is found, PEB exits immediately.

## Perl Scripts API
Every Perl script run by PEB is called by clicking a link or submitting a form to a pseudo filename composed of the name of the JavaScript object with the settings of the Perl script and a ``.settings`` extension.  

A minimal example of a Perl script settings object:  

```javascript
var perl_test = {};
perl_test.scriptFullPath = '{app}/perl/test.pl';
perl_test.stdoutFunction = function (stdout) {
  var container = document.getElementById('tests');
  container.innerHTML = stdout;
}
```

Three methods to start a local Perl script:  

```html
<a href="perl_test.settings">Start Perl script</a>
```

```html
<form action="perl_test.settings">
  <input type="text" name="input" id="test-script-input">
  <input type="submit" value="Start Perl script">
</form>
```

```javascript
peb.startScript('perl_test.settings');
```

* ``scriptFullPath``  
  This is the path of the Perl script that is going to be executed.  
  The keyword ``{app}`` will be replaced by the the full path of the application directory.  
  PEB does not check the filename extension or the shebang line of the supplied Perl script.  
  Scripts without a filename extension can also be used.  
  *This object property is mandatory.*  

* ``stdoutFunction``  
  Every piece of script output is passed to this function as its only argument.  
  *This object property is mandatory.*  

* ``requestMethod``  
  Only ``GET`` or ``POST`` are recognized.  

* ``inputData``  
  This object property is useless if ``requestMethod`` is not set.  

* ``inputDataHarvester``  
  This object property is a function that can get input data from an HTML form and supply it to PEB.  

  Single input box example with no dependencies:  

  ```javascript
  perlScriptObject.inputDataHarvester = function() {
    var data = document.getElementById('input-box-id').value;
    return data;
  }
  ```

  Whole form example using [jQuery](https://jquery.com/):  

  ```javascript
  perlScriptObject.inputDataHarvester = function() {
    var formData = $('#form-id').serialize();
    return formData;
  }
  ```

* ``scriptExitCommand``  
  The ``scriptExitCommand`` object property designates the command used to gracefully shut down an interactive script when PEB is going to be closed. Upon receiving it, the interactive script must start its shutdown procedure.

* ``scriptExitConfirmation``  
  Just before exiting an interactive script must print on STDOUT its ``scriptExitConfirmation`` to signal PEB that it completed its shutdown. All interactive scripts must exit in 3 seconds after ``scriptExitCommand`` is given or any unresponsive scripts will be killed and PEB will exit.

Perl scripts running for a long time should have ``$|=1;`` among their first lines to disable the built-in buffering of the Perl interpreter. Some builds of Perl may not give any output until the script is finished when buffering is enabled.

## Interactive Perl Scripts
Each PEB interactive Perl script must have its own event loop waiting constantly for new data on STDIN for a bidirectional connection with PEB. Many interactive scripts can be started simultaneously in one browser window. One script may be started in many instances provided that it has an unique JavaScript settings object with and unique ``stdoutFunction`` object property. Interactive scripts should also have the ``scriptExitCommand`` and ``scriptExitConfirmation`` object properties.  

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
      interactive_script.scriptFullPath = '{app}/perl/interactive.pl';
      interactive_script.requestMethod = 'POST';
      interactive_script.inputDataHarvester = function() {
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

The [index.htm](./resources/app/index.html) file of the demo package demonstrates how to start one script in two instances immediately after a page is loaded.

## Starting Local Server
A [Mojolicious](http://mojolicious.org/) application or other local Perl server can be started by PEB provided that a ``{PEB_binary_directory}/resources/app/local-server.json`` file is found instead of ``{PEB_binary_directory}/resources/app/index.html`` with the following structure:

```json
{
  "file" : "tabula",
  "ports" : [
    3000 ,
    6000
  ] ,
  "command-line-arguments" : [
    "--browser=none" ,
    "--port=#PORT#" ,
    "--no-port-test"
  ] ,
  "shutdown_command" : "shutdown"
}
```

* ``file`` is a string resolved to a full pathname using the ``{PEB_binary_directory}/resources/app`` folder.  
  All Perl servers started by PEB must be up and running within 5 seconds from being launched or PEB will display a timeout message. Servers being unable to start will also timeout.  
  *This element is mandatory.*

* ``ports`` is an array holding a single port or the lowest and the highest ports in a port range.  
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

* ``command-line-arguments`` is an array holding all command-line arguments that have to be passed to a local Perl server. The ``#PORT#`` keyword within the command-line arguments is substituted with the first available safe port when a port range is given. It is not possible to supply the first available safe port to the local server application if the ``#PORT#`` keyword is missing within the command line arguments.

* ``shutdown_command`` is a string appended to the base URL of the local server to make a special URL which is invoked just before PEB is closed to shut down the local server and prevent it from becoming a zombie process. ``shutdown_command`` is not needed if the local server uses a WebSocket connection to detect when PEB is disconnected and shut down on its own - see [Tabula](https://github.com/ddmitov/tabula) as an example.

## Selecting Files and Folders
Selecting files or folders with their full paths is performed by clicking a link to a pseudo filename composed from the name of the JavaScript object with the settings of the wanted dialog and a ``.dialog`` extension. Selected files or folders are seamlessly inserted in any local page by the ``receiverFunction`` taking all selected files or folders as its only argument.  

```html
<a href="select_file.dialog">Select existing file</a>
```

```javascript
var select_file = {};
// Type of the dialog, one of the following:
// 'single-file', 'multiple-files', 'new-file-name' or 'directory'.
select_file.type = 'single-file';
select_file.receiverFunction = function (file) {
  var container = document.getElementById('single-file-test');
  container.innerHTML = file;
}
```

* The actual opening of any existing file is performed by a Perl script and not by PEB.
* The actual creation of any new file is performed by a Perl script and not by PEB.
* When multiple files are selected, different filenames are separated by a semicolon ``;``
* When using the ``directory`` type of dialog, an existing or a new directory may be selected.  
  Any new directory will be created immediately by PEB.

## Minimal Portable Perl Distribution for PEB
Sometimes it is important to minimize the size of the relocatable (or portable) Perl distribution used by a PEB-based application. [Perl Distribution Compactor](sdk/compactor.pl) is one solution for this problem. It finds all dependencies of all Perl scripts in the ``{PEB_binary_directory}/resources/app`` directory and copies them in a new ``{PEB_binary_directory}/perl/lib`` folder; a new ``{PEB_binary_directory}/perl/bin`` is also created. The original ``bin`` and ``lib`` folders may be saved as ``bin-original`` and ``lib-original`` respectively.  

Perl Distribution Compactor should be started using [compactor.sh](sdk/compactor.sh) on a Linux machine or [compactor.cmd](sdk/compactor.cmd) on a Windows machine to ensure that only the Perl distribution of PEB is used. This is necessary to avoid dependency mismatches with any other Perl on PATH.  

Perl Distribution Compactor depends on [Module::ScanDeps](https://metacpan.org/pod/Module::ScanDeps) and [File::Copy::Recursive](https://metacpan.org/pod/File::Copy::Recursive) CPAN modules, which are included in the ``{PEB_binary_directory}/sdk/lib`` folder.

## AppImage Support
Any PEB-based application can be easily packed as a single executable Linux [AppImage](https://appimage.org/) file including the PEB binary, all necessary Qt libraries, relocatable Perl distribution and all application files. This can be easily achieved by the [AppImage Maker](sdk/appimage-maker.sh) script. It finds all dependencies of all Perl scripts in the ``{PEB_binary_directory}/resources/app`` directory and copies only the necessary Perl modules using the [Perl Distribution Compactor](sdk/compactor.pl). All Qt dependencies are detected and the final image is built using a special version of the [linuxdeployqt](https://github.com/probonopd/linuxdeployqt/releases/) binary.

## Log Files
If log files are needed for debugging of PEB or a PEB-based application, they can easily be turned on by manually creating ``{PEB_binary_directory}/resources/logs`` or ``{AppImage_binary_directory}/resources/logs`` if a PEB-based application is packed as an [AppImage](https://appimage.org/). If this directory is found during application startup, the browser assumes that logging is required and a separate log file is created for every browser session following the naming convention: ``{application_name}-started-at-{four_digit_year}-{month}-{day}--{hour}-{minute}-{second}.log``. PEB will not create ``{PEB_binary_directory}/logs`` on its own and if this directory is missing, no logs will be written.
