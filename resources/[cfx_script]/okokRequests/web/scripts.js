var darkMode = true; // false = light mode, true = dark mode
var selectedWindow = "none";

window.addEventListener("message", function (event) {
  if (darkMode == true) {
    $(".request .card-body").css("background-color", "rgba(0, 0, 0, 0.5)");
    $(".request .card-body").css("color", "rgba(160, 160, 160, 1)");
    $(".request #title").css("color", "#fff");
    $("#switchbtn").removeClass("switchbtn_labelc1");
    $("#switchbtn").addClass("switchbtn_labelc2");
    $(".blockrequest .card-body").css("background-color", "rgba(0, 0, 0, 0.5)");
    $(".blockrequest .card-body").css("color", "rgba(110, 113, 121, 0.5)");
    $(".blockrequest #titleblock").css("color", "#fff");
  }
});

// Windows
window.addEventListener("message", function (event) {
  switch (event.data.action) {
    case "open":
      $("#title").html(event.data.title);
      $("#message").html(event.data.message);
      selectedWindow = "request";
      $(".request").fadeIn();
      break;
    case "openblock":
      if (event.data.status == "enabled") {
        $("#status").prop("checked", true);
      } else if (event.data.status == "disabled") {
        $("#status").prop("checked", false);
      }

      $(".blockrequest").fadeIn();
      selectedWindow = "blockRequest";
      break;
    case "close":
      $(".request").fadeOut();
      $(".blockrequest").fadeOut();
      selectedWindow = "none";
      break;
  }
});

// Close ESC Key
$(document).ready(function () {
  document.onkeyup = function (data) {
    if (data.which == 27) {
      switch (selectedWindow) {
        case "request":
          $(".request").fadeOut();
          $(".blockrequest").fadeOut();
          $.post(
            "https://okokRequests/action",
            JSON.stringify({
              action: "closeEsc",
            })
          );
          selectedWindow = "none";
          break;
        case "blockRequest":
          $(".request").fadeOut();
          $(".blockrequest").fadeOut();
          $.post(
            "https://okokRequests/action",
            JSON.stringify({
              action: "closeBlockEsc",
            })
          );
          selectedWindow = "none";
          break;
      }
    }
  };
});

// Button Actions
// $(document).on("click", "#acceptRequest", function () {
//   $(".request").fadeOut();
//   $(".blockrequest").fadeOut();

//   $.post(
//     "https://okokRequests/action",
//     JSON.stringify({
//       action: "acceptRequest",
//     })
//   );
// });

$(document).on("keypress", function (event) {
  if (event.key.toLowerCase() === "z") {
    $(".request").fadeOut();
    $(".blockrequest").fadeOut();
    $.post(
      "https://okokRequests/action",
      JSON.stringify({
        action: "acceptRequest",
      })
    );
  }
});

// $(document).on("click", "#declineRequest", function () {
//   $(".request").fadeOut();
//   $(".blockrequest").fadeOut();

//   $.post(
//     "https://okokRequests/action",
//     JSON.stringify({
//       action: "declineRequest",
//     })
//   );
// });

$(document).on("keypress", function (event) {
  if (event.key.toLowerCase() === "x") {
    $(".request").fadeOut();
    $(".blockrequest").fadeOut();

    $.post(
      "https://okokRequests/action",
      JSON.stringify({
        action: "declineRequest",
      })
    );
  }
});

$(document).on("click", "#saveBlockRequest", function () {
  var status;

  if ($("#status").is(":checked")) {
    status = "enabled";
  } else {
    status = "disabled";
  }

  $(".request").fadeOut();
  $(".blockrequest").fadeOut();

  $.post(
    "https://okokRequests/action",
    JSON.stringify({
      action: "saveBlockRequest",
      status: status,
    })
  );
});

$(document).on("click", "#closeBlockRequest", function () {
  $(".request").fadeOut();
  $(".blockrequest").fadeOut();

  $.post(
    "https://okokRequests/action",
    JSON.stringify({
      action: "closeBlockRequest",
    })
  );
});
