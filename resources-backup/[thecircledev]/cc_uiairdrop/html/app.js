let Config = {};
let allColor = null;
Config.closeKeys = [27, 90];
let airdropType = null;
let data = [
  {
    color: "red",
    number: 0,
  },
  {
    color: "black",
    number: 0,
  },
  {
    color: "green",
    number: 0,
  },
  {
    color: "white",
    number: 0,
  },
  {
    color: "blue",
    number: 0,
  },
];

async function checkFull() {
  data.forEach((item) => {
    let text = document.getElementById("text-" + item.color);
    let pic = document.getElementById("pic-" + item.color);
    if (item.number === 15) {
      text.innerHTML = '<img class="w-[6vh] h-[6vh]" src="img/close_1.png" />';
      pic.src = "img/" + item.color + "_blank.png";
    } else {
      text.textContent = item.number;
    }
  });
}

function handleClick(color) {
  console.log(color);
  axios
    .post("https://cc_stageairdrop/openSelectUIAirdrop", {
      color: color,
      airdropType: airdropType,
    })
    .then((response) => {
      const status = response.data;
      console.log(status);
      if (status) {
        closeUI();
      }
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

function playHoverSound() {
  let hoverSound = document.getElementById("hoverSound");
  hoverSound.volume = 0.35;
  hoverSound.muted = false;
  hoverSound.play();
}

window.addEventListener("message", async function (event) {
  let res = event.data;
  if (res.action === "open") {
    allColor = res.allColor;
    airdropType = res.airdropType;
    await handleUI();
    await checkFull();
    $("body").fadeIn();
  }

  if (res.action === "closeAll") {
    $("body").fadeOut();
  }
});

function handleUI() {
  //bad logic
  data.forEach((item) => {
    const color = item.color;
    item.number = allColor[color];
    document.getElementById(`pic-${color}`).innerHTML = allColor[color];
  });
}

function closeUI() {
  $.post("https://cc_uiairdrop/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});
