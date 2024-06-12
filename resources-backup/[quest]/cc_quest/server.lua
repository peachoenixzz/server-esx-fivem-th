ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local alreadyDoneQuest = {}
ESX.RegisterServerCallback('cc_quest:savePlayer', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneQuest[source]) ~= "nil" then
        if alreadyDoneQuest[source] then
            exports.nc_notify:PushNotification(source,{
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบ Quest', -- หัวเรื่อง
                description = 'คิดว่าเป็น The Flash หรอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'default', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000 -- ระยะเวลาการแสดง Notify
            })
            cb(false)
            return
        end
    end
    alreadyDoneQuest[source] = true
    TriggerEvent('playerOpenQuest',xPlayer.source)
    Wait(100)
    cb(true)
    alreadyDoneQuest[source] = nil
end)



ESX.RegisterServerCallback('cc_quest:doneQuest', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneQuest[source]) ~= "nil" then
        if alreadyDoneQuest[source] then
            exports.nc_notify:PushNotification(source,{
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบ Quest', -- หัวเรื่อง
                description = 'คิดว่าเป็น The Flash หรอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'default', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000 -- ระยะเวลาการแสดง Notify
            })
            cb(false)
            return
        end
    end
    alreadyDoneQuest[source] = true
    local stmtStr = [[
            SELECT
            subquery.name,
            quantity
        FROM (
            SELECT
                discord_id,
                CASE
                    WHEN (HOUR(created_date) BETWEEN 0 AND 5) THEN '0.00 - 6.00'
                    WHEN (HOUR(created_date) BETWEEN 6 AND 11) THEN '6.00 - 12.00'
                    WHEN (HOUR(created_date) BETWEEN 12 AND 17) THEN '12.00 - 18.00'
                    WHEN (HOUR(created_date) BETWEEN 18 AND 23) THEN '18.00 - 0.00'
                END AS time_range,
                name,
                quantity,
                CASE
                    WHEN COUNT(*) OVER (PARTITION BY discord_id, time_range) > 1 THEN 'already'
                    ELSE 'none'
                END AS status
            FROM TB_PLAYER_QUEST
            WHERE discord_id = ?
            AND DATE(created_date) = CURDATE()
            AND status = 'in_progress'
        ) AS subquery
        WHERE subquery.time_range = CASE
                                      WHEN HOUR(NOW()) BETWEEN 0 AND 5 THEN '0.00 - 6.00'
                                      WHEN HOUR(NOW()) BETWEEN 6 AND 11 THEN '6.00 - 12.00'
                                      WHEN HOUR(NOW()) BETWEEN 12 AND 17 THEN '12.00 - 18.00'
                                      WHEN HOUR(NOW()) BETWEEN 18 AND 23 THEN '18.00 - 0.00'
                                   END
        ORDER BY discord_id, time_range, subquery.name
    ]]
    local response = MySQL.query.await(stmtStr, {
        xPlayer.identifier,
    })
    if #response == 0 or not response then
        onNoItem(xPlayer.source)
        cb(false)
        alreadyDoneQuest[source] = nil
        return
    end

    if response then
        for i=1, #response, 1 do
            local xItem = xPlayer.getInventoryItem(response[i].name)
            if xItem.count < response[i].quantity then
                onNoItem(xPlayer.source)
                cb(false)
                alreadyDoneQuest[source] = nil
                return
            end
        end

        for i=1, #response, 1 do
            local xItem = xPlayer.getInventoryItem(response[i].name)
            if xItem.count < response[i].quantity then
                onNoItem(xPlayer.source)
                cb(false)
                alreadyDoneQuest[source] = nil
                return
            end

            if xItem.count >= response[i].quantity then
                xPlayer.removeInventoryItem(xItem.name,response[i].quantity)
            end
        end

        for _,v in pairs(Config.questBonus) do
            if v.getItemName ~= nil then
                local matchingItems = {}

                for _,v in pairs(v.getItemName) do
                    table.insert(matchingItems, v)
                end

                if #matchingItems > 0 then
                    local randomIndex = math.random(1, #matchingItems)
                    local randomItemSet = matchingItems[randomIndex]
                    for i, itemName in ipairs(randomItemSet.itemName) do
                        local itemCount = math.random(randomItemSet.itemCount[1],randomItemSet.itemCount[2])
                        if itemName == "black_money" or itemName == "money" then
                            local amount = math.random(randomItemSet.itemCount[1], randomItemSet.itemCount[2])
                            xPlayer.addAccountMoney(itemName, tonumber(amount))
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'ReceivedStoreRobberyMoney',
                                    content = ('%s ได้รับ %s จำนวน $%s จากการงัดร้านค้า มีเงินผิดกฏหมายในกระเป๋าจำนวน $%s และเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, tonumber(amount), xPlayer.getAccount("black_money").money, ESX.Math.GroupDigits(xPlayer.getMoney())),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                        end
                        if itemName ~= "black_money" and itemName ~= "money" then
                            xPlayer.addInventoryItem(itemName, itemCount)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'ReceivedStoreRobberyItem',
                                    content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการงัดร้านค้า มีเงินผิดกฏหมายในกระเป๋าจำนวน $%s และเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, itemCount, xPlayer.getAccount("black_money").money, ESX.Math.GroupDigits(xPlayer.getMoney())),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                        end
                    end
                end
            end

            if v.getItemBonusSecond ~= nil then
                --print(v.getItemBonusSecond)
                xItemBonusSecondRate = math.random(1, 100000)/100000
                tblSecond = v.getItemBonusSecond
                itemBonusSecondRand = tblSecond[math.random(1, #tblSecond)]
                xItemBonusSecond = xPlayer.getInventoryItem(itemBonusSecondRand)
                --print('BonusSecondRate  '..xItemBonusSecondRate)
            end

            if v.getItemBonus ~= nil then
                local xItemBonusRate = math.random(1, 100000)/100000
                --print(xItemBonusRate)
                local matchingItems = {}
                local minMatchingPercent = 1.0

                for _, v in pairs(v.getItemBonus) do
                    if xItemBonusRate <= v.percent then
                        table.insert(matchingItems, v)
                        if v.percent < minMatchingPercent then
                            minMatchingPercent = v.percent
                        end
                    end
                end

                local finalMatchingItems = {}
                for _, v in pairs(matchingItems) do
                    if v.percent == minMatchingPercent then
                        table.insert(finalMatchingItems, v)
                    end
                end


                if #finalMatchingItems > 0 then
                    local randomIndex = math.random(1, #finalMatchingItems)
                    local randomItemSet = finalMatchingItems[randomIndex]
                    for i, itemName in ipairs(randomItemSet.itemName) do
                        local itemCount =  math.random(randomItemSet.itemCount[1],randomItemSet.itemCount[2])
                        if itemName == "black_money" then
                            local amount =  math.random(randomItemSet.itemCount[1],randomItemSet.itemCount[2])
                            xPlayer.addAccountMoney(itemName, tonumber(amount))
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'ReceivedStoreRobberyBlackMoney',
                                    content = ('%s ได้รับ %s จำนวน $%s จากการงัดร้านค้า มีเงินผิดกฏหมายในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, tonumber(amount), xPlayer.getAccount("black_money").money),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                            return
                        end

                        if itemName == "money" then
                            local amount =  math.random(randomItemSet.itemCount[1],randomItemSet.itemCount[2])
                            xPlayer.addAccountMoney(itemName, tonumber(amount))
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'ReceivedStoreRobberyMoney',
                                    content = ('%s ได้รับ %s จำนวน $%s จากการงัดร้านค้า มีเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, tonumber(amount), ESX.Math.GroupDigits(xPlayer.getMoney())),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                            return
                        end
                        xPlayer.addInventoryItem(itemName, itemCount)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ReceivedStoreRobberyItem',
                                content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการงัดร้านค้า'):format(xPlayer.name, itemName, itemCount),
                                source = xPlayer.source,
                            })
                        end) -- End log
                    end
                end
            end
        end

        local stmtUpdate = [[
            UPDATE TB_PLAYER_QUEST AS tpq
            SET tpq.status = 'success'
            WHERE EXISTS (
                SELECT 1
                FROM TB_PLAYER_QUEST AS subquery
                WHERE subquery.discord_id = ?
                AND DATE(subquery.created_date) = CURDATE()
                AND subquery.status = 'in_progress'
                AND (
                    (HOUR(subquery.created_date) BETWEEN 0 AND 5 AND HOUR(NOW()) BETWEEN 0 AND 5)
                    OR (HOUR(subquery.created_date) BETWEEN 6 AND 11 AND HOUR(NOW()) BETWEEN 6 AND 11)
                    OR (HOUR(subquery.created_date) BETWEEN 12 AND 17 AND HOUR(NOW()) BETWEEN 12 AND 17)
                    OR (HOUR(subquery.created_date) BETWEEN 18 AND 23 AND HOUR(NOW()) BETWEEN 18 AND 23)
                )
            )
            AND tpq.discord_id = ?
            AND DATE(tpq.created_date) = CURDATE()
            AND tpq.status = 'in_progress'
            ]]
        local update = MySQL.query.await(stmtUpdate, {
            xPlayer.identifier,
            xPlayer.identifier,
        })

        cb(true)
        alreadyDoneQuest[source] = nil
        return
    end
end)

ESX.RegisterServerCallback('cc_quest:doneWeight', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneQuest[source]) ~= "nil" then
        if alreadyDoneQuest[source] then
            exports.nc_notify:PushNotification(source,{
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบ Quest', -- หัวเรื่อง
                description = 'คิดว่าเป็น The Flash หรอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'default', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000 -- ระยะเวลาการแสดง Notify
            })
            cb(false)
            return
        end
    end
    alreadyDoneQuest[source] = true
    local stmtStr = [[
		SELECT tlw.quantity , tpw.weight_level
              FROM TB_PLAYER_WEIGHT tpw
              INNER JOIN TB_LEVEL_WEIGHT tlw
 			  WHERE tlw.weight_level = tpw.weight_level +1
              AND discord_id = ?;
]]
    local response = MySQL.query.await(stmtStr, {
        xPlayer.identifier,
    })
    if response then
        for i=1, #response, 1 do
            local xItem = xPlayer.getInventoryItem("exp")
            if xItem.count < response[i].quantity then
                onNoItem(xPlayer.source)
                cb(false)
                alreadyDoneQuest[source] = nil
                return
            end
            xPlayer.removeInventoryItem('exp', response[i].quantity)
        end
        local stmtUpdate = [[
                UPDATE TB_PLAYER_WEIGHT SET weight_level = weight_level+1, last_updated = SYSDATE()  WHERE discord_id = ?
           ]]
        local update = MySQL.query.await(stmtUpdate, {
            xPlayer.identifier,
        })
        if update then
            exports.cc_weight:activateWeight(xPlayer)
        end
        cb(true)
        alreadyDoneQuest[source] = nil
        return
    end
    onNoItem(xPlayer.source)
    cb(false)
    alreadyDoneQuest[source] = nil
    return
end)

ESX.RegisterServerCallback('cc_quest:resetQuest', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneQuest[source]) ~= "nil" then
        if alreadyDoneQuest[source] then
            exports.nc_notify:PushNotification(source,{
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบ Quest', -- หัวเรื่อง
                description = 'คิดว่าเป็น The Flash หรอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'default', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000 -- ระยะเวลาการแสดง Notify
            })
            cb(false)
            return
        end
    end
    alreadyDoneQuest[source] = true
    if xPlayer.getMoney() >= 3000 then
        local stmtCheckQuest = [[
            SELECT
				count(discord_id) as rowCount
			FROM (
				SELECT
			discord_id,
			CASE
				WHEN HOUR(created_date) >= 0 AND HOUR(created_date) < 6 THEN "0.00 - 6.00"
				WHEN HOUR(created_date) >= 6 AND HOUR(created_date) < 12 THEN "6.00 - 12.00"
				WHEN HOUR(created_date) >= 12 AND HOUR(created_date) < 18 THEN "12.00 - 18.00"
				ELSE '18.00 - 0.00'
			END AS time_range,
			CASE
				WHEN COUNT(id) > 1 THEN 'already'
				ELSE 'none'
			END AS status
			FROM TB_PLAYER_QUEST
			WHERE discord_id = ?
			AND DATE(created_date) = CURDATE()
			AND status = 'in_progress'
			GROUP BY discord_id, time_range
			) AS subquery
			WHERE subquery.time_range =
			CASE
				WHEN HOUR(NOW()) BETWEEN 0 AND 5 THEN "0.00 - 6.00"
				WHEN HOUR(NOW()) BETWEEN 6 AND 11 THEN "6.00 - 12.00"
				WHEN HOUR(NOW()) BETWEEN 12 AND 17 THEN "12.00 - 18.00"
				WHEN HOUR(NOW()) BETWEEN 18 AND 23 THEN "18.00 - 0.00"
			END
			GROUP BY discord_id, time_range
			ORDER BY discord_id, time_range;
        ]]
        local response = MySQL.query.await(stmtCheckQuest, {
            xPlayer.identifier,
        })
        if #response ~= 0 then
            xPlayer.removeMoney(3000)
            local stmtStr = [[
                UPDATE TB_PLAYER_QUEST AS tpq
                SET tpq.status = 'cancel'
                WHERE EXISTS (
                    SELECT 1
                    FROM TB_PLAYER_QUEST AS subquery
                    WHERE subquery.discord_id = ?
                    AND DATE(subquery.created_date) = CURDATE()
                    AND subquery.status = 'in_progress'
                    AND (
                        (HOUR(subquery.created_date) BETWEEN 0 AND 5 AND HOUR(NOW()) BETWEEN 0 AND 5)
                        OR (HOUR(subquery.created_date) BETWEEN 6 AND 11 AND HOUR(NOW()) BETWEEN 6 AND 11)
                        OR (HOUR(subquery.created_date) BETWEEN 12 AND 17 AND HOUR(NOW()) BETWEEN 12 AND 17)
                        OR (HOUR(subquery.created_date) BETWEEN 18 AND 23 AND HOUR(NOW()) BETWEEN 18 AND 23)
                    )
                )
                AND tpq.discord_id = ?
                AND DATE(tpq.created_date) = CURDATE()
                AND tpq.status = 'in_progress';
            ]]
            local update = MySQL.query.await(stmtStr, {
                xPlayer.identifier,
                xPlayer.identifier,
            })
            cb(true)
            alreadyDoneQuest[source] = nil
            return
        end
        questNotInProgress(xPlayer.source)
        alreadyDoneQuest[source] = nil
        cb(false)
        return
    end
    onNoMoney(xPlayer.source)
    alreadyDoneQuest[source] = nil
    cb(false)
end)



AddEventHandler('playerDropped', function(reason)
    local source = source
    alreadyDoneQuest[source] = nil-- Remove the player from the targets array
end)

RegisterCommand('openq', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('playerOpenQuest',xPlayer.source)
    Wait(150)
    TriggerClientEvent("cc_quest:handleMenuByCommand", source,"openquest")
end)

RegisterCommand('req', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('playerOpenQuest',xPlayer.source)
    Wait(150)
    TriggerClientEvent("cc_quest:handleMenuByCommand", source,"refreshquest")
end)

RegisterCommand('closeq', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('playerOpenQuest',xPlayer.source)
    Wait(150)
    TriggerClientEvent("cc_quest:handleMenuByCommand", source,"closequest")
end)

function onNoItem(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Quest', -- หัวเรื่อง
        description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_blueprint', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function questNotInProgress(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Quest', -- หัวเรื่อง
        description = 'คุณไม่เคยรับเควสมาก่อน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
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
        title = 'ระบบ Quest', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
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