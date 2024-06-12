let id;
let hp;
$(document).ready(function () {
  window.addEventListener("message", function (event) {
    let data = event.data;
    let food = event.data.food;
    let isCombat = event.data.isCombat;
    let stress = event.data.stress;
    let health = event.data.health;
    if (data.hidestatusbar) {
      $("body").fadeOut();
      return;
    }

    checkUpdateAnimationLogo(health, isCombat, food, stress);

    $("body").fadeIn();

    if (id == null) {
      $("#player-id").html("ID: " + data.id);
    }

    if (Math.round(data.health) >= 100) {
      $("#heal-point").css("width", Math.round(data.health) + "%");
      $("#heal-point").removeClass("rounded-sm");
      $("#heal-point").addClass("rounded-sm");
    }
    if (Math.round(data.health) < 100) {
      $("#heal-point").css("width", Math.round(data.health) + "%");
      $("#heal-point").removeClass("rounded-sm");
      $("#heal-point").addClass("rounded-sm");
    }

    if (data.armor >= 100) {
      $("#armor").css("width", data.armor + "%");
      $("#armor").removeClass("rounded-sm]");
      $("#armor").addClass("rounded-sm");
    }
    if (data.armor < 100) {
      $("#armor").css("width", data.armor + "%");
      $("#armor").removeClass("rounded-sm");
      $("#armor").addClass("rounded-sm");
    }

    if (food >= 95) {
      $("#food").css("height", food + "%");
      $("#food").removeClass("rounded-b-md");
      $("#food").addClass("rounded-md");
    }

    if (food < 95) {
      $("#food").css("height", food + "%");
      $("#food").removeClass("rounded-md");
      $("#food").addClass("rounded-b-md");
    }

    // if (data.water >= 95) {
    //   $("#healthy").css("height", data.water + "%");
    //   $("#healthy").removeClass("rounded-b-md");
    //   $("#healthy").addClass("rounded-md");
    // }
    // if (data.water < 95) {
    //   $("#healthy").css("height", data.water + "%");
    //   $("#healthy").removeClass("rounded-md");
    //   $("#healthy").addClass("rounded-b-md");
    // }

    if (data.stress >= 95) {
      $("#stress").css("height", data.stress + "%");
      $("#stress").removeClass("rounded-b-md");
      $("#stress").addClass("rounded-md");
    }
    if (data.stress < 95) {
      $("#stress").css("height", data.stress + "%");
      $("#stress").removeClass("rounded-md");
      $("#stress").addClass("rounded-b-md");
    }

    if (data.dive >= 95) {
      $("#dive-box").hide();
      $("#dive").removeClass("rounded-b-md");
      $("#dive").addClass("rounded-md");
      $("#dive").css("height", data.dive + "%");
    } else if (data.dive < 95) {
      $("#dive-box").show();
      $("#dive").removeClass("rounded-md");
      $("#dive").addClass("rounded-b-md");
      $("#dive").css("height", data.dive + "%");
    }

    // if (data.food != -100){
    // 	$('#HungerPen').html(Math.round(data.food) + "%")
    // }else if(data.food == 0){
    // 	$('#HungerPen').html("0")
    // }
    //
    // if (data.water != -100){
    // 	$('#ThirstPen').html(Math.round(data.water) + "%")
    // }else if(data.water == 0){
    // 	$('#ThirstPen').html("0")
    // }

    // if (data.armor != -100){
    // 	$('#ArmorPen').html(Math.round(data.armor) + "%")
    // }else if(data.armor == 0){
    // 	$('#ArmorPen').html("0")
    // }

    // if (data.stress != -100){
    // 	$('#StressPen').html(Math.round(data.stress) + "%")
    // }else if(data.stress == 0){
    // 	$('#StressPen').html("0")
    // }
  });
});

function checkUpdateAnimationLogo(hpWidth, isCombat, food, stress) {
  const logoImage = document.getElementById("dragon-hp");

  if (isCombat) {
    logoImage.src = "img/mad.png";
    return
  }
  if (hpWidth <= 40) {
    logoImage.src = "img/injure.png";
    return
  }
  if (food <= 30) {
    logoImage.src = "img/hungry.png";
    return
  }
  if (stress > 70){
    logoImage.src = "img/dizzy.png";
    return
  }
  if (!isCombat){
    logoImage.src = "img/happy.png";
    return
  }
  if (hpWidth > 40) {
    logoImage.src = "img/happy.png";
  }
}

