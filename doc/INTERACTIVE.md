# Perl Executing Browser - Interactive Perl Scripts

PEB interactive Perl scripts are able to receive user input multiple times after the script is started by waiting for new data on STDIN or in a temporary file. Many interactive scripts can be started simultaneously in one PEB instance. One script may be started in many instances, provided that each of them has a JavaScript settings object with an unique name.

## Requirements for Interactive Perl Scripts

* **Event Loop**  
  Each PEB interactive Perl script must have its own event loop waiting constantly for new data on STDIN or in a temporary file. ``AnyEvent`` is a popular Perl framework for building different types of event loops.

* **No Buffering**  
  PEB interactive scripts must run without output buffering, which may prevent output before the script has ended.
  Output buffering can be disabled using the following code:

  ```perl
  use English;

  $OUTPUT_AUTOFLUSH = 1;
  ```

* **Failsafe Print**  
  Failsafe print is necessary to shut down PEB Perl scripts if PEB unexpectedly crashes.
  Failsafe print can be implemented using the following code:

  ```perl
  print "output string" or shutdown_procedure();

  sub shutdown_procedure {
    # your shutdown code goes here...
    exit();
  }
  ```

## Examples of Interactive Perl Scripts

The [index.htm](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/index.html) file demonstrates how to start automatically one Perl interactive script in two instances.  

The [interactive.pl](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl-scripts/interactive.pl) is a Perl interactive script using STDIN input.

The [interactive-tempfile.pl](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl-scripts/interactive-tempfile.pl) is a Perl interactive script using a temporary file.  
This script creates a temporary file on startup and sends to PEB its full path in the following JSON format:  

```javascript
{"tempfile":"/path/to/tempfile"}
```

PEB sends data to the script by writing in its temporary file and the script checks periodically its temporary file for new messages.
