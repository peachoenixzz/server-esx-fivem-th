let zone = null;

let items = null;
let selectedItems;
let Config = {};
Config.closeKeys = [27, 90];
const itemContainer = document.getElementById("item-container");
const materialsContainer = document.getElementById("materials-container");
let lastHighlight = null;
let totalMaterial = null;
let onGuardRemove = false;
let onGuardBroken = {
  status: false,
};

window.addEventListener("message", function (event) {
  var data = event.data;

  // Open & Close main window
  if (data.message === "show") {
    if (data.clear === true) {
      items = null;
    }
    openMain();
  }

  if (data.message === "hide") {
    onGuardRemove = false;
    onGuardBroken = {
      status: false,
    };
    closeAll();
  }

  if (data.message === "add") {
    items = data.itemList;
    updateItemsDisplay(items);
    initFilterButton();
    updateMaterials(items[0].specific_name);
  }

  if (data.message === "playsound") {
    audioPlayer = new Audio("./sounds/success.wav");
    audioPlayer.volume = 0.5;
    audioPlayer.play();
  }
});

// let allMaterial = [];
function updateItemsDisplay(filteredItems) {
  totalMaterial = null;
  let html = "";
  filteredItems.forEach((item) => {
    // console.log("update display",item.specific_name)
    const buttonHtml = `<div class="mb-1">
        <button class="bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5] rounded-lg p-1 flex items-center text-white text-[1.8vh] w-full" onclick="updateMaterials('${item.specific_name}')" id="button-${item.specific_name}" >
          <div class="box-content w-[6vh] h-[6vh] bg-black/[0.5] rounded-lg">
            <img src="nui://nc_inventory/html/img/items/${item.name}.png" class="w-[6vh] h-[6vh]" />
          </div>
          <div class="ml-3.5">${item.label}</div>
        </button></div>
      `;
    html += buttonHtml;
  });
  itemContainer.innerHTML = html;
  const items = document.getElementById(
    `button-${filteredItems[0].specific_name}`
  );
  lastHighlight = `button-${filteredItems[0].specific_name}`;
  items.classList.add("bg-gradient");
}

function filterByCategory(category) {
  let filteredItems = [];
  if (category === "all") {
    filteredItems = items;
  } else {
    filteredItems = items.filter((item) => item.category === category);
  }
  updateItemsDisplay(filteredItems);
  updateMaterials(filteredItems[0].specific_name);
}

