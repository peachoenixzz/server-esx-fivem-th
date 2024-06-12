// document.addEventListener("DOMContentLoaded", function () {

// });

function selectItems() {
  const optionMenu = document.getElementById("select-menu");
  optionMenu.classList.toggle("active");
}

let authToken = null;
let header = {};
let Config = {};
Config.closeKeys = [27, 90];
let selectedGachapon = null;
let ESCStatus = true;
let maxQuantity = 0;

let setData = null;
let statusProgress = false;
async function progress_bar() {
  const optionMenu = document.getElementById("select-menu");
  if (optionMenu.classList.contains("active")) {
    optionMenu.classList.remove("active");
  }
  const maxPull = 500;
  const inputField = document.getElementById("input-number");
  let inputValue = parseInt(inputField.value);
  if (inputValue > maxPull) return;
  if (inputValue <= 0 || isNaN(inputValue)) return;

  let progress = $("#progress");
  let width = 0;
  let time = 3; // Total time in seconds
  let intervalTime = time * 1000; // Convert to milliseconds

  let statusValidate = await validateGachapon();
  if (statusValidate && !statusProgress) {
    ESCStatus = false;
    const selectElement = document.getElementById("select-data");
    const selectBtn = document.getElementById("select-btn");
    const btnProgress = document.getElementById("btn-progress");
    const inputField = document.getElementById("input-number");
    const maxButton = document.getElementById("btn-max");
    let sBtn_text = document.getElementById("sBtn-text");
    // const display = document.getElementById("display");
    maxButton.disabled = true;
    selectElement.disabled = true;
    selectBtn.disabled = true;
    inputField.disabled = true;
    if (btnProgress !== undefined) {
      btnProgress.disabled = true;
    }
    statusProgress = true;
    handleLoader();
    progress.css("transition", `width ${intervalTime / 100}ms linear`);
    progress.animate(
      { width: "100%" },
      {
        duration: intervalTime,
        progress: async function (animation, progress) {
          $(".absolute.inset-0.flex.items-center.justify-center.z-10").text(
            `${parseInt(progress * 100)}%`
          );
        },
        complete: async function () {
          // progress.css("width", "0%"); // Reset the progress bar width
          // $(".absolute.inset-0.flex.items-center.justify-center.z-10").text(
          //   "0%"
          // );
          // statusBar.innerHTML = `
          //   <button
          //     id="btn-success"
          //     class="btn-3d rounded-[0.5vh] w-full flex items-center justify-center text-center text-[2vh] h-[3vh] px-[2.5vh] "
          //     onclick="getItem()"
          //     disabled
          //   >
          //     Success
          //   </button>`;
          const display = $("#display");
          display.fadeOut(500, function () {
            display.hide();
          });
          state = true;
          await openGachapon();
          sBtn_text.innerText = "กรุณาเลือก";
          //     selectElement.innerHTML = `
          //     <option class="pl-[0.5vg]" value='default' selected>เลือก GACHAPON</option>
          // `;

          await initGacha();
        },
      }
    );
  }
}

function handleLoader() {
  setData.forEach((item) => {
    const quantityItems = document.getElementById(`quantity-show-${item.id}`);
    if (quantityItems) {
      quantityItems.innerHTML = `<span class="loader"></span>`;
    }
  });
}

async function validateGachapon() {
  if (selectedGachapon === null) return false;
  const inputField = document.getElementById("input-number");
  let inputValue = parseInt(inputField.value);
  let status = false;
  const header = {
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    Authorization: `Bearer ${authToken}`,
  };
  await axios
    .post(
      "https://cc_mysteryroom/validateGachapon",
      {
        name: selectedGachapon,
        quantity: inputValue,
      },
      {
        headers: header,
      }
    )
    .then(async function (response) {
      status = response.data;
      console.log(status);
      return status;
    })
    .catch(function (error) {
      console.error("Error to reset:", error);
    });
  return status;
}

