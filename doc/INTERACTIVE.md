# Perl Executing Browser - Interactive Perl Scripts

PEB interactive Perl scripts are able to receive user input multiple times after the script is already started thus forming a bidirectional connection with PEB. Many interactive scripts can be started simultaneously in one PEB instance. One script may be started in many instances, provided that each of them has a JavaScript settings object with an unique name.  

## Requirements for Interactive Perl Scripts

* **Event Loop**  
  Each PEB interactive Perl script must have its own event loop waiting constantly for new data on STDIN or in a temporary file for a bidirectional connection with PEB. ``AnyEvent`` is a popular Perl framework for building different types of event loops.

* **No Buffering**  
  PEB interactive scripts should run with no output buffering, which preventing output before the script has ended.
  Output buffering could be disabled using the following code:

  ```perl
  use English;

  $OUTPUT_AUTOFLUSH = 1;
  ```

* **Failsafe Print**  
  Failsafe print is necessary to shut down PEB Perl scripts when PEB unexpectedly crashes.
  Failsafe print could be implemented using the following code:

  ```perl
  print "output string" or shutdown_procedure();

  sub shutdown_procedure {
    # your shutdown code goes here...
    exit();
  }
  ```

## Examples of Interactive Perl Scripts

The following code shows how to start a PEB interactive Perl script right after the PEB index page is loaded:

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

The [index.htm of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/index.html) demonstrates how to start automatically one Perl interactive script based on STDIN input in two instances.  

The [interactive.pl script of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl/interactive.pl) is an example of a Perl interactive script based on STDIN input.

The [index-windows.htm of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/index-windows.html) demonstrates how to start automatically one Perl interactive script based on temporary files in two instances.  

The [interactive-windows.pl script of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl/interactive-windows.pl) is an example of a Perl interactive script based on temporary files.
