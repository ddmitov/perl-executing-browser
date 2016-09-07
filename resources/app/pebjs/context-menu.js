

// This functions is usefull only inside Perl Executing Browser.
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