// async function updateMaterials(itemName) {
//   const item = items.find((item) => item.specific_name === itemName);
//   totalMaterial = item.material.length;
//   const test = false;
//   const bigMaterils = document.getElementById("big-materials-container");
//   bigMaterils.innerHTML = "";
//   bigMaterils.innerHTML += `  <div class="flex justify-between">
// <div>
//   <div class="flex items-start mb-3 ml-6">
//     <div class="box-content w-[9vh] h-[9vh] rounded-lg mr-3 flex-none">
//       <img src="img/vest.png" id="items-image" class="w-full h-full" />
//     </div>
//     <div>
//       <div class="text-[4vh]" id="items-label">กล่องซ่อม</div>
//       <div class="text-[1.4vh] mt-0.5" id="items-success-rate">โอกาสสำเร็จ ${
//         item.success_rate * 100
//       }%</div>
//     </div>
//   </div>
// </div>
//
//   <div  class="flex justify-center items-center">
//     <div class="mb-3" id="req-container">
//
//     </div>
//   </div>
//   <div class="flex justify-center items-center">
//     <div class="mb-3 mr-6">
//       <div
//         class="box-content  rounded-lg mr-6 text-[2vh] flex flex-col items-center justify-center mb-1"
//       >
//         <div class="text-[2vh]">จำนวน</div>
//         <div class="flex">
//           <div class="flex justify-center items-center hover:bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5] bg-black/[0.5] rounded-md p-1">
//             <button
//               class="h-[2vh] w-[2vh]  flex items-center justify-center"
//               onclick="minusValue('${item.specific_name}','${item.currency}','${
//     item.price
//   }')"
//               id="minusButton"
//             >
//               -
//             </button>
//           </div>
//           <div class="flex justify-center items-center mx-1">
//             <input
//               type="number"
//               id="number-items"
//               name="1"
//               class="box-content rounded-md bg-gradient-to-l from-[#ffa800] to-[#ffcc00] h-[2vh] w-[4.5vh] text-center text-[1.2vh] p-1"
//               value="1"
//               onchange="changeValueItems('${item.specific_name}','${
//     item.currency
//   }','${item.price}')"
//             />
//           </div>
//           <div class="flex justify-center items-center hover:bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5] bg-black/[0.5] rounded-md p-1">
//             <button
//               class="h-[2vh] w-[2vh] rounded flex items-center justify-center"
//               onclick="plusValue('${item.specific_name}','${item.currency}','${
//     item.price
//   }')"
//              id="plusButton"
//             >
//               +
//             </button>
//           </div>
//         </div>
//       </div>
//     </div>
//   </div>
// </div>
// <div class="h-[0.2vh] bg-black/[0.5] mx-3 rounded-full"></div>
// <div class="mx-3 mt-3 mb-1 text-[2vh]">วัสดุที่ต้องใช้</div>
// <div id="materials-container"></div>
// <div class="absolute bottom-0 mb-3 w-[68vh] flex">
//   <div class="w-[40%] ml-2 h-full">
//     <div>${
//       item.failed_items === undefined ? "" : "สิ่งที่ได้รับหากไม่สำเร็จ"
//     }</div>
//     <div class="flex w-full">
//       <div id="fail-container" class="flex justify-center text-[1.2vh] ">
//
//       </div>
//     </div>
//   </div>
//   <div class="w-[60%] mx-2">
//   <div id="gurad-container" class="w-full">
//     <div class="flex w-full text-[1.3vh]">
//     ${
//       test
//         ? `<div class="flex items-center bg-black/[0.5] w-[50%] rounded mr-2" id="checkboxContainer">
//         <div class="flex w-full">
//           <div class="flex w-[70%] items-center">
//             <input type="checkbox" onchange="onCheck(this)" />
//             <img src="nui://nc_inventory/html/img/items/${item.name}.png" class="w-[2vh] h-[2vh]" />
//             <div class="ml-2">หินครอน</div>
//           </div>
//           <div class="w-[30%] flex items-center justify-end pr-1">
//            0 / 100
//           </div>
//         </div>
//       </div>
//       `
//         : `<div class="flex items-cente w-[50%] rounded mr-2">
//       </div>`
//     }
//     <div class="flex items-center bg-black/[0.5] w-[50%] rounded mr-2" id="checkboxContainer100">
//     <div class="flex w-full">
//       <div class="flex w-[70%] items-center">
//         <input type="checkbox" onchange="onCheck(this)" />
//         <img src="nui://nc_inventory/html/img/items/${
//           item.name
//         }.png" class="w-[2vh] h-[2vh]" />
//         <div class="ml-2">กันแตก 100%</div>
//       </div>
//       <div class="w-[30%] flex items-center justify-end pr-1">
//        10 / 100
//       </div>
//     </div>
//   </div>
//  </div>
//     <div class="flex mt-1  w-full text-[1.3vh]">
//     <div class="flex items-center bg-black/[0.5] w-[50%] rounded mr-2" id="checkboxContainer90">
//     <div class="flex w-full">
//       <div class="flex w-[70%] items-center">
//         <input type="checkbox" onchange="onCheck(this)" />
//         <img src="nui://nc_inventory/html/img/items/${
//           item.name
//         }.png" class="w-[2vh] h-[2vh]" />
//         <div class="ml-2">กันแตก 90%</div>
//       </div>
//       <div class="w-[30%] flex items-center justify-end pr-1">
//         2 / 100
//       </div>
//     </div>
//   </div>
//   <div class="flex items-center bg-black/[0.5] w-[50%] rounded mr-2" id="checkboxContainer70">
//   <div class="flex w-full">
//     <div class="flex w-[70%] items-center">
//       <input type="checkbox" onchange="onCheck(this)" />
//       <img src="nui://nc_inventory/html/img/items/${
//         item.name
//       }.png" class="w-[2vh] h-[2vh]" />
//       <div class="ml-2">กันแตก 70%</div>
//     </div>
//     <div class="w-[30%] flex items-center justify-end pr-1">
//      1 / 100
//     </div>
//   </div>
// </div>
//     </div>
//   </div>
// </div>
//
// </div>
// `;
//
//   if (item.failed_items !== undefined) {
//     let failhtml = "";
//     const failItems = document.getElementById("fail-container");
//     console.log(item.failed_items);
//     item.failed_items.forEach((item) => {
//       const fail_items = `<div class="flex items-center mt-1 mr-2 px-2 bg-black/[0.5] p-1 rounded">
//                   <div
//                     class="box-content w-[2.5vh] h-[2.5vh] flex items-center"
//                   >
//                     <img src="nui://nc_inventory/html/img/items/${item.name}.png" />
//                   </div>
//                   <div class="mx-2">${item.label} x${item.quantity}</div>
//                 </div>`;
//       failhtml += fail_items;
//     });
//     failItems.innerHTML = failhtml;
//   }
//
//   if (item.status === true) {
//     let html = "";
//     let reqContainer = 0;
//     const req_items = document.getElementById("req-container");
//
//     req_items.innerHTML = `<div class="text-[2vh] text-center">${
//       item.req.length === 0 ? "" : "สิ่งที่ต้องมี"
//     }</div>
//                     <div class="mb-1" id="body-req" >
//
//                     </div>`;
//
//     const body_req = document.getElementById("body-req");
//     for (let i = 0; i < item.req.length; i++) {
//       if (i % 2 === 0 || i === 0) {
//         body_req.innerHTML += `<div class="flex  text-[1.2vh]" id="req-${i}"></div>`;
//         reqContainer = i;
//       }
//
//       const reqFlexCon = document.getElementById(`req-${reqContainer}`);
//
//       reqFlexCon.innerHTML += `
//       <div class="${item.req.length === 1 ? "w-[100%] mr-1" : "w-[50%] mr-1"}">
//                       <div
//                         class="bg-black/[0.5] rounded-md p-1 pr-2 flex items-center text-white text-[1.2vh] mb-1 "
//                       >
//                         <div
//                           class="box-content w-[2vh] h-[2vh] bg-black/[0.5] rounded"
//                         >
//                          <img src="nui://nc_inventory/html/img/items/${
//                            item.req[i].req_name
//                          }.png" />
//                         </div>
//                         <div class="ml-1 " style="white-space: nowrap;">${
//                           item.req[i].req_label
//                         }</div>
//                     </div>
//                     </div>`;
//     }
//   }
//
//   const materials = document.getElementById("materials-container");
//   materials.innerHTML = "";
//   let lastContainer = 0;
//   // console.log(item);
//
//   const itemsLabel = document.getElementById("items-label");
//   itemsLabel.textContent = item.label;
//
//   const itemImage = document.getElementById("items-image");
//   itemImage.src = `nui://nc_inventory/html/img/items/${item.name}.png`;
//
//   await handleCurrency(item.currency, item.price);
//
//   selectedItems = item.specific_name;
//   const lastHighlightID = document.getElementById(lastHighlight);
//   const highlightID = document.getElementById(`button-${itemName}`);
//   lastHighlightID.classList.remove("bg-gradient");
//   highlightID.classList.add("bg-gradient");
//   lastHighlight = `button-${itemName}`;
//
//   if (item.material.length > 0) {
//     for (let i = 0; i < item.material.length; i++) {
//       let countMaterial = await callbackMaterialItem(
//         item.material[i].name,
//         item.material[i].type
//       );
//       if (i % 2 === 0 || i === 0) {
//         materials.innerHTML += `<div class="flex mx-3 text-[1.5vh]" id="materials-${i}"></div>`;
//         lastContainer = i;
//       }
//
//       const flexContainer = document.getElementById(
//         `materials-${lastContainer}`
//       );
//       // console.log("ชื่อไอเทม: ", item.material[i].quantity);
//       flexContainer.innerHTML += `
//               <div class="w-[50%]">
//                 <div class="flex items-center justify-between">
//                   <div>
//                     <div class="flex items-center">
//                       <div class="box-content w-[4vh] h-[4vh] rounded-lg">
//                         <img src="nui://nc_inventory/html/img/items/${
//                           item.material[i].name
//                         }.png" />
//                       </div>
//                       <div class="ml-3">${item.material[i].label}</div>
//                     </div>
//                   </div>
//                   <div>
//                     <div>
//                     <div class="mr-10 ${
//                       countMaterial < item.material[i].quantity
//                         ? "text-red-700"
//                         : ""
//                     }"
//                     data-material="${item.material[i].quantity}"  id="m-${i}">
//                     ${countMaterial} / ${item.material[i].quantity}
//                   </div>
//                   </div>
//                 </div>
//
//           `;
//     }
//   }
// }

