

// These functions are usefull only inside Perl Executing Browser.
$(document).ready(function() {
	$('#file-selection').bind("inodeselection", function(){
		$.ajax({
			url: 'http://local-pseudodomain/perl/open-file.pl',
			data: {filename: $('#file-selection').html()},
			method: 'POST',
			dataType: 'text',
			success: function(data) {
				document.write(data);
			}
		});
	});

	$('#files-selection').bind("inodeselection", function(){
		var selectedFilesElement = document.getElementById("files-selection");
		selectedFilesElement.innerHTML = selectedFilesElement.innerHTML.replace(/;/g, "<br>");
	});

	$('#directory-selection').bind("inodeselection", function(){
		$.ajax({
			url: 'http://local-pseudodomain/perl/open-directory.pl',
			data: {directoryname: $('#directory-selection').html()},
			method: 'POST',
			dataType: 'text',
			success: function(data) {
				document.write(data);
			}
		});
	});
});
