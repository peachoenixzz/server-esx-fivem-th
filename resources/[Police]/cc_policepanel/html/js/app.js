// const axios = require('axios').default;

var Config = new Object();
Config.closeKeys = [27];

let mins = 0;
let miliSeconds = 0;
let fineAllCalulate = 0;

let playerArrestID = null;
let token;
let oldFine = 0;
let oldImprison = 0;

let inputCal = {
  illegal_money_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_screwdv: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_drug_skull: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_storerobbery: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  housebreaking_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_cement_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_ice_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_heroin_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_amp_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_n_amp_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_cocaine_pack_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_ice_pack_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_cocaine_case: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_keycard: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_microchip: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_box_amp: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_box_supermarket: {
    imprison: 0,
    fine: 0,
    count: 0,
  },

  illegal_box_exhibit: {
    imprison: 0,
    fine: 0,
    count: 0,
  },


  decrease_imprison: {
    imprison: 0,
    fine: 0,
    count: 0,
  },
};

let allJSONData = {
  arrest_player_name: "",
  police_player_name: "",
  arrest_steam_player_name: "",
  police_steam_player_name: "",
  arrest_job_player: "",
  arrest_sex_player: "",
  case: [],
  case_quantity: [],
  case_custom: [],
  time_custom: [],
  fine_custom: [],
  all_milisec: 0,
  all_mins: 0,
  all_fine: 0,
  police_decrease_time: 0,
};

let chargeCase = {
  name: "",
  label_name: "",
  fine: 0,
  imprison: 0,
};

const addChargeBtn = document.getElementById("add-charge");
const listChargeData = document.getElementById("charge-optional-all");
const addImprisonBtn = document.getElementById("add-imprison");
const listImprisonData = document.getElementById("imprison-optional-all");
const addFineBtn = document.getElementById("add-fine");
const listFineData = document.getElementById("fine-optional-all");
const fineAll = document.getElementById("fine-all");
const imprisonAll = document.getElementById("imprison-mins");
addFineBtn.addEventListener("click", async function () {
  let inputFine = document.getElementById("input-fine").value;
  if (inputFine === "" || !/^\d*$/.test(inputFine)) {
    //!/^\d*$/.test(inputCharge) ||
    // console.log("wrong in put")
    return;
  }
  allJSONData.fine_custom.push(inputFine);
  const lengthCaseCustom = allJSONData.fine_custom.length;
  // console.log("input : "+inputCharge)
  // console.log(lengthCaseCustom)
  listFineData.innerHTML += `   <div class="flex justify-between items-center" id="fine-${
    lengthCaseCustom === 0 ? 1 : lengthCaseCustom
  }">
              <div > $ ${inputFine}</div>
                <button class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-sm w-[2vh] h-[2vh] text-white text-[1.5vh] flex justify-center items-center mx-2" name="button-delete-fine" id="delete-fine-custom-${
                  lengthCaseCustom === 0 ? 1 : lengthCaseCustom
                }">
                  X
                </button>
              </div>
             </div>
        `;
  document.getElementById("input-fine").value = "";
  fineAllCalulate = await addFine(inputFine);
  // console.log(allJSONData.fine_custom);
  fineAll.innerHTML = fineAllCalulate;
  imprisonAll.innerHTML = mins;
  const deleteButtons = document.querySelectorAll(
    '[name="button-delete-fine"]'
  );
  deleteButtons.forEach((button) => {
    button.addEventListener("click", async function (event) {
      const button = event.target;
      const fineCustom = button.parentNode;
      if (fineCustom === null) return;
      // console.log("case id : " + fineCustom.id);
      const arrayIndex = parseInt(fineCustom.id.replace("fine-", "")) - 1;
      // console.log(arrayIndex)
      await decreaseFine(allJSONData.fine_custom[arrayIndex]);
      allJSONData.fine_custom.splice(arrayIndex, 1);
      fineAll.innerHTML = fineAllCalulate;
      imprisonAll.innerHTML = mins;
      listFineData.removeChild(fineCustom);
    });
  });
});

