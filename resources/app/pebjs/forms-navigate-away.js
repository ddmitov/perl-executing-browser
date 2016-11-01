

var formSubmitted = false;

// This functions is usefull only inside Perl Executing Browser.
// It is necessary to prevent navigate away confirmation when form is being submitted.
function submitFunction() {
	formSubmitted = true;
}


// This functions is usefull only inside Perl Executing Browser.
// Navigate away confirmation -
// it will be trigered only if form is not being submitted:
$(window).on("beforeunload", function() {
	if (formSubmitted == false) {
		var textEntered = "";

		var textFields = new Array();
		textFields = document.getElementsByTagName("textarea");

		for (i = 0; i < textFields.length; i++) { 
			if (textFields[i].value.length > 0) {
				textEntered = "yes";
			}
		}

		var inputBoxes = new Array();
		inputBoxes = document.querySelectorAll("input[type=text]");

		for (i = 0; i < inputBoxes.length; i++) { 
			if (inputBoxes[i].value.length > 0) {
				textEntered = "yes";
			}
		}

		if (textEntered == "yes") {
			return "Text was entered in a form and it is going to be lost!\n" +
								"Are you sure you want to leave this page?";
		}
	}
});
