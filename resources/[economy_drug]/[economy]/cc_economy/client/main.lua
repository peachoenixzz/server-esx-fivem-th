menuOpen = false

local nearCords = nil
local position = nil
local helpState = true
local menuState = true

RegisterNetEvent( 'sent:economy' )
AddEventHandler( 'sent:economy', function(num)
    if Config.OpenUI then
        --show for none items in inventory
    SendNUIMessage({
        message     = "show",
        clear = true
    })

    SetNuiFocus(true, true)
    local pricedif = 0
        local itemsArr = {}
        for k, v in pairs(num) do
            if v.price ~= v.priceold then
                pricedif = v.price - v.priceold
            end
            if v.price == v.priceold then
                pricedif = 0
            end

            if v.position_item ~= "eco_special" or v.category ~= 'eco_special' then
                local itemArr = {
                    id          = v.id,
                    item        = v.item,
                    label       = v.label,
                    price       = v.price,
                    pricedif    = pricedif,
                    typemoney   = v.typemoney,
                    randomprice = v.randomprice,
                    pricemin    = v.pricemin,
                    pricemax    = v.pricemax,
                    sellPosition = v.sellPosition,
                    processPosition = v.processPosition,
                    packagePosition = v.packagePosition,
                    pickPosition = v.pickPosition,
                    position_item = v.position_item
                }
                table.insert(itemsArr,itemArr)
            end
        end
        SendNUIMessage({
            message     = "show-all-item",
            items = itemsArr
        })
    else
    ESX.UI.Menu.CloseAll()
    local elements = {}
    menuOpen = true

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Economy', {
        title    = 'Economy',
        align    = 'top-right',
        elements = elements
    }, function(data, menu)

    end, function(data, menu)
        menu.close()
        menuOpen = false
    end)
    
    end
end )

RegisterNetEvent( 'sent:economysell' )
AddEventHandler( 'sent:economysell', function(listitem,position)
    if Config.OpenUI then
    local pricedif = 0
    SendNUIMessage({
        message     = "show-sell",
        clear = true
    })
        menuOpen = true
    SetNuiFocus(true, true)
        local itemsArr = {}
        local itemArr = {}
    for k, v in pairs(listitem) do
        local Text
        local countmax = 0
        local players = ESX.GetPlayerData()
        for a, b in pairs(players.inventory) do
        if b.name == v.item and b.count > 0 then
            countmax = b.count
            if v.randomprice then
            Text = ('%s - <span style="color:green;">$%s  -  $%s</span>'):format(v.label, ESX.Math.GroupDigits(v.pricemin), ESX.Math.GroupDigits(v.pricemax))
            else
            Text = ('%s - <span style="color:green;">$%s</span>'):format(v.label, ESX.Math.GroupDigits(v.price))
            end
        end
        end

        if v.price ~= v.priceold then
            pricedif = v.price - v.priceold
        end
        if v.price == v.priceold then
            pricedif = 0
        end
        itemArr = {
            id          = v.id,
            item        = v.item,
            label       = v.label,
            price       = v.price,
            pricedif    = pricedif,
            typemoney   = v.typemoney,
            randomprice = v.randomprice,
            pricemin    = v.pricemin,
            pricemax    = v.pricemax,
            min         = 1,
            max         = countmax,
            position_npc = position,
            position_item = v.position_item
        }
        table.insert(itemsArr, itemArr)
    end
        SendNUIMessage({
            message     = "sell",
            items = itemsArr,
        })

    
    else
    ESX.UI.Menu.CloseAll()
    local elements = {}
    menuOpen = true


    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Economy', {
        title    = 'Economy',
        align    = 'top-right',
        elements = elements
    }, function(data, menu)
        TriggerServerEvent('economy:shopsellmoney', data.current.name, data.current.value ,data.current.price)
        menu.close()
    end, function(data, menu)
        menu.close()
        menuOpen = false
    end)
    end
end)


function checkStateEconomy()
    local coords = GetPlayerCoordsAsync()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        if menuOpen and menuState then
            exports.helpnotify:hideHelpNotification()
            helpState = true
            menuState = false
        end
        if GetDistanceBetweenCoords(coords, nearCords, true) > 1 then
            exports.helpnotify:hideHelpNotification()
            helpState = true
            menuState = true
            nearCords = nil
            position = nil
        end
        if GetDistanceBetweenCoords(coords, nearCords, true) < 1 and not menuOpen and helpState then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อขายสินค้า")
            helpState = false
            menuState = true
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if nearCords ~= nil then
            checkStateEconomy()
            if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                TriggerServerEvent('economy:shopall',position)
                exports.helpnotify:hideHelpNotification()
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'OpenEconomyShop',
                        content = ('ทำการกด E เพื่อ เข้าร้านขายสินค้า'):format(),
                    })
                end) -- End Log
            end
        end
        if nearCords == nil then
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if nearCords == nil then
            for _,v in pairs(Config.zones) do
                local coords = GetPlayerCoordsAsync()
                if GetDistanceBetweenCoords(coords, v.coords, true) < 1 and not IsPedInAnyVehicle(PlayerPedId(), false) then
                    nearCords = v.coords
                    position = v.position
                end
                if nearCords ~= nil then exports.helpnotify:showHelpNotification("กด","E","เพื่อขายสินค้า") goto endState end
            end
            Citizen.Wait(250)
        end
        Citizen.Wait(250)
        ::endState::
    end