async function openGachapon() {
  // console.log("test");
  const selectElement = document.getElementById("select-data");
  const selectBtn = document.getElementById("select-btn");
  const btnProgress = document.getElementById("btn-progress");
  const maxButton = document.getElementById("btn-max");
  const inputField = document.getElementById("input-number");
  let inputValue = parseInt(inputField.value);
  // const btnSuccess = document.getElementById("btn-success");
  // btnSuccess.disabled = true;

  console.log(selectedGachapon);
  axios
    .post("https://cc_mysteryroom/open", {
      name: selectedGachapon,
      quantity: inputValue,
    })
    .then(async function (response) {
      // console.log(response);
      // console.log(response.data);
      // const selectElement = document.getElementById("select-data");
      // // const btnProgress = document.getElementById("btn-progress");
      // const maxButton = document.getElementById("btn-max");
      const data = JSON.parse(response.data);
      selectElement.disabled = true;
      maxButton.disabled = true;
      inputField.disabled = true;
      selectBtn.disabled = true;
      // if (btnProgress !== undefined) {
      //   btnProgress.disabled = true;
      // }

      let index = 0;
      console.log("index0");
      let intervalId = setInterval(() => {
        if (index < setData.length) {
          const sd = setData[index];
          const quantityItems = document.getElementById(
            `quantity-show-${sd.id}`
          );
          if (quantityItems) {
            const matchingItem = data.find((v) => sd.id === v.ItemId);
            quantityItems.innerHTML = matchingItem ? matchingItem.Quantity : 0;
          }
          const audio = document.getElementById("open-sound");
          if (audio) {
            audio.currentTime = 0;
            audio.volume = 0.25;
            audio.play();
          }
          index++;
          // console.log(index);
        }
        if (index == setData.length) {
          // btnSuccess.disabled = false;
          getGachaponAlreadyOpen();
          clearInterval(intervalId);
        }
      }, 400);
    })
    .catch(function (error) {
      maxButton.disabled = false;
      selectElement.disabled = false;
      selectBtn.disabled = false;
      inputField.disabled = false;
      if (btnProgress !== undefined) {
        btnProgress.disabled = false;
      }
      console.error("Error to reset:", error);
    });
}

async function showItems(name, quantity) {
  let sendData = {
    name: "",
  };

  const selectedValue = name;
  changeImageSrc(selectedValue);

  maxQuantity = quantity;

  console.log(maxQuantity);
  const gridCon = document.getElementById("griditems-container");
  gridCon.classList.remove(
    "flex",
    "items-center",
    "justify-center",
    "min-h-[21vh]"
  );
  gridCon.classList.add("grid", "grid-cols-4", "gap-[0.5vh]");
  sendData.name = selectedValue;
  selectedGachapon = selectedValue;
  await getGachaponAlreadyOpen();
  // console.log(sendData);
  // console.log(selectedValue);

  if (selectedValue === "default") {
    defaultHandle();
    return;
  }
  const header = {
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    Authorization: `Bearer ${authToken}`,
  };
  axios
    .post("https://mongkol.dev/api/gachapon/items", sendData, {
      headers: header,
    })
    .then(async function (response) {
      const data = response.data;
      setData = data;
      // console.log(JSON.stringify(data));
      // console.log(data);
      let items = "";
      let textSizeClass = "text-[0.85vh]";
      // let textSizeClass = "text-[1.5vh]";

      data.forEach((item) => {
        // Check the length of each item's label_name
        if (item.label_name.length > 15) {
          textSizeClass = "text-[0.85vh]";
        } else {
          textSizeClass = "text-[0.85vh]"; // Reset the class for other items
        }

        items += `<div>
          <div class="bg-black/[0.5] rounded-[0.8vh] w-fit p-[0.5vh]">
            <div class="${textSizeClass} leading-[1.2vh] mb-[0.5vh] text-center">
              ${item.label_name}
            </div>
            <div class="bg-black/[0.5] rounded-[0.8vh] w-fit mt-[0.5]">
              <div class="box-content w-[15vh] h-[15vh] flex justify-center items-center">
                <img src="nui://nc_inventory/html/img/items/${item.name}.png" class="w-[10vh] h-[10vh]" />
              </div>
            </div>
            <div id="quantity-show-${item.id}" class="box-content flex justify-center items-center text-[2vh] h-[3vh] bg-black/[0.5] rounded-[0.8vh] mt-[0.5vh] w-full">
              ? ? ?
            </div>
          </div>
        </div>`;
      });
      gridCon.innerHTML = items; // Set the innerHTML with the generated HTML content.
    })
    .catch(function (error) {
      console.error("Error to reset:", error);
    });
}

async function getGachaponAlreadyOpen() {
  if (selectedGachapon === null) return;
  const header = {
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    Authorization: `Bearer ${authToken}`,
  };
  axios
    .post(
      "https://mongkol.dev/api/gachapon/users/status",
      { name: selectedGachapon },
      {
        headers: header,
      }
    )
    .then(async function (response) {
      const data = response.data;
      await handleStatusBar(data.in_slot);
    })
    .catch(function (error) {
      console.error("Error to reset:", error);
    });
}

function defaultHandle() {
  // sendData.name = selectedValue;
  const gridCon = document.getElementById("griditems-container");
  gridCon.classList.remove("grid", "grid-cols-4", "gap-[0.5vh]");
  gridCon.classList.add(
    "flex",
    "items-center",
    "justify-center",
    "min-h-[21vh]"
  );
  let items = `<span class="loader-default"></span>`;

  gridCon.innerHTML = items; // Remove the forward slash here
}

