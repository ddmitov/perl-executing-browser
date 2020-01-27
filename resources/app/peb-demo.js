// Perl Executing Browser Demo

// This program is free software;
// you can redistribute it and/or modify it under the terms of the
// GNU Lesser General Public License,
// as published by the Free Software Foundation;
// either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.
// Dimitar D. Mitov, 2013 - 2020
// Valcho Nedelchev, 2014 - 2016
// https://github.com/ddmitov/perl-executing-browser

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

var create_file = {};
create_file.scriptRelativePath = 'perl-scripts/create-file.pl';
create_file.stdoutFunction = function (stdout) {
  displayTestResult('new-file', stdout);
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

  var form = document.createElement('form');
  form.setAttribute('action', 'open_file.script');
  document.body.appendChild(form);
  form.submit();
}

var new_file = {};
new_file.type = 'new-file-name';
new_file.receiverFunction = function (fileName) {
  create_file.inputData = fileName;
  clearTestData();

  var form = document.createElement('form');
  form.setAttribute('action', 'create_file.script');
  document.body.appendChild(form);
  form.submit();
}

var select_files = {};
select_files.type = 'multiple-files';
select_files.receiverFunction = function (fileNames) {
  open_files.inputData = fileNames;
  clearTestData();

  var form = document.createElement('form');
  form.setAttribute('action', 'open_files.script');
  document.body.appendChild(form);
  form.submit();
}

var select_directory = {};
select_directory.type = 'directory';
select_directory.receiverFunction = function (directoryName) {
  open_directory.inputData = directoryName;
  clearTestData();

  var form = document.createElement('form');
  form.setAttribute('action', 'open_directory.script');
  document.body.appendChild(form);
  form.submit();
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

// About dialog:
function about() {
  alert(
    "Browser version: " + peb.browser_version + "\n"+
    "Qt version: " + peb.qt_version + "\n\n"+

    "This program is free software;\n"+
    "you can redistribute it and/or modify it under\n"+
    "the terms of the GNU Lesser General Public License,\n"+
    "as published by the Free Software Foundation;\n"+
    "either version 3 of the License,\n"+
    "or (at your option) any later version.\n\n"+

    "This program is distributed\n"+
    "in the hope that it will be useful,\n"+
    "but WITHOUT ANY WARRANTY;\n"+
    "without even the implied warranty of\n"+
    "MERCHANTABILITY or\n"+
    "FITNESS FOR A PARTICULAR PURPOSE.\n\n"+

    "Dimitar D. Mitov, 2013 - 2020\n"+
    "Valcho Nedelchev, 2014 - 2016"
  );
}
