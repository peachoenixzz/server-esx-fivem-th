 ESX = nil --
 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterServerCallback('cc_exchange:checkZoneNewDrug', function(source, cb)
    local newDrugZones = {
        {
            coords = {
                vector3(-1221.449951171875, -168.22000122070312, 39.31999969482422), 
                vector3(-1218.4100341796875, -169.72000122070312, 39.31999969482422),
                vector3(-1220.9599609375, -173.89999389648438, 39.31999969482422),
                vector3(-1223.719970703125, -172.5, 39.31999969482422),
            },
            name = "coke_meth_zone",
            debug = false,
            minZ = 38.0,
            maxZ = 42.0,
            markerCoords = {x = -1221.1099853515625, y = -171.07000732421875, z = 38.31999969482422,}
        },
    }
    cb(newDrugZones)
end)

 ESX.RegisterServerCallback('cc_pick_new_drug:checkCanPressKey', function(source, cb)
     local xPlayer =  ESX.GetPlayerFromId(source)
     local status = exports.cc_coreeffect:coreEffectCheckTimeRealTimeGlobal('block_pick_basic_drug', 10)
     if status then
         cb(status)
         return
     end
     notifyCoolDown(xPlayer)
    cb(status)
 end)

RegisterServerEvent('donePickNewDrug')
AddEventHandler('donePickNewDrug', function(drugIdentify)
    local source = source
    local xPlayer =  ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.newDrugInfo) do
        if v.name == drugIdentify then
            if v.type == 'basic_drug' then
                    --print(xItemBonusRate)
                    local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2])
                    local tbl = v.getItem
                    local itemBaseRand = tbl[math.random(1, #tbl)]
                    local xItem = xPlayer.getInventoryItem(itemBaseRand)
                    if v.getItemBonus ~= nil then
                        local xItemBonusRate = math.random(1, 100000)/100000
                        --print(xItemBonusRate)
                        local matchingBonusItems = {}
                        local minMatchingBonusPercent = 1.0
                
                        for _, v in pairs(v.getItemBonus) do
                            if xItemBonusRate <= v.percent then
                                table.insert(matchingBonusItems, v)
                                if v.percent < minMatchingBonusPercent then
                                    minMatchingBonusPercent = v.percent
                                end
                            end
                        end
                
                        local finalMatchingBonusItems = {}
                        for _, v in pairs(matchingBonusItems) do
                            if v.percent == minMatchingBonusPercent then
                                table.insert(finalMatchingBonusItems, v)
                            end
                        end
                
                
                        if #finalMatchingBonusItems > 0 then
                            local randomBonusIndex = math.random(1, #finalMatchingBonusItems)
                            local randomBonusItem = finalMatchingBonusItems[randomBonusIndex]
                            local addItemCount = math.random(randomBonusItem.quantity[1], randomBonusItem.quantity[2])
                            if xPlayer.canCarryItem(randomBonusItem.itemName, addItemCount) then
                                xPlayer.addInventoryItem(randomBonusItem.itemName, addItemCount)    
                            end
                        end
                    end


                    if xPlayer.canCarryItem(xItem.name, xItemCount) then
                        xPlayer.addInventoryItem(xItem.name, xItemCount)
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'PickUpNewDrugs',
                                content = ('%s ได้ทำการเก็บ %s ได้รับ %s จำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItemCount),
                                source = xPlayer.source,
                            })
                        end) -- End Log
                    else
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'OverWeightPickUpNewDrugs',
                                content = ('%s ไม่สามารถได้รับ %s จำนวน %s ชิ้น จากการเก็บ %s ได้ เนื่องจากน้ำหนักกระเป๋าเต็ม'):format(xPlayer.name, xItem.name, xItemCount, xItem.name),
                                source = xPlayer.source,
                            })
                        end) -- End Log
                        exports.nc_notify:PushNotification(source,{
                            scale = 1.0,
                            title = 'ระบบน้ำหนัก',
                            description = 'น้ำหนักกระเป๋าของคุณไม่เพียงพอ',
                            type = 'warning',
                            position = 'top',
                            direction = 'right',
                            priority = 'medium',
                            icon = 'inventory_max',
                            duration = 3000
                        })
                    end
            end
        end
    end
end)


 RegisterServerEvent('initTimeGlobal')
 AddEventHandler('initTimeGlobal', function()
     exports.cc_coreeffect:createDebuffGlobal('block_pick_basic_drug',300000,'block_pick_basic_drug','hide')
 end)



 -- Initial sleep time (milliseconds)
 local slp = 10000

 Citizen.CreateThread(function()
     while true do
         Citizen.Wait(slp)

         -- Perform the query using your 'coreEffectCheckTimeRealTimeGlobal' function
         local queryAllowPick = exports.cc_coreeffect:coreEffectCheckTimeRealTimeGlobal('block_pick_basic_drug', 10)

         -- Trigger the client event to send data to all clients
         TriggerClientEvent("cc_new_pick_drug:collectAllowData", -1, queryAllowPick)

         -- Update sleep time for the next iteration
         slp = 10000
     end
 end)



 function notifyCoolDown(xPlayer)
     exports.nc_notify:PushNotification(xPlayer.source,{
         scale = 1.0, -- ปรับขนาดของ Notify
         title = 'ระบบเก็บยา', -- หัวเรื่อง
         description = 'อยู่ระหว่างรอ Cooldown เก็บยา', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
         type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
         position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
         direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
         priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
         icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
         duration = 3000 -- ระยะเวลาการแสดง Notify
     })
 end
