

// Functions to handle actions

let tips = [
  "เปลี่ยนชื่อ Steam ให้ตรงกับชื่อในบัตรประชาชน [IC]",
  "รบกวนผู้เล่นที่เป็นแก๊งและหน่วยงานอย่าลืมใส่ Tag หน้าชื่อของท่าน",
  "หากพบผู้กระทำผิด สามารถติดต่อทีมงานในห้องแจ้งปัญหาได้ทันที",
  "ผู้เล่นจะต้องมี Overlay หรือภาพหลักฐานทุกครั้งในการแจ้งปัญหากับทางทีมงาน",
  "ผู้เล่นสามารถเปิด Cash Shop (F10) เพื่อเลือกซื้อของต่าง ๆ",
  "หลังจากซื้อของที่ Cash Shop กรุณารอ 1-3 นาที",
  "การเติมแต้ม Gold สามารถเติมตลอดเวลา ทีมงานจะเริ่มแอดให้ตั้งแต่เวลา 17.00 - 00.00น.",
  "สามารถพิมพ์/autopilot เพื่อไปยังจุดหมายที่ Marker ไว้บนแผนที่ได้",
  "สามารถพิมพ์ /selectmap เพื่อเปลี่ยนรูปแบบแผนที่ได้",
  "การโอนสิทธิยานพาหนะ ผู้เล่นจะต้องมีบัตรโอนรถตั้งสองคน",
  "อุปกรณ์การทำงานทั้งหมดมีโอกาสแตก และทุกครั้งที่แตกมีโอกาสเลือดลดลงเล็กน้อย",
  "ผู้เล่นสามารถกด F12 ถ่ายภาพขณะยังมีชีวิต เพื่อใช้เป็นหลักฐานดำเนินคดีได้"
];
let currentTip = 0;
let tipInterval;


startInterval(); // Start the interval when the script loads
updateTip(); // Initialize with the first tip

function updateTip() {
  document.getElementById('tip-content').innerText = tips[currentTip];
}

function startInterval() {
  tipInterval = setInterval(function() {
    currentTip = (currentTip + 1) % tips.length;
    updateTip();
  }, 5000); // Change tips every 5000 milliseconds (5 seconds)
}

function stopInterval() {
  clearInterval(tipInterval);
}

document.getElementById('next-tip').addEventListener('click', function() {
  stopInterval();
  currentTip = (currentTip + 1) % tips.length;
  updateTip();
  startInterval();
});

document.getElementById('prev-tip').addEventListener('click', function() {
  stopInterval();
  currentTip = (currentTip - 1 + tips.length) % tips.length;
  updateTip();
  startInterval();
});

const hideLoginPanel = () => {
  $("body").fadeOut();
};

const enableLoginButton = () => {
  const playBtn =  document.getElementById("play-button");
  playBtn.classList.add("bg-color");
  playBtn.textContent = "PLAY";
  playBtn.disabled = false;
};

const toggleMuteVideo = (mute) => {
  const video =  document.getElementById("video");
  video.muted = mute;
};

// Listen for messages from other windows or frames
window.addEventListener("message", (event) => {
  const { action } = event.data;
  switch (action) {
    case "hideLoginPanel":
      hideLoginPanel();
      break;
    case "enableLoginButton":
      enableLoginButton();
      break;
    case "unmutedVideo":
      toggleMuteVideo(false);
      break;
    default:
      console.warn(`Unknown action: ${action}`);
  }
});

// Initialize login button click event
document.getElementById("play-button").addEventListener("click", () => {
  toggleMuteVideo(true); // Mute the video when the login button is clicked

  axios.post("https://cc_authlogin/login", {})
      .then(response => {
        // Handle successful login
      })
      .catch(error => {
        console.error("Login failed:", error);
      });
});

// Handle spacebar keydown event to toggle mute
document.addEventListener("keydown", (event) => {
  if (event.keyCode === 32) { // 32 is the keycode for the spacebar
    const video =  document.getElementById("video");
    toggleMuteVideo(!video.muted);
  }
});
