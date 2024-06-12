ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)
itemSellTrigger = {}
local itemSetting = {
    cocaine_2 = { -- use same ItemName in database or another setting
        minPrice = 1000,
        maxPrice = 2000,
        removeItem = 1,
        percent = 60
    },
    meth_a = { -- use same ItemName in database or another setting
        minPrice = 2500,
        maxPrice = 3000,
        removeItem = 1,
        percent = 60
    },
    meth_b = { -- use same ItemName in database or another setting
        minPrice = 3500,
        maxPrice = 4000,
        removeItem = 1,
        percent = 60
    },
    heroine = { -- use same ItemName in database or another setting
        minPrice = 4500,
        maxPrice = 5000,
        removeItem = 1,
        percent = 60
    },
}

RegisterServerEvent('cc_selldrug:sellDrug')
AddEventHandler('cc_selldrug:sellDrug', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(itemSellTrigger[source])
    print("player is here : ",xPlayer.name)
    local percentRand = math.random(0, 100)
    print("percent sell success", percentRand)
    pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'DrugSelling',
            content = ('%s ได้ทำการขาย %s และมี %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItem.count),
            source = xPlayer.source,
        })
    end) -- End Log

    if xItem.count <= 0 then
        TriggerClientEvent('cc_selldrug:failedToSell', xPlayer.source)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'DrugSellingFailNoneItem',
                content = ('%s ไม่สามารถขาย %s ได้เนื่องจากไม่มีไอเทมเพื่อทำการขาย'):format(xPlayer.name, xItem.name),
                source = xPlayer.source,
            })
         end) -- End Log
        return
    end

    if percentRand > itemSetting[itemSellTrigger[xPlayer.source]].percent then
        TriggerClientEvent('cc_selldrug:failedToSell', xPlayer.source)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'DrugSellingFail',
                content = ('%s ไม่สามารถขาย %s ได้เนื่องจากเจรจากับคนซื้อไม่ลงตัวและมี %s ในกระเป๋าจำนวน %s ชิ้น โอกาสที่จะเจรจาไม่ลงตัว %s เปอร์เซ็น'):format(xPlayer.name,xItem.name, xItem.name, xItem.count, percentRand),
                source = xPlayer.source,
            })
        end) -- End Log
        return
    end
    if percentRand < itemSetting[itemSellTrigger[xPlayer.source]].percent then
        -- For Log Purpose
        local oldmoneycount = xPlayer.getAccount("black_money").money
        -- End Log
        xPlayer.removeInventoryItem(itemSellTrigger[xPlayer.source], itemSetting[itemSellTrigger[xPlayer.source]].removeItem)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'DrugSellingRemoveItem',
                content = ('%s ได้ทำการขาย %s และได้สูญเสีย %s จำนวน 1 ชิ้นจากการขายและเหลือ %s จำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItem.name, xPlayer.getInventoryItem(itemSellTrigger[source], itemSetting[itemSellTrigger[source]].removeItem).count),
                source = xPlayer.source,
            })
         end) -- End Log
        xPlayer.addAccountMoney('black_money', math.random(itemSetting[itemSellTrigger[xPlayer.source]].minPrice,
        itemSetting[itemSellTrigger[xPlayer.source]].maxPrice))
        -- For Log Purpose
        local newmoneycount = xPlayer.getAccount("black_money").money
        -- End Log
            pcall(function() -- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'DrugSellingReceivedMoney',
                    content = ('%s ได้ทำการขาย %s และได้รับ black_money จำนวน $%s'):format(xPlayer.name, xItem.name, (newmoneycount - oldmoneycount)),
                    source = xPlayer.source,
                })
            end) -- End Log
        TriggerClientEvent('cc_selldrug:successToSell', xPlayer.source)
    end
end)

RegisterServerEvent('cc_selldrug:checkItem')
AddEventHandler('cc_selldrug:checkItem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(itemSellTrigger[xPlayer.source])
    if xItem.count <= 0 then
        TriggerClientEvent('cc_selldrug:resetStatePlayer', xPlayer.source)
    end
end)

ESX.RegisterUsableItem("cocaine_2", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("cocaine_2")
    itemSellTrigger[source] = xItem.name
    TriggerClientEvent('cc_selldrug:openMenu', source, xItem.label, xItem.name)
    --print(xItem.label, xItem.name)
end)

ESX.RegisterUsableItem("meth_a", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("meth_a")
    itemSellTrigger[source] = xItem.name
    TriggerClientEvent('cc_selldrug:openMenu', source, xItem.label, xItem.name)
    --print(xItem.label, xItem.name)
end)

ESX.RegisterUsableItem("meth_b", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("meth_b")
    itemSellTrigger[source] = xItem.name
    TriggerClientEvent('cc_selldrug:openMenu', source, xItem.label, xItem.name)
    --print(xItem.label, xItem.name)
end)

ESX.RegisterUsableItem("heroine", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("heroine")
    itemSellTrigger[source] = xItem.name
    TriggerClientEvent('cc_selldrug:openMenu', source, xItem.label, xItem.name)
    --print(xItem.label, xItem.name)
end)

ESX.RegisterUsableItem("weed_pack", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("weed_pack")
    itemSellTrigger[source] = xItem.name
    TriggerClientEvent('cc_selldrug:openMenuDrug', source, xItem.label, xItem.name)
    --print(xItem.label, xItem.name)
end)

-- ESX.RegisterUsableItem("drug_skull", function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local xItem = xPlayer.getInventoryItem("drug_skull")
--     itemSellTrigger[source] = xItem.name
--     TriggerClientEvent('cc_selldrug:openMenu', source, xItem.label, xItem.name)
--     --print(xItem.label, xItem.name)
-- end)


-- ESX.RegisterUsableItem("weed_pack", function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local xItem = xPlayer.getInventoryItem("weed_pack")
--     if xItem.count > 0 then
--         TriggerClientEvent('cc_selldrug:openMenuDrug', source, xItem.label, xItem.name)
--     end
--     --print(xItem.label, xItem.name)
-- end)


AddEventHandler('playerDropped', function()
    local playerId = source
    if playerId then
        itemSellTrigger[source] = nil
    end
end)