addImprisonBtn.addEventListener("click", async function () {
  let inputImprison = document.getElementById("input-imprison").value;
  if (inputImprison === "" || !/^\d*$/.test(inputImprison)) {
    //!/^\d*$/.test(inputCharge) ||
    // console.log("wrong in put")
    return;
  }
  allJSONData.time_custom.push(inputImprison);
  const lengthCaseCustom = allJSONData.time_custom.length;
  // console.log("input : "+inputCharge)
  // console.log(lengthCaseCustom)
  const mili = inputImprison * 60 * 1000;
  // console.log(mili);
  miliSeconds = await addMiliSeconds(mili);
  mins = await milliSecondstoMin(miliSeconds);
  listImprisonData.innerHTML += `   <div class="flex justify-between items-center" id="time-${
    lengthCaseCustom === 0 ? 1 : lengthCaseCustom
  }">
              <div >${inputImprison} นาที</div>
                <button class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-sm w-[2vh] h-[2vh] text-white text-[1.5vh] flex justify-center items-center mx-2" name="button-delete-time" id="delete-time-custom-${
                  lengthCaseCustom === 0 ? 1 : lengthCaseCustom
                }">
                  X
                </button>
              </div>
             </div>
        `;
  fineAll.innerHTML = fineAllCalulate;
  imprisonAll.innerHTML = mins;
  document.getElementById("input-imprison").value = "";
  // console.log(allJSONData.time_custom);
  const deleteButtons = document.querySelectorAll(
    '[name="button-delete-time"]'
  );
  deleteButtons.forEach((button) => {
    button.addEventListener("click", async function (event) {
      const button = event.target;
      const timeCustom = button.parentNode;
      if (timeCustom === null) return;
      // console.log("case id : " + timeCustom.id);
      const arrayIndex = parseInt(timeCustom.id.replace("time-", "")) - 1;
      // console.log(arrayIndex)
      const mili = allJSONData.time_custom[arrayIndex] * 60 * 1000;
      miliSeconds = await decreaseMiliSeconds(mili);
      mins = await milliSecondstoMin(miliSeconds);
      allJSONData.time_custom.splice(arrayIndex, 1);
      fineAll.innerHTML = fineAllCalulate;
      imprisonAll.innerHTML = mins;
      listImprisonData.removeChild(timeCustom);
    });
  });
});

addChargeBtn.addEventListener("click", async function () {
  let inputCharge = document.getElementById("input-charge").value;
  if (inputCharge === "") {
    //!/^\d*$/.test(inputCharge) ||
    // console.log("wrong in put")
    return;
  }
  allJSONData.case_custom.push(inputCharge);
  const lengthCaseCustom = allJSONData.case_custom.length;
  // console.log("input : "+inputCharge)
  // console.log(lengthCaseCustom)
  listChargeData.innerHTML += `   <div class="flex justify-between items-center" id="case-${
    lengthCaseCustom === 0 ? 1 : lengthCaseCustom
  }">
              <div>${inputCharge}</div>
                <button class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-sm w-[2vh] h-[2vh] text-white text-[1.5vh] flex justify-center items-center mx-2" name="button-delete-case" id="delete-case-custom-${
                  lengthCaseCustom === 0 ? 1 : lengthCaseCustom
                }">
                  X
                </button>
              </div>
             </div>
        `;
  document.getElementById("input-charge").value = "";
  // console.log(allJSONData.case_custom);
  const deleteButtons = document.querySelectorAll(
    '[name="button-delete-case"]'
  );

  deleteButtons.forEach((button) => {
    // console.log(button);
    button.addEventListener("click", async function (event) {
      const button = event.target;
      // console.log(button);

      const caseCustom = button.parentNode;
      // console.log(caseCustom);
      if (caseCustom === null) return;

      // console.log("case id : " + caseCustom.id);
      const arrayIndex = parseInt(caseCustom.id.replace("case-", "")) - 1;
      // console.log(arrayIndex);
      allJSONData.case_custom.splice(arrayIndex, 1);
      listChargeData.removeChild(caseCustom);
    });
  });
});

