let Config = new Object();
Config.closeKeys = [27, 90];
let slideIndex = 0;
let timer;
let authToken = null;
let data = {
  name: "",
  quantity: 1,
};
function showSlides() {
  clearTimeout(timer);
  let i;
  let slides = document.getElementsByClassName("imgSlides");
  let dots = document.getElementsByClassName("dot");
  for (i = 0; i < slides.length; i++) {
    slides[i].classList.add("hidden");
  }
  slideIndex++;
  if (slideIndex > slides.length) {
    slideIndex = 1;
  }

  for (i = 0; i < dots.length; i++) {
    dots[i].classList.remove("bg-gray-500");
    dots[i].classList.add("bg-gray-500");
  }
  slides[slideIndex - 1].classList.remove("hidden");
  dots[slideIndex - 1].classList.remove("bg-gray-500");
  dots[slideIndex - 1].classList.add("bg-white");
  timer = setTimeout(showSlides, 2000); // Change image every 2 seconds
}
let countdownInterval;
let qrCodeGenerated = false;
function generateQRCode(data, size) {
  if (!qrCodeGenerated) {
    const qrCodeContainer = document.getElementById("qrCodeContainer");
    const qrCode = document.getElementById("qr-code");
    const qrText = document.getElementById("qr-text");
    qrCodeContainer.style.display = "block";
    const qrCodegen = new QRCode(qrCode, {
      text: data,
      width: size,
      height: size,
    });
    const timeInSeconds = 60;
    let remainingSeconds = timeInSeconds;
    updateTimer(); // อัปเดตเวลาแสดงเมื่อฟังก์ชันถูกเรียกใช้
    countdownInterval = setInterval(() => {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        clearInterval(countdownInterval);
        qrText.innerHTML = "หมดเวลา";
        qrCode.innerHTML = "";
        qrText.innerHTML = "";
        qrCodeContainer.style.display = "none";
        qrCodeGenerated = false;
      } else {
        updateTimer();
      }
    }, 1000);

    function updateTimer() {
      const minutes = Math.floor(remainingSeconds / 60)
        .toString()
        .padStart(2, "0");
      const seconds = (remainingSeconds % 60).toString().padStart(2, "0");
      qrText.innerHTML = `กรุณาชำระภายใน ${minutes} : ${seconds} นาที`;
    }

    qrCodeGenerated = true;
  }
}

function closeTopupContainer() {
  const topupContainer = document.getElementById("topup-container");
  topupContainer.innerHTML = "";
}

document.addEventListener("keydown", function (event) {
  if (event.key === "Escape") {
    closeTopupContainer();
  }
});

function cancelText() {
  const textInput = document.getElementById("textInput");
  textInput.value = "";
}

function closeGenerateQRCode() {
  clearInterval(countdownInterval);
  const qrCodeContainer = document.getElementById("qrCodeContainer");
  const qrCode = document.getElementById("qr-code");
  const qrText = document.getElementById("qr-text");
  qrCode.innerHTML = "";
  qrText.innerHTML = "";
  qrCodeContainer.style.display = "none";
  qrCodeGenerated = false;
}

