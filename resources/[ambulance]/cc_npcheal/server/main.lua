local vehicleData = {
    modDashboard = -1,
    modTrunk = -1,
    model = 841808271,
    modDoorSpeaker = -1,
    modXenon = false,
    modTransmission = -1,
    modDial = -1,
    xenonColor = 255,
    modArchCover = -1,
    modFrontBumper = -1,
    modFrame = -1,
    bodyHealth = 1000.0,
    modSeats = -1,
    wheels = 1,
    modAirFilter = -1,
    modRightFender = -1,
    modSideSkirt = -1,
    modCustomBackWheels = false,
    modEngineBlock = -1,
    modBrakes = -1,
    color1 = 6,
    modSpeakers = -1,
    modCustomFrontWheels = false,
    modTurbo = false,
    neonEnabled = {false, false, false, false},
    extras = {},
    fuelLevel = 100.0,
    modSpoilers = -1,
    modHorns = -1,
    modLightbar = -1,
    modAerials = -1,
    modHood = -1,
    windowTint = -1,
    customSecondaryColor = {0, 0, 0},
    plateIndex = 0,
    color2 = 0,
    tyreSmokeColor = {255, 255, 255},
    modSmokeEnabled = false,
    wheelColor = 156,
    modArmor = -1,
    dashboardColor = 0,
    modPlateHolder = -1,
    doorsBroken = {["3"] = false, ["2"] = false, ["4"] = false, ["1"] = false, ["0"] = false},
    modOrnaments = -1,
    modFrontWheels = -1,
    modShifterLeavers = -1,
    dirtLevel = 9.0,
    customPrimaryColor = {0, 0, 0},
    modAPlate = -1,
    interiorColor = 0,
    tyresCanBurst = 1,
    modVanityPlate = -1,
    engineHealth = 1000.0,
    tankHealth = 1000.0,
    modTank = -1,
    modSuspension = -1,
    driftTyresEnabled = false,
    modLivery = -1,
    modHydrolic = -1,
    modWindows = -1,
    modSteeringWheel = -1,
    modRoofLivery = -1,
    tyreBurst = {["5"] = false, ["4"] = false, ["1"] = false, ["0"] = false},
    modFender = -1,
    windowsBroken = {["3"] = false, ["2"] = false, ["5"] = true, ["4"] = true, ["7"] = false, ["6"] = false, ["1"] = false, ["0"] = false},
    modRoof = -1,
    modGrille = -1,
    modEngine = -1,
    modRearBumper = -1,
    pearlescentColor = 111,
    modTrimB = -1,
    neonColor = {255, 0, 255},
    modExhaust = -1,
    modBackWheels = -1,
    plate = "XXXCXXX",
    modStruts = -1,
    modTrimA = -1
}

ESX.RegisterServerCallback('cc_npcheal:autoHeal', function(source, cb, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if state == "all_in_one" and xPlayer.getMoney() >= 400 then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
            description = 'กำลังรักษา', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
        xPlayer.removeMoney(400)
        cb(true,"all_in_one")
        return
    end
    if state == "healthy" and xPlayer.getMoney() >= 100 then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
            description = 'กำลังรักษา', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
        xPlayer.removeMoney(100)
        cb(true,"healthy")
        return
    end
    if state == "healpoint" and xPlayer.getMoney() >= 200 then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
            description = 'กำลังรักษา', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
        xPlayer.removeMoney(200)
        cb(true,"healpoint")
        return
    end
    exports.nc_notify:PushNotification(xPlayer.source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
        description = 'จำนวนเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 5000 -- ระยะเวลาการแสดง Notify
    })
    cb(false)
end)