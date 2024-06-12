// Created By.JackZee
var sound_effect = document.getElementById("sound-effect");
$(function() {
  window.addEventListener("message", function(event) {
    var item = event.data;
    if (item !== undefined) {
      if (item.type == "ui") {
        if (item.display == true) {
          $("body").fadeIn();
        } else {
          $("body").fadeOut();
        }
      } else if (item.type == "update") {
        $("#id").html(item.my_id);
        $("#phone").html(item.my_phonenmumber);
        $("#name").html(item.my_fullname);
        // $("#job").html(item.my_job);
		$("#job").html(item.my_jobb);
        // $("#Ping").html(item.my_ping);
        // $("#PL").html(item.players);
        $("#player-count").html(item.players);
        $("#medic-count").html(item.ems);
        // $("#F").html(item.chef);
        getCashPoint(item.token)
      }
    }
  });
});

function getCashPoint(authToken) {
  const api = "https://mongkol.dev/api/cash-shop/users";
  const headers = {
    // 'Host': 'https://circleproject.dev',
    // 'Origin': 'https://tx.circleproject.dev',
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    // 'Access-Control-Request-Method' : 'GET',
    // 'Access-Control-Request-Headers': 'Authorization',
    // 'Referer': 'https://tx.circleproject.dev',
    Authorization: `Bearer ${authToken}`,
  };
  axios
      .get(api, {
        headers: headers,
      })
      .then(async function (response) {
        let point = parseInt(response.data.point);
        point = point.toLocaleString("en-US");
        $("#c-point").html(point);
      })
      .catch(function (error) {
        console.log(JSON.stringify(error));
      });
}