function createMaterialHtml(material, countMaterial, index) {
  return `
    <div class="w-[50%]">
      <div class="flex items-center justify-between">
        <div>
          <div class="flex items-center">
            <div class="box-content w-[4vh] h-[4vh] rounded-lg">
              <img src="nui://nc_inventory/html/img/items/${
                material.name
              }.png" />
            </div>
            <div class="ml-3">${material.label}</div>
          </div>
        </div>
        <div>
          <div class="mr-10 ${
            countMaterial < material.quantity ? "text-red-700" : ""
          }" 
           data-material="${material.quantity}" id="m-${index}"
          >
            ${countMaterial} / ${material.quantity}
          </div>
        </div>
      </div>
    </div>
  `;
}

async function updateMaterialsContainer(item, materialsContainer) {
  materialsContainer.innerHTML = "";
  let materialsHtml = "";
  if (item.material.length > 0) {
    for (const material of item.material) {
      const index = item.material.indexOf(material);
      const countMaterial = await callbackMaterialItem(
        material.name,
        material.type
      );
      materialsHtml += createMaterialHtml(material, countMaterial, index);
      if (index % 2 === 0 || index === 0) {
        materialsContainer.innerHTML += `<div class="flex mx-3 text-[1.5vh]" id="materials-${index}"></div>`;
      }
      document.getElementById(
        `materials-${Math.floor(index / 2) * 2}`
      ).innerHTML += materialsHtml;
      materialsHtml = ""; // Reset after appending
    }
  }
}

