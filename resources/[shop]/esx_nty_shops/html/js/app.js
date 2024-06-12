var Config = new Object();
Config.closeKeys = [27, 90];

let prices = {};
let maxes = {};
let zone = null;
let lastContainer = 0;
let container = 0;

function openMain() {
  $("body").fadeIn();
}
function closeUI() {
  // $("body").fadeOut()
  $.post("https://esx_nty_shops/quit", JSON.stringify({}));
}

window.addEventListener("message", async function (event) {
  let res = event.data;
  // console.log("in js");

  // Open & Close main window
  if (res.message === "show") {
    if (res.clear === true) {
      $("#container-shop").empty();
      prices = {};
      maxes = {};
      zone = null;
    }
    // openMain();
  }

  if (res.message === "hide") {
    container = 0;
    lastContainer = 0;
    $("body").fadeOut();
    // console.log(JSON.stringify(allJSONData))
  }

  if (res.message === "add") {
    await getItems(res.item, res.price, res.loc, res.label, res.type);
    openMain();
  }
});

async function getItems(item, price, location, label, type) {
  const shopContainer = document.getElementById("container-shop");
  if (container % 6 === 0 || container === 0) {
    // console.log(i)
    lastContainer += 1;
    shopContainer.innerHTML += `<div class="grid grid-cols-6 gap-3" id="shop-${lastContainer}">`;
  }
  const flexContainer = document.getElementById(`shop-${lastContainer}`);
  let HTMLCount;
  HTMLCount = `                    
                    <div class="flex mt-1.5 w-[12vh]">
                      <div
                        class="w-[20%] flex justify-center items-center ml-1"
                      >
                        <button
                          class="h-[2vh] w-[2vh] bg-gradient rounded flex items-center justify-center"
                           onclick="minusValue('${item}','${price}')"
                        >
                          -
                        </button>
                      </div>
                      <div class="flex justify-center items-center mx-1.5">
                        <input onchange="changeValueItems('${item}','${price}')"
                          type="number"
                          id="number-${item}"
                          class="box-content rounded bg-black/[0.5] h-[2vh] text-center text-[1.2vh] w-[100%]"
                          placeholder="จำนวน"
                          value="1"
                        />
                      </div>
                      <div
                        class="w-[20%] flex justify-center items-center mr-1"
                      >
                        <button
                          class="h-[2vh] w-[2vh] bg-gradient rounded flex items-center justify-center"
                          onclick="plusValue('${item}','${price}')"
                        >
                          +
                        </button>
                      </div>
                    </div>`;
  if (type === "weapon") HTMLCount = ``;

  flexContainer.innerHTML += `
                <div class="bg-black/[0.5] hover:bg-gradient-to-r from-[#ffcc00]/[0.3] to-[#ffa800]/[0.3] rounded-lg w-fit p-1.5  mb-[12px]">
                    <div
                      class="box-content bg-gradient-to-r from-[#ffcc00]/[0.3] to-[#ffa800]/[0.3] rounded w-[12vh] flex flex-col"
                    >
                    <div class="flex justify-center">${label}</div>
                      <div class="flex justify-center m-1">
                        <div class="box-content w-[8.5vh] h-[8.5vh]">
                          <img src="nui://nc_inventory/html/img/items/${item}.png" class="w-[8.5vh] h-[8.5vh]" />
                        </div>
                      </div>
                      
                      <div class="flex mb-1.5 mx-1.5">
                        <div
                          class="box-content bg-black/[0.5] w-full h-[2.2vh] flex items-center justify-center rounded"
                            id="price-${item}"
                        >
                          $ ${price}
                        </div>
                      </div>
                    </div>
                    ${HTMLCount}
                    <button
                      class="h-[2.5vh] w-full bg-gradient mt-1.5 rounded"
                      onclick="buyItem('${item}','${location}','${type}')"
                    >
                      CASH
                    </button>
                    <button
                      class="h-[2.5vh] w-full  bg-gradient mt-1.5 rounded"
                      onclick="buyItemCredit('${item}','${location}','${type}')"
                    >
                      CREDIT
                    </button>
                  </div>
        `;
  prices[item] = price;
  maxes[item] = 99;
  zone = location;
  container++;
}

function buyItem(itemName, location, type) {
  let count = 100;
  if (type === "economy") {
    count = document.getElementById(`number-${itemName}`).value;
  }
  if (type === "weapon") {
    count = 1;
  }

  $.post(
    "http://esx_nty_shops/purchase",
    JSON.stringify({
      item: itemName,
      count: count,
      type: type,
      loc: location,
    })
  );
}

function buyItemCredit(itemName, location, type) {
  let count = 100;

  if (type === "economy") {
    count = document.getElementById(`number-${itemName}`).value;
  }
  if (type === "weapon") {
    count = 1;
  }

  $.post(
    "http://esx_nty_shops/purchaseCredit",
    JSON.stringify({
      item: itemName,
      count: count,
      type: type,
      loc: location,
    })
  );
}

function plusValue(item, price) {
  // console.log(item)
  const priceContainer = document.getElementById(`price-${item}`);
  const quantity = document.getElementById(`number-${item}`);
  if (parseInt(quantity.value) === 100) {
    return;
  }
  quantity.value = parseInt(quantity.value) + parseInt(1);
  priceContainer.innerHTML = `$ ${parseInt(quantity.value) * price}`;
}

function minusValue(item, price) {
  // console.log(item)
  const priceContainer = document.getElementById(`price-${item}`);
  const quantity = document.getElementById(`number-${item}`);
  if (parseInt(quantity.value) === 1) return;
  quantity.value = parseInt(quantity.value) - parseInt(1);
  priceContainer.innerHTML = `$ ${parseInt(quantity.value) * price}`;
}

function changeValueItems(item, price) {
  const priceContainer = document.getElementById(`price-${item}`);
  const quantity = document.getElementById(`number-${item}`);
  quantity.value = parseInt(quantity.value);
  priceContainer.innerHTML = `$ ${parseInt(quantity.value) * price}`;
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});
