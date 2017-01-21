// This function is usefull only inside Perl Executing Browser.

// Synchronous dialog for window close confirmation:
function pebCloseConfirmationSync() {
  var confirmation =
    confirm("Text was entered in a form and it is going to be lost!\n" +
            "Are you sure you want to close the window?");
  return confirmation;
}