async function updateMaterials(itemName) {
  const item = items.find((item) => item.specific_name === itemName);
  totalMaterial = item.material.length;
  const bigMaterials = document.getElementById("big-materials-container");
  bigMaterials.innerHTML = `
  <div class="flex justify-between">
    <div>
      <div class="flex items-start mb-3 ml-6">
        <div class="box-content w-[9vh] h-[9vh] rounded-lg mr-3 flex-none">
          <img src="nui://nc_inventory/html/img/items/${
            item.name
          }.png" id="items-image" class="w-full h-full" />
        </div>
        <div>
          <div class="text-[4vh]" id="items-label">${item.label}</div>
          <div class="text-[1.4vh] mt-0.5" id="items-success-rate">โอกาสสำเร็จ ${
            item.success_rate * 100
          }%</div>
        </div>
      </div>
    </div>
    <div class="flex justify-center items-center">
      <div class="mb-3" id="req-container"></div>
    </div>
    <div class="flex justify-center items-center">
      <div class="mb-3 mr-6">
        <div class="box-content rounded-lg mr-6 text-[2vh] flex flex-col items-center justify-center mb-1">
          <div class="text-[2vh]">จำนวน</div>
          <div class="flex">
            <div class="flex justify-center items-center hover:bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5] bg-black/[0.5] rounded-md p-1">
              <button class="h-[2vh] w-[2vh] flex items-center justify-center" onclick="minusValue('${
                item.specific_name
              }','${item.currency}','${
    item.price
  }')" id="minusButton">-</button>
            </div>
            <div class="flex justify-center items-center mx-1">
              <input type="number" id="number-items" name="1" class="box-content rounded-md bg-gradient-to-l from-[#ffa800] to-[#ffcc00] h-[2vh] w-[4.5vh] text-center text-[1.2vh] p-1" value="1" onchange="changeValueItems('${
                item.specific_name
              }','${item.currency}','${item.price}')" />
            </div>
            <div class="flex justify-center items-center hover:bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5] bg-black/[0.5] rounded-md p-1">
              <button class="h-[2vh] w-[2vh] rounded flex items-center justify-center" onclick="plusValue('${
                item.specific_name
              }','${item.currency}','${item.price}')" id="plusButton">+</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="h-[0.2vh] bg-black/[0.5] mx-3 rounded-full"></div>
  <div class="mx-3 mt-3 mb-1 text-[2vh]">วัสดุที่ต้องใช้</div>
  <div id="materials-container"></div>
  <div class="absolute bottom-0 mb-3 w-[68vh] flex">
    <div class="w-[40%] ml-2 h-full">
      <div>${
        item.failed_items === undefined ? "" : "สิ่งที่ได้รับหากไม่สำเร็จ"
      }</div>
      <div class="flex w-full">
        <div id="fail-container" class="flex justify-center text-[1.2vh]"></div>
      </div>
    </div>
  
  </div>
  <div class="absolute bottom-0 mb-3 w-[68vh] flex"> 
  <div class="w-[40%] ml-2">
  </div>
    <div class="w-[60%] mx-2">
      <div id="guard-container" class="w-full">
        <div class="flex justify-end w-full text-[1.3vh]" id="protect_remove-first_protect_broken"> </div>
        <div class="flex w-full text-[1.3vh] " id="protect_broken"> </div>
        </div>
      </div>
    </div>
  </div>
`;
  const materialsContainer = document.getElementById("materials-container");
  await updateSelectedItem(itemName);
  await updateMaterialsContainer(item, materialsContainer);
  await generateFailItemsHtml(item);
  await generateGuardOptionsHtml(item);
  await handleCurrency(item.currency, item.price);
  await updateRequiredItems(item);
}

async function updateRequiredItems(item) {
  if (item.status === true && Array.isArray(item.req) && item.req.length > 0) {
    const reqContainer = document.getElementById("req-container");
    let html = `<div class="text-[2vh] text-center">สิ่งที่ต้องมี</div><div class="mb-1">`;
    item.req.forEach((reqItem, index) => {
      if (index % 2 === 0) html += `<div class="flex text-[1.2vh]">`;

      html += `
        <div class="${item.req.length === 1 ? "w-[100%]" : "w-[50%]"} mr-1">
          <div class="bg-black/[0.5] rounded-md p-1 pr-2 flex items-center text-white text-[1.2vh] mb-1">
            <div class="box-content w-[2vh] h-[2vh] bg-black/[0.5] rounded">
              <img src="nui://nc_inventory/html/img/items/${
                reqItem.req_name
              }.png" />
            </div>
            <div class="ml-1" style="white-space: nowrap;">${
              reqItem.req_label
            }</div>
          </div>
        </div>`;

      if (index % 2 === 1 || index === item.req.length - 1) html += `</div>`;
    });

    html += `</div>`;

    reqContainer.innerHTML = html;
  }
}

