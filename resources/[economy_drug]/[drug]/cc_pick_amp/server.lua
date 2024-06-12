ESX = nil --
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local slp = 1500
ESX.RegisterServerCallback('cc_exchange:checkZoneAmp', function(source, cb)
    local ampZones = {
        {
            coords = {
                vector3(-489.0499877929688, -334.7000122070313, 34.36000061035156), 
                vector3(-494.1600036621094, -334.0799865722656, 34.36999893188476),
                vector3(-494.80999755859375, -338.6900024414063, 34.38000106811523),
                vector3(-489.6700134277344, -339.4299926757813, 34.36999893188476),
            },
            name = "amp_zone",
            debug = false,
            minZ = 32.0,
            maxZ = 37.0,
            markerCoords = {x = -492.0400085449219, y = -336.7300109863281, z = 33.11000061035156,}
        },
    }
    cb(ampZones)
end)

RegisterServerEvent('donePickAmp')
AddEventHandler('donePickAmp', function(ampIdentify)
    local source = source
    local xPlayer =  ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.ampInfo) do
        if v.name == ampIdentify then
            if v.type == 'basic_amp' then
                if exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'block_pick_amps_drug') ~= 0 then
                    notifyCoolDown(xPlayer)
                    return
                end

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

                if v.getItem ~= nil then
                    local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2])
                    local tbl = v.getItem
                    local itemBaseRand = tbl[math.random(1, #tbl)]
                    local xItem = xPlayer.getInventoryItem(itemBaseRand)
        
                    if xPlayer.canCarryItem(xItem.name, xItemCount) then
                        xPlayer.addInventoryItem(xItem.name, xItemCount)
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'PickUpAmp',
                                content = ('%s ได้ทำการเก็บ %s ได้รับ %s จำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItemCount),
                                source = xPlayer.source,
                            })
                        end) -- End Log
                    else
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'OverWeightPickUpAmp',
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
                exports.cc_coreeffect:createDebuff(xPlayer,'block_pick_amps_drug',600000,'block_pick_amps_drug','hide')
            end
        end
    end
end)

ESX.RegisterServerCallback('cc_pick_amp:checkStatus', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local time = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'block_pick_amps_drug')
    if time > 0 then
        notifyCoolDown(xPlayer)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PickUpAmpCoolDown',
                content = ('%s ได้พยายามเก็บ amp แต่ติด cooldown %s นาที'):format(xPlayer.name, ((time/1000)/60)),
                source = xPlayer.source,
            })
        end) -- End Log
        cb(false)
        return
    end
    cb(true)
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




