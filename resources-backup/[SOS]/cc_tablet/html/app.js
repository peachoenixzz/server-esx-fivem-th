let Config = new Object();
Config.closeKeys = [27, 90];

let data = [];
let firstTime = false;
const initBtn = [
  {
    type: "dead",
    name: "หมดสติ",
  },
  {
    type: "amp",
    name: "เก็บแอมป์",
  },
  {
    type: "cement",
    name: "ขโมยปูน",
  },
  {
    type: "drug",
    name: "ขายยา",
  },
  {
    type: "store_rob",
    name: "งัดร้านค้า",
  },
  {
    type: "house_rob",
    name: "งัดบ้าน",
  },
  {
    type: "thief",
    name: "โจรปล้น",
  },
  {
    type: "prisonbreak",
    name: "แหกคุก",
  },
  {
    type: "dead2",
    name: "ศพ (ถูกห่อ)",
  },
  {
    type: "bleeding_shroud",
    name: "ศพ (เข้าตู้เอ๋อ)",
  },
  {
    type: "bleeding",
    name: "เสียชีวิต",
  },
  {
    type: "ping",
    name: "ช่วยด้วย",
  },
];

initDataEvent();
showDataAllEvent();

window.addEventListener("message", async function (event) {
  let res = event.data;
  if (res.action === "open") {
    $("body").fadeIn();
  }

  if (res.action === "close") {
    $("body").fadeOut();
  }

  if (res.action === "update") {
    let dataLua = {
      name: res.name,
      labelname: res.labelName,
      datapanel: [
        {
          address: res.address,
          phone: res.phone,
          location: {
            x: res.location.x,
            y: res.location.y,
            z: res.location.z,
          },
          time: res.time,
        },
      ],
    };

    if (data.length > 40) {
      data.pop();
    }
    data.unshift(dataLua);

    clearData();
    handleCase();
  }
});

function closeUI() {
  $.post("https://cc_tablet/NUIFocusOff", JSON.stringify({}));
}

function initDataEvent() {
  let eventData = document.getElementById("event-data");
  initBtn.forEach((item) => {
    const color = colorBackground(item.type);
    eventData.innerHTML += `<button
      class="h-[3vh] w-full bg-[#3c3b3c]/[0.8] hover:bg-gradient-to-l from-black/[0.6] to-[${color}]/[0.8] rounded-[0.8vh] flex items-center justify-center mb-[0.5vh]"
      onclick="showDataEvent('${item.name}','${item.type}')" id="btn-${item.type}"
    >
      ${item.name}
    </button>`;
  });
}

// function initDataEvent() {
//   let eventData = document.getElementById("event-data");
//   initBtn.forEach((item) => {
//     const color = colorBackground(item.type);

//     const button = document.createElement("button");
//     button.textContent = item.name;
//     button.style.height = "3vh";
//     button.style.width = "100%";
//     button.classList.add("bg-[#3c3b3c]/[0.8]");
//     button.style.borderRadius = "0.8vh";
//     button.style.display = "flex";
//     button.style.alignItems = "center";
//     button.style.justifyContent = "center";
//     button.style.marginBottom = "0.5vh";

//     button.setAttribute("id", `btn-${item.type}`);

//     button.addEventListener("mouseover", () => {
//       button.style.backgroundImage = `linear-gradient(to left, rgba(0, 0, 0, 0.6), rgba(${color}, 0.7))`;
//     });

//     button.addEventListener("mouseout", () => {
//       button.style.backgroundImage = "none";
//       button.classList.add("bg-[#3c3b3c]/[0.8]");
//     });

//     button.addEventListener("click", () => {
//       showDataEvent(item.name, item.type);
//     });

//     eventData.appendChild(button);
//   });
// }

function clearData() {
  let showData = document.getElementById("show-data");
  showData.innerHTML = "";
}

