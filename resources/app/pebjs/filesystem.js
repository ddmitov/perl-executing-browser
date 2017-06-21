// These functions are usefull only inside Perl Executing Browser.

function fileSelection(file) {
    var scriptRequest = new XMLHttpRequest();
    scriptRequest.open('POST', 'perl/open-file.pl?stdout=open-file', true);
    scriptRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    scriptRequest.send("file=" + file);
}

function filesSelection(files) {
  var scriptRequest = new XMLHttpRequest();
  scriptRequest.open('POST', 'perl/open-files.pl?stdout=open-files', true);
  scriptRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  scriptRequest.send("files=" + files);
}

function directorySelection(directory) {
  var scriptRequest = new XMLHttpRequest();
  scriptRequest.open('POST', 'perl/open-directory.pl?stdout=open-directory', true);
  scriptRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  scriptRequest.send("directory=" + directory);
}

function newFilenameSelection(filename) {
  var container = document.getElementById('new-filename');
  container.innerHTML = "<pre>New filename: " + filename + "</pre>";
}
