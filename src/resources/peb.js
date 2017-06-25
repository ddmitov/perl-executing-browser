

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

	var textFieldsArray = [];
	textFieldsArray = document.getElementsByTagName("textarea");

	for (index = 0; index < textFieldsArray.length; index++) { 
		if (textFieldsArray[index].value.length > 0) {
			textEntered = true;
		}
	}

	var inputBoxesArray = [];
	inputBoxesArray = document.querySelectorAll("input[type=text]");

	for (index = 0; index < inputBoxesArray.length; index++) { 
		if (inputBoxesArray[index].value.length > 0) {
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
