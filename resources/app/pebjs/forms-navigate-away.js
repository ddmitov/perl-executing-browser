
var formSubmitted = false;

// It is necessary to prevent navigate away confirmation when form is being submitted.
function submitFunction() {
  formSubmitted = true;
}

// Navigate away confirmation -
// it will be trigered only if form is not being submitted:
$(window).on("beforeunload", function() {
  if (formSubmitted == false) {
    var textEntered = "";

    var textFields = [];
    textFields = document.getElementsByTagName("textarea");

    for (index = 0; index < textFields.length; index++) {
      if (textFields[i].value.length > 0) {
        textEntered = "yes";
      }
    }

    var inputBoxes = [];
    inputBoxes = document.querySelectorAll("input[type=text]");

    for (index = 0; index < inputBoxes.length; index++) {
      if (inputBoxes[index].value.length > 0) {
        textEntered = "yes";
      }
    }

    if (textEntered == "yes") {
      return "Text was entered in a form and it is going to be lost!\n" +
              "Are you sure you want to leave this page?";
    }
  }
});
