const alphabet = ["Q", "W", "E", "A", "S", "D"];
const numberic = ["1", "2", "3", "4", "5"];
const whiteSpace = [" "];
let valid_keys;
let chooseGame;
let gameType = "whitespace";
let canvas = document.getElementById("canvas");
let ctx = canvas.getContext("2d");

let W = canvas.width;
let H = canvas.height;
let degrees = 0;
let new_degrees = 0;
let time = 8;
let color = "#ffffff";
let bgcolor = "#0000007F";
let bgcolor2;
let key_to_press;
let g_start, g_end;
let animation_loop;
let alpha;

let needed = 4;
let streak = 0;
let allowedFailures;
let failuresCount = 0;

const colorsBackground = [
  // สีแดง
  "#e51c23",
  "#e84e40",
  "#e51c23",
  "#d01716",
  "#c41411",
  "#b0120a",
  // สีชมพู
  "#e91e63",
  "#f06292",
  "#ec407a",
  "#e91e63",
  "#d81b60",
  // สีม่วง
  "#9c27b0",
  "#ba68c8",
  "#ab47bc",
  "#9c27b0",
  // สีม่วงเข้ม
  "#673ab7",
  "#9575cd",
  "#7e57c2",
  "#673ab7",
  // สีเขียว
  "#259b24",
  "#42bd41",
  "#2baf2b",
  "#259b24",
  // สีเขียวอ่อน
  "#8bc34a",
  "#aed581",
  "#9ccc65",
  "#8bc34a",
  // สีเขียวมะนาว
  "#cddc39",
  "#dce775",
  "#d4e157",
  "#cddc39",
  // สีเหลือง
  "#ffeb3b",
  "#fff176",
  "#ffee58",
  "#ffeb3b",
  // สีเหลืองอมส้ม
  "#ffc107",
  "#ffd54f",
  "#ffca28",
  "#ffc107",
  // สีส้ม
  "#ff9800",
  "#ffb74d",
  "#ffa726",
  "#ff9800",
  // สีส้มเข้ม
  "#ff5722",
  "#ff8a65",
  "#ff7043",
  "#ff5722",
];

function getRandomColorFromArray(colorArray) {
  const randomIndex = getRandomInt(0, colorArray.length - 1);
  return colorArray[randomIndex];
}

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1) + min); //The maximum is inclusive and the minimum is inclusive
}

function init() {
  // Clear the canvas every time a chart is drawn
  ctx.clearRect(0, 0, W, H);

  // Function to draw arcs with shadow
  function drawArcWithShadow(
    x,
    y,
    radius,
    startAngle,
    endAngle,
    strokeStyle,
    lineWidth,
    shadowColor
  ) {
    ctx.beginPath();
    ctx.arc(x, y, radius, startAngle, endAngle, false);
    ctx.strokeStyle = strokeStyle;
    ctx.lineWidth = lineWidth;
    ctx.shadowColor = shadowColor;
    ctx.shadowBlur = 10;
    ctx.stroke();
    ctx.shadowColor = "transparent"; // Reset shadow after drawing
  }

  // Background 360 degree arc
  drawArcWithShadow(
    W / 2,
    H / 2,
    100,
    0,
    Math.PI * 2,
    bgcolor,
    20,
    "rgba(0, 0, 0, 0.2)"
  );

  // Green zone
  drawArcWithShadow(
    W / 2,
    H / 2,
    100,
    g_start - (90 * Math.PI) / 180,
    g_end - (90 * Math.PI) / 180,
    bgcolor2,
    20,
    "rgba(0, 0, 0, 0.2)"
  );

  // Angle in radians = angle in degrees * PI / 180
  let radians = (degrees * Math.PI) / 180;
  drawArcWithShadow(
    W / 2,
    H / 2,
    100,
    0 - (90 * Math.PI) / 180,
    radians - (90 * Math.PI) / 180,
    color,
    20,
    "rgba(0, 0, 0, 0.2)"
  );

  // Adding the key_to_press
  ctx.fillStyle = color;
  if (gameType === "whitespace") {
    ctx.font = "900 50px sans-serif";
  } else {
    ctx.font = "900 100px sans-serif";
  }

  let keyText = key_to_press === " " ? "Space" : key_to_press;
  let textWidth = ctx.measureText(keyText).width;
  let textY = gameType === "whitespace" ? H / 2 + 20 : H / 2 + 35;

  // Apply shadow to text
  ctx.shadowColor = "rgba(0, 0, 0, 0.2)";
  ctx.shadowBlur = 10;
  ctx.fillText(keyText, W / 2 - textWidth / 2, textY);
  ctx.shadowColor = "transparent"; // Reset shadow after drawing
}

