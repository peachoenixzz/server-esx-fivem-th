let firstInner = true;
window.addEventListener("message", function (event) {
  let res = event.data;
  const getItems = document.getElementById("process-items");
  const getBonusItems = document.getElementById("bonus-items");
  const baseItems = document.getElementById("base-items");

  if (event.data.action === "showProcessDetail") {
    $("body").fadeIn();
    $("#process").fadeIn();
    getBonusItems.innerHTML = "";
    getItems.innerHTML = "";
    baseItems.innerHTML = "";
    if (firstInner === true) {
      baseItems.innerHTML += `<div
              class="flex items-center justify-between text-[1.2vh] text-white mb-2 mx-2"
            >
              <div class="box-content w-[2.5vh] h-[2.5vh] rounded">
                <img src="nui://nc_inventory/html/img/items/${res.baseItem}.png" />
              </div>
              <div class="w-[48%]">${res.baseItemName}</div>
              <div class="bg-black/[0.5] rounded w-[2.8vh] text-center" id="count_base">${res.countBaseItem}</div>
            </div>`;

      //get Item Zone
      getItems.innerHTML += `<div
              class="flex items-center justify-between text-[1.2vh] text-white mb-2 mx-2"
            >
              <div class="box-content w-[2.5vh] h-[2.5vh] rounded">
                <img src="nui://nc_inventory/html/img/items/${res.getItem.ItemName}.png"  />
              </div>
              <div class="w-[48%]">${res.getItem.Text}</div>
              <div class="bg-black/[0.5] rounded w-[2.8vh] text-center" id="count_${res.getItem.ItemName}">0</div>
            </div>`;

      res.getItem.BonusPlus.forEach((v) => {
        getBonusItems.innerHTML += `<div
              class="flex items-center justify-between text-[1.2vh] text-white mb-2 mx-2"
            >
              <div class="box-content w-[2.5vh] h-[2.5vh] rounded">
                <img src="nui://nc_inventory/html/img/items/${v.ItemName}.png"  />
              </div>
              <div class="w-[48%]">${v.Text}</div>
              <div class="bg-black/[0.5] rounded w-[2.8vh] text-center" id="count_${v.ItemName}">0</div>
            </div>`;
      });

      res.getItem.Bonus.forEach((v) => {
        getBonusItems.innerHTML += `<div
              class="flex items-center justify-between text-[1.2vh] text-white mb-2 mx-2"
            >
              <div class="box-content w-[2.5vh] h-[2.5vh] rounded">
                <img src="nui://nc_inventory/html/img/items/${v.ItemName}.png"  />
              </div>
              <div class="w-[48%]">${v.Text}</div>
              <div class="bg-black/[0.5] rounded w-[2.8vh] text-center" id="count_${v.ItemName}">0</div>
            </div>`;
      });
      firstInner = false;
    }
    return;
  }

  if (event.data.action === "hideProcessDetail") {
    $("body").fadeOut();
    $("#process").fadeOut();
    firstInner = true;
    getBonusItems.innerHTML = "";
    getItems.innerHTML = "";
    baseItems.innerHTML = "";
    return;
  }

  if (event.data.action === "updateProcessDetail") {
    const updateCount = `count_${res.itemName}`;
    // console.log(res.count)
    document.getElementById(updateCount).innerHTML = res.count;
    if (res.totalBaseItemCount !== undefined) {
      document.getElementById("count_base").innerHTML = res.totalBaseItemCount;
    }
  }
});
