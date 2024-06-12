let Config = {};
Config.closeKeys = [27, 90];
let globalItem = {};
function generateEconomy(type) {
  const container = document.getElementById("container-auto");
  let itemsHTML = "";
  const economyArray = type["economy"];
  if (economyArray) {
    economyArray.forEach((v) => {
      itemsHTML += `
      <button 
        class="bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.3] to-[#ffcc00]/[0.3] w-full h-[5vh] rounded-[0.8vh]"
        onclick="chooseAutoItem('${v.name}')"
        >
        ${v.label}
      </button>`;
    });
  }

  itemsHTML += `
    <button 
      class="bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.3] to-[#ffcc00]/[0.3] w-full h-[5vh] rounded-[0.8vh]" 
      onclick="backButton()"    
    >
      <
    </button>
  `;

  container.innerHTML = itemsHTML;
}

function generateMaterial(type) {
  const container = document.getElementById("container-auto");
  let itemsHTML = "";
  const economyArray = type["mining"];
  if (economyArray) {
    economyArray.forEach((v) => {
      itemsHTML += `
      <button 
          class="bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.3] to-[#ffcc00]/[0.3] w-full h-[5vh] rounded-[0.8vh]"
          onclick="chooseAutoItem('${v.name}')"
      >
        ${v.label}
      </button>`;
    });
  }

  itemsHTML += `
    <button 
      class="bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.3] to-[#ffcc00]/[0.3] w-full h-[5vh] rounded-[0.8vh]" 
      onclick="backButton()"    
    >
      <
    </button>
  `;

  container.innerHTML = itemsHTML;
}

async function chooseAutoItem(currentAutoFarm) {
  $.post(
    "https://cc_auto_farm/NUIStartAuto",
    JSON.stringify({ currentAutoFarm: currentAutoFarm })
  );
  closeUI();
}

function HandleType(configType) {
  const autoType = {};
  for (const [key, value] of Object.entries(configType)) {
    if (!autoType[value.type]) {
      autoType[value.type] = [];
    }
    autoType[value.type].push(value);
  }
  globalItem = autoType;
  return autoType;
}

function initContainer(type) {
  const main = document.getElementById("container-main");
  main.innerHTML = `
        <div class="bg-black/[0.5] w-[35vh] h-full text-white">
          <div class="flex justify-center">
            <div class="box-content w-[13vh] h-[13vh] mt-[8vh]">
              <img src="img/axe.png" />
            </div>
          </div>
          <div class="flex justify-center mt-[2vh] text-[3vh]">
            ระบบฟาร์มอัตโนมัติ
          </div>
          <div class="grid grid-rows gap-[1.5vh] mx-[1vh] mt-[1vh] text-[2.5vh]" id="container-auto">
            <!-- Buttons will be inserted here -->
          </div>
        </div>
      `;

  // Create ECONOMY button
  const economyButton = document.createElement("button");
  economyButton.textContent = "ECONOMY";
  economyButton.className =
    "bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.3] to-[#ffcc00]/[0.3] w-full h-[5vh] rounded-[0.8vh]";
  economyButton.addEventListener("click", () => {
    generateEconomy(type);
  });

  // Create METERIAL button
  const materialButton = document.createElement("button");
  materialButton.textContent = "MINING";
  materialButton.className =
    "bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.3] to-[#ffcc00]/[0.3] w-full h-[5vh] rounded-[0.8vh]";
  materialButton.addEventListener("click", () => {
    generateMaterial(type);
  });
  // Append buttons to container
  const containerAuto = document.getElementById("container-auto");
  containerAuto.appendChild(economyButton);
  containerAuto.appendChild(materialButton);
}

window.addEventListener("message", async function (event) {
  let res = event.data;
  let autoType = {};
  if (event.data.action === "open") {
    const jsonConfig = JSON.parse(res.config);
    const autoType = HandleType(jsonConfig);
    initContainer(autoType);
    $("body").fadeIn();
  }

  if (event.data.action === "closeAll") {
    $("body").fadeOut();
  }
});

function backButton() {
  initContainer(globalItem);
}

function closeUI() {
  $.post("https://cc_auto_farm/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});
