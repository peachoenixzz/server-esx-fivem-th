let authToken = null;
let header = {};
let Config = {};
let isQuest = false;
Config.closeKeys = [27, 90];
// document.addEventListener("DOMContentLoaded", function () {
//   initStatus();
//   requireQuest();
// });

let data = [];
// let interval = setInterval(refreshSubMenu, 60000); //1000=1วิ
let subMenuStatus = false;
//
// function refreshSubMenu(){
//   if (subMenuStatus) {
//      axios
//         .post("https://cc_quest/update", {})
//         .then((response) => {
//           if (response.data) {
//             initStatus();
//           }
//         })
//         .catch((error) => {
//           console.error("Error:", JSON.stringify(error));
//         });
//   }
// }

function showQuest() {
  let questContainer = document.getElementById("quest-container");
  let subquestContainer = document.getElementById("sub-quest-container");
  if (!data) {
  } else {
    questContainer.classList.remove(
      "flex",
      "items-center",
      "justify-center",
      "h-full"
    );
    questContainer.classList.add("grid", "grid-row", "gap-[1vh]");

    subquestContainer.classList.remove(
      "flex",
      "items-center",
      "justify-center",
      "h-full"
    );
    subquestContainer.classList.add("grid", "grid-row", "gap-[0.5vh]");

    let ItemsQuest = "";
    let subItemsQuest = "";

    data.forEach((item) => {
      ItemsQuest += `<div class="flex items-center justify-between">
        <div class="flex items-center">
          <img
            src="nui://nc_inventory/html/img/items/${item.item_name}.png"
            class="w-[3.5vh] h-[3.5vh] mr-[1vh]"
          />
          <div>${item.label_name}</div>
        </div>
        <div class="w-[6vh] h-[3.5vh] bg-black/[0.5] flex items-center justify-center rounded-[0.5vh] ${
          item.player_item_quantity >= item.quest_require_quantity
            ? "bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5]"
            : ""
        }">
        ${item.comparison}
      </div>
      
      </div>`;
    });

    data.forEach((item) => {
      subItemsQuest += `<div class="flex items-center justify-between">
    <div class="flex items-center">
      <img
        src="nui://nc_inventory/html/img/items/${item.item_name}.png"
        class="w-[2vh] h-[2vh] mr-[1vh]"
      />
      <div>${item.label_name}</div>
    </div>
    <div
      class="w-[3.5vh] h-[2vh] bg-black/[0.5]  flex items-center justify-center  rounded-[0.3vh]  ${
        item.player_item_quantity >= item.quest_require_quantity
          ? "bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5]"
          : ""
      }"
    >
    ${item.comparison}
    </div>
  </div>`;
    });

    questContainer.innerHTML = ItemsQuest;
    subquestContainer.innerHTML = subItemsQuest;
  }
}

async function initStatus() {
  const buttonQuestContainer = document.getElementById(
    "button-quest-container"
  );

  let sendButton = `
  <button class="bg-gradient-to-l from-[#ffa800] to-[#ffcc00] rounded-[0.5vh] px-[1.5vh]" onclick="sendQuest()">
    ส่งเควส
  </button>
  `;

  const api = "https://mongkol.dev/api/quest/users/status";
  axios
    .get(api, {
      headers: header,
    })
    .then(async function (response) {
      // console.log(response.data.Message);

      if (response.data.Message === "already_quest") {
        await compareItem();
        buttonQuestContainer.innerHTML = sendButton;
      }
    })
    .catch(function (error) {
      console.error("Error in /users/status request:", error);
    });
}

async function compareItem() {
  try {
    const response = await axios.get(
      "https://mongkol.dev/api/quest/users/compare",
      {
        headers: header,
      }
    );

    data = response.data;
    await showQuest();
    // console.log(data);
  } catch (error) {
    console.error("Error in /users/compare request:", error);
  }
}

function resetQuest() {
  axios
    .post(
      "https://cc_quest/resetQuest",
      {},
      {
        headers: header,
      }
    )
    .then(async function (response) {
      // console.log(response.data.Message);
      if (response.data) {
        await createQuest();
        resetUI();
        initStatus();
      }
    })
    .catch(function (error) {
      console.error("Error to reset :", error);
    });
}

async function createQuest() {
  isQuest = true;
  let buttonQuestContainer = document.getElementById("button-quest-container");
  let sendButton = `
  <button class="bg-gradient-to-l from-[#ffa800] to-[#ffcc00] rounded-[0.5vh] px-[1.5vh]" onclick="sendQuest()">
    ส่งเควส
  </button>
  `;

  axios
    .post(
      "https://mongkol.dev/api/quest/users/create",
      {},
      {
        headers: header,
      }
    )
    .then(async function (response) {
      // console.log(response.data.Message);
      await compareItem();
      buttonQuestContainer.innerHTML = sendButton;
    })
    .catch(function (error) {
      console.error("Error to reset :", error);
    });
}

