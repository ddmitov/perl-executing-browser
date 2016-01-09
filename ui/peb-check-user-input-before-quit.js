
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
		if (confirm("На тази страница е попълнен текст и той ще бъде загубен!\n" +
			"Въведената информация не може да бъде възстановена!\n" +
			"Сигурни ли сте, че искате да изключите програмата?")) {
				quitDecision = "yes";
		}
	}

	return quitDecision;
}
