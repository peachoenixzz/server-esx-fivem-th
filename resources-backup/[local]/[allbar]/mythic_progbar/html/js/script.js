/* Edited by Dojwun#8480 -- (NoPixel Inspired) */

$("document").ready(function () {
  MythicProgBar = {};

  MythicProgBar.Progress = function (data) {
    $(".progress-container").css({ display: "block" });
    $("#progress-label").text(data.label);
    $("#progress-bar")
      .stop()
      .css({ width: 0, "background-color": "#rgba(80,135,177,0.0);" })
      .animate(
        {
          width: "100%",
        },
        {
          duration: parseInt(data.duration),
          complete: function () {
            $(".progress-container").css({ display: "none" });
            $("#progress-bar").css("width", 0);
            $.post("http://mythic_progbar/actionFinish", JSON.stringify({}));
          },
        }
      );
  };

  MythicProgBar.ProgressCancel = function () {
    $(".progress-container").css({ display: "block" });
    $("#progress-label").text("CANCELLED");
    $("#progress-bar")
      .stop()
      .css({ width: "100%", "background-color": "#rgba(80,135,177,0.0);" });

    setTimeout(function () {
      $(".progress-container").css({ display: "none" });
      $("#progress-bar").css("width", 0);
      $.post("http://mythic_progbar/actionCancel", JSON.stringify({}));
    }, 10);
  };

  MythicProgBar.CloseUI = function () {
    $(".progress-container").css({ display: "none" });
    $(".character-box").removeClass("active-char");
    $(".character-box").attr("data-ischar", "false");
    $("#delete").css({ display: "none" });
  };

  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "mythic_progress":
        MythicProgBar.Progress(event.data);
        break;
      case "mythic_progress_cancel":
        MythicProgBar.ProgressCancel();
        break;
    }
  });
});
