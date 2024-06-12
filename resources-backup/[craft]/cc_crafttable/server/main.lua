
local alreadyCraft = {}

ESX.RegisterServerCallback('cc_crafttable:clearMemory', function(source, cb)
    alreadyCraft[source] = nil
    collectgarbage("collect")
    cb()
end)

ESX.RegisterServerCallback('cc_crafttable:checkMaterial', function(source, cb, items,type)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local count = 0
    if type == "weapon" then
        local weapon = xPlayer.getWeapon(items)
        if weapon then
            count = 1
        end
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'CheckWeaponMaterial',
                    content = ('%s มีอาวุธ %s จำนวน %s ชิ้น'):format(xPlayer.name, items, count),
                    source = xPlayer.source,
                })
            end) -- End log
        cb(count)
        return
    end
    local xItem =   xPlayer.getInventoryItem(items)
    count = xItem.count
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'CheckMaterial',
                content = ('%s มี %s จำนวน %s ชิ้น'):format(xPlayer.name, items, count),
                source = xPlayer.source,
            })
    end)
    cb(count)
end)

ESX.RegisterServerCallback('cc_crafttable:checkCanCraft', function(source, cb, validateSet)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if alreadyCraft[source] == true then
        --doing log check macro phase
        exports.nc_notify:PushNotification(source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบโต๊ะคราฟ', -- หัวเรื่อง
            description = 'ระบบกำลังปกป้องตนเอง', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'danger', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'default', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'MacroSpam',
                content = ('%s ได้ทำการกดคราฟ %s จำนวนหลายครั้งภายในเวลาอันสั้น'):format(xPlayer.name, items.name),
                source = xPlayer.source,
            })
        end) -- End log
        cb(false)
        return
    end

    alreadyCraft[source] = true

    if not validateConfig(xPlayer, validateSet) then
        alreadyCraft[source] = false
        cb(false)
        return
    end

    alreadyCraft[source] = false
    cb(true)
end)

ESX.RegisterServerCallback('cc_crafttable:successCraft', function(source, cb, validateSet)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if alreadyCraft[source] == true then
        --doing log check macro phase
        exports.nc_notify:PushNotification(source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบโต๊ะคราฟ', -- หัวเรื่อง
            description = 'คิดว่าเป็น The Flash หรอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'danger', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'default', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
        alreadyCraft[source] = false

        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'MacroSpam',
                content = ('%s ได้ทำการกดคราฟ %s จำนวนหลายครั้งภายในเวลาอันสั้น : พิกัด %s'):format(xPlayer.name, items.name),
                source = xPlayer.source,
            })
        end) -- End log
        cb(false)
        return
    end
    alreadyCraft[source] = true

    if not validateConfig(xPlayer, validateSet) then
        alreadyCraft[source] = false
        cb(false)
        return
    end

    local status = giveItems(validateSet,xPlayer)
    if status == "success" and validateSet.item.play_sound then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        local xPlayers = ESX.OneSync.GetPlayersInArea(playerCoords, 13.0)
        for _, player in pairs(xPlayers) do
            if player.id == xPlayer.source then goto endState end
            TriggerClientEvent('cc_crafttable:playSound', player.id)
            ::endState::
        end
    end
    alreadyCraft[source] = false
    cb(status)
end)