function confirmModel(itemName) {
  const modelContainer = document.getElementById("model-container");
  const model = ` <div
      class="bg-gradient-to-b from-black/[0.6] to-teal-700/[0.8] rounded-[0.8vh] w-fit p-[1.5vh] text-white relative"
    >
      <div class="flex justify-center flex-col">
      <div class="text-[1.5vh] text-center">ยอมรับการแลกเปลี่ยน ?</div>
      <input type="number" class="bg-black/[0.5] rounded-[0.5vh] w-[14vh] text-center items-center justify-center" placeholder="จำนวน" value="1" id="input-number"
      onchange="validateInput()"/>
        <div class="grid grid-cols-2 gap-[1vh] mt-[1vh]">
          <button
            class="btn-3d h-[2.3vh] w-full rounded-md text-white select-none whitespace-nowrap flex items-center justify-center" onclick="buyItem('${itemName}')"
          >
            <div class="box-content h-[1.7] w-[1.7vh]">
              <img
                src="img/confirm.png"
                class="box-content h-[1.5] w-[1.5vh] mb-[0.2vh]"
              />
            </div>
          </button>
          <button
            class="btn-3d-canclex h-[2.3vh] w-full rounded-md text-white select-none whitespace-nowrap flex items-center justify-center" onclick="cancleModel()"
          >
            <div class="box-content h-[1.7] w-[1.7vh]">
              <img
                src="img/cancel.png"
                class="box-content h-[1.5] w-[1.5vh] mb-[0.2vh]"
              />
            </div>
          </button>
        </div>
      </div>
    </div>`;
  modelContainer.innerHTML = model;
}

function cancleModel() {
  const modelContainer = document.getElementById("model-container");
  modelContainer.innerHTML = "";
  let cashItems = document.getElementById("cash-items");
  cashItems.innerHTML = "";
  showSlides();
  initCashShop();
  initItemsCashShop();
}

function initCashShop() {
  const api = "https://mongkol.dev/api/cash-shop/users";
  const headers = {
    // 'Host': 'https://circleproject.dev',
    // 'Origin': 'https://tx.circleproject.dev',
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    // 'Access-Control-Request-Method' : 'GET',
    // 'Access-Control-Request-Headers': 'Authorization',
    // 'Referer': 'https://tx.circleproject.dev',
    Authorization: `Bearer ${authToken}`,
  };
  axios
    .get(api, {
      headers: headers,
    })
    .then(async function (response) {
      const data = response.data;
      let playerName = document.getElementById("player-name");
      let cashPoint = document.getElementById("cash-point");
      let vipExpire = document.getElementById("expire-vip");
      let point = parseInt(data.point);
      point = point.toLocaleString("en-US");
      playerName.innerHTML = data.first_name + " " + data.last_name;
      cashPoint.innerHTML = point;
      let dateFormat = new Date(data.expire_date_vip);
      vipExpire.innerHTML = `${dateFormat.getDate()}/${dateFormat.getMonth()}/${dateFormat.getFullYear()}`;
    })
    .catch(function (error) {
      console.log(JSON.stringify(error));
    });
}

function initItemsCashShop() {
  const api = "https://mongkol.dev/api/cash-shop/users/items";
  const headers = {
    // 'Host': 'https://circleproject.dev',
    // 'Origin': 'https://tx.circleproject.dev',
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    // 'Access-Control-Request-Method' : 'GET',
    // 'Access-Control-Request-Headers': 'Authorization',
    // 'Referer': 'https://tx.circleproject.dev',
    Authorization: `Bearer ${authToken}`,
  };
  axios
    .get(api, {
      headers: headers,
    })
    .then(async function (response) {
      const items = response.data;
      // console.log(items);
      let cashItems = document.getElementById("cash-items");
      items.forEach((item) => {
        let listItems = `<div class="bg-black/[0.5] rounded-lg w-fit p-[1vh]">
      <div class="text-center text-[1.2vh] w-[10vh]">${item.label_name} </div>
      <div class="flex justify-center mx-1">
        <div class="box-content w-[9vh] h-[9vh] relative flex justify-center">
        <div class="text-[1.2vh] absolute bottom-0 ">
        {
          item.limit_type === "00"
            ? ""
            : `${item.remaining_quantity}/${item.max_limit}`
        } </div>    
          <img
            src="nui://nc_inventory/html/img/items/${item.item_name}.png"
            class="w-[9vh] h-[9vh]"
          />
        </div>
      </div>
      <div
        class="mx-auto w-full h-[0.09vh] bg-gray-400 rounded-full"
      ></div>
      <div class="text-[1.6vh] text-center">${item.point} CC</div>
      <button
        class="btn-3d my-btn-class-32 h-[2.3vh] w-full rounded-md text-white select-none whitespace-nowrap flex items-center justify-center"
        onclick="confirmModel('${item.item_name}')"
      >
        <div class="box-content h-[1.7] w-[1.7vh]">
          <img
            src="img/reset.png"
            class="box-content h-[1.5] w-[1.5vh] mb-[0.2vh]"
          />
        </div>
      </button>
    </div>`;
        cashItems.innerHTML += listItems;
      });
    })
    .catch(function (error) {
      console.log(JSON.stringify(error));
    });
}