async function resetPanel() {
  const checkboxes = document.querySelectorAll('input[type="checkbox"]');
  checkboxes.forEach((checkbox) => {
    checkbox.checked = false;
  });
  const inputs = document.querySelectorAll("input");
  inputs.forEach((input) => {
    input.value = "";
  });
  allJSONData = {
    arrest_player_name: "",
    police_player_name: "",
    arrest_steam_player_name: "",
    police_steam_player_name: "",
    arrest_job_player: "",
    arrest_sex_player: "",
    case: [],
    case_quantity: [],
    case_custom: [],
    time_custom: [],
    fine_custom: [],
    all_milisec: 0,
    all_mins: 0,
    all_fine: 0,
    police_decrease_time: 0,
  };
  inputCal = {
    illegal_money_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_cement_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_ice_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_drug_skull: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_heroin_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_n_amp_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_amp_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_screwdv: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_storerobbery: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    housebreaking_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_microchip: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_box_amp: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_box_supermarket: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_keycard: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_cocaine_pack_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_ice_pack_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_cocaine_case: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    illegal_box_exhibit: {
      imprison: 0,
      fine: 0,
      count: 0,
    },

    decrease_imprison: {
      imprison: 0,
      fine: 0,
      count: 0,
    },
  };
  mins = 0;
  miliSeconds = 0;
  fineAllCalulate = 0;
  listImprisonData.innerHTML = "";
  listFineData.innerHTML = "";
  listChargeData.innerHTML = "";
  fineAll.innerHTML = 0;
  imprisonAll.innerHTML = 0;
  document.getElementById("optional-zone").innerHTML = "";
}

window.addEventListener("message", async function (event) {
  let res = event.data;
  // console.log("in js")
  if (event.data.action === "showPolicePanel") {
    // console.log("show police");
    await resetPanel();
    $("body").fadeIn();
    document.getElementById("arrest-player").innerHTML += res.closetPlayer;
    document.getElementById("police-player").innerHTML += res.policePlayer;
    allJSONData.arrest_player_name = res.nameLabel;
    allJSONData.police_player_name = res.policePlayer;
    allJSONData.arrest_steam_player_name = res.closetPlayer;
    allJSONData.police_steam_player_name = res.policePlayer;
    allJSONData.arrest_job_player = res.jobLabel;
    allJSONData.arrest_sex_player = res.sexLabel;
    playerArrestID = res.player;
    token = res.token;
    // console.log(JSON.stringify(allJSONData))
  }

  if (event.data.action === "hidePolicePanel") {
    // console.log("hide police");
    $("body").hide();
    document.getElementById("arrest-player").innerHTML = "";
    document.getElementById("police-player").innerHTML = "";
    // console.log(JSON.stringify(allJSONData))
  }
});

async function handleQuantity(element)
{
  const checkbox = document.querySelector(`[data-name="${element.id}"]`);
  if (element.value >= 1 && checkbox.checked) {
    await summaryQuantity(element);
  } else {
  }
}

async function summaryQuantity(element) {
  const fineAll = document.getElementById("fine-all");
  const imprisonAll = document.getElementById("imprison-mins");
  const id = element.id;
  // console.log(id);
  const dataCheckbox = document.querySelector(`[data-name="${id}"]`);
  // console.log(dataCheckbox)
  let fine = dataCheckbox.getAttribute("data-fine");
  let imprison = dataCheckbox.getAttribute("data-imprison");
  const chnageValuefine = document.getElementById(id + "-fine");
  const newValuefine = (
    parseInt(fine) * parseInt(element.value)
  ).toLocaleString();
  chnageValuefine.innerHTML = "$ " + newValuefine;
  const chnageValueimprison = document.getElementById(id + "-time");
  const newValueimprison = (
    (parseInt(imprison) / 60000) *
    parseInt(element.value)
  ).toLocaleString();
  chnageValueimprison.innerHTML = newValueimprison + " นาที";

  if (dataCheckbox.getAttribute("data-imprison") != 0) {
    miliSeconds -= inputCal[id].imprison;
    imprison *= element.value;
    miliSeconds = await addMiliSeconds(imprison);
    mins = await milliSecondstoMin(miliSeconds);
    inputCal[id].imprison = imprison;
  }
  inputCal[id].count = element.value;
  fineAllCalulate -= inputCal[id].fine;
  fine *= element.value;
  fineAllCalulate = await addFine(fine);
  inputCal[id].fine = fine;
  const newfineAllCalulate = fineAllCalulate.toLocaleString();
  fineAll.innerHTML = newfineAllCalulate;
  imprisonAll.innerHTML = mins;
}

