// Perl Executing Browser QtWebEngine Demo

// This program is free software;
// you can redistribute it and/or modify it under the terms of the
// GNU Lesser General Public License,
// as published by the Free Software Foundation;
// either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.
// Dimitar D. Mitov, 2013 - 2024
// Valcho Nedelchev, 2014 - 2016
// https://github.com/ddmitov/perl-executing-browser

// Settings object for perl_info.pl:
const perlInfo = {}

perlInfo.scriptRelativePath = 'perl_scripts/perl_info.pl'

perlInfo.stdoutFunction = function (stdout) {
  const newElement = document.createElement('pre')
  newElement.innerHTML = stdout
  document.getElementById('perl-info-output').appendChild(newElement)

  document.getElementById('perl-info-button').style.display = 'none'
}

// Settings object for open_file.pl:
const openFile = {}

openFile.scriptRelativePath = 'perl_scripts/open_file.pl'

openFile.scriptInput = '{"existing-file":"Select File"}'

openFile.stdoutFunction = function (stdout) {
  displayTestResult(stdout)
}

// Settings object for new_file.pl:
const newFile = {}

newFile.scriptRelativePath = 'perl_scripts/new_file.pl'

newFile.scriptInput = '{"new-file":"New File Name"}'

newFile.stdoutFunction = function (stdout) {
  displayTestResult(stdout)
}

// Settings object for open_directory.pl:
const openDirectory = {}

openDirectory.scriptRelativePath = 'perl_scripts/open_directory.pl'

openDirectory.scriptInput = '{"directory":"Select Directory"}'

openDirectory.stdoutFunction = function (stdout) {
  displayTestResult(stdout)
}

// Helper functions:
function displayTestResult (stdout) {
  clearTestData()

  const newElement = document.createElement('pre')
  newElement.innerHTML = stdout
  document.getElementById('filesystem-tests').appendChild(newElement)
}

function clearTestData () {
  const container = document.getElementById('filesystem-tests')

  while (container.firstChild) {
    container.removeChild(container.firstChild)
  }
}