--function giveItems(items,amount,xPlayer)
--    -- not 100% success
--    if type(items.count_per_quantity) == "nil" then
--        items.count_per_quantity = 1
--    end
--
--    if items.success_rate ~= 1 then
--        local successRate = math.random(1, 100000)/100000
--        --print("success Rate",successRate)
--        --print("success Rate Items Craft",items.success_rate)
--        if successRate <= items.success_rate then
--            if items.currency == "money" then
--                if items.price ~= 0 then
--                    xPlayer.removeMoney((items.price * amount))
--                    pcall(function() -- Start log
--                        exports['azael_dc-serverlogs']:insertData({
--                            event = 'RemoveMoneyFromCrafting',
--                            content = ('%s ได้สูญเสียเงินจำนวน $%s จากการคราฟ %s เหลือเงินในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getMoney())),
--                            source = xPlayer.source,
--                        })
--                    end) -- End log
--                end
--            end
--            if items.currency == "black_money" then
--                if items.price ~= 0 then
--                    xPlayer.removeAccountMoney("black_money", items.price * amount)
--                    pcall(function() -- Start log
--                        exports['azael_dc-serverlogs']:insertData({
--                            event = 'RemoveBlackMoneyFromCrafting',
--                            content = ('%s ได้สูญเสียเงินผิดกฏหมายจำนวน $%s จากการคราฟ %s เหลือเงินผิดกฏหมายในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getAccount("black_money").money)),
--                            source = xPlayer.source,
--                        })
--                    end) -- End log
--                end
--            end
--
--            removeMaterial(items,amount,xPlayer)
--
--            if items.type == 'weapon' then
--                xPlayer.addWeapon(items.name, 1)
--                pcall(function() -- Start log
--                    exports['azael_dc-serverlogs']:insertData({
--                        event = 'ReceivedCraftWeapon',
--                        content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s'):format(xPlayer.name, items.name, amount, items.label),
--                        source = xPlayer.source,
--                    })
--                 end) -- End log
--                return "success"
--            end
--            xPlayer.addInventoryItem(items.name, amount*items.count_per_quantity)
--
--            if type(items.expire_date) ~= "nil" then
--                if items.expire_date ~= nil then
--                    local stmt = [[
--            		INSERT IGNORE
--		            INTO items_expire (item_name,player_id,category,expire_timestamp)
--		            VALUES (@item_name,@player_id,@category,SYSDATE() + INTERVAL @expire_date DAY)
--            ]]
--                    MySQL.Async.execute(stmt, {
--                        ['@item_name'] = items.name,
--                        ['@player_id'] = xPlayer.identifier,
--                        ['@category'] = "economy",
--                        ['@expire_date'] = items.expire_date
--                    }, function(rows)
--                        if rows then
--                            pcall(function() -- Start log
--                                exports['azael_dc-serverlogs']:insertData({
--                                    event = 'ReceivedCraftItemExpireDate',
--                                    content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s และ ถูกบันทึกลงใน Database ว่าหมดอายุในเวลา %s'):format(xPlayer.name, items.name, amount, items.label, items.expire_date),
--                                    source = xPlayer.source,
--                                })
--                            end) -- End log
--                        end
--                    end)
--                end
--            end
--
--            pcall(function() -- Start log
--                exports['azael_dc-serverlogs']:insertData({
--                    event = 'ReceivedCraftItem',
--                    content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s'):format(xPlayer.name, items.name, amount, items.label),
--                    source = xPlayer.source,
--                })
--            end) -- End log
--            return "success"
--        end
--
--        -- hotfix remove money when not have failed items
--        if items.failed_items == nil and successRate > items.success_rate then
--            if items.currency == "money" then
--                if items.price ~= 0 then
--                    xPlayer.removeMoney((items.price * amount))
--                    pcall(function() -- Start log
--                        exports['azael_dc-serverlogs']:insertData({
--                            event = 'RemoveMoneyFromCrafting',
--                            content = ('%s ได้สูญเสียเงินจำนวน $%s จากการคราฟ %s เหลือเงินในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getMoney())),
--                            source = xPlayer.source,
--                        })
--                    end) -- End log
--                end
--            end
--            if items.currency == "black_money" then
--                if items.price ~= 0 then
--                    xPlayer.removeAccountMoney("black_money", items.price * amount)
--                    pcall(function() -- Start log
--                        exports['azael_dc-serverlogs']:insertData({
--                            event = 'RemoveBlackMoneyFromCrafting',
--                            content = ('%s ได้สูญเสียเงินผิดกฏหมายจำนวน $%s จากการคราฟ %s เหลือเงินผิดกฏหมายในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getAccount("black_money").money)),
--                            source = xPlayer.source,
--                        })
--                    end) -- End log
--                end
--            end
--        end
--
--        --when have failed items give away
--        if items.failed_items ~= nil then
--            if items.currency == "money" then
--                if items.price ~= 0 then
--                    xPlayer.removeMoney((items.price * amount))
--                    pcall(function() -- Start log
--                        exports['azael_dc-serverlogs']:insertData({
--                            event = 'RemoveMoneyFromCrafting',
--                            content = ('%s ได้สูญเสียเงินจำนวน $%s จากการคราฟ %s เหลือเงินในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getMoney())),
--                            source = xPlayer.source,
--                        })
--                    end) -- End log
--                end
--            end
--
--            if items.currency == "black_money" then
--                if items.price ~= 0 then
--                    xPlayer.removeAccountMoney("black_money", items.price * amount)
--                    pcall(function() -- Start log
--                        exports['azael_dc-serverlogs']:insertData({
--                            event = 'RemoveBlackMoneyFromCrafting',
--                            content = ('%s ได้สูญเสียเงินผิดกฏหมายจำนวน $%s จากการคราฟ %s เหลือเงินผิดกฏหมายในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getAccount("black_money").money)),
--                            source = xPlayer.source,
--                        })
--                    end) -- End log
--                end
--            end
--
--            xPlayer.addInventoryItem(items.failed_items, amount)
--            pcall(function() -- Start log
--                exports['azael_dc-serverlogs']:insertData({
--                    event = 'ReceivedFailCraftItem',
--                    content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s'):format(xPlayer.name, items.failed_items, amount, items.label),
--                    source = xPlayer.source,
--                })
--             end) -- End log
--
--            removeMaterial(items,amount,xPlayer)
--
--            pcall(function() -- Start log
--                exports['azael_dc-serverlogs']:insertData({
--                    event = 'CraftingFail',
--                    content = ('%s ได้ทำการคราฟ %s ไม่สำเร็จ'):format(xPlayer.name, items.label),
--                    source = xPlayer.source,
--                })
--             end) -- End log
--            return "failed"
--        end
--        removeMaterial(items,amount,xPlayer)
--        pcall(function() -- Start log
--            exports['azael_dc-serverlogs']:insertData({
--                event = 'CraftingFail',
--                content = ('%s ได้ทำการคราฟ %s ไม่สำเร็จ'):format(xPlayer.name, items.label),
--                source = xPlayer.source,
--            })
--         end) -- End log
--        return "failed"
--    end
--
--    -- 100% success
--    if items.success_rate == 1 then
--        if items.currency == "money" then
--            if items.price ~= 0 then
--                xPlayer.removeMoney((items.price * amount))
--                pcall(function() -- Start log
--                    exports['azael_dc-serverlogs']:insertData({
--                        event = 'RemoveMoneyFromCrafting',
--                        content = ('%s ได้สูญเสียเงินจำนวน $%s จากการคราฟ %s เหลือเงินในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getMoney())),
--                        source = xPlayer.source,
--                    })
--                end) -- End log
--            end
--        end
--        if items.currency == "black_money" then
--            if items.price ~= 0 then
--                xPlayer.removeAccountMoney("black_money", items.price * amount)
--                pcall(function() -- Start log
--                    exports['azael_dc-serverlogs']:insertData({
--                        event = 'RemoveBlackMoneyFromCrafting',
--                        content = ('%s ได้สูญเสียเงินผิดกฏหมายจำนวน $%s จากการคราฟ %s เหลือเงินผิดกฏหมายในกระเป๋า จำนวน $%s'):format(xPlayer.name, (items.price*amount), items.label, ESX.Math.GroupDigits(xPlayer.getAccount("black_money").money)),
--                        source = xPlayer.source,
--                    })
--                end) -- End log
--            end
--        end
--        removeMaterial(items,amount,xPlayer)
--        if items.type == 'weapon' then
--            xPlayer.addWeapon(items.name, 1)
--            pcall(function() -- Start log
--                exports['azael_dc-serverlogs']:insertData({
--                    event = 'ReceivedCraftWeapon',
--                    content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s'):format(xPlayer.name, items.name, amount, items.label),
--                    source = xPlayer.source,
--                })
--             end) -- End log
--            return "success"
--        end
--        xPlayer.addInventoryItem(items.name, amount*items.count_per_quantity)
--
--        if type(items.expire_date) ~= "nil" then
--            if items.expire_date ~= nil then
--                local stmt = [[
--            		INSERT IGNORE
--		            INTO items_expire (item_name,player_id,category,expire_timestamp)
--		            VALUES (@item_name,@player_id,@category,SYSDATE() + INTERVAL @expire_date DAY)
--            ]]
--                MySQL.Async.execute(stmt, {
--                    ['@item_name'] = items.name,
--                    ['@player_id'] = xPlayer.identifier,
--                    ['@category'] = "economy",
--                    ['@expire_date'] = items.expire_date
--                }, function(rows)
--                    if rows then
--                        pcall(function() -- Start log
--                            exports['azael_dc-serverlogs']:insertData({
--                                event = 'ReceivedCraftItemExpireDate',
--                                content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s และ ถูกบันทึกลงใน Database ว่าหมดอายุในเวลา %s'):format(xPlayer.name, items.name, amount, items.label, items.expire_date),
--                                source = xPlayer.source,
--                            })
--                        end) -- End log
--                    end
--                end)
--            end
--        end
--
--        pcall(function() -- Start log
--            exports['azael_dc-serverlogs']:insertData({
--                event = 'ReceivedCraftItem',
--                content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s'):format(xPlayer.name, items.name, amount, items.label),
--                source = xPlayer.source,
--            })
--         end) -- End log
--        return "success"
--    end
--end
--
--function removeMaterial(items,amount,xPlayer)
--    for _, v in ipairs(items.material) do
--        if v.type == "weapon" then
--            xPlayer.removeWeapon(v.name)
--            pcall(function() -- Start log
--                exports['azael_dc-serverlogs']:insertData({
--                    event = 'RemoveWeaponFromCrafting',
--                    content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น จากการคราฟ %s'):format(xPlayer.name, v.name, (v.quantity * amount), items.label),
--                    source = xPlayer.source,
--                })
--             end) -- End log
--            goto endState
--        end
--        xPlayer.removeInventoryItem(v.name, (v.quantity * amount))
--        pcall(function() -- Start log
--            exports['azael_dc-serverlogs']:insertData({
--                event = 'RemoveCraftMaterial',
--                content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น จากการคราฟ %s'):format(xPlayer.name, v.name, (v.quantity * amount), items.label),
--                source = xPlayer.source,
--            })
--         end) -- End log
--        ::endState::
--    end
--end

AddEventHandler('playerDropped', function(reason)
    local source = source
    alreadyCraft[source] = nil-- Remove the player from the targets array
    collectgarbage("collect")
end)


function onNoBlueprint(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบโต๊ะคราฟ', -- หัวเรื่อง
        description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onNoItem(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบโต๊ะคราฟ', -- หัวเรื่อง
        description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_blueprint', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onNoMoney(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบโต๊ะคราฟ', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end