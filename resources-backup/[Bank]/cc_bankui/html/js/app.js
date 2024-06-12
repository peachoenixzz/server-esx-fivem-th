var Config = new Object();
Config.closeKeys = [27, 90];

window.addEventListener("message", async function (event) {
  let res = event.data;
  // console.log("in js");
  if (event.data.action === "openGeneral") {
    $("body").fadeIn();
    const inputs = document.querySelectorAll("input");
    inputs.forEach((input) => {
      input.value = "";
    });
    // console.log(JSON.stringify(allJSONData))
  }

  if (event.data.action === "closeAll") {
    $("body").fadeOut();
    // $("body").hide();
  }

  if (event.data.action === "balanceHUD") {
    // console.log("show police")
    await updateBalance(res.player, res.balanceBank, res.balanceMoney);
    // console.log(JSON.stringify(allJSONData))
  }
});

async function updateBalance(name, bankBalance, cashBalance) {
  // console.log(name, bankBalance);
  const playerName = document.getElementById("player-name");
  playerName.innerHTML = name;
  const balance = document.getElementById("player-bank");
  balance.innerHTML = bankBalance.toLocaleString("en-US");
  const bank = document.getElementById("player-cash");
  bank.innerHTML = cashBalance.toLocaleString("en-US");
}

function deposit() {
  const withdrawBtn = document.getElementById("withdraw-btn");
  const depositBtn = document.getElementById("deposit-btn");
  const tranferBtn = document.getElementById("tranfer-btn");
  depositBtn.classList.add("gradient");
  withdrawBtn.classList.add("bg-black/[0.5]");
  tranferBtn.classList.add("bg-black/[0.5]");
  depositBtn.classList.remove("bg-black/[0.5]");
  withdrawBtn.classList.remove("gradient");
  tranferBtn.classList.remove("gradient");
  const inputContainer = document.getElementById("input-container");
  inputContainer.innerHTML = `  
        <input
        type="text"
        id="deposit-input"
        class="box-content rounded-lg bg-[black]/[0.5] w-[100%] h-[2.5vh] text-center mb-2 mx-2"
        placeholder="จำนวน"
      />`;
}

function withdraw() {
  const withdrawBtn = document.getElementById("withdraw-btn");
  const depositBtn = document.getElementById("deposit-btn");
  const tranferBtn = document.getElementById("tranfer-btn");
  withdrawBtn.classList.add("gradient");
  tranferBtn.classList.add("bg-black/[0.5]");
  depositBtn.classList.add("bg-black/[0.5]");
  withdrawBtn.classList.remove("bg-black/[0.5]");
  depositBtn.classList.remove("gradient");
  tranferBtn.classList.remove("gradient");
  const inputContainer = document.getElementById("input-container");
  inputContainer.innerHTML = `  
        <input
        type="text"
        id="withdraw-input"
        class="box-content rounded-lg bg-[black]/[0.5] w-[100%] h-[2.5vh] text-center mb-2 mx-2"
        placeholder="จำนวน"
      />`;
}

function tranfer() {
  const withdrawBtn = document.getElementById("withdraw-btn");
  const depositBtn = document.getElementById("deposit-btn");
  const tranferBtn = document.getElementById("tranfer-btn");
  tranferBtn.classList.add("gradient");
  depositBtn.classList.add("bg-black/[0.5]");
  withdrawBtn.classList.add("bg-black/[0.5]");
  tranferBtn.classList.remove("bg-black/[0.5]");
  depositBtn.classList.remove("gradient");
  withdrawBtn.classList.remove("gradient");
  const inputContainer = document.getElementById("input-container");
  inputContainer.innerHTML = `  
        <input
        type="text"
        id="tranfer-input"
        name="#"
        class="box-content rounded-lg bg-[black]/[0.5] w-[100%] h-[2.5vh] text-center mb-2 mx-2"
        placeholder="จำนวน"
      />
        <input 
        type="text"
        placeholder="ID"
        id="tranferid-input"
        class="box-content rounded-lg bg-[black]/[0.5] w-[40%] h-[2.5vh] text-center mb-2 mr-2"
        />
        `;
}

function fastWithdraw(money) {
  if (parseInt(money) <= 0) return;
  $.post(
    "https://cc_bankui/withdrawl",
    JSON.stringify({
      amountw: money,
    })
  );
}

function confirmAction() {
  const withdraw = document.getElementById("withdraw-input");
  const deposit = document.getElementById("deposit-input");
  const tranfer = document.getElementById("tranfer-input");
  const tranferid = document.getElementById("tranferid-input");
  if (withdraw !== null) {
    if (withdraw.value !== "") {
      if (parseInt(withdraw.value) <= 0) return;
      $.post(
        "https://cc_bankui/withdrawl",
        JSON.stringify({
          amountw: withdraw.value,
        })
      );
    }
    return;
  }
  if (deposit !== null) {
    if (parseInt(deposit.value) <= 0) return;
    if (deposit.value !== "") {
      $.post(
        "https://cc_bankui/deposit",
        JSON.stringify({
          amount: deposit.value,
        })
      );
    }
    return;
  }
  if (tranfer !== null && tranferid !== null) {
    if (parseInt(tranfer.value) <= 0 && parseInt(tranferid.value) <= 0) return;
    if (tranfer.value !== "" && tranferid.value !== "") {
      $.post(
        "https://cc_bankui/transfer",
        JSON.stringify({
          amountt: tranfer.value,
          to: tranferid.value,
        })
      );
    }
  }
}

function closeUI() {
  // $( "body" ).fadeOut( "slow" );
  $.post("https://cc_bankui/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});