async function updateSelectedItem(itemName) {
  selectedItems = itemName; // Update the currently selected item

  // Check if there's a previously highlighted item
  if (lastHighlight) {
    const lastHighlightID = document.getElementById(lastHighlight);
    if (lastHighlightID) {
      lastHighlightID.classList.remove("bg-gradient"); // Remove highlight from the previous item
    }
  }

  // Highlight the newly selected item
  const highlightID = document.getElementById(`button-${itemName}`);
  if (highlightID) {
    highlightID.classList.add("bg-gradient");
    lastHighlight = `button-${itemName}`; // Update 'lastHighlight' to the newly selected item
  }
}

async function generateFailItemsHtml(item) {
  if (Array.isArray(item.failed_items) && item.failed_items.length > 0) {
    let failHtml = ""; // Initialize variable to accumulate HTML strings
    const failItemsContainer = document.getElementById("fail-container"); // Get the container for failed items

    // Iterate over each failed item to construct HTML string
    item.failed_items.forEach((failedItem) => {
      failHtml += `
            <div class="flex items-center mt-1 mr-2 px-2 bg-black/[0.5] p-1 rounded">
                <div class="box-content w-[2.5vh] h-[2.5vh] flex items-center">
                    <img src="nui://nc_inventory/html/img/items/${failedItem.name}.png" />
                </div>
                <div class="mx-2">${failedItem.label} x${failedItem.quantity}</div>
            </div>`;
    });

    // Set the innerHTML of the fail-container to the constructed HTML string
    failItemsContainer.innerHTML = failHtml;
  }
}

async function generateGuardOptionsHtml(item) {
  const guardContainerRemove = document.getElementById(
    "protect_remove-first_protect_broken"
  );
  const guardContainerBroken = document.getElementById("protect_broken");

  let htmlRemove = "";
  let htmlBroken = "";

  if (item.protect_broken) {
    guardContainerBroken.classList.add("mt-1");
    for (let i = 1; i < item.protect_broken_items.length; i++) {
      const currentItem = item.protect_broken_items[i];
      const count = await callbackMaterialItem(
        currentItem.name,
        currentItem.type
      );
      htmlBroken += `
          <div class="flex items-center bg-black/[0.5] w-[50%] rounded mr-2" id="checkboxContainer-${currentItem.name}">
            <div class="flex w-full">
              <div class="flex w-[70%] items-center">
              <input type="checkbox" onchange="onCheckGurad(this, 'checkboxContainer-${currentItem.name}')" />
                <img src="nui://nc_inventory/html/img/items/${currentItem.name}.png" class="w-[2vh] h-[2vh]" />
                <div class="ml-2">${currentItem.label}</div>
              </div>
              <div class="w-[30%] flex items-center justify-end pr-1">
               ${count} / ${currentItem.quantity} 
              </div>
            </div>
          </div>
        `;
    }
  }

  if (item.protect_remove) {
    for (const item1 of item.protect_remove_items) {
      const count = await callbackMaterialItem(item1.name, item1.type);
      htmlRemove += `
        <div class="flex items-center bg-black/[0.5] w-[50%] rounded mr-2" id="checkboxContainer">
        <div class="flex w-full">
          <div class="flex w-[70%] items-center">
            <input type="checkbox" onchange="onCheckRemove(this)" />
            <img src="nui://nc_inventory/html/img/items/${item1.name}.png" class="w-[2vh] h-[2vh]" />
            <div class="ml-2">${item1.label}</div>
          </div>
          <div class="w-[30%] flex items-center justify-end pr-1">
           ${count} / ${item1.quantity} 
          </div>
        </div>
      </div>
        `;
    }
    if (item.protect_broken) {
      const firstItem = item.protect_broken_items[0];
      const count = await callbackMaterialItem(firstItem.name, firstItem.type);
      htmlRemove += `
        <div class="flex items-center bg-black/[0.5] w-[50%] rounded mr-2" id="checkboxContainer-${firstItem.name}">
        <div class="flex w-full">
          <div class="flex w-[70%] items-center">
          <input type="checkbox" onchange="onCheckGurad(this, 'checkboxContainer-${firstItem.name}')" />
            <img src="nui://nc_inventory/html/img/items/${firstItem.name}.png" class="w-[2vh] h-[2vh]" />
            <div class="ml-2">${firstItem.label}</div>
          </div>
          <div class="w-[30%] flex items-center justify-end pr-1">
          ${count} / ${firstItem.quantity} 
          </div>
        </div>
      </div>
      `;
    }
  }

  guardContainerRemove.innerHTML = htmlRemove;
  guardContainerBroken.innerHTML = htmlBroken;
}

