let Config = {};
let allColor = null;
Config.closeKeys = [27, 90];
let airdropType = null;
let allGang;

function handleClick(gangName) {
    console.log(gangName)
  axios
      .post("https://cc_stageairdrop/openSelectUIAirdrop", {
        color: gangName,
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

async function initGang(){
    const sortedKeys = Object.keys(allGang).sort((a, b) => {
        return allGang[a].group.localeCompare(allGang[b].group);
    });

// Iterating over sorted keys
    for (let key of sortedKeys) {
        if (allGang.hasOwnProperty(key)) {
            const item = allGang[key];
            document.getElementById("gang-grid").innerHTML +=
                `
          <button
            onclick="handleClick('${key}')"
            onmouseover="playHoverSound()"
            class="bg-[${item.color}]/[0.5] w-[20vh] h-[20vh] rounded-[1vh] flex justify-center items-center"
            style="box-shadow: 0px 0px 4px rgba(0, 0, 0, 0.5)"
          >
            <img class="w-full h-full" src="img/${item.logo}" /> 
          </button>
      `
        }
    }
}

function playHoverSound() {
  let hoverSound = document.getElementById("hoverSound");
  hoverSound.volume = 0.35;
  hoverSound.muted = false;
  hoverSound.play();
}


window.addEventListener("message", async function (event) {
  let res = event.data;
  document.getElementById("gang-grid").innerHTML = ""
  if (res.action === "open") {
        allGang = res.dataPlayer
        airdropType = res.airdropType;
        await initGang();
        $("body").fadeIn();
        return;
  }
  if (res.action === "closeAll"){
      allGang = null;
      airdropType = null;
      $("body").fadeOut();
  }
});

function closeUI() {
    $.post("https://cc_uiairdrop_gang/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeUI();
        }
    });
});

