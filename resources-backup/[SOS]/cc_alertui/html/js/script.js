window.addEventListener("message", async function (event) {
  let alert = event.data;
  if (alert.type === "police") {
    await casePopupPolice(
      alert.title,
      alert.actionType,
      alert.value,
      alert.tip,
      alert.location,
      alert.timeout,
      alert.type,
      alert.sex,
      alert.streetName
    );
    return;
  }
  if (alert.type === "confirm-police") {
    await confirmCasePolice(alert.playerName, alert.tip, alert.timeout);
  }

  if (alert.type === "ambulance") {
    await casePopupAmbulance(
      alert.title,
      alert.actionType,
      alert.value,
      alert.tip,
      alert.location,
      alert.timeout,
      alert.type,
      alert.sex,
      alert.streetName
    );
  }

  if (alert.type === "confirm-ambulance") {
    await confirmCaseAmbulance(alert.playerName, alert.tip, alert.timeout);
  }
});

async function colorBackgroundPolice(actionType) {
  console.log(actionType);
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

async function casePopupPolice(
  title,
  actionType,
  value,
  tip,
  location,
  timeout,
  type,
  sex,
  streetName
) {
  const caseContainer = document.getElementById("case-container");
  const color = await colorBackgroundPolice(actionType);
  console.log(color);
  const caseItems = `
          <div
            class="py-3 px-3 mt-1  rounded-lg w-[200px]"
            style="box-shadow: 0px 0px 7px rgba(0, 0, 0, 0.8);background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0.7), rgba(${color}, 0.7));"
          >
            <div class="text-[2vh] mb-2 leading-5">${title}</div>
            <div class="text-[1.2vh]">
              <div class="flex items-center">
                <img src="img/gps.png" class="h-[1.5vh] w-[1.5vh]" />
                <div class="flex justify-center pl-[0.5vh]">${streetName}</div>
              </div>
              <div class="flex items-center">
                <div
                  class="flex justify-center px-[1.5vh] w-[2vh] bg-black/[0.5] rounded leading-4 text-[12px]"
                >
                  ALT
                </div>
                +
                <div
                  class="flex justify-center px-[1.5vh] w-[2vh] bg-black/[0.5] rounded leading-4 text-[12px]"
                >
                 ${tip}
                </div>
                <div class="pl-1">เพื่อรับเคสนี้</div>
              </div>
            </div>
          </div>
        `;
  const newCaseItem = document.createElement("div");
  newCaseItem.id = `case-police-${tip}`;
  newCaseItem.innerHTML = caseItems;

  caseContainer.appendChild(newCaseItem);
  newCaseItem.style.display = "none";
  $(`#case-police-${tip}`).fadeIn();

  setTimeout(() => {
    $(`#case-police-${tip}`).fadeOut();
    setTimeout(() => {
      $(`#case-police-${tip}`).remove();
    }, timeout - 1000);
  }, timeout);
}

function confirmCasePolice(playerName, tip, timeout) {
  const caseContainer = document.getElementById("confirm-container");
  const caseItems = `
        <div class="flex justify-end">
          <div
            class="px-3 mt-1 bg-[#003fd4]/[0.7] rounded-md flex items-center"
            style="box-shadow: 0px 0px 7px rgba(0, 0, 0, 0.8)"
          >
            <img src="img/check.png" class="h-[15px] w-[15px]" />
            <div class="flex justify-center pl-1">${playerName} รับเคสแล้ว</div>
          </div>
        </div>
        `;
  const newCaseItem = document.createElement("div");
  newCaseItem.id = `confirm-police-${tip}`;
  newCaseItem.innerHTML = caseItems;

  caseContainer.appendChild(newCaseItem);
  newCaseItem.style.display = "none";
  $(`#confirm-police-${tip}`).fadeIn();

  setTimeout(() => {
    $(`#confirm-police-${tip}`).fadeOut();
    setTimeout(() => {
      $(`#confirm-police-${tip}`).remove();
    }, timeout - 1000);
  }, timeout);
}

async function casePopupAmbulance(
  title,
  text,
  value,
  tip,
  location,
  timeout,
  type,
  sex,
  streetName
) {
  const caseContainer = document.getElementById("case-container");
  const caseItems = `
          <div
            class="py-3 px-3 mt-1 bg-gradient-to-b from-black/[0.7] to-[#c3021f]/[0.7] rounded-lg w-[200px]"
            style="box-shadow: 0px 0px 7px rgba(0, 0, 0, 0.8)"
          >
            <div class="text-[2vh] mb-2 leading-5">${title}</div>
            <div class="text-[1.2vh]">
              <div class="flex items-center">
                <img src="img/gps.png" class="h-[1.5vh] w-[1.5vh]" />
                <div class="flex justify-center pl-[0.5vh]">${streetName}</div>
              </div>
              <div class="flex items-center">
                <div
                  class="flex justify-center px-[1.5vh] w-[2vh] bg-black/[0.5] rounded leading-4 text-[12px]"
                >
                  ALT
                </div>
                +
                <div
                  class="flex justify-center px-[1.5vh] w-[2vh] bg-black/[0.5] rounded leading-4 text-[12px]"
                >
                 ${tip}
                </div>
                <div class="pl-1">เพื่อรับเคสนี้</div>
              </div>
            </div>
          </div>
        `;
  const newCaseItem = document.createElement("div");
  newCaseItem.id = `case-ambulance-${tip}`;
  newCaseItem.innerHTML = caseItems;

  caseContainer.appendChild(newCaseItem);
  newCaseItem.style.display = "none";
  $(`#case-ambulance-${tip}`).fadeIn();

  setTimeout(() => {
    $(`#case-ambulance-${tip}`).fadeOut();
    setTimeout(() => {
      $(`#case-ambulance-${tip}`).remove();
    }, timeout - 1000);
  }, timeout);
}

function confirmCaseAmbulance(playerName, tip, timeout) {
  const caseContainer = document.getElementById("confirm-container");
  const caseItems = `
        <div class="flex justify-end">
          <div
            class="px-3 mt-1 bg-[#c3021f]/[0.7] rounded-md flex items-center"
            style="box-shadow: 0px 0px 7px rgba(0, 0, 0, 0.8)"
          >
            <img src="img/check.png" class="h-[15px] w-[15px]" />
            <div class="flex justify-center pl-1">${playerName} รับเคสแล้ว</div>
          </div>
        </div>
        `;
  const newCaseItem = document.createElement("div");
  newCaseItem.id = `confirm-ambulance-${tip}`;
  newCaseItem.innerHTML = caseItems;

  caseContainer.appendChild(newCaseItem);
  newCaseItem.style.display = "none";
  $(`#confirm-ambulance-${tip}`).fadeIn();

  setTimeout(() => {
    $(`#confirm-ambulance-${tip}`).fadeOut();
    setTimeout(() => {
      $(`#confirm-ambulance-${tip}`).remove();
    }, timeout - 1000);
  }, timeout);
}
