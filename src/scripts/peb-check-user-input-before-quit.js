
// UTF-8 encoded file!


function checkUserInputBeforeQuit() {
	var textEntered = false;
	var quitDecision = "no";

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

	if (textEntered == false) {
		quitDecision = "yes";
	}

	if (textEntered == true) {
		if (confirm("This page contains text entered by user and it is going to be lost!\n" +
			"This information can not be recovered!\n" +
			"Are you sure that you want to quit the program?")) {
				quitDecision = "yes";
		}
	}

	return quitDecision;
}
