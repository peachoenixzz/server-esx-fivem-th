function pad(str) {
  str = str.toString();
  return str.length < 2 ? pad("0" + str, 2) : str;
}
$(function () {
  window.addEventListener("message", function (event) {
    var item = event.data;

    if (item !== undefined) {
      // if (item.id !== undefined) {
      //   $("#myid").html(item.id)
      // }
      if (item.transactionType == "playSound") {

        audioPlayer = new Audio("./sounds/" + event.data.transactionFile + ".mp3");
        audioPlayer.volume = event.data.transactionVolume;
        audioPlayer.play();
      }
      if (item.type !== undefined) {
        var minutes = pad(Math.floor(item.time / 60));
        var seconds = pad(item.time - minutes * 60);
        var _thistime = minutes + ":" + seconds
        if (item.type == 1) {
          if (item.Detail == 'run') {
            $("#main-container").html(`<div class="col displayzc" id="tem">
            <div class="row" id="maintext">
              <h5 id="text"> กิจกรรมไตรกีฬา  <span class="colortext">` + _thistime + `</span> นาที</h5>
            </div>
            </div>
            <div class="row" id="maintext2" style="margin-top: 140px;">
            <h6 id="buttonXtext">กด <button><b>G</b></button> เพื่อเข้าร่วม</h6>&nbsp;&nbsp;
            <h6 id="buttonXtext">กด <button><b>X</b></button> เพื่อยกเลิก</h6>
            </div>`
            );
          } else if (item.Detail == 'start') {
            $("#main-container")
              .animate({ "margin-top": "0%" }, "slow");
          } else if (item.Detail == 'end') {
            $("#main-container")
              .animate({ "margin-top": "-15%" }, "slow");
          }
        } else if (item.type == 2) {
          if (item.Detail == 'run') {
            var minutes = pad(Math.floor(item.time / 60));
            var seconds = pad(item.time - minutes * 60);
            var _thistime = minutes + ":" + seconds
            $("#main-container").html(`<div class="col displayzc" id="tem" style="padding: 0px;">
            <div class="row" id="maintext" style="padding: 0px;">
              <h5 id="text"> Checkpoint  <span class="colortext">`+ item.poin + `</span>/<span class="colortext">` + item.endpoin + `</span></h5>
            </div>
            <div class="row" id="maintext" style="padding: 0px;">
              <h6 id="text"> กิจกรรมไตรกีฬา  <span class="colortext"> `+ _thistime + `</span> นาที</h6>
            </div>
          </div>
          <div class="row" id="maintext2" style="margin-top: 135px;font-size: 12px;">
            <span id="buttonXtext">กด <button style="padding: 0px 12px;">G</button> เพื่อกลับไปยัง Checkpoin ล่าสุด</span>&nbsp;&nbsp;&nbsp;&nbsp;
            <span id="buttonXtext">พิม <button style="padding: 0px 12px;">/exit</button> เพื่อออกจากกิจกรรม</span>
          </div>  `
            );
          } else if (item.Detail == 'start') {
            $("#main-container")
              .animate({ "margin-top": "-2%" }, "slow");
          } else if (item.Detail == 'end') {
            $("#main-container")
              .animate({ "margin-top": "-15%" }, "slow");
          }

        } else if (item.type == 3) {
          if (item.Detail == 'run') {
            var minutes = pad(Math.floor(item.time / 60));
            var seconds = pad(item.time - minutes * 60);
            var _thistime = minutes + ":" + seconds
            $("#main-container").html(`<div class="col displayzc" id="tem" style="padding: 0px;">
          <div class="row" id="maintext" style="padding: 0px;">
            <h5 id="text"> Checkpoint  <span class="colortext">`+ item.poin + `</span>/<span class="colortext">` + item.endpoin + `</span></h5>
          </div>
          <div class="row" id="maintext" style="padding: 0px;">
            <h6 id="text"> กิจกรรมไตรกีฬาจะจบลงใน <span class="colortext"> `+ _thistime + `</span> นาที</h6>
          </div>
        </div>
        <div class="row" id="maintext2" style="margin-top: 135px;font-size: 12px;">
          <span id="buttonXtext">กด <button style="padding: 0px 12px;">G</button> เพื่อกลับไปยัง Checkpoin ล่าสุด</span>&nbsp;&nbsp;&nbsp;&nbsp;
          <span id="buttonXtext">พิม <button style="padding: 0px 12px;">/exit</button> เพื่อออกจากกิจกรรม</span>
        </div>  `
            );
          } else if (item.Detail == 'start') {
            $("#main-container")
              .animate({ "margin-top": "-2%" }, "slow");
          } else if (item.Detail == 'end') {
            $("#main-container")
              .animate({ "margin-top": "-15%" }, "slow");
          }
        }
      }

    }
  });
});
// $("#detail").remove();
// $("#chartBar").append('<canvas id="detail"><canvas>');