async function handleCurrency(currency, price) {
  const cur = document.getElementById("currency");
  cur.innerHTML = "";
  if (Array.isArray(currency)) {
    currency.forEach((v, k) => {
      cur.innerHTML += `
        <div class="box-content w-[2vh] h-[2vh] ${
          k % 2 === 1 ? "ml-3" : ""
        } mr-3">
            <img src="nui://nc_inventory/html/img/items/${v}.png" />
        </div>
        <div id="${v}">${price[k].toLocaleString()}</div>
        `;
    });
  }

  if (!Array.isArray(currency)) {
    const cur = document.getElementById("currency");
    cur.innerHTML = `
    <div class="box-content w-[2vh] h-[2vh] mr-3">
      <img src="nui://nc_inventory/html/img/items/${currency}.png" />
    </div>
    <div id="${currency}">${price.toLocaleString()}</div>
    `;
  }
}

async function onChangeCurrency(currency, price, count) {
  currency = currency.trim();
  currency = currency.split(",");
  price = price.trim();
  price = price.split(",");

  if (currency.length === 1) {
    const priceID = document.getElementById(currency[0]);
    let p = price[0] * count;
    priceID.classList.add("number-change-animation");
    setTimeout(() => {
      priceID.classList.remove("number-change-animation");
    }, 300); // Match the duration of the animation
    priceID.innerHTML = `
        ${p.toLocaleString()}
      `;
    return;
  }

  currency.forEach((v, k) => {
    const priceID = document.getElementById(v);
    let p = price[k] * count;
    priceID.classList.add("number-change-animation");
    setTimeout(() => {
      priceID.classList.remove("number-change-animation");
    }, 300); // Match the duration of the animation
    priceID.innerHTML = `
          ${p.toLocaleString()}
        `;
  });
}

async function callbackMaterialItem(item, type) {
  let materialCount = 0;
  await axios
    .post("https://cc_crafttable/checkMaterial", { item: item, type: type })
    .then((response) => {
      materialCount = response.data;
    })
    .catch((error) => {
      console.error("Error:", error);
    });
  // console.log(materialCount)
  return materialCount;
}

function initFilterButton() {
  let lastbtnCon = 0;
  const btnContainer = document.getElementById("container-button");
  btnContainer.innerHTML = "";
  const uniqueCategories = items.reduce((acc, curr) => {
    if (!acc.includes(curr.category)) {
      acc.push(curr.category);
    }
    return acc;
  }, []);

  const uniqueCategoriesLabel = items.reduce((acc, curr) => {
    if (!acc.includes(curr.label_category)) {
      acc.push(curr.label_category);
    }
    return acc;
  }, []);
  if (uniqueCategoriesLabel.length < 10) {
    const filter = document.getElementById("filter");
    filter.classList.remove("text-[2.2vh]");
    filter.classList.add("text-[1.8vh]");
  }
  for (let i = 0; i < uniqueCategoriesLabel.length; i++) {
    if (i % 4 === 0 || i === 0) {
      btnContainer.innerHTML += `<div class="flex m-1" id="btnF-${i}"></div>`;
      lastbtnCon = i;
    }

    const btnFlexCon = document.getElementById(`btnF-${lastbtnCon}`);
    const v = uniqueCategories[i];
    btnFlexCon.innerHTML += `
      <button
        id="buttonc-${v}"
        class="bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.5] to-[#ffcc00]/[0.5] rounded-lg w-[13.5vh] h-[3vh]  mr-3 flex items-center justify-center"
        onclick="filterByCategory('${v}'); addBg('buttonc-${v}')"
      >
        ${uniqueCategoriesLabel[i]}
      </button>
    `;
  }
}

async function validateCraftItem(confirmItems, quantity) {
  let status;
  // console.log("validate Craft");
  // console.log(confirmItems.name);
  // console.log(confirmItems.specific_name);
  await axios
    .post("https://cc_crafttable/checkCanCraft", {
      item: confirmItems,
      onGuardBroken: onGuardBroken,
      onGuardRemove: onGuardRemove,
      amount: parseInt(quantity),
    })
    .then((response) => {
      // console.log(response.data);
      status = response.data;
    })
    .catch((error) => {
      console.error("Error:", JSON.stringify(error));
    });
  return status;
  // console.log(materialCount)
}

