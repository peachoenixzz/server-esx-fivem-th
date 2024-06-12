ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local alreadyDoneGachapon = {}
local validateGachaponName = {

}

function handleErrorAndNotify(xPlayer,err)
    if err == "not_done" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบห้องเปิดกาชา', -- หัวเรื่อง
            description = 'เครื่องจักรกำลังทำงาน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'danger', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "not_require_item" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบห้องเปิดกาชา', -- หัวเรื่อง
            description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
end

ESX.RegisterServerCallback('cc_gachapon:savePlayer', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneGachapon[source]) ~= "nil" then
        if alreadyDoneGachapon[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false)
            return
        end
    end
    alreadyDoneGachapon[source] = true
    TriggerEvent('playerOpenGachapon',xPlayer.source)
    Wait(300)
    cb(true)
    alreadyDoneGachapon[source] = nil
end)

ESX.RegisterServerCallback('cc_gachapon:validateGachapon', function(source, cb,payload)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneGachapon[source]) ~= "nil" then
        if alreadyDoneGachapon[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false)
            return
        end
    end
    alreadyDoneGachapon[source] = true
    local xItem = xPlayer.getInventoryItem(payload.name)
    print(payload.quantity)
    if xItem.count < payload.quantity then
        handleErrorAndNotify(xPlayer,"not_require_item")
        cb(false)
        alreadyDoneGachapon[source] = nil
        return
    end
    Wait(300)
    cb(true)
    alreadyDoneGachapon[source] = nil
end)

ESX.RegisterServerCallback('cc_gachapon:openGachapon', function(source, cb, token, payload)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneGachapon[source]) ~= "nil" then
        if alreadyDoneGachapon[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false,"fail")
            return
        end
    end
    alreadyDoneGachapon[source] = true
    -- Perform the HTTP request with basic authentication
    TriggerEvent('playerOpenGachapon',xPlayer.source)
    Wait(300)

    local xItem = xPlayer.getInventoryItem(payload.name)
    if xItem.count < payload.quantity then
        handleErrorAndNotify(xPlayer,"not_require_item")
        cb(false,"fail")
        alreadyDoneGachapon[source] = nil
        return
    end

    local auth_header = "Bearer "..token
    PerformHttpRequest('https://mongkol.dev/api/gachapon/users/open', function(statusCode, text, headers)
        if statusCode == 200 then
            xPlayer.removeInventoryItem(payload.name,payload.quantity)
            Wait(200)
            TriggerEvent('playerOpenGachapon',xPlayer.source)
            Wait(300)
            cb(true,text)
            alreadyDoneGachapon[source] = nil
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'RemoveGachaponFromOpening',
                    content = ('%s ได้สูญเสีย %s จำนวน %s ลูก เหลือ %s ในกระเป๋าจำนวน %s ลูก'):format(xPlayer.name, payload.name, payload.quantity, payload.name, xPlayer.getInventoryItem(payload.name).count),
                    source = xPlayer.source,
                 })
             end) -- End log
            return
        end
        if statusCode ~= 200 then
            TriggerEvent('playerOpenGachapon',xPlayer.source)
            Wait(300)
            cb(false,"fail")
            alreadyDoneGachapon[source] = nil
            return
        end
    end, 'POST', json.encode(payload), {
        ["Authorization"] = auth_header,
        ["Content-Type"] = "application/json"
    })
    alreadyDoneGachapon[source] = nil
end)