const checkboxes = document.querySelectorAll('input[type="checkbox"]');
checkboxes.forEach((checkbox) => {
  checkbox.addEventListener("click", async function () {
    const fine = checkbox.getAttribute("data-fine");
    const imprison = checkbox.getAttribute("data-imprison");
    const fineAll = document.getElementById("fine-all");
    const imprisonAll = document.getElementById("imprison-mins");
    const name = checkbox.getAttribute("data-name");
    const labelName = checkbox.getAttribute("data-labelname");
    // const labeldiv = document.getElementById("charge-optional-all");
    // const imprisonDiv = document.getElementById("imprison-optional-all");
    // const finediv = document.getElementById("fine-optional-all");

    if (checkbox.checked) {
      const minOfselect = parseInt(imprison) / 60000;
      const fineOfselect = parseInt(fine).toLocaleString();

      if (document.getElementById(name) != null) {
        // console.log("have id to enable input");
        const fineOfselectminus = parseInt(fine) - parseInt(fine);
        const minOfselectminus = parseInt(imprison) - parseInt(imprison);
        document.getElementById(name).disabled = false;
        listChargeData.innerHTML += `<div id="${name}-casename"> - ${labelName}</div>`;
        listImprisonData.innerHTML += `<div id="${name}-time">${minOfselectminus} นาที</div>`;
        listFineData.innerHTML += `<div id="${name}-fine">$ ${fineOfselectminus}</div>`;

        deleteButtonsCase();
        deleteButtonsFine();
        deleteButtonsImprison();

        return;
      }
      miliSeconds = await addMiliSeconds(imprison);
      mins = await milliSecondstoMin(miliSeconds);
      fineAllCalulate = await addFine(fine);
      const newfineAllCalulate = fineAllCalulate.toLocaleString();
      listChargeData.innerHTML += `<div id="${name}-casename"> - ${labelName}</div>`;
      listImprisonData.innerHTML += `<div id="${name}-time">${minOfselect} นาที</div>`;
      listFineData.innerHTML += `<div id="${name}-fine">$ ${fineOfselect}</div>`;

      deleteButtonsCase();
      deleteButtonsFine();
      deleteButtonsImprison();
      // fineAllCalulate = await addFine(fine);
      // miliSeconds = await addMiliSeconds(imprison);
      // mins = await milliSecondstoMin(miliSeconds);

      chargeCase.name = checkbox.getAttribute("data-name");
      chargeCase.imprison = checkbox.getAttribute("data-imprison");
      chargeCase.fine = checkbox.getAttribute("data-fine");
      chargeCase.label_name = checkbox.getAttribute("data-labelname");
      allJSONData.case.push(JSON.stringify(chargeCase));
      fineAll.innerHTML = newfineAllCalulate;
      imprisonAll.innerHTML = mins;
    } else {
      const labelName = checkbox.getAttribute("data-labelname");
      const itemIndex = allJSONData.case.findIndex(
        (caseName) => caseName.label_name === labelName
      );

      if (itemIndex > -1) {
        allJSONData.case.splice(itemIndex, 1);
      }

      if (document.getElementById(name) != null) {
        document.getElementById(name).disabled = true;
        document.getElementById(name).value = "";
        await decreaseFineTotalInput(name);
        await decreaseImprisonTotalInput(name);
        mins = await milliSecondstoMin(miliSeconds);
        // console.log(allJSONData.case);
        const labelElement = document.getElementById(`${name}-casename`);
        const imprisonElement = document.getElementById(`${name}-time`);
        const fineElement = document.getElementById(`${name}-fine`);

        if (labelElement) {
          listChargeData.removeChild(labelElement);
        }

        if (imprisonElement) {
          listImprisonData.removeChild(imprisonElement);
        }

        if (fineElement) {
          listFineData.removeChild(fineElement);
        }
        fineAll.innerHTML = fineAllCalulate;
        imprisonAll.innerHTML = mins;
        return;
      }
      const labelElement = document.getElementById(`${name}-casename`);
      const imprisonElement = document.getElementById(`${name}-time`);
      const fineElement = document.getElementById(`${name}-fine`);

      if (labelElement) {
        listChargeData.removeChild(labelElement);
      }

      if (imprisonElement) {
        listImprisonData.removeChild(imprisonElement);
      }

      if (fineElement) {
        listFineData.removeChild(fineElement);
      }
      fineAllCalulate = await decreaseFine(fine);
      miliSeconds = await decreaseMiliSeconds(imprison);
      mins = await milliSecondstoMin(miliSeconds);
      fineAll.innerHTML = fineAllCalulate;
      imprisonAll.innerHTML = mins;
      // console.log(allJSONData.case);
    }
  });
});

