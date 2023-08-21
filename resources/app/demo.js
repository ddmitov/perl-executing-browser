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
// Dimitar D. Mitov, 2013 - 2020, 2023
// Valcho Nedelchev, 2014 - 2016
// https://github.com/ddmitov/perl-executing-browser

// Settings objects for Perl scripts:
var perl_info = {};
perl_info.scriptRelativePath = 'perl_scripts/perl_info.pl';
perl_info.stdoutFunction = function (stdout) {
  var newElement = document.createElement("pre");
  newElement.innerHTML = stdout;
  document.getElementById('perl-info-output').appendChild(newElement);
  document.getElementById('perl-info-button').style.display = 'none';;
}

var sqlite = {};
sqlite.scriptRelativePath = 'perl_scripts/sqlite.pl';
sqlite.stdoutFunction = function (stdout) {
  var newElement = document.createElement("pre");
  newElement.innerHTML = stdout;
  document.getElementById('sqlite-output').appendChild(newElement);
  document.getElementById('sqlite-button').style.display = 'none';
}

var open_file = {};
open_file.scriptRelativePath = 'perl_scripts/open_file.pl';
open_file.stdoutFunction = function (stdout) {
  displayTestResult('open-file', stdout);
}

var new_file = {};
new_file.scriptRelativePath = 'perl_scripts/new_file.pl';
new_file.stdoutFunction = function (stdout) {
  displayTestResult('new-file', stdout);
}

var open_files = {};
open_files.scriptRelativePath = 'perl_scripts/open_files.pl';
open_files.stdoutFunction = function (stdout) {
  displayTestResult('open-files', stdout);
}

var open_directory = {};
open_directory.scriptRelativePath = 'perl_scripts/open_directory.pl';
open_directory.stdoutFunction = function (stdout) {
  displayTestResult('open-directory', stdout);
}

// Settings objects for filesystem dialogs:
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

var new_filename = {};
new_filename.type = 'new-file-name';
new_filename.receiverFunction = function (fileName) {
  new_file.inputData = fileName;

  clearTestData();

  var form = document.createElement('form');
  form.setAttribute('action', 'new_file.script');
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
  var container = document.getElementById('filesystem-tests');
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
    document.getElementById('filesystem-tests').appendChild(newElement);
  } else {
    existingElement.innerHTML = existingElement.innerHTML + stdout;
  }
}
