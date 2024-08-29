# Perl Executing Browser QtWebEngine - Perl Scripts API

Every Perl script run by PEB must have a JavaScript configuration object with an arbitrary object name and fixed-name object properties. The name of the JavaScript configuration object with a ``.script`` extension forms a pseudo link used to start the corresponding Perl script.  

There are two methods to start a Perl script in PEB:  

* **Click a pseudo link:**  
  ```html
  <a href="example.script">Start Perl script</a>
  ```

* **Submit a form to a pseudo link:**  

  ```html
  <form action="example.script">
    <input type="submit" value="Start Perl script">
  </form>
  ```

A minimal example of a JavaScript configuration object for a Perl script run by PEB:  

```javascript
const example = {}

example.scriptRelativePath = 'relative/path/to/script.pl'

example.stdoutFunction = function (stdout) {
  const container = document.getElementById('DOM-element-id')
  container.innerText = stdout
}
```

A JavaScript configuration object for a Perl script run by PEB must have the following required properties:

* **scriptRelativePath**  
  ``String`` for the relative path of the Perl script run by PEB  

  The relative path of the script is converted to a full path using the [PEB Application Directory](./doc/application-directory.md) as a root folder. PEB does not check filename extensions or shebang lines of Perl scripts. Scripts without filename extensions can also be used.  

* **stdoutFunction**  
  ``function`` executed by PEB every time data is available on the STDOUT of the Perl script  
  The only parameter passed to the ``stdoutFunction`` is the STDOUT ``String``.  

  An example of a ``stdoutFunction`` displaying immediately STDOUT data:

  ```javascript
  example.stdoutFunction = function (stdout) {
    document.getElementById('DOM-element-id').textContent = stdout
  }
  ```

  Please note that many Perl scripts do not give their STDOUT data in a single shot.  
  If several chunks of output have to be combined, this must be done at JavaScript level:  

  ```javascript
  let accumulatedOutput

  example.stdoutFunction = function (stdout) {
    accumulatedOutput = accumulatedOutput + stdout
    document.getElementById('DOM-element-id').textContent = accumulatedOutput
  };
  ```

A JavaScript configuration object for a Perl script run by PEB may also have the following additional properties:

* **perlInterpreter**  
  ``String`` for the relative path of a [relocatable](https://github.com/skaji/relocatable-perl) Perl interpreter used by PEB  

  The relative path of a relocatable Perl interpreter is converted to a full path using the [PEB Application Directory](./doc/application-directory.md) as a root folder. If a relocatable Perl interpreter is not configured, PEB will use the first Perl interpreter on PATH.  

* **scriptInput**  
  ``String``  

  The ``scriptInput`` string is written to the STDIN of the Perl script.  

  If any of the following special tags is included in the ``scriptInput`` string, a file or directory selection dialog is presented to the user and the tag is replaced with the user-selected file or folder path before starting the Perl script. Any number and combination of special tags may be included in the ``scriptInput`` string.  

  All file or directory selection tags are JSON-compatible snippets with the dialog type as element name and the dialog title as element value. The acceptable element names are ``existing-file``, ``new-file`` and ``directory``, the element values are text labels which must match the regular expression ``[a-zA-Z0-9\\s]{1,}`` meaning that one or more instances of lowercase or uppercase letters, numbers or spaces are allowed in any combination.  

  Special tags for file or folder selection:  

  * ``{"existing-file":"Your Dialog Title"}``  
  The actual opening of an existing file is performed by the Perl script and not by PEB.  

  * ``{"new-file":"Your Dialog Title"}``  
  The actual creation of a new file is performed by the Perl script and not by PEB.  

  * ``{"directory":"Your Dialog Title"}``  
  When ``directory`` type of dialog is used, an existing directory may be selected or a new directory may be created and then selected; any new directory will be immediately created by PEB.
