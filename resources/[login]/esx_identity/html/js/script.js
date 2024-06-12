let sexValue = "";

function changeBackground(label) {
  const labels = document.querySelectorAll("label");

  labels.forEach((otherLabel) => {
    otherLabel.classList.remove("bg-gradient");
  });

  label.classList.add("bg-gradient");
  sexValue = label.getAttribute("value");
}

$(document).ready(function (locales) {
  // console.log("we are done is ready");
  $.post("https://esx_identity/ready", JSON.stringify({}));


  window.addEventListener("message", function (event) {
    if (event.data.type === "enableui") {
      event.data.enable ? $("body").fadeIn() : $("body").fadeOut();
    }
  });


  $("#register-circle").submit(function (event) {
    event.preventDefault();
    $.post(
      "https://esx_identity/register",
      JSON.stringify({
        firstname: $("#firstname").val(),
        lastname: $("#lastname").val(),
        dateofbirth: $("#dateofbirth").val(),
        sex: sexValue,
        height: $("#height").val(),
      })
    );

    // $("#register").trigger("reset");
  });
});
