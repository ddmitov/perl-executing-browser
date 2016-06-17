

function checkCloseWarning() {
	var closeWarning;

	if (typeof pebCloseConfirmationAsync == 'function') {
		closeWarning = "async";
	}else{
		if (typeof pebCloseConfirmationSync == 'function') {
			closeWarning = "sync";
		} else {
			closeWarning = "none";
		}
	}

	return closeWarning;
}


function checkUserInputBeforeClose() {
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
