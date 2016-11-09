

// These functions are usefull only inside Perl Executing Browser.
function fileSelection(file) {
	$.ajax({
		url: 'http://local-pseudodomain/perl/open-file.pl',
		data: {filename: file},
		method: 'POST',
		dataType: 'text',
		success: function(data) {
			document.write(data);
		}
	});
}


function filesSelection(files) {
	var selectedFilesElement = document.getElementById("files-selection");
	selectedFilesElement.innerHTML = files.replace(/;/g, "<br>");
}


function directorySelection(directory) {
	$.ajax({
		url: 'http://local-pseudodomain/perl/open-directory.pl',
		data: {directoryname: directory},
		method: 'POST',
		dataType: 'text',
		success: function(data) {
			document.write(data);
		}
	});
}