async function getItem() {
  const btnSuccess = document.getElementById("btn-success");
  btnSuccess.disabled = true;

  const audioOpen = document.getElementById("open-sound");
  if (audioOpen) {
    audioOpen.pause();
  }

  const audioSuccess = document.getElementById("success-sound");
  if (audioSuccess) {
    audioSuccess.volume = 0.25;
    audioSuccess.currentTime = 0;
    audioSuccess.play();
  }

  const header = {
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    Authorization: `Bearer ${authToken}`,
  };
  axios
    .post("https://cc_mysteryroom/getItem", {
      name: selectedGachapon,
    })
    .then(async function (response) {
      console.log(response.data);
      if (response.data) {
        selectedGachapon = null;
        const selectElement = document.getElementById("select-data");
        const inputField = document.getElementById("input-number");
        const maxButton = document.getElementById("btn-max");
        const selectBtn = document.getElementById("select-btn");
        const sBtn_text = document.getElementById("sBtn-text");
        //     selectElement.innerHTML = `
        //     <option class="pl-[0.5vh]" value='default' selected>เลือก GACHAPON</option>
        // `;

        selectElement.disabled = false;
        inputField.disabled = false;
        inputField.value = NaN;
        maxButton.disabled = false;
        selectBtn.disabled = false;
        sBtn_text.innerText = "กรุณาเลือก";

        await initGacha();
        await handleStatusBar();
        defaultHandle();
        changeImageSrc("default");
        statusProgress = false;
        ESCStatus = true;
      }
    })
    .catch(function (error) {
      console.error("Error to reset:", error);
    });
}

async function handleStatusBar(slot = null) {
  const display = $("#display");
  display.fadeIn(500);
  // display.style.display = "block";
  // display.style.transform = "translateY(100%)";
  // setTimeout(function () {
  //   display.style.transform = "translateY(0%)";
  // }, 50);
  const statusBar = document.getElementById("status-bar");
  // statusBar.style.display = "block";
  const selectBtn = document.getElementById("select-btn");
  const selectElement = document.getElementById("select-data");
  const inputField = document.getElementById("input-number");
  const maxButton = document.getElementById("btn-max");
  if (slot > 0) {
    ESCStatus = false;
    selectElement.disabled = true;
    inputField.disabled = true;
    maxButton.disabled = true;
    selectBtn.disabled = true;
    statusBar.innerHTML = `           
            <button  
              id="btn-success"
              class="btn-3d rounded-[0.5vh] w-full flex items-center justify-center text-center text-[2vh] h-[3vh] px-[2.5vh] "
              onclick="getItem()"
            >
              Success
            </button>`;
  }
  if (slot === 0) {
    statusBar.innerHTML = `            
            <button
              class="btn-3d rounded-[0.5vh] text-[2vh] h-[3vh] px-[2.5vh] mr-[1vh]"
                id="btn-progress"
              onclick="progress_bar()"
            >
              เปิด
            </button>
            <div
              class="box-content bg-black/[0.5] h-[3vh] w-full flex items-center justify-center text-center relative rounded-[0.5vh]"
            >
              <div
                class="absolute inset-0 flex items-center justify-center z-10"
              >
                0%
              </div>
              <div
                id="progress"
                class="absolute bottom-0 left-0 right-0 box-content progress h-[3vh] w-[0%] z-0 rounded-[0.5vh]"
              ></div>
            </div>`;
  }
  if (slot === null) {
    statusBar.innerHTML = `            
            <button
              class="btn-3d rounded-[0.5vh] text-[2vh] h-[3vh] px-[2.5vh] mr-[1vh]"
              id="btn-progress"
              onclick="progress_bar()"
            >
              เปิด
            </button>
            <div
              class="box-content bg-black/[0.5] h-[3vh] w-full flex items-center justify-center text-center relative rounded-[0.5vh]"
            >
              <div
                class="absolute inset-0 flex items-center justify-center z-10"
              >
                0%
              </div>
              <div
                id="progress"
                class="absolute bottom-0 left-0 right-0 box-content progress h-[3vh] w-[0%] z-0 rounded-[0.5vh]"
              ></div>
            </div>`;
  }
}
async function initGacha() {
  const selectElement = document.getElementById("select-data");
  selectElement.innerHTML = "";
  let gachaName = document.getElementById("gacha-name");
  gachaName.innerText = "";

  const header = {
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    Authorization: `Bearer ${authToken}`,
  };
  axios
    .get("https://mongkol.dev/api/gachapon/users", {
      headers: header,
    })
    .then(async function (response) {
      const data = response.data; // Make sure this is the correct property containing the array
      createSelectOptions(data);
    })
    .catch(function (error) {
      console.error("Error to reset:", error);
    });
}