function processLaw() {
  // console.log(miliSeconds)
  oldImprison = mins;
  oldFine = fineAllCalulate;
  if (fineAllCalulate > 0 && miliSeconds === 0) {
    document.getElementById("optional-zone").innerHTML = `
          <button
           class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2.5"
            onclick="fineOnly()"
          >
            สั่งจ่ายบิล
          </button>
            `;
  }
  if (fineAllCalulate > 0 && miliSeconds > 0) {
    document.getElementById("optional-zone").innerHTML = `
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
                        onclick="jailAtBolingbrokePenitentiary('left')"
          >
             คุกซ้าย
          </button>
          
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
                        onclick="jailAtBolingbrokePenitentiary('default')"
          >
            คุกกลาง
          </button>
          
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
                        onclick="jailAtBolingbrokePenitentiary('right')"
          >
             คุกขวา
          </button>
          
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
            onclick="jailAtPoliceStation()"
          >
            จำคุกใต้ สน.
          </button>
            `;
  }

  if (miliSeconds > 0 && fineAllCalulate === 0) {
    document.getElementById("optional-zone").innerHTML = `
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
                        onclick="jailAtBolingbrokePenitentiary('left')"
          >
             คุกซ้าย
          </button>
          
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
                        onclick="jailAtBolingbrokePenitentiary('default')"
          >
            คุกกลาง
          </button>
          
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
                        onclick="jailAtBolingbrokePenitentiary('right')"
          >
             คุกขวา
          </button>
          
          <button
          class="bg-black hover:bg-gradient-to-b from-[#ffa800] to-[#ffcc00] rounded-lg mb-2 text-center text-white w-[12vh] h-[3vh] mx-2"
            onclick="jailAtPoliceStation()"
          >
            จำคุกใต้ สน.
          </button>
            `;
  }
  if (fineAllCalulate === 0 && miliSeconds === 0) {
    document.getElementById("optional-zone").innerHTML = "";
  }
}

async function milliSecondstoMin(milisec) {
  return (mins = milisec / 1000 / 60);
}

async function addMiliSeconds(milisec) {
  return (miliSeconds += parseInt(milisec));
}

async function addFine(fine) {
  return (fineAllCalulate += parseInt(fine));
}

async function decreaseFineTotalInput(valueCase) {
  // console.log(inputCal[valueCase].fine);
  fineAllCalulate -= inputCal[valueCase].fine;
  inputCal[valueCase].fine = 0;
  return fineAllCalulate;
}

async function decreaseImprisonTotalInput(valueCase) {
  miliSeconds -= inputCal[valueCase].imprison;
  inputCal[valueCase].imprison = 0;
  return miliSeconds;
}

async function decreaseFine(fine) {
  return (fineAllCalulate -= parseInt(fine));
}

async function decreaseMiliSeconds(milisec) {
  return (miliSeconds -= parseInt(milisec));
}

async function deleteButtonsCase() {
  const deleteButtons = document.querySelectorAll(
    '[name="button-delete-case"]'
  );

  deleteButtons.forEach((button) => {
    // console.log(button);
    button.addEventListener("click", async function (event) {
      const button = event.target;
      // console.log(button);

      const caseCustom = button.parentNode;
      // console.log(caseCustom);
      if (caseCustom === null) return;

      console.log("case id : " + caseCustom.id);
      const arrayIndex = parseInt(caseCustom.id.replace("case-", "")) - 1;
      // console.log(arrayIndex);
      allJSONData.case_custom.splice(arrayIndex, 1);
      listChargeData.removeChild(caseCustom);
    });
  });
}