function buyItem(itemName) {
  const inputValue = document.getElementById("input-number").value;
  const modelContainer = document.getElementById("model-container");
  modelContainer.innerHTML = `
  <div class="flex flex-col items-center justify-center bg-gradient-to-b from-black/[0.6] to-teal-700/[0.8] rounded-[0.8vh] w-fit p-[1.5vh] text-white">
  <div>กำลังแลกเปลี่ยนสินค้า</div>
  <span class="loader mt-[0.5vh]"></span>
</div>`;

  data.name = itemName;
  data.quantity = parseInt(inputValue);
  // console.log(data);
  const api = "https://mongkol.dev/api/cash-shop/users/buy";
  const headers = {
    // 'Host': 'https://circleproject.dev',
    // 'Origin': 'https://tx.circleproject.dev',
    "Access-Control-Allow-Origin": "https://mongkol.dev",
    // 'Access-Control-Request-Method' : 'GET',
    // 'Access-Control-Request-Headers': 'Authorization',
    // 'Referer': 'https://tx.circleproject.dev',
    Authorization: `Bearer ${authToken}`,
  };
  axios
    .put(api, data, {
      headers: headers,
    })
    .then(async function (response) {
      const data = response.data;
      resultBuy(data.Message);
    })
    .catch(function (error) {
      console.log(JSON.stringify(error));
      resultBuy("fail");
    });
}

function resultBuy(Message) {
  const modelContainer = document.getElementById("model-container");
  modelContainer.innerHTML = ` <div
      class="bg-gradient-to-b from-black/[0.6] to-teal-700/[0.8] rounded-[0.8vh] w-fit p-[1.5vh] text-white relative"
    >
     <div class="text-center"> ${
       Message === "fail" ? "ทำการซื้อล้มเหลว" : "ทำการซื้อสำเร็จ"
     }</div>
        <div class="flex justify-center mt-[1vh]">
        <button
        class="${
          Message === "fail" ? "btn-3d-canclex" : "btn-3d"
        } h-[2.3vh] px-[2.5vh] rounded-md text-white select-none whitespace-nowrap flex items-center justify-center"
        onclick="cancleModel()">
        <div class="box-content h-[1.7] w-[1.7vh]">
          <img
            src="img/confirm.png"
            class="box-content h-[1.5] w-[1.5vh] mb-[0.2vh]"
          />
        </div>
      </button>
        </div>
    </div>`;
}

function closeUI() {
  $.post("https://cc_mysmarket/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      // console.log("closer")
      cancleModel()
      closeUI();
    }
  });
});

window.addEventListener("message", async function (event) {
  // console.log(event.data.auth)
  if (event.data.action === "openCashShop") {
    authToken = event.data.auth;
    $("body").fadeIn();
    let cashItems = document.getElementById("cash-items");
    cashItems.innerHTML = "";
    showSlides();
    initCashShop();
    initItemsCashShop();
  }

  if (event.data.action === "closeAll") {
    // console.log("ปิด")
    $("body").fadeOut();
    let cashItems = document.getElementById("cash-items");
    cashItems.innerHTML = "";
  }
});

function validateInput() {
  const inputField = document.getElementById("input-number");
  let inputValue = parseInt(inputField.value);

  if (inputValue <= 0 || isNaN(inputValue)) {
    inputValue = 1;
    return (inputField.value = inputValue);
  }
}
