local useESXanimations = false      -- 
local speed = 600.0                  --
local helpNotify = true



local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local autopilotActive = false
local blipX = 0.0
local blipY = 0.0
local blipZ = 0.0
RegisterNetEvent("autopilot:start")
AddEventHandler("autopilot:start", function(source)
  local player = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(player,false)
  local model = GetEntityModel(vehicle)
  --local displaytext = GetDisplayNameFromVehicleModel(model)
  local blip = GetFirstBlipInfoId(8)
  if (blip ~= nil and blip ~= 0) then
      local coord = GetBlipCoords(blip)
      blipX = coord.x
      blipY = coord.y
      blipZ = coord.z
      TaskVehicleDriveToCoordLongrange(player, vehicle, blipX, blipY, blipZ, speed, 1074528293, 2.0) --447 is safe here
      autopilotActive = true
  else
      exports.nc_notify:PushNotification({
          scale = 1.0, -- ปรับขนาดของ Notify
          title = 'ระบบขับรถอัตโนมัติ', -- หัวเรื่อง
          description = 'เลือกจุดหมายของท่าน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
          type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
          position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
          direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
          priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
          icon = 'garage', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
          duration = 3000 -- ระยะเวลาการแสดง Notify
      })
  end
end)

Citizen.CreateThread(function()
    local targetCoords
    local helpNotificationShown = false

    while true do
        if autopilotActive then
            local waitTime = 200 -- Adjust this time as necessary

            if not helpNotificationShown then
                exports.helpnotify:showHelpNotification("กด", "Q", "เพื่อยกเลิก")
                helpNotificationShown = true
            end

            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(player)

            if not targetCoords then
                local blip = GetFirstBlipInfoId(8)
                targetCoords = GetBlipCoords(blip)
            end

            local dist = Vdist(coords.x, coords.y, coords.z, targetCoords.x, targetCoords.y, targetCoords.z)
            if dist <= 10 then
                GradualStop(player)
                NotifyPlayerReachedDestination()
                exports.helpnotify:hideHelpNotification()
                autopilotActive = false
                helpNotificationShown = false
                targetCoords = nil
            end

            Citizen.Wait(waitTime)
        else
            targetCoords = nil
            helpNotificationShown = false
            Citizen.Wait(1000) -- Less frequent checks when autopilot is not active
        end
    end
end)

function GradualStop(player)
    local vehicle = GetVehiclePedIsIn(player, false)
    local speeds = {19.0, 15.0, 11.0, 6.0, 0.0}
    for _, speed in ipairs(speeds) do
        SetVehicleForwardSpeed(vehicle, speed)
        Citizen.Wait(200)
    end
end

function NotifyPlayerReachedDestination()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบขับรถอัตโนมัติ', -- หัวเรื่อง
        description = 'ถึงที่หมายแล้ว !!', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'garage', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


   Citizen.CreateThread(function()
       local slp = 1500
     while true do
       Citizen.Wait(slp)
       if IsControlJustReleased(0, Keys['Q']) and autopilotActive then
           ClearPedTasks(PlayerPedId())
           exports.helpnotify:hideHelpNotification()
           autopilotActive = false
           helpNotify = true
       end
         if autopilotActive then
             slp = 0
         end
         if not autopilotActive then
             slp = 1500
         end
     end
   end)