function resetUI() {
  let buttonQuestContainer = document.getElementById("button-quest-container");
  let questContainer = document.getElementById("quest-container");
  let subquestContainer = document.getElementById("sub-quest-container");
  questContainer.classList.remove("grid", "grid-row", "gap-[1vh]");
  questContainer.classList.add(
    "flex",
    "items-center",
    "justify-center",
    "h-full"
  );

  subquestContainer.classList.remove("grid", "grid-row", "gap-[1vh]");
  subquestContainer.classList.add(
    "flex",
    "items-center",
    "justify-center",
    "h-full"
  );

  loadQuest = `<span class="loader"></span>`;
  subloadQuest = `<span class="subloader"></span>`;
  let sendButton = `
  <button
              class="bg-[#ffcc00] rounded-[0.5vh] px-[1.5vh]"
              onclick="createQuest()"
            >
              รับเควส
            </button>
  `;

  questContainer.innerHTML = loadQuest;
  buttonQuestContainer.innerHTML = sendButton;
  subquestContainer.innerHTML = subloadQuest;
}

function requireQuest() {
  let weightLeft = document.getElementById("weight-left");
  let weightRight = document.getElementById("weight-right");
  let require = document.getElementById("require");
  const conButPro = document.getElementById("container-buttonNprogress");
  buttonUp = ` <button 
  class="absolute bottom-0 left-0 right-0 flex items-center justify-center box-content progress h-full w-[100%] z-0 rounded-[0.5vh] bg-gradient-to-l from-[#ffa800] to-[#ffcc00]"
  onclick="upGrade()">อัพเกรด</button>`;
  axios
    .get("https://mongkol.dev/api/quest/users/quest", {
      headers: header,
    })
    .then(async function (response) {
      // console.log(response.data.Message);
      const resdata = response.data;
      weightLeft.innerHTML = resdata.weight_level + 30;
      weightRight.innerHTML = resdata.weight_level + 1 + 30;
      if (resdata.card_a_item < resdata.quantity) {
        require.style.display = "block";
        conButPro.innerHTML = `
              <div
                id="progress"
                class="absolute bottom-0 left-0 right-0 box-content progress h-full w-[0%] z-0 rounded-[0.5vh] bg-gradient-to-l from-[#ffa800] to-[#ffcc00]"
              ></div>
        `;
        const percentage = (resdata.card_a_item / resdata.quantity) * 100;
        const actualPercentage = Math.min(percentage, 100);
        const progressBar = document.getElementById("progress");
        progressBar.style.width = `${actualPercentage}%`;
        require.innerHTML = resdata.card_a_item + "/" + resdata.quantity;
      }

      if (resdata.card_a_item >= resdata.quantity) {
        conButPro.innerHTML = buttonUp;
        require.style.display = "none";
      }
    })
    .catch(function (error) {
      console.error("Error:", error);
    });
}

async function upGrade() {
  await axios
    .post("https://cc_quest/doneWeight", {})
    .then((response) => {
      if (response.data) {
        requireQuest();
        closeUI();
      }
    })
    .catch((error) => {
      console.error("Error:", JSON.stringify(error));
    });
}

async function sendQuest() {
  await axios
    .post("https://cc_quest/doneQuest", {})
    .then((response) => {
      if (response.data) {
        closeUI();
        resetUI();
        $("#container-sub").fadeOut();
        isQuest = false;
      }
    })
    .catch((error) => {
      console.error("Error:", JSON.stringify(error));
    });
}

window.addEventListener("message", async function (event) {
  // console.log(event.data.auth)
  if (event.data.action === "openQuestMenu") {
    authToken = event.data.auth;
    header = {
      "Access-Control-Allow-Origin": "https://mongkol.dev",
      Authorization: `Bearer ${authToken}`,
    };
    resetUI();
    initStatus();
    requireQuest();
    subMenuStatus = true;
    $("body").fadeIn();
    $("#container-sub").fadeIn();
    $("#container-main").fadeIn();
  }

  if (event.data.action === "openSubQuestMenu") {
    authToken = event.data.auth;
    header = {
      "Access-Control-Allow-Origin": "https://mongkol.dev",
      Authorization: `Bearer ${authToken}`,
    };
    resetUI();
    initStatus();
    requireQuest();
    subMenuStatus = true;
    $("body").fadeIn();
    $("#container-sub").fadeIn();
  }

  if (event.data.action === "refreshSubQuest") {
    authToken = event.data.auth;
    header = {
      "Access-Control-Allow-Origin": "https://mongkol.dev",
      Authorization: `Bearer ${authToken}`,
    };
    resetUI();
    initStatus();
    requireQuest();
    subMenuStatus = true;
    $("body").fadeIn();
    $("#container-sub").fadeIn();
  }

  if (event.data.action === "closeSubQuest") {
    $("#container-sub").fadeOut();
    $("body").fadeOut();
    subMenuStatus = false;
  }

  if (event.data.action === "closeAll") {
    $("#container-main").fadeOut();
    if (!isQuest) {
      $("#container-sub").fadeOut();
    }
    subMenuStatus = true;
  }
});

function closeUI() {
  $.post("https://cc_quest/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      // console.log("closer")
      closeUI();
      // clearInterval(interval);
    }
  });
});