function createSelectOptions(data) {
  const selectElement = document.getElementById("select-data");
  const gachaName = document.getElementById("gacha-name");
  let sBtn_text = document.getElementById("sBtn-text");
  if (data === null) return;
  data.forEach((item) => {
    const optionMenu = document.getElementById("select-menu");

    const option = document.createElement("li");
    option.className = "option";

    const span = document.createElement("span");
    span.className = "option-text";
    span.textContent = item.label_name + "  " + "(" + item.quantity + ")";

    option.onclick = function () {
      console.log(item.label_name);

      sBtn_text.innerText = item.label_name;
      optionMenu.classList.remove("active");
      gachaName.innerText = item.label_name;
      showItems(item.name, item.quantity);
    };

    option.appendChild(span);
    selectElement.appendChild(option);
  });
}

const maxPull = 500;
function validateInput() {
  const inputField = document.getElementById("input-number");
  let inputValue = parseInt(inputField.value);
  // console.log(maxQuantity);

  if (inputValue <= 0 || isNaN(inputValue)) {
    inputValue = 1;
    return (inputField.value = inputValue);
  }
  if (maxQuantity > inputValue) {
    if (maxPull <= inputValue) {
      // console.log("if");
      return (inputField.value = maxPull);
    } else {
      // console.log("else");
      return (inputField.value = inputValue);
    }
  }
}

function maxQuantityItems() {
  const inputField = document.getElementById("input-number");

  if (maxPull <= maxQuantity) {
    return (inputField.value = maxPull);
  } else {
    return (inputField.value = maxQuantity);
  }
}

function changeImageSrc(item) {
  const gachaponImage = document.getElementById("gachaponImage");
  if (gachaponImage) {
    gachaponImage.src = `nui://nc_inventory/html/img/items/${item}.png`;
  }
  if (item === "default") {
    gachaponImage.src = `img/question.png`;
  }
}
window.addEventListener("message", async function (event) {
  // console.log(event.data.auth)
  const optionMenu = document.getElementById("select-menu");
  const selectBtn = document.getElementById("select-btn");

  const selectElement = document.getElementById("select-data");
  const inputField = document.getElementById("input-number");
  const btnProgress = document.getElementById("btn-progress");
  const maxButton = document.getElementById("btn-max");
  let sBtn_text = document.getElementById("sBtn-text");
  if (event.data.action === "openGachapon") {
    authToken = event.data.auth;
    header = {
      "Access-Control-Allow-Origin": "https://mongkol.dev",
      Authorization: `Bearer ${authToken}`,
    };

    let progress = $("#progress");
    $(".absolute.inset-0.flex.items-center.justify-center.z-10").text(
      "READY TO GACHAPON !!"
    );
    progress.stop().css("width", "100%");
    setTimeout(function () {
      $(".absolute.inset-0.flex.items-center.justify-center.z-10").text("0%");
      progress.css("width", "0%"); // Reset the progress bar width
    }, 10);

    await initGacha();
    await handleStatusBar();
    selectedGachapon = null;
    ESCStatus = true;
    maxQuantity = 0;
    statusProgress = false;
    inputField.disabled = false;
    selectElement.disabled = false;
    maxButton.disabled = false;
    selectBtn.disabled = false;
    $("body").fadeIn();
  }

  if (event.data.action === "closeAll") {
    defaultHandle();
    changeImageSrc("default");
    if (btnProgress !== undefined) {
      btnProgress.disabled = false;
    }
    selectedGachapon = null;
    ESCStatus = true;
    maxQuantity = 0;
    statusProgress = false;
    inputField.disabled = false;
    maxButton.disabled = false;
    selectBtn.disabled = false;
    // selectElement.innerHTML = "";
    sBtn_text.innerText = "กรุณาเลือก";
    if (optionMenu.classList.contains("active")) {
      // selectElement.innerHTML = "";
      optionMenu.classList.remove("active");
    }
    //     selectElement.innerHTML = `
    //     <option class="pl-[0.5vh]" value='default' selected>เลือก GACHAPON</option>
    // `;

    $("body").fadeOut();
  }
});

// function test() {
//   if ((index = setData.length)) {
//     const successButton = document.getElementById("btn-success");
//     successButton.disabled = false;
//   } else {
//     console.log("else");
//   }
// }

function closeUI() {
  let progress = $("#progress");
  $(".absolute.inset-0.flex.items-center.justify-center.z-10").text(
    "CANCELLED"
  );
  progress.stop().css("width", "100%");
  setTimeout(function () {
    $(".absolute.inset-0.flex.items-center.justify-center.z-10").text("0%");
    progress.css("width", "0%"); // Reset the progress bar width
  }, 10);

  $.post("https://cc_mysteryroom/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      if (ESCStatus) {
        closeUI();
      }
    }
  });
});
