

function pebFindContextMenu() {
	if (typeof pebContextMenu == 'function') {
		var returnValue = pebContextMenu();
		return returnValue;
	}
}


function pebFindMessageBoxElements() {
	if (typeof pebMessageBoxElements == 'function') {
		var returnValue = pebMessageBoxElements();
		return returnValue;
	}
}


function pebCheckUserInputBeforeClose() {
	var textEntered = false;

	var textFields = new Array();
	textFields = document.getElementsByTagName("textarea");

	for (i = 0; i < textFields.length; i++) { 
		if (textFields[i].value.length > 0) {
			textEntered = true;
		}
	}

	var inputBoxes = new Array();
	inputBoxes = document.querySelectorAll("input[type=text]");

	for (i = 0; i < inputBoxes.length; i++) { 
		if (inputBoxes[i].value.length > 0) {
			textEntered = true;
		}
	}

	return textEntered;
}


function pebCheckCloseWarning() {
	var closeWarning;

	if (typeof pebCloseConfirmationAsync == 'function') {
		closeWarning = "async";
	} else {
		if (typeof pebCloseConfirmationSync == 'function') {
			closeWarning = "sync";
		} else {
			closeWarning = "none";
		}
	}

	return closeWarning;
}


function pebInodeSelection(elementName, inodes) {
	var element = document.getElementById(elementName);
	element.innerHTML = inodes;

	var event;
	event = document.createEvent("HTMLEvents");
	event.initEvent("inodeselection", true, true);
	event.eventName = "inodeselection"
	element.dispatchEvent(event);
}


function pebScriptOutput(elementName, output) {
	var element = document.getElementById(elementName);
	element.innerHTML = output;

	var event;
	event = document.createEvent("HTMLEvents");
	event.initEvent("scriptoutput", true, true);
	event.eventName = "scriptoutput"
	element.dispatchEvent(event);
}
