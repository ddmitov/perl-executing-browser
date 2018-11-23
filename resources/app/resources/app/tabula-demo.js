var baseUrl = "ws://" + window.location.host;

var interactiveWebSocket;
interactiveWebSocket = new WebSocket(baseUrl + '/interactive');

var nonInteractiveWebSocket;
nonInteractiveWebSocket = new WebSocket(baseUrl + '/noninteractive');

var resizerWebSocket;
resizerWebSocket = new WebSocket(baseUrl + '/jpg_resizer');

$(document).ready(function() {
  if (!('WebSocket' in window)) {
    alert('Your browser does not support WebSockets!');
    return;
  }

  $('#interactive-input').keypress(function(event) {
    if (event.which == 13) {
      event.preventDefault();
      sendDataToInteractiveScript();
    }
  });

  interactiveWebSocket.onmessage = function(event) {
    var data = event.data;

    if (data.indexOf('file://') >= 0) {
      $('#interactive-file').html('Last file: ' + data.replace('file://', ''));
    }

    if (data.indexOf('file://') < 0) {
      $('#interactive-data').html(data);
    }
  };

  interactiveWebSocket.onclose = function(event) {
    $('#container').html('<br>Tabula local server is stopped. Close this window.');
  }

  nonInteractiveWebSocket.onopen = function(event) {
    nonInteractiveWebSocket.send('Hello from a non-interactive script!');
  };

  nonInteractiveWebSocket.onmessage = function(event) {
    var data = event.data;
    $('#noninteractive').html(data);
  };

  resizerWebSocket.onmessage = function(event) {
    var data = event.data;

    $('#resizer-output').html(data);
    $('#resizer-stop-button').css({'visibility':'visible'});
    window.scrollTo(0, document.body.scrollHeight);

    if (data.indexOf('Resizing successfully completed') >= 0) {
      $('#resizer-stop-button').css({'visibility':'hidden'});
    }
  };
});

function sendDataToInteractiveScript() {
  var input = $('#interactive-input');
  interactiveWebSocket.send(input.val());
  input.val('');
}

function selectFileForInteractiveScript() {
  interactiveWebSocket.send('_select_file_');
}

function selectResizerDirectory() {
  resizerWebSocket.send('_select_directory_');
  $('#resizer-message').html('');
}

function killResizerScript() {
  resizerWebSocket.send('_kill_');

  $('#resizer-message').html('Resizer killed!');
  $('#resizer-stop-button').css({'visibility':'hidden'});
}
