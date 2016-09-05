

// The following functions are only usefull inside Perl Executing Browser.


function pebContextMenu() {
	var contextMenuObject = new Object();

	contextMenuObject.printPreview = "- Print Preview -";
	contextMenuObject.print = "- Print -";

	contextMenuObject.cut = "- Cut -";
	contextMenuObject.copy = "- Copy -";
	contextMenuObject.paste = "- Paste -";
	contextMenuObject.selectAll = "- Select All -";

	return JSON.stringify(contextMenuObject);
}


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

function pebCloseConfirmationSync() {
	var confirmation = confirm("Text was entered in a form and it is going to be lost!\n" +
							"Are you sure you want to close the window?");
	return confirmation;
}