async function successProgress(state, items) {
  if (state === false || state === null) return;
  const quantity = document.getElementById("number-items").value;
  await axios
    .post("https://cc_crafttable/successCraft", {
      item: items,
      onGuardBroken: onGuardBroken,
      onGuardRemove: onGuardRemove,
      amount: parseInt(quantity),
    })
    .then((response) => {
      onGuardRemove = false;
      onGuardBroken = {
        status: false,
      };
      if (response.data === "success") {
        audioPlayer = new Audio("./sounds/success.wav");
        audioPlayer.volume = 0.5;
        audioPlayer.play();
        return;
      }
      audioPlayer = new Audio("./sounds/fail.wav");
      audioPlayer.volume = 0.5;
      audioPlayer.play();
      // console.log(response.data)
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

function addBg(clickedButtonId) {
  const buttons = document.querySelectorAll('[id^="buttonc-"]');
  console.log(clickedButtonId);
  buttons.forEach((button) => {
    if (button.id === clickedButtonId) {
      button.classList.add("bg-gradient");
    } else {
      button.classList.remove("bg-gradient");
    }
  });
}

async function plusValue(itemName, currency, price) {
  const item = items.find((item) => item.specific_name === itemName);

  const quantity = document.getElementById("number-items");
  if (parseInt(quantity.value) === item.max_quantity) return;
  quantity.classList.add("number-change-animation");
  setTimeout(() => {
    quantity.classList.remove("number-change-animation");
  }, 300); // Match the duration of the animation
  quantity.value = parseInt(quantity.value) + parseInt(1);

  await onChangeCurrency(currency, price, parseInt(quantity.value));
  for (let i = 0; i < totalMaterial; i++) {
    // console.log("MaterialPress: ", item.material[i].name);
    let countMaterial = await callbackMaterialItem(item.material[i].name);
    const materialValue = document.getElementById(`m-${i}`);
    materialValue.classList.add("number-change-animation");
    setTimeout(() => {
      materialValue.classList.remove("number-change-animation");
    }, 300); // Match the duration of the animation
    const materialDataDefault = materialValue.getAttribute("data-material");
    const newValueMeterial = parseInt(materialDataDefault);
    materialValue.innerHTML = `${countMaterial.toLocaleString()} / ${(
      newValueMeterial * parseInt(quantity.value)
    ).toLocaleString()}`;
    if (countMaterial < newValueMeterial * parseInt(quantity.value)) {
      materialValue.classList.remove("text-red-700");
      materialValue.classList.add("text-red-700");
    } else {
      materialValue.classList.remove("text-red-700");
    }
  }
}

async function minusValue(itemName, currency, price) {
  // console.log(item)
  const item = items.find((item) => item.specific_name === itemName);
  const priceContainer = document.getElementById("items-price");
  const quantity = document.getElementById("number-items");
  if (parseInt(quantity.value) === 1) return;
  quantity.classList.add("number-change-animation");
  setTimeout(() => {
    quantity.classList.remove("number-change-animation");
  }, 300); // Match the duration of the animation
  quantity.value = parseInt(quantity.value) - parseInt(1);
  await onChangeCurrency(currency, price, parseInt(quantity.value));

  for (let i = 0; i < totalMaterial; i++) {
    let countMaterial = await callbackMaterialItem(item.material[i].name);
    const materialValue = document.getElementById(`m-${i}`);
    materialValue.classList.add("number-change-animation");
    setTimeout(() => {
      materialValue.classList.remove("number-change-animation");
    }, 300); // Match the duration of the animation
    const materialDataDefault = materialValue.getAttribute("data-material");
    const newValueMeterial = parseInt(materialDataDefault);
    materialValue.innerHTML = `${countMaterial.toLocaleString()} / ${(
      newValueMeterial * parseInt(quantity.value)
    ).toLocaleString()}`;
    if (countMaterial < newValueMeterial * parseInt(quantity.value)) {
      materialValue.classList.remove("text-red-700");
      materialValue.classList.add("text-red-700");
    } else {
      materialValue.classList.remove("text-red-700");
    }
  }
}

async function changeValueItems(itemName, currency, price) {
  const item = items.find((item) => item.specific_name === itemName);
  const priceContainer = document.getElementById("items-price");
  const quantity = document.getElementById("number-items");
  quantity.classList.add("number-change-animation");
  setTimeout(() => {
    quantity.classList.remove("number-change-animation");
  }, 300); // Match the duration of the animation
  if (parseInt(quantity.value) < 1 || quantity.value === "") {
    quantity.value = 1;
  }
  if (parseInt(quantity.value) > item.max_quantity) {
    quantity.value = item.max_quantity;
  }

  quantity.value = parseInt(quantity.value);

  await onChangeCurrency(currency, price, parseInt(quantity.value));
  for (let i = 0; i < totalMaterial; i++) {
    let countMaterial = await callbackMaterialItem(item.material[i].name);
    const materialValue = document.getElementById(`m-${i}`);
    materialValue.classList.add("number-change-animation");
    setTimeout(() => {
      materialValue.classList.remove("number-change-animation");
    }, 300); // Match the duration of the animation
    const materialDataDefault = materialValue.getAttribute("data-material");
    const newValueMeterial = parseInt(materialDataDefault);
    materialValue.innerHTML = `${countMaterial} / ${(
      newValueMeterial * parseInt(quantity.value)
    ).toLocaleString()}`;
    if (countMaterial < newValueMeterial * parseInt(quantity.value)) {
      materialValue.classList.remove("text-red-700");
      materialValue.classList.add("text-red-700");
    } else {
      materialValue.classList.remove("text-red-700");
    }
  }
}

function openMain() {
  $("body").css("display", "block");
}
function closeAll() {
  let progress = $("#progress");
  $(".absolute.inset-0.flex.items-center.justify-center.z-10").text(
    "CANCELLED"
  );
  progress.stop().css("width", "100%");
  setTimeout(function () {
    const button = document.getElementById("craft-button");
    button.disabled = false;
    $(".absolute.inset-0.flex.items-center.justify-center.z-10").text("0%");
    progress.css("width", "0%"); // Reset the progress bar width
  }, 10);
  $("body").css("display", "none");
}

$(document).ready(function () {
  $("body").on("keyup", function (key) {
    if (Config.closeKeys.includes(key.which)) {
      closeUI();
    }
  });
});

function disableButton() {
  const button = document.getElementById("craft-button");
  const minusButton = document.getElementById("minusButton");
  const plusButton = document.getElementById("plusButton");
  const numberInput = document.getElementById("number-items");
  minusButton.disabled = true;
  plusButton.disabled = true;
  button.disabled = true;
  numberInput.disabled = true;
}

function enableButton() {
  const button = document.getElementById("craft-button");
  const minusButton = document.getElementById("minusButton");
  const plusButton = document.getElementById("plusButton");
  const numberInput = document.getElementById("number-items");
  minusButton.disabled = false;
  plusButton.disabled = false;
  button.disabled = false;
  numberInput.disabled = false;
}

async function progress_bar() {
  let state = false;
  const confirmItems = items.find(
    (item) => item.specific_name === selectedItems
  );
  const button = document.getElementById("craft-button");
  const quantity = document.getElementById("number-items").value;
  disableButton();
  if (!(await validateCraftItem(confirmItems, quantity)) && button.disabled) {
    enableButton();
    return;
  }

  let progress = $("#progress");
  let width = 0;
  let time = confirmItems.crafting_time; // Total time in seconds
  let intervalTime = time * 1000; // Convert to milliseconds

  progress.css("transition", `width ${intervalTime / 100}ms linear`);
  progress.animate(
    { width: "100%" },
    {
      duration: intervalTime,
      progress: async function (animation, progress) {
        $(".absolute.inset-0.flex.items-center.justify-center.z-10").text(
          `${parseInt(progress * 100)}%`
        );

        // width = progress * 100; // Calculate current width as a percentage
        // await updateProgress(width, null, button, progress[0], confirmItems);
      },
      complete: async function () {
        enableButton();
        progress.css("width", "0%"); // Reset the progress bar width
        $(".absolute.inset-0.flex.items-center.justify-center.z-10").text("0%");
        state = true;
        await successProgress(state, confirmItems);
        await updateMaterials(confirmItems.specific_name);
      },
    }
  );
}

function closeUI() {
  let progress = $("#progress");
  $(".absolute.inset-0.flex.items-center.justify-center.z-10").text(
    "CANCELLED"
  );
  progress.stop().css("width", "100%");
  setTimeout(function () {
    const button = document.getElementById("craft-button");
    button.disabled = false;
    $(".absolute.inset-0.flex.items-center.justify-center.z-10").text("0%");
    progress.css("width", "0%"); // Reset the progress bar width
    $.post("https://cc_crafttable/quit", JSON.stringify({}));
  }, 10);
}

function onCheckRemove(checkbox) {
  const container = document.getElementById("checkboxContainer");
  if (checkbox.checked) {
    onGuardRemove = true;
    container.classList.remove("bg-black/[0.5]");
    container.classList.add("bg-gradient");
  }
  if (!checkbox.checked) {
    onGuardRemove = false;
    container.classList.remove("bg-gradient");
    container.classList.add("bg-black/[0.5]");
  }
}

function onCheckGurad(checkbox, containerId) {
  const containerIds = [
    "checkboxContainer-heart_100",
    "checkboxContainer-heart_90",
    "checkboxContainer-heart_70",
  ];

  let container = document.getElementById(containerId);

  if (checkbox.checked) {
    container.classList.remove("bg-black/[0.5]");
    container.classList.add("bg-gradient");

    containerIds.forEach(function (id) {
      if (id !== containerId) {
        let otherCheckbox = document
          .getElementById(id)
          .querySelector('input[type="checkbox"]');
        otherCheckbox.checked = false;
        let otherContainer = document.getElementById(id);
        otherContainer.classList.remove("bg-gradient");
        otherContainer.classList.add("bg-black/[0.5]");
      }
      onGuardBroken = {
        status: true,
        item: containerId.split("-")[1],
      };
    });
  }
  if (!checkbox.checked) {
    onGuardBroken = {
      status: false,
    };
    container.classList.remove("bg-gradient");
    container.classList.add("bg-black/[0.5]");
  }
}
