// PEB embedded JavaScript code:
var peb = {};

peb.getPageSettings = function() {
  if (window[pebSettings] !== null) {
    return JSON.stringify(pebSettings);
  }
}

peb.getScriptSettings = function(scriptObject) {
  if (window[scriptObject] !== null) {
    if (typeof scriptObject.inputDataHarvester === 'function') {
      scriptObject.inputData = scriptObject.inputDataHarvester();
    }
    return JSON.stringify(scriptObject);
  }
}

peb.getDialogSettings = function(dialogObject) {
  if (window[dialogObject] !== null) {
    return JSON.stringify(dialogObject);
  }
}

peb.checkUserInputBeforeClose = function() {
  var textEntered = false;
  var close = true;

  var textFieldsArray = [];
  textFieldsArray = document.getElementsByTagName('textarea');

  for (index = 0; index < textFieldsArray.length; index++) {
    if (textFieldsArray[index].value.length > 0) {
      textEntered = true;
    }
  }

  var inputBoxesArray = [];
  inputBoxesArray = document.querySelectorAll('input[type=text]');

  for (index = 0; index < inputBoxesArray.length; index++) {
    if (inputBoxesArray[index].value.length > 0) {
      textEntered = true;
    }
  }

  if (textEntered === true && pebSettings.closeConfirmation !== null) {
      close = confirm(pebSettings.closeConfirmation);
  }

  return close;
}