ESX.RegisterServerCallback('cc_gachapon:getItem', function(source, cb, payload)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(alreadyDoneGachapon[source]) ~= "nil" then
        if alreadyDoneGachapon[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false)
            return
        end
    end
    alreadyDoneGachapon[source] = true
    TriggerEvent('playerOpenGachapon',xPlayer.source)

    local stmt = [[
        SELECT category,item_name,quantity  FROM TB_GIVE_ITEMS_GACHAPON tgig
        WHERE 	discord_id = ?
        AND		gachapon_name = ?
        AND		status = ?
    ]]
    local response = MySQL.query.await(stmt, {
        xPlayer.identifier,
        payload.name,
        'pending',
    })

    if response then
        for i = 1, #response do
            local row = response[i]
            if row.category == "black_money" then
                xPlayer.addAccountMoney('black_money', tonumber(row.quantity))
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'ReceivedGachaponBlackMoney',
                        content = ('%s ได้รับ black_money จำนวน $%s มีเงินผิดกฏหมายในกระเป๋าจำนวน $%s'):format(xPlayer.name, tonumber(row.quantity), xPlayer.getAccount("black_money").money),
                        source = xPlayer.source,
                     })
                 end) -- End log
            end
            if row.category == "money" then
                xPlayer.addAccountMoney('money', tonumber(row.quantity))
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'ReceivedGachaponMoney',
                        content = ('%s ได้รับ money จำนวน $%s มีเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, tonumber(row.quantity), ESX.Math.GroupDigits(xPlayer.getMoney())),
                        source = xPlayer.source,
                     })
                 end) -- End log
            end
            if row.category == "economy" then
                xPlayer.addInventoryItem(row.item_name, row.quantity)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'ReceivedGachaponItem',
                        content = ('%s ได้รับ %s จำนวน %s ชิ้น จาก %s'):format(xPlayer.name, row.item_name, row.quantity, payload.name),
                        source = xPlayer.source,
                     })
                 end) -- End log
            end
        end
    end


    local stmtUpdate = [[
        UPDATE TB_GIVE_ITEMS_GACHAPON SET status = 'success',last_update = SYSDATE() WHERE
        gachapon_name = ?
        AND discord_id = ?
        AND status = 'pending'
    ]]
    local queries = {
        { stmtUpdate, { payload.name, xPlayer.identifier } },
    }
    local success = MySQL.transaction.await(queries, nil --[[leave nil for specific format]])
    if success then
        cb(true)
        alreadyDoneGachapon[source] = nil
        TriggerEvent('playerOpenGachapon',xPlayer.source)
        return
    end
    cb(false)
    alreadyDoneGachapon[source] = nil
end)

-- ESX.RegisterServerCallback('checkPlayerGachapon', function(source, cb, destination)
--     local NearbyPlayers = ESX.OneSync.GetPlayersInArea(destination, 50.0)
--     cb(#NearbyPlayers)
-- end)

ESX.RegisterServerCallback('checkPermissionAndPlayerGacha', function(source, cb, destinationcheck,token)
    local xPlayer = ESX.GetPlayerFromId(source)
    local NearbyPlayers = ESX.OneSync.GetPlayersInArea(destinationcheck, 50.0)
    if type(alreadyDoneGachapon[source]) ~= "nil" then
        if alreadyDoneGachapon[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false)
            return
        end
    end
    alreadyDoneGachapon[source] = true
    TriggerEvent('playerOpenGachapon',xPlayer.source)
    local auth_header = "Bearer "..token
    PerformHttpRequest('https://mongkol.dev/api/gachapon/users', function(statusCode, text, headers)
        if statusCode == 200 then
            if json.decode(text) == nil then
                handleErrorAndNotify(xPlayer,"not_require_item")
                cb(false)
                alreadyDoneGachapon[source] = nil
                return
            end
            if #NearbyPlayers >= 20 then
                maximumPlayerGacha(xPlayer.source)
                cb(false)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'GachaponRoomFull',
                        content = ('%s พยายามใช้วาปเพื่อเข้าไป Gachapon Room แต่มีผู้เล่นจำนวน %s คนอยู่ใน Gachapon Room แล้ว'):format(xPlayer.name, #NearbyPlayers),
                        source = xPlayer.source,
                    })
                end) -- End log
                return
            end
            cb(true)
            alreadyDoneGachapon[source] = nil
        end
        if statusCode ~= 200 then
            handleErrorAndNotify(xPlayer,"not_require_item")
            cb(false)
            alreadyDoneGachapon[source] = nil
            return
        end
    end, 'GET','',{
        ["Authorization"] = auth_header,
        ["Content-Type"] = "application/json"
    })
end)

function maximumPlayerGacha(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบห้องเปิดกาชา', -- หัวเรื่อง
        description = 'มีคนในห้องเกินที่กำหนดไว้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function maximumPlayerGacha(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบห้องเปิดกาชา', -- หัวเรื่อง
        description = 'มีคนในห้องเกินที่กำหนดไว้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end