async function deleteButtonsImprison() {
  const deleteButtons = document.querySelectorAll(
    '[name="button-delete-time"]'
  );
  deleteButtons.forEach((button) => {
    button.addEventListener("click", async function (event) {
      const button = event.target;
      const timeCustom = button.parentNode;
      if (timeCustom === null) return;
      // console.log("case id : " + timeCustom.id);
      const arrayIndex = parseInt(timeCustom.id.replace("time-", "")) - 1;
      // console.log(arrayIndex)
      const mili = allJSONData.time_custom[arrayIndex] * 60 * 1000;
      miliSeconds = await decreaseMiliSeconds(mili);
      mins = await milliSecondstoMin(miliSeconds);
      allJSONData.time_custom.splice(arrayIndex, 1);
      fineAll.innerHTML = fineAllCalulate;
      imprisonAll.innerHTML = mins;
      listImprisonData.removeChild(timeCustom);
    });
  });
}
async function deleteButtonsFine() {
  const deleteButtons = document.querySelectorAll(
    '[name="button-delete-fine"]'
  );
  deleteButtons.forEach((button) => {
    button.addEventListener("click", async function (event) {
      const button = event.target;
      const fineCustom = button.parentNode;
      if (fineCustom === null) return;
      // console.log("case id : " + fineCustom.id);
      const arrayIndex = parseInt(fineCustom.id.replace("fine-", "")) - 1;
      // console.log(arrayIndex)
      await decreaseFine(allJSONData.fine_custom[arrayIndex]);
      allJSONData.fine_custom.splice(arrayIndex, 1);
      fineAll.innerHTML = fineAllCalulate;
      imprisonAll.innerHTML = mins;
      listFineData.removeChild(fineCustom);
    });
  });
}

function closeMain() {
  // $( "body" ).fadeOut( "slow" );
  $("body").css("display", "none");
}

function closeUI() {
  // $( "body" ).fadeOut( "slow" );
  $.post("https://cc_policepanel/quit", JSON.stringify({}));
}

