
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function checkItemOnServer(itemName)
    print("item check",itemName)
    for _,v in pairs(Config.drugSetting) do
        print(v.name)
        if itemName == v.name then
            return v.name
        end
    end
    return nil
end

ESX.RegisterServerCallback('cc_usedrug:checkPlayerItem', function(source, cb, itemName)
    if checkItemOnServer(itemName) == nil then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(itemName)
    print("xitem" , xItem.name)
    if xItem.count <= 0 then
        exports.nc_notify:PushNotification(source,{
            scale = 1.0,  -- ปรับขนาดของ Notify
            title = 'ระบบเสพยา',  -- หัวเรื่อง
            description = 'คุณไม่มีไอเท็มสำหรับเสพยา',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'default',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000  -- ระยะเวลาการแสดง Notify
        })
        cb(false,xItem.name)
        return
    end
    if xItem.count > 0 then
        xPlayer.removeInventoryItem(itemName, 1)
        cb(true,xItem.name)
        pcall(function() -- Start log 
            exports['azael_dc-serverlogs']:insertData({
                event = 'TakingDrugs',
                content = ('%s ได้ทำการใช้ %s เพื่อเสพลดความเครียด'):format(xPlayer.name, xItem.name),
                source = xPlayer.source,
            })
        end) -- End log
        return
    end
end)

ESX.RegisterServerCallback('cc_usedrug:useDrugSuccess', function(source, cb, itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    updatePlayerStatus(identifier,itemName,cb)
end)

ESX.RegisterServerCallback('cc_usedrug:checkDuration', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    decreaseDuration(identifier,cb)
end)

function decreaseDuration(identifier,cb)
    local PlayerID = identifier
    local rowPlayerDrug = MySQL.single.await('SELECT * FROM cc_usedrug WHERE identifier = ?', {PlayerID})
    if rowPlayerDrug then
        if rowPlayerDrug.level == 0 and rowPlayerDrug.level == 0  then
            cb(rowPlayerDrug.duration,rowPlayerDrug.item_name,rowPlayerDrug.level)
        end
        if rowPlayerDrug.duration <= 0 then
            local updateSuccess = MySQL.update.await('UPDATE cc_usedrug SET duration = 0,updated_at = CURRENT_TIMESTAMP,level = 0.0  WHERE identifier = ?', {PlayerID})
            if updateSuccess then
                rowPlayerDrug = MySQL.single.await('SELECT * FROM cc_usedrug WHERE identifier = ?', {PlayerID})
                if rowPlayerDrug then
                    cb(rowPlayerDrug.duration,rowPlayerDrug.item_name,rowPlayerDrug.level)
                end
            end
        end
        if rowPlayerDrug.duration > 0 then
            local updateSuccess = MySQL.update.await('UPDATE cc_usedrug SET duration = duration-3000,updated_at = CURRENT_TIMESTAMP  WHERE identifier = ?', {PlayerID})
            if updateSuccess then
                rowPlayerDrug = MySQL.single.await('SELECT * FROM cc_usedrug WHERE identifier = ?', {PlayerID})
                if rowPlayerDrug then
                    cb(rowPlayerDrug.duration,rowPlayerDrug.item_name,rowPlayerDrug.level)
                end
            end
        end
    end
end

function updatePlayerStatus(identifier,itemName,cb)
    print("itemName update",itemName)
    local drugConfig = Config.drugSetting[itemName]
    local PlayerID = identifier
    local rowPlayerDrug = nil
    print(identifier)
    print("drug config",drugConfig.name)
     MySQL.Async.prepare('SELECT * FROM cc_usedrug WHERE identifier = ?', {PlayerID}, function(result)
        if result then
            print("prepare update duration for player")
            local updateSuccess = MySQL.update.await('UPDATE cc_usedrug SET duration = duration+? ,updated_at = CURRENT_TIMESTAMP,item_name = ?,level = level+1  WHERE identifier = ?', {drugConfig.duration,drugConfig.name, PlayerID})
            if updateSuccess then
                print("update success and prepare to query new data")
                rowPlayerDrug = MySQL.single.await('SELECT * FROM cc_usedrug WHERE identifier = ?', {PlayerID})
                if rowPlayerDrug then
                    print("query new data success")
                    print(rowPlayerDrug.duration,rowPlayerDrug.item_name,rowPlayerDrug.level)
                    cb(rowPlayerDrug.duration,rowPlayerDrug.item_name,rowPlayerDrug.level)
                end
            end
            return true
        end

        if result == nil then
            print("create new row for player use drug")
            MySQL.Async.insert('INSERT INTO cc_usedrug (identifier,duration,item_name,level) VALUES (?,?,?,1)', {PlayerID,drugConfig.duration,drugConfig.name}, function(id)
                rowPlayerDrug = MySQL.single.await('SELECT * FROM cc_usedrug WHERE id = ?', {id})
                if rowPlayerDrug then
                    cb(rowPlayerDrug.duration,rowPlayerDrug.item_name,rowPlayerDrug.level)
                end
            end)
        end
    end)
end