// PEB settings objects for Perl scripts:
var open_file = {};
open_file.scriptRelativePath = 'perl-scripts/open-files.pl';
open_file.stdoutFunction = function (stdout) {
  displayTestResult('open-file', stdout);
}

var open_files = {};
open_files.scriptRelativePath = 'perl-scripts/open-files.pl';
open_files.stdoutFunction = function (stdout) {
  displayTestResult('open-files', stdout);
}

var open_directory = {};
open_directory.scriptRelativePath = 'perl-scripts/open-directory.pl';
open_directory.stdoutFunction = function (stdout) {
  displayTestResult('open-directory', stdout);
}

var perl_info = {};
perl_info.scriptRelativePath = 'perl-scripts/perl-info.pl';
perl_info.stdoutFunction = function (stdout) {
  clearTestData();
  displayTestResult('perl-info', stdout);
}

var sqlite = {};
sqlite.scriptRelativePath = 'perl-scripts/sqlite.pl';
sqlite.stdoutFunction = function (stdout) {
  clearTestData();
  displayTestResult('sqlite-test', stdout);
}

// Settings objects for the filesystem dialogs:
var select_file = {};
select_file.type = 'single-file';
select_file.receiverFunction = function (fileName) {
  open_file.inputData = fileName;
  clearTestData();
  peb.startScript('open_file.script');
}

var new_file_name = {};
new_file_name.type = 'new-file-name';
new_file_name.receiverFunction = function (fileName) {
  clearTestData();
  var pre = document.createElement("pre");
  pre.innerHTML = 'New file name: ' + fileName;
  document.getElementById('tests').appendChild(pre);
}

var select_files = {};
select_files.type = 'multiple-files';
select_files.receiverFunction = function (fileNames) {
  open_files.inputData = fileNames;
  clearTestData();
  peb.startScript('open_files.script');
}

var select_directory = {};
select_directory.type = 'directory';
select_directory.receiverFunction = function (directoryName) {
  open_directory.inputData = directoryName;
  clearTestData();
  peb.startScript('open_directory.script');
}

function startPerlInfo() {
  peb.startScript('perl_info.script');
}

function startSqlite() {
  peb.startScript('sqlite.script');
}

function clearTestData() {
  var container = document.getElementById('tests');
  while (container.firstChild) {
    container.removeChild(container.firstChild);
  }
}

function displayTestResult(id, stdout) {
  var existingElement = document.getElementById(id);
  if (existingElement === null) {
    clearTestData();
    var newElement = document.createElement("pre");
    newElement.id = id;
    newElement.innerHTML = stdout;
    document.getElementById('tests').appendChild(newElement);
  } else {
    existingElement.innerHTML = existingElement.innerHTML + stdout;
  }
}
