var Config = new Object();
Config.closeKeys = [27, 90];
let allBilling = 0;
window.addEventListener("message", async function (event) {
  let res = event.data;
  // console.log("in js");
  const mainContainer = document.getElementById("main-container");
  if (event.data.action === "openBill") {
    mainContainer.classList.add("animate-pulse");
    $("body").fadeIn();
    document.getElementById("bill-container").innerHTML = "";
    allBilling = 0;
    // console.log(JSON.stringify(allJSONData))
  }

  if (event.data.action === "closeAll") {
    $("body").fadeOut();
    allBilling = 0;
    // $("body").hide();
  }

  if (event.data.action === "updateBill") {
    // console.log("show police")
    mainContainer.classList.remove("animate-pulse");
    console.log(JSON.stringify(event.data.allbill));
    await updateBill(event.data.allbill);
    // console.log(JSON.stringify(allJSONData))
  }
});
// toLocaleString("en-US");

function updateBill(bill) {
  const billContainer = document.getElementById("bill-container");
  bill.forEach((v) => {
    billContainer.innerHTML += `
                <div
                class="box-content bg-black/[0.5] hover:bg-gradient-to-r from-[#ffcc00]/[0.3] to-[#ffa800]/[0.3] rounded"
                id="detail-container-${v.id}"
              >
                <div class="flex items-center justify-between w-[26vh]">
                  <div class="m-1.5 w-[70%]">
                    <div class="w-[100%] break-all">${v.label}</div>
                    <div>$${v.amount.toLocaleString("en-US")}</div>
                  </div>
                  <button id="${v.id}" onclick="payBill(${
      v.id
    })" class="box-content w-[3vh] h-[3vh] mx-1.5 rounded-lg">
                    <img src="img/import.png" />
                  </button>
                </div>
              </div>
    `;
    allBilling += v.amount;
  });
  const allBill = document.getElementById("all-bill-price");
  allBill.innerHTML = `$${allBilling.toLocaleString("en-US")}`;
}

function payBill(id) {
  $.post(
    "https://esx_billing/payBill",
    JSON.stringify({
      id: id,
    })
  );
}

function closeUI() {
  // $( "body" ).fadeOut( "slow" );
  $.post("https://esx_billing/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});