async function draw(time) {
  if (typeof animation_loop !== undefined) clearInterval(animation_loop);
  bgcolor2 = getRandomColorFromArray(colorsBackground);
  g_start = getRandomInt(25, 50) / 10;
  g_end = getRandomInt(4, 7) / 10;
  g_end = g_start + g_end;

  degrees = 0;
  new_degrees = 360;

  key_to_press = await selectKeyToPress(gameType);
  // console.log("time : ", time);
  animation_loop = setInterval(animate_to, time);
}

async function selectKeyToPress(gameType) {
  switch (gameType) {
    case "alphabet":
      return alphabet[getRandomInt(0, alphabet.length - 1)]; // Random alphabet letter
    case "numberic":
      return numberic[getRandomInt(0, numberic.length - 1)]; // Random alphabet letter
    case "whitespace":
      return whiteSpace[getRandomInt(0, whiteSpace.length - 1)]; // Random alphabet letter
    default:
      return alphabet[getRandomInt(0, alphabet.length - 1)]; // Random alphabet letter
  }
}

function animate_to() {
  if (degrees >= new_degrees) {
    wrong();
    return;
  }
  degrees += 2.0;
  init();
}

function correct() {
  streak += 1;
  successSound();
  if (streak == needed) {
    clearInterval(animation_loop);
    endGame(true);
    failuresCount = 0;
  } else {
    draw(8);
  }
}

function wrong() {
  failureSound();
  failuresCount += 1;
  if (allowedFailures < failuresCount) {
    clearInterval(animation_loop);
    endGame(false);
    failuresCount = 0;
    return;
  }
  draw(8);
}

document.addEventListener("keydown", function (ev) {
  let key_pressed = ev.key;
  if (gameType === "alphabet") {
    // console.log(key_pressed)
    key_pressed = key_pressed.toUpperCase();
    // console.log(key_pressed)
  }
  if (valid_keys.includes(key_pressed)) {
    if (key_pressed === key_to_press) {
      let d_start = (180 / Math.PI) * g_start;
      let d_end = (180 / Math.PI) * g_end;
      if (degrees < d_start) {
        wrong();
      } else if (degrees > d_end) {
        wrong();
      } else {
        correct();
      }
    } else {
      wrong();
    }
  }
});

function startGame(time) {
  $("#canvas").show();
  draw(time);
}

function endGame(status) {
  $("#canvas").hide();
  var xhr = new XMLHttpRequest();
  let u = "fail";
  if (status) u = "success";
  xhr.open("POST", `https://cc_minigame/${u}`, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.send(JSON.stringify({}));
  streak = 0;
  needed = 4;
}

window.addEventListener("message", async (event) => {
  if (event.data.action === "start") {
    if (event.data.value !== null) {
      needed = event.data.value;
    }
    if (event.data.time !== null) {
      time = event.data.time;
    }
    if (event.data.failure !== null) {
      allowedFailures = event.data.failure;
    }
    if (event.data.gameType !== null) {
      gameType = event.data.gameType;
      chooseGame = await selectGame(gameType);
      valid_keys = chooseGame;
    }
    // console.log(event.data.gameType)
    // console.log(event.data.failure)
    // console.log(event.data.time)
    startGame(8);
  }
});

// startGame(time)

async function selectGame(gameType) {
  switch (gameType) {
    case "alphabet":
      return alphabet;
    case "whitespace":
      return whiteSpace;
    case "numberic":
      return numberic;
    default:
      return alphabet;
  }
}

function successSound() {
  const sound = new Audio("sounds/click_success.mp3");
  sound.play();
}

function failureSound() {
  const sound = new Audio("sounds/click_failed.mp3");
  sound.play();
}