function generateEventDataHTML(name, pdataItem, labelname, indexArr) {
  const color = colorBackground(name);
  // console.log(`chk-${name}-${pdataItem.phone}-${indexArr}`)
  return `
    <div class="flex w-full mb-[0.5vh]" id="${name}-${indexArr}">
        <div class="w-[5%] h-[3vh] mr-[0.2vh]">
        <input type="checkbox" id="chk-${name}-${pdataItem.phone}-${indexArr}" onclick="sendPosition('${name}-${pdataItem.phone}-${indexArr}','${pdataItem.location.x}','${pdataItem.location.y}','${pdataItem.location.z}')" />
        </div>
        <div class="w-[95%] h-[3vh]">
          <div class="h-[3vh] bg-black/[0.5] rounded-[0.8vh] flex justify-between px-[1vh]" id="bg-${name}-${pdataItem.phone}-${indexArr}">
          <div class="w-[30%] flex">
            <div class="flex items-center w-[50%]">
              <div class="box-content w-[2vh] h-[2vh] mr-[0.5vh] rounded-full flex items-center">
                <img class="w-[2vh] h-[2vh]" src="img/phone.png" />
              </div>
              ${pdataItem.phone}
            </div>
            <div class="flex items-center w-[50%] ml-[1.5vh] ">
              <div class="box-content w-[2vh] h-[2vh] mr-1 my-1 rounded-full flex items-center">
                <img class="w-[2vh] h-[2vh]" src="img/time.png" />
              </div>
              <div>${pdataItem.time}</div>
            </div>
         </div>
            <div class="flex items-center justify-center mx-[3vh]  w-[25%] my-[0.2vh] rounded-[0.8vh]"
            style="box-shadow: 0px 0px 7px rgba(0, 0, 0, 0.8);background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0.7), rgba(${color}, 0.7));">
              ${labelname}
            </div>
            <div class="flex items-center w-[37%] overflow-hidden">
              <div class="box-content w-[2vh] h-[2vh] mr-1 my-1 rounded-full flex items-center">
                <img class="w-[2vh] h-[2vh]" src="img/teleport.png" />
              </div>
              <div>${pdataItem.address}</div>
            </div>
            <div class="flex items-center w-[3%] overflow-hidden">
            <button onclick="delOneData('${name}','${indexArr}')"><img src="img/bin.png" /></button>
            </div>
          </div>
        </div>
      </div>`;
}

function handleCase() {
  let showData = document.getElementById("show-data");
  data.forEach((item, indexArr) => {
    item.datapanel.forEach((pdataItem) => {
      showData.innerHTML += generateEventDataHTML(
        item.name,
        pdataItem,
        item.labelname,
        indexArr
      );
    });
  });
}

function showDataAllEvent() {
  const button = document.getElementById("btn-allevent");
  // axios
  //   .post("https://Porpy_ambulancealert/updateTypeAvailable", { type: "all" })
  //   .then(async function (response) {
  //     const status = response.data;
  //     clearData();
  //     handleCase();
  //     changeButtonColor("allevent", status);
  //   })
  //   .catch(function (error) {
  //     console.error("Error:", error);
  //   });

  axios
    .post("https://Porpy_policealert/updateTypeAvailable", { type: "all" })
    .then(async function (response) {
      const status = response.data;
      clearData();
      handleCase();
      changeButtonColor("allevent", status);
    })
    .catch(function (error) {
      console.error("Error:", error);
    });
}

function showDataEvent(name, type) {
  // handleAmbulance(name, type);
  handlePolice(name, type);
}

// function handleAmbulance(name, type) {
//   axios
//     .post("https://Porpy_ambulancealert/updateTypeAvailable", { type: type })
//     .then(async function (response) {
//       const status = response.data;
//       console.log("status from lua : ", status);
//       changeButtonColor(type, status);
//     })
//     .catch(function (error) {
//       console.error("Error:", error);
//     });
// }

function handlePolice(name, type) {
  axios
    .post("https://Porpy_policealert/updateTypeAvailable", { type: type })
    .then(async function (response) {
      const status = response.data;
      console.log("status from lua : ", status);
      changeButtonColor(type, status);
    })
    .catch(function (error) {
      console.error("Error:", error);
    });
}

