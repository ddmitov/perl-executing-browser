// PEB embedded JavaScript code:
var peb = {};

peb.getPageSettings = function() {
  if (window[pebSettings] !== null) {
    return JSON.stringify(pebSettings);
  }
}

peb.getDialogSettings = function(dialogSettings) {
  if (window[dialogSettings] !== null) {
    return JSON.stringify(dialogSettings);
  }
}

peb.getScriptSettings = function(scriptSettings) {
  if (window[scriptSettings] !== null) {
    if (typeof scriptSettings.inputData === 'function') {
      scriptSettings.scriptInput = scriptSettings.inputData();
    } else {
      scriptSettings.scriptInput = scriptSettings.inputData;
    }

    return JSON.stringify(scriptSettings);
  }
}

peb.startScript = function(scriptSettings) {
  var form = document.createElement('form');
  form.setAttribute('action', scriptSettings);
  document.body.appendChild(form);
  form.submit();
}

peb.checkUserInputBeforeClose = function() {
  var textEntered = false;
  var close = true;

  var textFields = [];
  textFields = document.getElementsByTagName('textarea');

  for (index = 0; index < textFields.length; index++) {
    if (textFields[index].value.length > 0) {
      textEntered = true;
    }
  }

  var inputBoxes = [];
  inputBoxes = document.querySelectorAll('input[type=text]');

  for (index = 0; index < inputBoxes.length; index++) {
    if (inputBoxes[index].value.length > 0) {
      textEntered = true;
    }
  }

  if (textEntered === true && pebSettings.closeConfirmation !== null) {
      close = confirm(pebSettings.closeConfirmation);
  }

  return close;
}
