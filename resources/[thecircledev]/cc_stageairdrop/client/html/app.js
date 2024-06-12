var audioPlayer = null;

$(function () {
  window.addEventListener(
    "message",
    function (event) {
      var item = event.data;

      var people = $(".board-people");
      var gang = $(".board-gang");
      var family = $(".board-family");
      if (item.ShowMenu === "startall") {
        people.fadeIn();
        gang.fadeIn();
        family.fadeIn();
        document.getElementById("text-gang").innerHTML =
          'พิมพ์ <span style="color: black">/sad</span> เพื่อเข้าร่วม';
        document.getElementById("text-people").innerHTML =
          'พิมพ์ <span style="color: black">/sad</span> เพื่อเข้าร่วม';
        document.getElementById("text-family").innerHTML =
              'พิมพ์ <span style="color: black">/sad</span> เพื่อเข้าร่วม';
        $("#time-gang").html("<div><span>" + item.timegang + "</span></div>");
        $("#time-people").html(
          "<div><span>" + item.timepeople + "</span></div>"
        );
        $("#time-family").html(
          "<div><span>" + item.timefamily + "</span></div>"
        );
      }

      if (item.ShowMenu === "gang") {
        gang.fadeIn();
        document.getElementById("text-gang").innerHTML =
          'พิมพ์ <span style="color: black">/sad</span> เพื่อเข้าร่วม';
        $("#time-gang").html("<div><span>" + item.time + "</span></div>");
      }

      if (item.ShowMenu === "people") {
        people.fadeIn();
        document.getElementById("text-people").innerHTML =
          'พิมพ์ <span style="color: black">/sad</span> เพื่อเข้าร่วม';
        $("#time-people").html("<div><span>" + item.time + "</span></div>");
      }

      if (item.ShowMenu === "family") {
          family.fadeIn();
          document.getElementById("text-family").innerHTML =
              'พิมพ์ <span style="color: black">/sad</span> เพื่อเข้าร่วม';
          $("#time-family").html("<div><span>" + item.time + "</span></div>");
      }

      //   if (item.ShowMenu === "people") {
      //     people.fadeIn();
      //     document.getElementById("text-people").innerHTML =
      //       "เตรียมตัวใน 1 นาที พร้อมลุย !";
      //     $("#time-people").html(
      //       "<h4  style='margin-top: 3px;display: inline;'>ใน " +
      //         "<span class='timetextcolor-ppl'>" +
      //         item.time +
      //         "</span> นาที</h4>"
      //     );
      //   }

      if (item.hideMenu === "people") {
        people.fadeOut();
      }

      if (item.hideMenu === "gang") {
        gang.fadeOut();
      }

        if (item.hideMenu === "family") {
            family.fadeOut();
        }


        if (item.ShowMenu === "stopall") {
        people.fadeOut();
        gang.fadeOut();
        family.fadeOut();
      }

      if (event.data.Type === "playSound") {
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