function jailAtPoliceStation() {
  if (oldFine !== fineAllCalulate && oldImprison !== mins) {
    $.post(
      "https://cc_policepanel/notify",
      JSON.stringify({
        description: "กรุณาประมวลคดีอีกครั้ง",
        type: "warning",
      })
    );
    return;
  }

  let title;

  if (allJSONData.case_custom.length !== 0) {
    title = allJSONData.case_custom[0];
  }

  if (allJSONData.case.length !== 0) {
    const titleJson = JSON.parse(allJSONData.case[0]);
    title = titleJson.label_name;
  }

  if (allJSONData.case_custom.length === 0 && allJSONData.case.length === 0) {
    title = "ครอบครองสิ่งของผิดกฎหมาย";
  }

  // console.log(allJSONData.case[0].name);
  allJSONData.case_quantity.push(JSON.stringify(inputCal));
  allJSONData.police_decrease_time = inputCal.decrease_imprison.imprison;
  allJSONData.all_milisec = miliSeconds;
  allJSONData.all_mins = mins;
  allJSONData.all_fine = fineAllCalulate;
  axios
    .post("https://mongkol.dev/api/policelog/create", allJSONData, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
    .then((response) => {
      // console.log(response.status)
      if (response.status !== 201) return;
      $.post(
        "https://cc_policepanel/policeStation",
        JSON.stringify({
          closet_player: playerArrestID,
          jail_time: mins,
          fine: fineAllCalulate,
          title: title,
        })
      );
      $.post(
        "https://cc_policepanel/notify",
        JSON.stringify({
          description: "ประมวลคดีสำเร็จ",
          type: "success",
        })
      );
      oldImprison = 0;
      oldFine = 0;
    })
    .catch((error) => {
      console.error(error);
    });
  closeUI();
}

function fineOnly() {
  if (oldFine != fineAllCalulate && oldImprison != mins) {
    $.post(
      "https://cc_policepanel/notify",
      JSON.stringify({
        description: "กรุณาประมวลคดีอีกครั้ง",
        type: "warning",
      })
    );
    return;
  }

  let title;
  if (allJSONData.case_custom.length !== 0) {
    title = allJSONData.case_custom[0];
  }

  if (allJSONData.case.length !== 0) {
    const titleJson = JSON.parse(allJSONData.case[0]);
    title = titleJson.label_name;
  }

  if (allJSONData.case_custom.length === 0 && allJSONData.case.length === 0) {
    title = "ครอบครองสิ่งของผิดกฎหมาย";
  }

  // console.log(allJSONData.case[0].name);
  allJSONData.case_quantity.push(JSON.stringify(inputCal));
  allJSONData.police_decrease_time = inputCal.decrease_imprison.imprison;
  allJSONData.all_milisec = miliSeconds;
  allJSONData.all_mins = mins;
  allJSONData.all_fine = fineAllCalulate;
  axios
    .post("https://mongkol.dev/api/policelog/create", allJSONData, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
    .then((response) => {
      if (response.status !== 201) return;
      $.post(
        "https://cc_policepanel/fine",
        JSON.stringify({
          closet_player: playerArrestID,
          fine: fineAllCalulate,
          title: title,
        })
      );
      $.post(
        "https://cc_policepanel/notify",
        JSON.stringify({
          description: "ประมวลคดีสำเร็จ",
          type: "success",
        })
      );
      oldImprison = 0;
      oldFine = 0;
    })
    .catch((error) => {
      console.error(error);
    });
  closeUI();
}

async function jailAtBolingbrokePenitentiary(position) {
  // $( "body" ).fadeOut( "slow" );
  if (oldFine !== fineAllCalulate && oldImprison !== mins) {
    $.post(
      "https://cc_policepanel/notify",
      JSON.stringify({
        description: "กรุณาประมวลคดีอีกครั้ง",
        type: "warning",
      })
    );
    return;
  }
  let title;

  if (allJSONData.case_custom.length !== 0) {
    title = allJSONData.case_custom[0];
  }

  if (allJSONData.case.length !== 0) {
    const titleJson = JSON.parse(allJSONData.case[0]);
    title = titleJson.label_name;
  }

  if (allJSONData.case_custom.length === 0 && allJSONData.case.length === 0) {
    title = "ครอบครองสิ่งของผิดกฎหมาย";
  }
  // console.log(title);
  allJSONData.case_quantity.push(JSON.stringify(inputCal));
  allJSONData.police_decrease_time = inputCal.decrease_imprison.imprison;
  allJSONData.all_milisec = miliSeconds;
  allJSONData.all_mins = mins;
  allJSONData.all_fine = fineAllCalulate;
  axios
    .post("https://mongkol.dev/api/policelog/create", allJSONData, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
    .then((response) => {
      console.log(response.status);
      if (response.status !== 201) return;
      $.post(
        "https://cc_policepanel/bolingbrokePenitentiary",
        JSON.stringify({
          closet_player: playerArrestID,
          jail_time: mins,
          fine: fineAllCalulate,
          title: title,
          position: position,
        })
      );
      oldImprison = 0;
      oldFine = 0;
    })
    .catch((error) => {
      console.log(Object.values(error.response.data.errors));
    });
  closeUI();
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});

// let checkboxesData = document.querySelectorAll("input[data-name]");
// let labeldiv = document.getElementById("charge-optional-all");
// let imprisonDiv = document.getElementById("imprison-optional-all");
// let finediv = document.getElementById("fine-optional-all");

// checkboxesData.forEach(function (checkbox) {
//   checkbox.addEventListener("change", function () {
//     let checkedLabels = Array.from(checkboxesData)
//       .filter(function (checkbox) {
//         return checkbox.checked;
//       })
//       .map(function (checkbox) {
//         return (
//           '<div class="overflow-x-hiden"> - ' +
//           checkbox.getAttribute("data-labelname") +
//           "</div>"
//         );
//       });

//     labeldiv.innerHTML = checkedLabels.join("");

//     let checkedImprison = Array.from(checkboxesData)
//       .filter(function (checkbox) {
//         return checkbox.checked;
//       })
//       .map(function (checkbox) {
//         let seconds = parseInt(checkbox.getAttribute("data-imprison"));
//         let minutes = seconds / 60000;
//         return minutes;
//       });

//     if (checkedImprison.length > 0) {
//       let imprisonText = checkedImprison
//         .map(function (imprison) {
//           return "<div>" + imprison + " นาที" + "</div>";
//         })
//         .join("");

//       imprisonDiv.innerHTML = imprisonText;
//     } else {
//       imprisonDiv.innerHTML = "";
//     }

//     let checkedFine = Array.from(checkboxesData)
//       .filter(function (checkbox) {
//         return checkbox.checked;
//       })
//       .map(function (checkbox) {
//         return "<div> $ " + checkbox.getAttribute("data-fine") + "</div>";
//       });

//     finediv.innerHTML = checkedFine.join("");
//   });
// });
