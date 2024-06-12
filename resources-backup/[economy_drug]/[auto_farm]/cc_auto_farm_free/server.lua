ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local selectedItems = {}

RegisterServerEvent('doneFreeAutoFarm')
AddEventHandler('doneFreeAutoFarm', function(currentFreeAutoFarm)
    local xPlayer = ESX.GetPlayerFromId(source)
    doneFreeAutoFarmHandler(currentFreeAutoFarm, xPlayer)
end)

function doneFreeAutoFarmHandler(currentFreeAutoFarm,xPlayer)
    if type(selectedItems[xPlayer.source]) == "nil" then
        initUI(xPlayer,currentFreeAutoFarm)
    end

    local statusBonus = calculateBonus(xPlayer,currentFreeAutoFarm)
    -- if not statusBonus then
        baseItem(xPlayer, currentFreeAutoFarm)
    -- end
    xPlayer.triggerEvent('ongoingFreeAutoFarm')
end

function clearState(source)
    selectedItems[source] = nil
end

function initUI(xPlayer,currentFreeAutoFarm)
    -- init ui
    if type(selectedItems[xPlayer.source]) == "nil" then
        selectedItems[xPlayer.source] = {}
        --print("before currentfarm")
        for _, v in pairs(Config.AutoFarmFreeInfoServer) do
            if currentFreeAutoFarm == v.name then
                --print("true currentfarm")
                local itemNames = v.getItemName
                for _, itemName in ipairs(itemNames) do
                    local xItem = xPlayer.getInventoryItem(itemName)
                    selectedItems[xPlayer.source][itemName] = {}
                    selectedItems[xPlayer.source][itemName].quantity = 0
                    selectedItems[xPlayer.source][itemName].name = itemName
                    selectedItems[xPlayer.source][itemName].label = xItem.label
                    --print(selectedItems[xPlayer.source][itemName].quantity)
                    --print(selectedItems[xPlayer.source][itemName].name)
                    --print(selectedItems[xPlayer.source][itemName].label)
                end

                local getItemBonus = v.getItemBonus
                if getItemBonus ~= nil then
                    for _, bonusItemName in ipairs(getItemBonus) do
                        local xItem = xPlayer.getInventoryItem(bonusItemName.itemName)
                        selectedItems[xPlayer.source][bonusItemName.itemName] = {}
                        selectedItems[xPlayer.source][bonusItemName.itemName].quantity = 0
                        selectedItems[xPlayer.source][bonusItemName.itemName].name = bonusItemName.itemName
                        selectedItems[xPlayer.source][bonusItemName.itemName].label = xItem.label
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].quantity)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].name)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].label)
                    end
                end

                local getItemBonusSecond = v.getItemBonusSecond
                if getItemBonusSecond ~= nil then
                    for _, bonusItemNameSecond in ipairs(getItemBonusSecond) do
                        local xItem = xPlayer.getInventoryItem(bonusItemNameSecond)
                        selectedItems[xPlayer.source][bonusItemNameSecond] = {}
                        selectedItems[xPlayer.source][bonusItemNameSecond].quantity = 0
                        selectedItems[xPlayer.source][bonusItemNameSecond].name = bonusItemNameSecond
                        selectedItems[xPlayer.source][bonusItemNameSecond].label = xItem.label
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].quantity)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].name)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].label)
                    end
                end
                xPlayer.triggerEvent('cc_auto_farm_free:initUI', selectedItems[xPlayer.source])
            end
        end
    end
end

ESX.RegisterServerCallback('checkHasItem', function(source, cb,currentFreeAutoFarm)
    local xPlayer = ESX.GetPlayerFromId(source)
    --print(currentFreeAutoFarm)
    for _,v in pairs(Config.AutoFarmFreeInfoServer) do
        --print('in for loop but not in if')
        if v.name == currentFreeAutoFarm then
            --print('in if')
            local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2])
            local tbl = v.getItemName
            local itemBaseRand = tbl[math.random(1, #tbl)]
            local xItem = xPlayer.getInventoryItem(itemBaseRand)
            local hasxItem = xPlayer.getInventoryItem(v.useitem)
            if hasxItem.count >= v.useitemcount  then
                xPlayer.removeInventoryItem(v.useitem, v.useitemcount)
                initUI(xPlayer,currentFreeAutoFarm)
                cb(true)
                return
            end
            hasnoItem(xPlayer.source)
            cb(false)
            return
        end
    end
    --print('not in for loop')
    cb(false)
end)


function calculateBonus(xPlayer,currentFreeAutoFarm)
    local getBonus = false
    for _,v in pairs(Config.AutoFarmFreeInfoServer) do
		if v.name == currentFreeAutoFarm then
            if v.getItemBonus ~= nil then
                local xItemBonusRate = math.random(1, 100000)/100000
                --print("1st Bonus : "..xItemBonusRate)
                for _,v in pairs(v.getItemBonus) do
                    if xItemBonusRate <= v.percent then
                        local xItemBonus = xPlayer.getInventoryItem(v.itemName)
                        givebonusitem(xPlayer, xItemBonus)
                        getBonus = true
                        break 
                    end
                end
            end

            if v.getItemBonusSecond ~= nil then
                local xItemBonusSecondRate = math.random(1, 100000)/100000
                local tblSecond = v.getItemBonusSecond
                local itemBonusSecondRand = tblSecond[math.random(1, #tblSecond)]
                --print('2rd Bonus : '..xItemBonusSecondRate)
                if xItemBonusSecondRate <= v.getItemBonusSecondPercent then
                    local xItemBonusSecond = xPlayer.getInventoryItem(itemBonusSecondRand)
                    givebonusitem(xPlayer, xItemBonusSecond)
                    getBonus = true
                end
            end
            return getBonus
        end
    end
    return getBonus
end

function givebonusitem(xPlayer, currentBonus)
    xPlayer.addInventoryItem(currentBonus.name, 1)
    selectedItems[xPlayer.source][currentBonus.name].quantity = 1 + selectedItems[xPlayer.source][currentBonus.name].quantity
    xPlayer.triggerEvent('cc_auto_farm_free:updateUI',selectedItems[xPlayer.source])
end

function baseItem(xPlayer, currentFreeAutoFarm)
    for _,v in pairs(Config.AutoFarmFreeInfoServer) do
        if v.name == currentFreeAutoFarm then
            local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2]) 
            local tbl = v.getItemName
            local itemBaseRand = tbl[math.random(1, #tbl)]
            local xItem = xPlayer.getInventoryItem(itemBaseRand)

            xPlayer.addInventoryItem(xItem.name, xItemCount)
            selectedItems[xPlayer.source][xItem.name].quantity = xItemCount + selectedItems[xPlayer.source][xItem.name].quantity
            xPlayer.triggerEvent('cc_auto_farm_free:updateUI',selectedItems[xPlayer.source])
        end
    end
end

function onMaxWeight(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Auto Farm', -- หัวเรื่อง
        description = 'น้ำหนักกระเป๋าเต็ม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function hasnoItem(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Auto Farm', -- หัวเรื่อง
        description = 'คุณไม่มีไอเทมที่กำหนดไว้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

RegisterServerEvent('cc_auto_farm_free:cancelFromClient')
AddEventHandler('cc_auto_farm_free:cancelFromClient', function()
    local xPlayer	= ESX.GetPlayerFromId(source)
    clearState(xPlayer.source)
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    if playerId then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            clearState(xPlayer.source)
        end
        collectgarbage()
    end
end)