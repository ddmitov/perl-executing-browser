// These functions are usefull only inside Perl Executing Browser.

function fileSelection(file) {
  window.location.href = "http://local-pseudodomain/perl/open-file.pl?stdout=open-file&file=" + file;
}

function filesSelection(files) {
  window.location.href = "http://local-pseudodomain/perl/open-files.pl?stdout=open-files&files=" + files;
}

function directorySelection(directory) {
  window.location.href = "http://local-pseudodomain/perl/open-directory.pl?stdout=open-directory&directory=" + directory;
}

function newFilenameSelection(filename) {
  var container = document.getElementById('new-filename');
  container.innerHTML = "<pre>New filename: " + filename + "</pre>";
}
