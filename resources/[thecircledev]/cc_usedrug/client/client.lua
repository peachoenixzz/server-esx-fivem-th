ESX              = nil
local DrugZoneVector = {}
local InZoneDrug = nil
local onEating = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
end)

local drugSetting = {
    cocaine_2 = {
        name = "cocaine_2",
        effect = "Drunk",
        animDict = "mini@tennisexit@michael",
        animBase = "tennis_outro_michael",
        propModel = nil,
        Stress = 1200000,
    },
    weed_pack = {
        name = "weed_pack",
        effect = "Drunk",
        animDict = "anim@safehouse@bong",
        animBase = "bong_stage3",
        propModel = "hei_heist_sh_bong_01",
        Stress = 900000,
    }
}

DrugZoneVector[1] = PolyZone:Create({--บ่อน
    vector3(964.0800170898438, -189.5800018310547, 73.20999908447266),
    vector3(973.3900146484376, -195.2899932861328, 73.20999908447266),
    vector3(966.52001953125, -206.66000366210935, 73.20999908447266),
    vector3(964.5700073242188, -205.60000610351565, 73.20999908447266),
    vector3(959.8900146484376, -212.9900054931641, 73.20999908447266),
    vector3(953.6900024414064, -209.38999938964844, 73.20999908447266),
    vector3(952.3400268554688, -211.1699981689453, 73.20999908447266),
    vector3(946.4600219726564, -207.67999267578128, 73.20999908447266),
    vector3(954.9000244140624, -193.5800018310547, 73.20999908447266),
    vector3(960.030029296875, -196.17999267578128, 73.12999725341797),
    vector3(964.0800170898438, -189.5800018310547, 73.20999908447266)
}, {
    name="drug_zone_casino",
    minZ=-73,
    maxZ=100,
    debugPoly = false,
})

DrugZoneVector[2] = PolyZone:Create({--ส่วนกลาง
    vector3(-450.2699890136719, 1083.6600341796875, 327.57000732421875),
    vector3(-452.1499938964844, 1076.8800048828125, 327.57000732421875),
    vector3(-458.1799926757813, 1083.2099609375, 327.57000732421875),
    vector3(-462.010009765625, 1091.8199462890625, 327.57000732421875),
    vector3(-454.8299865722656, 1089.780029296875, 327.6300048828125),
    vector3(-452.6799926757813, 1086.1099853515625, 327.6300048828125),
}, {
    name="drug_zone_casino",
    minZ=326,
    maxZ=330,
    debugPoly = false,
})

DrugZoneVector[3] = PolyZone:Create({--หมอ
    vector3(357.9200134277344, -1440.25, 32.5099983215332),
    vector3(350.4200134277344, -1449.300048828125, 32.5099983215332),
    vector3(345.3900146484375, -1445.1300048828125, 32.5099983215332),
    vector3(353.1000061035156, -1435.97998046875, 32.5099983215332),
}, {
    name="drug_zone_casino",
    minZ=30,
    maxZ=36,
    debugPoly = false,
})

DrugZoneVector[4] = PolyZone:Create({--ตำรวจ
    vector3(463.44000244140625, -976.489990234375, 30.69000053405761),
    vector3(458.989990234375, -976.3699951171876, 30.79000091552734),
    vector3(459.1000061035156, -982.719970703125, 30.69000053405761),
    vector3(463.5799865722656, -983.0900268554688, 31.96999931335449),
}, {
    name="drug_zone_casino",
    minZ=29,
    maxZ=32,
    debugPoly = false,
})

DrugZoneVector[5] = PolyZone:Create({--ตำรวจ
    vector3(-450.8399963378906, 1088.4300537109375, 321.1799926757813),
    vector3(-448.7000122070313, 1097.97998046875, 321.6099853515625),
    vector3(-461.0199890136719, 1101.47998046875, 321.7699890136719),
    vector3(-461.0199890136719, 1101.47998046875, 321.7699890136719),
    vector3(-460.5299987792969, 1094.25, 321.1799926757813),
    vector3(-461.19000244140625, 1091.199951171875, 321.1799926757813),
    vector3(-450.6400146484375, 1088.3800048828125, 321.1799926757813),
}, {
    name="circle_department",
    minZ=320,
    maxZ=325,
    debugPoly = false,
})

function useDrug(itemName)
    if itemName == "weed_pack" or itemName == "cocaine_2" then
        removeItem(itemName)
    else
        onUseDrugcantuse()
    end
end

function removeItem(itemName)
    ESX.TriggerServerCallback('cc_usedrug:checkPlayerItem', function(status,item)
        if status then
            onEating = true
            processDrug(item)
            onGoingDrug()
        end
    end, itemName )-- param send to sv
end


function processDrug(realItemName)
    -- print("process",realItemName)
    -- print(drugSetting[realItemName].animDict)
    -- print(drugSetting[realItemName].anim)
    -- print(drugSetting[realItemName].model)
    TriggerEvent("mythic_progbar:client:progress",{
        name = "useDrug",
        duration = 30000,
        label = "กำลังเสพยา",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = drugSetting[realItemName].animDict,
            anim = drugSetting[realItemName].animBase,
            flags = 49
        },
        prop = {
            model = drugSetting[realItemName].propModel,
        }
    }, function(status)
        if not status then
            onEating = false
            exports.helpnotify:hideHelpNotification()
            useDrugSuccess()
            TriggerEvent('esx_status:remove','stress', drugSetting[realItemName].Stress)
        end
    end)
end

function onGoingDrug()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onEating do
            Citizen.Wait(0)
            if onEating then
                --DisableControlAction(0,Config.Key['F'], true)
                DisableControlAction(0, 288, true) --F1
                DisableControlAction(0, 74, true) --H
                DisableControlAction(0, 74, true) --E
                --DisableControlAction(0,Config.Key['LEFTSHIFT'], true)
                --DisableControlAction(0, 75, true) --ลงรถ
                DisableControlAction(0, 104, true) --สไลด์
                DisableControlAction(0, 155, true) --สไลด์
                --DisableControlAction(0, 24, true)
            end
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
            end

            if IsControlJustPressed(0,73) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
            end
        end
    end)
end

function useDrugSuccess()
    ESX.TriggerServerCallback('cc_coreeffect:createDebuffPlayerByCallback', function()

    end,"dizzy")-- param send to sv
end


local DrugZone = ComboZone:Create(DrugZoneVector, {name="drug_zone_casino", debugPoly=false})
DrugZone:onPlayerInOut(function(isPointInside, point, zone)
    if zone then
        if isPointInside then
            InZoneDrug = true
        else
            InZoneDrug = false
        end
    end
end, 1500)

AddEventHandler('esx:onPlayerDeath', function() 
	if onEating then
		onEating = false
        TriggerEvent("mythic_progbar:client:cancel")
	end
end)


function onUseDrugcantuse()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบเสพยา', -- หัวเรื่อง
        description = 'ยาชนิดนี้ไม่สามารถเสพได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
