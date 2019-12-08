# Perl Executing Browser - Interactive Perl Scripts

PEB interactive Perl scripts are able to receive user input multiple times after the script is started by waiting for new data coming either on STDIN or in a temporary file. Many interactive scripts can be started simultaneously in one PEB instance. One script may be started in many instances, provided that each of them has a JavaScript settings object with an unique name.

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

The [index.htm of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/index.html) demonstrates how to start automatically one Perl interactive script using STDIN input in two instances.  

The [interactive.pl script of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl-scripts/interactive.pl) is an example of a Perl interactive script using STDIN input.

The [index-windows.htm of the demo package](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/index-windows.html) demonstrates how to start automatically one Perl interactive script using a temporary file in two instances.  

The [interactive-windows.pl](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl-scripts/interactive-windows.pl) script of the demo package is an example of a Perl interactive script using a temporary file. This script creates a temporary file on startup and sends back to PEB its full path. PEB sends data to the interactive script by forwarding this path and a message text to the STDIN of a helper script, [messenger.pl](https://github.com/ddmitov/perl-executing-browser/blob/master/resources/app/perl-scripts/messenger.pl). The helper script writes all data received from PEB in the temporary file. The interactive script checks periodically its temporary file for any new messages.