// function openMD() {
//   const chkMD = document.getElementById(`chk-MD`);
//   if (chkMD.checked) {
//     axios
//       .post("https://Porpy_ambulancealert/updateAlert", {
//         update: true,
//       })
//       .then(async function (response) {})
//       .catch(function (error) {
//         console.error("Error to reset:", error);
//       });
//   }
//   if (!chkMD.checked) {
//     axios
//       .post("https://Porpy_ambulancealert/updateAlert", {
//         update: false,
//       })
//       .then(async function (response) {})
//       .catch(function (error) {
//         console.error("Error to reset:", error);
//       });
//   }
// }
//
// function openPD() {
//   const chkPD = document.getElementById(`chk-PD`);
//   if (chkPD.checked) {
//     axios
//       .post("https://Porpy_policealert/updateAlert", { update: true })
//       .then(async function (response) {})
//       .catch(function (error) {
//         console.error("Error to reset:", error);
//       });
//   }
//   if (!chkPD.checked) {
//     axios
//       .post("https://Porpy_policealert/updateAlert", { update: false })
//       .then(async function (response) {})
//       .catch(function (error) {
//         console.error("Error to reset:", error);
//       });
//   }
// }

function changeButtonColor(name, status) {
  if (status) {
    const button = document.getElementById(`btn-${name}`);
    button.classList.remove("bg-[#3c3b3c]/[0.8]");
    button.classList.add("button-active");
  }

  if (!status) {
    const button = document.getElementById(`btn-${name}`);
    button.classList.remove("button-active");
    button.classList.add("bg-[#3c3b3c]/[0.8]");
  }

  if (name !== "allevent") {
    const button = document.getElementById(`btn-allevent`);
    button.classList.remove("button-active");
    button.classList.add("bg-[#3c3b3c]/[0.8]");
  }

  if (name === "allevent") {
    initBtn.forEach((item) => {
      const button = document.getElementById(`btn-${item.type}`);
      button.classList.remove("button-active");
      button.classList.add("bg-[#3c3b3c]/[0.8]");
    });
  }
}

function sendPosition(id, x, y, z) {
  const checkbox = document.getElementById(`chk-${id}`);
  const bgChnage = document.getElementById(`bg-${id}`);
  if (checkbox.checked) {
    bgChnage.classList.remove("bg-[#3c3b3c]/[0.8]");
    bgChnage.classList.add("button-active");
    axios
      .post("https://cc_tablet/alertArea", { x: x, y: y, z: z })
      .then(async function (response) {})
      .catch(function (error) {
        console.error("Error to reset:", error);
      });
  } else {
    bgChnage.classList.remove("button-active");
    bgChnage.classList.add("bg-[#3c3b3c]/[0.8]");
  }
}

function searchPhone() {
  let showData = document.getElementById("show-data");
  let sPhone = document.getElementById("search-phone").value;
  showData.innerHTML = "";

  data.forEach((searchData, indexArr) => {
    const phone = searchData.datapanel.filter(
      (panel) => panel.phone === sPhone
    );

    if (phone.length > 0) {
      phone.forEach((pdataItem) => {
        showData.innerHTML += generateEventDataHTML(
          searchData.name,
          pdataItem,
          searchData.labelname,
          indexArr
        );
      });
    }
  });

  if (sPhone == "") {
    showData.innerHTML = "";
    handleCase();
  }
}

function delAllData() {
  let showData = document.getElementById("show-data");
  showData.innerHTML = "";
  data = [];
}

function delOneData(name, indexArr) {
  // console.log(name, indexArr);
  const Id = `${name}-${indexArr}`;
  let del = document.getElementById(Id);
  let showData = document.getElementById("show-data");

  if (del) {
    showData.removeChild(del);
    data.splice(indexArr, 1);
  }
}

function colorBackground(actionType) {
  switch (actionType) {
    case "dead":
      // return "#191919";
      return "25,25,25";
    case "amp":
      // return "#b5ff00";
      return "181, 255, 0";
    case "cement":
      // return "#ffa800";
      return "255, 168, 0";
    case "drug":
      // return "#b5ff00";
      return "181, 255, 0";
    case "store_rob":
      // return "#00acff";
      return "0, 172, 255";
    case "house_rob":
      // return "#00acff";
      return "0, 172, 255";
    case "thief":
      // return "#ff0092";
      return "255, 0, 146";
    case "prisonbreak":
      // return "#af00ff";
      return "175, 0, 255";
    case "dead2":
      // return "#ff0000";
      return "255, 0, 0";
    case "bleeding":
      // return "#ff0000";
      return "255, 0, 0";
    case "bleeding_shroud":
      // return "#ff0000";
      return "255, 0, 0";
    case "ping":
      // return "#191919";
      return "25,25,25";
    default:
      // return "#003fd4";
      return "0, 63, 212";
  }
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});