end)


function GetPlayerCoordsAsync()
    return Citizen.InvokeNative(0x3FEF770D40960D5A, PlayerPedId(), Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())
end


ESX.RegisterInput("circle:economy", "Economy Circle Hotkey", "keyboard", "F5", function()
    TriggerServerEvent('economy:callback')
    pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'CheckEconomyPrice',
            content = ('ทำการกด F5 เพื่อ เช็คราคาสินค้า'):format(),
        })
    end) -- End Log
end)

--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--        if Config.onhotkeys then
--            if IsControlJustReleased(0, Config.hotkey)  then
--                TriggerServerEvent('economy:callback')
--                pcall(function() -- Start Log
--                    exports['azael_dc-serverlogs']:insertData({
--                        event = 'CheckEconomyPrice',
--                        content = ('ทำการกด F5 เพื่อ เช็คราคาสินค้า'):format(),
--                    })
--                end) -- End Log
--            end
--        end
--    end
--end)


function closeGui()
    menuOpen = false
  SetNuiFocus(false, false)
  SendNUIMessage({message = "hide"})              
    pcall(function() -- Start Log
     exports['azael_dc-serverlogs']:insertData({
        event = 'CloseEconomyMenu',
        content = ('ทำการกด Esc เพื่อปิด menu ใน Economy'):format(),
    })
    end) -- End Log
end

RegisterNUICallback('quit', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('sellitem', function(data, cb)
    if tonumber(data.count) > 0 then
        closeGui()
        TriggerServerEvent('economy:shopsellmoney', data.nameitem, data.count)
        cb('ok')
    end
    if tonumber(data.count) < 0 then
        
    end
end)

RegisterNUICallback('sellPosition', function(data, cb)
    SetNewWaypoint(tonumber(data.position.x), tonumber(data.position.y))
end)

RegisterNUICallback('processPosition', function(data, cb)
    SetNewWaypoint(tonumber(data.position.x), tonumber(data.position.y))
end)

RegisterNUICallback('packagePosition', function(data, cb)
    SetNewWaypoint(tonumber(data.position.x), tonumber(data.position.y))
end)

RegisterNUICallback('pickPosition', function(data, cb)
    SetNewWaypoint(tonumber(data.position.x), tonumber(data.position.y))
end)

-- function CreateBlipCircle(coords, text, radius, color, blipid)
--     local blip
--     SetBlipHighDetail(blip, true)
--     SetBlipColour(blip, 1)
--     SetBlipAlpha (blip, 128)

--     blip = AddBlipForCoord(coords)

--     SetBlipHighDetail(blip, true)
--     SetBlipSprite (blip, blipid)
--     SetBlipScale  (blip, 0.8)
--     SetBlipColour (blip, color)
--     SetBlipAsShortRange(blip, true)

--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString(text)
--     EndTextCommandSetBlipName(blip)
-- end

-- Citizen.CreateThread(function()
--     CreateBlipCircle(Config.zones.pork.coords, Config.zones.pork.name, Config.zones.pork.radius, Config.zones.pork.color, Config.zones.pork.blipid)
--     CreateBlipCircle(Config.zones.chicken.coords, Config.zones.chicken.name, Config.zones.chicken.radius, Config.zones.chicken.color, Config.zones.chicken.blipid)
--     CreateBlipCircle(Config.zones.wood.coords, Config.zones.wood.name, Config.zones.wood.radius, Config.zones.wood.color, Config.zones.wood.blipid)
--     CreateBlipCircle(Config.zones.coconut.coords, Config.zones.coconut.name, Config.zones.coconut.radius, Config.zones.coconut.color, Config.zones.coconut.blipid)
--     CreateBlipCircle(Config.zones.rice.coords, Config.zones.rice.name, Config.zones.rice.radius, Config.zones.rice.color, Config.zones.rice.blipid)
--     CreateBlipCircle(Config.zones.fishmullet.coords, Config.zones.fishmullet.name, Config.zones.fishmullet.radius, Config.zones.fishmullet.color, Config.zones.fishmullet.blipid)
--     CreateBlipCircle(Config.zones.squid1.coords, Config.zones.squid1.name, Config.zones.squid1.radius, Config.zones.squid1.color, Config.zones.squid1.blipid)
--     CreateBlipCircle(Config.zones.bottle.coords, Config.zones.bottle.name, Config.zones.bottle.radius, Config.zones.bottle.color, Config.zones.bottle.blipid)
-- end)
