var Config = new Object();
Config.closeKeys = [27, 90];
$(window).ready(function () {
  window.addEventListener("message", async function (event) {
    let data = event.data;

    if (data.countUI !== undefined) {
      // console.log("not undefi dataui");
      // if (data.countUI) {
      //   // console.log("can count data");
      //   document.getElementById("garage-count").innerHTML = data.countInGarage;
      //   document.getElementById("impound-count").innerHTML = data.countInPound;
      //   return;
      // }
      return;
    }

    if (data.showMenu) {
      $("#container-vehicle").empty();
      $("body").fadeIn();

      // if (data.type === "impound") {
      //   $("#header ul").hide();
      // } else {
      //   $("#header ul").show();
      // }

      if (data.vehiclesList !== undefined) {
        await getVehicles(data.locales, data.vehiclesList);
        if (data.type === "trunkVehicle") {
          $("#container-vehicle").data("trunkpoint", true);
          return;
        }
        $("#container-vehicle").data("trunkpoint", false);
        $("#container-vehicle").data("spawnpoint", data.spawnPoint);
        if (data.poundCost !== undefined) {
          $("#container-vehicle").data("poundcost", data.poundCost);
        }
      }

      // if (data.vehiclesImpoundedList != undefined) {
      //   $(".impounded_content").data("poundName", data.poundName);
      //   $(".impounded_content").data("poundSpawnPoint", data.poundSpawnPoint);
      //   if (data.poundCost) $("#container").data("poundcost", data.poundCost);
      //   $(".impounded_content .vehicle-list").html(
      //     getImpoundedVehicles(data.locales, data.vehiclesImpoundedList)
      //   );
      //   $(".impounded_content h2").hide();
      // } else {
      //   $(".impounded_content h2").show();
      //   $(".impounded_content .vehicle-list").empty();
      // }
    } else if (data.hideAll) {
      $("body").fadeOut();
    }
  });

  function closeUI() {
    // $( "body" ).fadeOut( "slow" );
    $.post("https://esx_garage/escape", JSON.stringify({}));
  }

  $(document).ready(function () {
    $("body").on("keyup", function (key) {
      if (Config.closeKeys.includes(key.which)) {
        closeUI();
      }
    });
  });

  async function getVehicles(locale, vehicle, amount = null) {
    let html = "";
    let vehicleData = JSON.parse(vehicle);
    let bodyHealth = 1000;
    let engineHealth = 1000;
    let tankHealth = 1000;
    // let vehicleDamagePercent = "";
    // console.log(JSON.stringify(vehicleData))
    const vehicleContainer = document.getElementById("container-vehicle");
    let lastContainer = 0;
    // console.log(vehicleData.length)
    for (let i = 0; i < vehicleData.length; i++) {
      bodyHealth = (vehicleData[i].props.bodyHealth / 1000) * 100;
      engineHealth = (vehicleData[i].props.engineHealth / 1000) * 100;
      tankHealth = (vehicleData[i].props.tankHealth / 1000) * 100;
      if (i % 2 === 0 || i === 0) {
        // console.log(i)
        vehicleContainer.innerHTML += `<div class="grid grid-cols-2 gap-2" id="vehicle-${i}"></div>`;
        lastContainer = i;
      }
      const flexContainer = document.getElementById(`vehicle-${lastContainer}`);
      // console.log(JSON.stringify(vehicleData[i].props))
      flexContainer.innerHTML += `              
                <button
                  data-button='spawn'
                  class="box-content bg-black/[0.5] hover:bg-gradient-to-l from-[#ffa800]/[0.3] to-[#ffcc00]/[0.3] rounded-xl text-white px-[5.5vh] py-2 h-[10vh] text-center mr-1"
                  data-vehprops='${JSON.stringify(vehicleData[i].props)}'
                >
                  <div>${vehicleData[i].model}</div>
                  <div>${vehicleData[i].plate}</div>
                  <div>ENGINE : ${Math.floor(engineHealth)}%</div>
                  <div>FUEL : ${vehicleData[i].props.fuelLevel}%</div>
                </button>
                `;
    }
    // for (let i = 0; i < vehicleData.length; i++) {
    //   bodyHealth = (vehicleData[i].props.bodyHealth / 1000) * 100;
    //   engineHealth = (vehicleData[i].props.engineHealth / 1000) * 100;
    //   tankHealth = (vehicleData[i].props.tankHealth / 1000) * 100;
    //
    //   vehicleDamagePercent =
    //     Math.round(((bodyHealth + engineHealth + tankHealth) / 300) * 100) +
    //     "%";
    //
    //   html += "<div class='vehicle-listing'>";
    //   html += "<div>Model: <strong>" + vehicleData[i].model + "</strong></div>";
    //   html += "<div>Plate: <strong>" + vehicleData[i].plate + "</strong></div>";
    //   html +=
    //     "<div>Condition: <strong>" + vehicleDamagePercent + "</strong></div>";
    //   html +=
    //     "<button data-button='spawn' class='vehicle-action unstyled-button' data-vehprops='" +
    //     JSON.stringify(vehicleData[i].props) +
    //     "'>" +
    //     locale.action +
    //     (amount ? " ($" + amount + ")" : "") +
    //     "</button>";
    //   html += "</div>";
    // }

    return html;
  }

  function getImpoundedVehicles(locale, vehicle) {
    let html = "";
    let vehicleData = JSON.parse(vehicle);
    let bodyHealth = 1000;
    let engineHealth = 1000;
    let tankHealth = 1000;
    let vehicleDamagePercent = "";

    for (let i = 0; i < vehicleData.length; i++) {
      bodyHealth = (vehicleData[i].props.bodyHealth / 1000) * 100;
      engineHealth = (vehicleData[i].props.engineHealth / 1000) * 100;
      tankHealth = (vehicleData[i].props.tankHealth / 1000) * 100;

      vehicleDamagePercent =
        Math.round(((bodyHealth + engineHealth + tankHealth) / 300) * 100) +
        "%";

      html += "<div class='vehicle-listing'>";
      html += "<div>Model: <strong>" + vehicleData[i].model + "</strong></div>";
      html += "<div>Plate: <strong>" + vehicleData[i].plate + "</strong></div>";
      html +=
        "<div>Condition: <strong>" + vehicleDamagePercent + "</strong></div>";
      html +=
        "<button data-button='impounded' class='vehicle-action red unstyled-button' data-vehprops='" +
        JSON.stringify(vehicleData[i].props) +
        "'>" +
        locale.impound_action +
        "</button>";
      html += "</div>";
    }

    return html;
  }

  $(document).on(
    "click",
    "button[data-button='spawn']",
    async function (event) {
      let spawnPoint = $("#container-vehicle").data("spawnpoint");
      let poundCost = $("#container-vehicle").data("poundcost");
      let trunkPoint = $("#container-vehicle").data("trunkpoint");
      let vehicleProps = $(this).data("vehprops");
      // console.log(JSON.stringify(vehicleProps));
      // console.log(spawnPoint);
      // prevent empty cost
      if (poundCost === undefined) poundCost = 0;

      $.post(
        "https://esx_garage/spawnVehicle",
        JSON.stringify({
          vehicleProps: vehicleProps,
          spawnPoint: spawnPoint,
          trunkPoint: trunkPoint,
          exitVehicleCost: poundCost,
        })
      );
    }
  );
});
