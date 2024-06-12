// Partial Functions
let prices = {};
// let identifier = null;
let ID = null;
let itemDetail = null;
let itemSpecialDetail = null;
let showEcoSpecial = false;
let normalItem = null;
let specialItem = null;
let lastContainer = 0;
let container = 0;

function closeMain() {
  // $( "body" ).fadeOut( "slow" );
  $("body").css("display", "none");
  $("#sell-economy").css("display", "none");
  $("#sell-special-economy").css("display", "none");
  $("#all-economy").css("display", "none");
  $("#big-sell-economy").css("display", "none");
}

function openMain() {
  // $("body").css("display", "block");
  $("body").fadeIn();
  $("#all-economy").css("display", "block");
  // $("#all-economy").slideDown()
}

function closeAll() {
  // $( "body" ).fadeOut( "slow" );
  $("body").css("display", "none");
  $("#sell-economy").css("display", "none");
  $("#sell-special-economy").css("display", "none");
  $("#all-economy").css("display", "none");
  $("#big-sell-economy").css("display", "none");
}

$(".close").click(function () {
  $.post("https://cc_economy/quit", JSON.stringify({}));
});

async function SellItem(item, value) {
  await getDetailItem(item, value);
  $.post("https://cc_economy/sellitem", itemDetail);
}

function SellSpecialItem() {
  $.post("https://cc_economy/sellitem", itemSpecialDetail);
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});

function closeUI() {
  // $( "body" ).fadeOut( "slow" );
  $.post("https://cc_economy/quit", JSON.stringify({}));
}

function sendLocationPick(x, y) {
  $.post(
    "https://cc_economy/pickPosition",
    JSON.stringify({ position: { x: x, y: y } })
  );
}

function sendLocationProcess(x, y) {
  $.post(
    "https://cc_economy/processPosition",
    JSON.stringify({ position: { x: x, y: y } })
  );
}

function sendLocationPackage(x, y) {
  $.post(
    "https://cc_economy/packagePosition",
    JSON.stringify({ position: { x: x, y: y } })
  );
}

function sendLocationSell(x, y) {
  $.post(
    "https://cc_economy/sellPosition",
    JSON.stringify({ position: { x: x, y: y } })
  );
}

function openSellEconomy() {
  $("body").fadeIn("slow");
  $("#sell-economy").css("display", "block");
  $("#sell-special-economy").css("display", "block");
  $("#big-sell-economy").css("display", "block");
}

function getDetailItem(itemName, itemCount) {
  itemDetail = JSON.stringify({
    nameitem: itemName,
    count: itemCount,
  });
}

function getDetailItemSpecial(itemName, itemCount) {
  itemSpecialDetail = JSON.stringify({
    nameitem: itemName,
    count: itemCount,
  });
}

function changeValueNormal(item, prices) {
  // let item = normalItem;
  // console.log(item);
  // console.log(prices);
  const input = document.getElementById(`itemValue-${item}`);
  const price = document.getElementById(`itemPrice-${item}`);
  if (input.value < 0) {
    input.value = 0;
    price.innerHTML = parseInt(input.value * prices);
  }
  price.innerHTML = parseInt(input.value * prices);
  getDetailItem(item, parseInt(input.value));
}

