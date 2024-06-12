
let configColor = [
  {
    "dizzy": {
      "color_gradient_top": "#7b7836",
      "color_gradient_bottom": "#66652a"
    },
    "in_jail": {
      "color": "#003fd4"
    },
    "block_pick_basic_drug": {
      "color": "#5500d4"
    },
    "bounty_hunter": {
      "color": "#ff0000"
    },
    "eco_x2": {
      "color": "#000000"
    },
    "mining_x2": {
      "color": "#000000"
    },
    "auto_farm": {
      "color": "#000000"
    },
    "unlimit_bag": {
      "color": "#000000"
    },
    "adrenaline": {
      "color": "#000000"
    },
    "adrenaline_gov": {
      "color": "#000000"
    },
    "fever_time_event": {
      "color": "#ffcc00"
    },
    "blessing_bell": {
      "color": "#ffcc00"
    }
  }
]


window.addEventListener("message", async function (event) {
  let res = event.data;
  if (res.action === "update") {
    updateEffect(res.effectName, res.currentTime, res.effectType,res.image);
  }
  if (res.action === "delete"){
    deleteEffect(res.effectName)
  }
});

function deleteEffect(effectName){
  const effectID = document.getElementById(effectName);
  if (effectID !== null) {
    effectID.remove();
  }
}

function updateEffect(effectName, currentTime, effectType, image) {
  const effectID = document.getElementById(effectName);
  // console.log("image",image)
  let topColor
  let bottomColor

  for (let i = 0; i < configColor.length; i++) {
    const object = configColor[i];
    const keys = Object.keys(object);

    for (let j = 0; j < keys.length; j++) {
      const key = keys[j];
      const value = object[key];

      if (value && typeof value === "object" && "color_gradient_top" in value && "color_gradient_bottom" in value) {
         topColor = value.color_gradient_top;
         bottomColor = value.color_gradient_bottom;
      }
    }
  }

  // console.log(effectName);
  // console.log(effectID);
  if (effectID === null) {
    // console.log("in undefi");
    if (effectType === "debuff") {
      // console.log("in debuff");
      let debuffColor

      for (let i = 0; i < configColor.length; i++) {
        const object = configColor[i];
        const keys = Object.keys(object);

        for (let j = 0; j < keys.length; j++) {
          const key = keys[j];
          const value = object[key];

          if (value && typeof value === "object" && "color" in value) {
            debuffColor = value.color;
          }
        }
      }

      document.getElementById("main-effect").innerHTML += `
            <div class="flex justify-end" id="${effectName}">
              <div
                class="block-content bg-[${debuffColor}]/[0.5] px-2 mt-1 rounded flex items-center"
                style="box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.7)"
              >
                <img src="img/${image}.png" class="w-[15px] h-[15px] mr-2" />
                <div id="${effectName}-time">${
        Math.floor(currentTime / 1000 / 60) + " นาที"
      }</div>
              </div>
            </div>`;
    }
    if (effectType === "debuff_player") {
      document.getElementById("main-debuff").innerHTML += `
                <div
                   id="${effectName}"
                  class="box-content bg-black/[0.5] w-[3vh] h-[3vh] rounded-lg relative flex items-center justify-center"
                  style="box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.7)"
          >
            <div
                    class="bg-gradient-to-b from-[${topColor}] to-[${bottomColor}] h-[100%] rounded-lg absolute bottom-0 left-0 right-0 z-10 smooth-height"
            ></div>
            <img src="img/${image}.png" class="relative z-20 w-[2vh] h-[2vh]" />
          </div>
      `
    }
    if (effectType !== "debuff" && effectType !== "debuff_player" ) {
      let debuffColor

      for (let i = 0; i < configColor.length; i++) {
        const object = configColor[i];
        const keys = Object.keys(object);

        for (let j = 0; j < keys.length; j++) {
          const key = keys[j];
          const value = object[key];

          if (value && typeof value === "object" && "color" in value) {
            debuffColor = value.color;
          }
        }
      }

      document.getElementById("main-effect").innerHTML += `
            <div class="flex justify-end" id="${effectName}">
              <div
                class="block-content bg-[${debuffColor}]/[0.5] px-2 mt-1 rounded flex items-center"
                style="box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.7)"
              >
                <img src="nui://nc_inventory/html/img/items/${image}.png" class="w-[20px] h-[20px] mr-2" />
                <div id="${effectName}-time">${Math.floor(currentTime / 1000 / 60) + " นาที"}</div>
              </div>
            </div>`;
    }
    // if (effectType !== "debuff" && currentTime <= 30000) {
    //     document.getElementById("main-effect").innerHTML += `
    //     <div class="flex justify-end" id="${effectName}">
    //       <div
    //         class="block-content bg-red-500/[0.5] px-2 mt-1 rounded flex items-center"
    //       >
    //         <img src="img/${image}.png" class="w-[15px] h-[15px] mr-2" />
    //         <div>${(currentTime / 1000) / 60} นาที</div>
    //       </div>
    //     </div>`
    // }
    return;
  }

  if (effectID && effectType !== "debuff_player") {
    document.getElementById(`${effectName}-time`).innerHTML = `${
      Math.floor(currentTime / 1000 / 60) + " นาที"
    }`;
  }
}

function updateClock() {
  let now = new Date();
  let month = (now.getMonth() + 1).toString().padStart(2, "0");
  let day = now.getDate().toString().padStart(2, "0");
  let hours = now.getHours().toString().padStart(2, "0");
  let minutes = now.getMinutes().toString().padStart(2, "0");
  let date = `${month}/${day} `;
  let time = `${hours}:${minutes} `;
  document.getElementById("datezone").innerHTML = date;
  document.getElementById("timezone").innerHTML = time;
}
setInterval(updateClock, 1000); // Update clock every second
