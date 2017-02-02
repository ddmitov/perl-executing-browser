

function pebFindContextMenu() {
	if (typeof pebContextMenu === "function") {
		var returnValue = pebContextMenu();
		return returnValue;
	}
}


function pebFindMessageBoxElements() {
	if (typeof pebMessageBoxElements === "function") {
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

	if (typeof pebCloseConfirmationAsync === "function") {
		closeWarning = "async";
	} else {
		if (typeof pebCloseConfirmationSync === "function") {
			closeWarning = "sync";
		} else {
			closeWarning = "none";
		}
	}

	return closeWarning;
}


function pebInodeSelection(inodes, target) {
	if (typeof window[target] === "function") {
		var inodesTransmitted = inodes;
		window[target](inodesTransmitted);
	} else {
		var element = document.getElementById(target);
		if (element === null) {
			console.error(
				'PEB Embedded JavaScript: Target \'' + target +
				'\' was not found!');
		} else {
			element.innerHTML = inodes;
		}
	}
}


function pebOutputInsertion(output, target) {
	if (typeof window[target] === "function") {
		window[target](output);
	} else {
		var element = document.getElementById(target);
		if (element === null) {
			console.error(
				'PEB Embedded JavaScript: Target \'' + target +
				'\' was not found!');
		} else {
			element.innerHTML = output;
		}
	}
}
