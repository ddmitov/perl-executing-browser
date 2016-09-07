

// This functions is usefull only inside Perl Executing Browser.
function pebMessageBoxElements() {
	var messageBoxElementsObject = new Object();

	messageBoxElementsObject.alertTitle = "- Alert -";
	messageBoxElementsObject.confirmTitle = "- Confirmation -";
	messageBoxElementsObject.promptTitle = "- Prompt -";

	messageBoxElementsObject.okLabel = "OK";
	messageBoxElementsObject.cancelLabel = "CANCEL";
	messageBoxElementsObject.yesLabel = "YES";
	messageBoxElementsObject.noLabel = "NO";

	return  JSON.stringify(messageBoxElementsObject);
}
