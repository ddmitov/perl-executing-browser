// These functions are usefull only inside Perl Executing Browser.

function fileSelection(file) {
  window.location.href = "http://local-pseudodomain/perl/open-file.pl?stdout=tests&file=" + file;
}

function filesSelection(files) {
  window.location.href = "http://local-pseudodomain/perl/open-files.pl?stdout=tests&files=" + files;
}

function directorySelection(directory) {
  window.location.href = "http://local-pseudodomain/perl/open-directory.pl?stdout=tests&directory=" + directory;
}

function newFilenameSelection(filename) {
  var container = document.getElementById('tests');
  container.innerHTML = "<pre>New filename: " + filename + "</pre>";
}
