ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(100)
end)

local inzoneExchange = false

local blackmoneyexchange = PolyZone:Create({
    vector3(245.44000244140625, 223.9900054931641, 106.29000091552736), 
    vector3(244.52000427246097, 221.85000610351565, 106.29000091552736),
    vector3(248.7299957275391, 220.2100067138672, 106.29000091552736),
    vector3(249.4499969482422, 222.42999267578128, 106.29000091552736),
},{
    name = "exchange_blackmoney",
    debugPoly = false,
    minZ = 105,
    maxZ = 110,
})

blackmoneyexchange:onPlayerInOut(function(isPointInside, point)
    if isPointInside then
        inzoneExchange = true
        exports.helpnotify:showHelpNotification("กด","E","เพื่อแลกเงิน")
    else
        inzoneExchange = false
        exports.helpnotify:hideHelpNotification()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inzoneExchange == true then
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                exports.helpnotify:hideHelpNotification()
                exchangeMenu()
                --putamounttoTrade()
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

function exchangeMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createamount_exchange',
    {
        title = "แลกเงินผิดกฎหมายขั้นต่ำ 100",
    }, function(data, menu)
        if inzoneExchange then     
            if tonumber(data.value) and tonumber(data.value) >= 100 then
                --print("Int : "..data.value)
                TriggerServerEvent('cc_exchange:blackmoneyexchange', tonumber(data.value))
                menu.close()
            else
                --print("Char : "..data.value)
                menu.close()
            end
        else    
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end
