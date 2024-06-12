let firstInner = true;
window.addEventListener("message", function (event) {
  let res = event.data;
  const itemsContainer = document.getElementById("container-items");

  if (event.data.action === "showProcessDetail") {
    $("body").fadeIn();
    $("#process").fadeIn();
    const jsonSelectedItems = JSON.parse(res.selectedItems);

    const container = document.getElementById("container-items");
    container.innerHTML = "";
    // Loop through the data and create elements
    for (const key in jsonSelectedItems) {
      const item = jsonSelectedItems[key];
      container.innerHTML += `
        <div
          class="flex items-center justify-between text-[1.2vh] text-white mb-2"
        >
              <div class="box-content w-[2.5vh] h-[2.5vh] rounded">
                <img src="nui://nc_inventory/html/img/items/${item.name}.png" />
              </div>
              <div class="mx-[4vh]">${item.label}</div>
              <div class="bg-black/[0.5] rounded w-[2.8vh] text-center" id="count_${item.name}">0</div>
        </div>
      `;
    }
    return;
  }

  if (event.data.action === "hideProcessDetail") {
    $("body").fadeOut();
    $("#process").fadeOut();
    const container = document.getElementById("container-items");
    container.innerHTML = "";
    return;
  }

  if (event.data.action === "updateProcessDetail") {
    const jsonSelectedItems = JSON.parse(res.selectedItems);
    // console.log(JSON.stringify(jsonSelectedItems))
    for (const key in jsonSelectedItems) {
      const item = jsonSelectedItems[key];
      const countContainer = document.getElementById(`count_${item.name}`);
      // console.log(countContainer)
      if (countContainer !== undefined) {
        countContainer.innerHTML = item.quantity
      }
    }
  }
});
