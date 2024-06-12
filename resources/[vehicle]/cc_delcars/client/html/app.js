var audioPlayer = null;

$(function () {
  window.addEventListener(
    "message",
    function (event) {
      var item = event.data;
      var boxaction = $(".board");

      if (item.ShowMenu == true) {
        boxaction.fadeIn();
        $("#text-1").html(
          "<h4 class='timetext'><span class='timetextcolor'>" +
            item.text1 +
            "</span></h4>"
        );
      } else {
        boxaction.fadeOut();
      }

      if (event.data.Type == "playSound") {
        if (audioPlayer != null) {
          audioPlayer.pause();
        }

        audioPlayer = new Audio("./sounds/" + event.data.File);
        audioPlayer.volume = event.data.Volume;
        audioPlayer.play();
      }
    },
    false
  );
});