window.addEventListener("message", async function (event) {
  let item = event.data;
  // Open & Close main window
  if (item.message === "show") {
    if (item.clear === true) {
      $("#main-shop").empty();
      prices = {};
    }
    showEcoSpecial = false;
    openMain();
  }

  if (item.message === "show-sell") {
    if (item.clear === true) {
      $("#sell-economy").empty();
      $("#sell-special-economy").empty();
      prices = {};
    }
    openSellEconomy();
  }

  if (item.message === "hide") {
    container = 0;
    lastContainer = 0;
    showEcoSpecial = false;
    closeMain();
  }

  if (item.message === "show-all-item") {
    let items = event.data.items;
    let itemsort = items.sort((a, b) => a.id - b.id);

    itemsort.forEach((item) => {
      const upPrice = `<span style="color:green; font-size:14px;">${item.price} ▲</span>`;
      const downPrice = `<span style="color:${
        item.pricedif === 0 ? "white" : "red"
      }; font-size:11px;">${item.price} ${
        item.pricedif === 0 ? "~" : "▼"
      }</span>`;
      document.getElementById("main-shop").innerHTML += `
             <div
            class="box-content bg-gradient-to-r from-[#ffcc00]/[0.3] to-[#ffa800]/[0.3] mx-1 mt-1 rounded  flex items-center justify-between text-[1.5vh]"
          >
            <div class="flex flex-row items-center justify-between text-white ">
              <div class="bg-black/[0.5] ml-1 mr-2 my-1 rounded w-[4vh] h-[4vh] ">
                <img class="w-[4vh] h-[4vh]" src="nui://nc_inventory/html/img/items/${
                  item.item
                }.png" />
              </div>
              <div
              class="box-content flex-row items-center justify-center h-[4vh]"
            >
              <div class="drop-shadow">${item.label}</div>
              <div class="flex items-center">
                <i
                  class="fa-solid fa-location-dot text-[1.2vh] mr-[0.8vh] tooltip cursor-pointer"
                  id="L-pick"
                  style="color: white"
                  onclick="sendLocationPick('${item.pickPosition.x}','${
        item.pickPosition.y
      }')"
                  ><span class="tooltiptext">ตำแหน่งจุดเก็บ</span></i
                >
                <i
                  class="fa-solid fa-box text-[1.2vh] mr-[0.8vh] tooltip cursor-pointe"
                  id="L-package"
                  style="color: white"
                  onclick="sendLocationProcess('${item.processPosition.x}','${
        item.processPosition.y
      }')"
                  ><span class="tooltiptext">ตำแหน่งผลิต</span></i
                >
                <i
                class="fa-solid fa-dollar-sign text-[1.2vh] mr-[0.8vh] tooltip cursor-pointer"
                id="L-sell"
                style="color: white"
                onclick="sendLocationSell('${item.sellPosition.x}','${
        item.sellPosition.y
      }')"
                ><span class="tooltiptext">ตำแหน่งขาย</span></i
              >
              </div>
            </div>
            </div>
            <div
              class="px-[1vh] h-[2.5vh] bg-black/[0.5] mr-1 my-1 rounded text-white drop-shadow font-bold flex items-center justify-center"
            >
              ${
                item.pricemax === item.pricemin
                  ? `${item.pricemax}`
                  : `${item.pricemin} ~ ${item.pricemax}`
              }
            </div>
          </div>
  `;
    });
  }

  if (item.message === "sell") {
    let items = event.data.items;
    items.forEach((item) => {
      if (item.position_item === item.position_npc) {
        const upPrice = `<span style="color:green; font-size:14px;">▲</span>`;
        const downPrice = `<span style="color:${
          item.pricedif === 0 ? "gray" : "red"
        }; font-size:11px;">${item.pricedif === 0 ? "~" : "▼"}</span>`;
        const summary = item.pricemax * item.max;
        getDetailItem(item.item, item.max);
        const sellContainer = document.getElementById("sell-economy");
        if (container % 3 === 0 || container === 0) {
          lastContainer += 1;
          sellContainer.innerHTML += `<div class="grid grid-cols-3 gap-3  mb-3" id="sell-${lastContainer}">`;
        }
        document.getElementById(`sell-${lastContainer}`).innerHTML += `
    <div class="bg-black/[0.5] rounded-lg w-[23vh]" id="economy-${
      item.label
    }">          
      <div
        class="relative container bg-gradient-to-r from-[#ffcc00] to-[#ffa800] text-white font-bold  p-1 rounded-t-lg flex items-center justify-center  text-[1.6vh]"
      >
      <div class="absolute inset-0 z-10">
            <img
              src="img/cloud_texture2.png"
              class="w-full h-full object-cover opacity-70"
            />
          </div>
          <div class="font-bold" style="text-shadow: 1px 1px 1px black">     
        ${item.label}
       </div>
      </div>
      <div class="flex">
        <div class="w-[35%]">
          <div
            class="box-content   bg-gradient-to-r from-[#ffcc00]/[0.3] to-[#ffa800]/[0.3] w-[5vh] h-[5vh] ml-2 my-2 rounded-lg"
          >
          <img src="nui://nc_inventory/html/img/items/${
            item.item
          }.png" class="w-[5vh] h-[5vh]" />
        </div>
        </div>
        <div
          class="w-[60%] text-white flex flex-col items-center justify-center"
        >
          <div>
            <span class="text-[1.6vh] font-bold">ราคาตั้งแต่</span>
          </div>
          <div  class="w-[60%] text-white flex flex-col items-center justify-center ><span class=" text-[1.5vh] font-bold">${
            item.pricemax === item.pricemin
              ? `${item.pricemax}`
              : `${item.pricemin} ~ ${item.pricemax}`
          }</span></div>
          <div class="text-[1.6vh]">
              จำนวน :
              <input
                min = "0"
                id="itemValue-${item.item}"
                value="${item.max}"
                onkeyup="changeValueNormal('${item.item}', ${item.pricemax})"
                type="number"
                class="box-content bg-black/[0.8] w-[5vh] rounded-[0.6vh] text-center"
              />
            </div>
        </div>
      </div>
      <div class="mx-2 my-2 flex justify-between text-white text-[1.66vh]">
        <div class="flex justify-center items-center w-[60%]">
          <div class="flex text-[1.5vh]">ได้รับสูงสุด $<span id="itemPrice-${
            item.item
          }">${summary.toLocaleString("en-US")}</span></div>
        </div>

        <button
          class="bg-gradient-to-b from-[#ffcc00] to-[#a66a02] font-bold px-6 py-1 rounded-lg mb-2  text-[1.6vh]"
          onclick="SellItem('${
            item.item
          }', document.getElementById('itemValue-${item.item}').value)"
          ${item.max > 0 ? "" : "disable"}
        >
          ${item.max > 0 ? "ขาย" : "..."}  
        </button>
      </div>
    </div> 
    `;
        if (item.max <= 0) {
          let ecoDom = document.getElementById(`economy-${item.label}`);
          ecoDom.classList.add("opacity-30");
          ecoDom.classList.add("grayscale");
        }
        container++;
      }
      if (
        item.position_item === "eco_special" &&
        !showEcoSpecial &&
        item.max > 0
      ) {
        specialItem = item;
        getDetailItemSpecial(item.item, item.max);
        document.getElementById("sell-special-economy").innerHTML += `   
       <div class="flex">
        <div class="w-[45%]">
          <div
            class="box-content bg-gradient-to-r from-[#ffcc00]/[0.3] to-[#ffa800]/[0.3] w-[7vh] h-[7vh] mx-2 my-2 rounded-lg"
          >
              <img
                src="nui://nc_inventory/html/img/items/${item.item}.png"
              class="w-[7vh] h-[7vh]"/>
        </div>
        </div>
        <div class="w-[55%] text-white flex justify-end">
          <div class="rounded-lg flex flex-col items-center">
            <div class="text-[2vh]">$ ${item.price}</div>
            <button
              class="flex items-center bg-gradient-to-b from-[#ffcc00]/[0.3] to-[#a66a02]/[0.3] font-bold  px-[2vh] py-1 rounded-lg mt-1 hover:bg-gradient-to-r from-[#ffcc00] to-[#a66a02] text-[2vh]"
              onclick="SellSpecialItem()" ${item.max > 0 ? "" : "disable"}
            >
              ${item.max > 0 ? "ขาย" : "..."}
            </button>
          </div>
        </div>
      </div>
`;
        showEcoSpecial = true;
      }
    });
  }
});

// <i
//     className="fa-solid fa-arrows-spin text-[1.2vh] mr-[0.8vh] tooltip cursor-pointer"
//     id="L-processs"
//     style="color: white"
//     onClick="sendLocationProcess('${item.processPosition.x}','${item.processPosition.y}')"
// ><span className="tooltiptext">ตำแหน่งโพสเซส</span></i
// >
