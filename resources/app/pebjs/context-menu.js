// This function is usefull only inside Perl Executing Browser.

function pebContextMenu() {
  var contextMenuObject = {};

  contextMenuObject.printPreview = "- Print Preview -";
  contextMenuObject.print = "- Print -";

  contextMenuObject.cut = "- Cut -";
  contextMenuObject.copy = "- Copy -";
  contextMenuObject.paste = "- Paste -";
  contextMenuObject.selectAll = "- Select All -";

  return JSON.stringify(contextMenuObject);
}
