ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--local userConfirm = {}
local userSelectedItems = {}


RegisterNetEvent('cc_coreeffect:accpetedUserItem')
AddEventHandler('cc_coreeffect:accpetedUserItem', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if userSelectedItems[source] == nil then
        return
    end
    local xItem = xPlayer.getInventoryItem(userSelectedItems[source].name)
    if xItem.count > 0 then
        createEffectByEffectName(xPlayer,xItem)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'UseCoreEffectItem',
                content = ('%s ได้ทำการใช้ %s มีในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.count),
                source = xPlayer.source,
            })
        end) -- End Log
    end
end)

ESX.RegisterUsableItem('ticket_eco_x2', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("ticket_eco_x2")
    --if userConfirm[source] == nil then
    --    userConfirm[source] = false
    --    return
    --end
    --
    --if not userConfirm[source] then
    --    notifyAlertUseCashShopItem(xPlayer)
    --    userConfirm[source] = true
    --    return
    --end

    if xItem.count > 0 then --and userConfirm[source]
        userSelectedItems[source] = xItem
        TriggerClientEvent('okokRequests:RequestMenu', source, source, 60000, "ใช้งานไอเทม "..xItem.label.." หรือไม่ ?", "ต้องการใช้หรือไม่ ?", "cc_coreeffect:accpetedUserItem", "server")
        --userConfirm[source] = true
        return
    end
end)

ESX.RegisterUsableItem('gum_mining', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("gum_mining")

    --if userConfirm[source] == nil then
    --    userConfirm[source] = false
    --    return
    --end
    --
    --if not userConfirm[source] then
    --    notifyAlertUseCashShopItem(xPlayer)
    --    userConfirm[source] = true
    --    return
    --end

    if xItem.count > 0  then --and userConfirm[source]
        userSelectedItems[source] = xItem
                TriggerClientEvent('okokRequests:RequestMenu', source, source, 60000, "ใช้งานไอเทม "..xItem.label.." หรือไม่ ?", "ต้องการใช้หรือไม่ ?", "cc_coreeffect:accpetedUserItem", "server")
        --userConfirm[source] = true
        return
    end
end)

ESX.RegisterUsableItem('auto_farm', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("auto_farm")

    --if userConfirm[source] == nil then
    --    userConfirm[source] = false
    --    return
    --end
    --
    --if not userConfirm[source] then
    --    notifyAlertUseCashShopItem(xPlayer)
    --    userConfirm[source] = true
    --    return
    --end

    if xItem.count > 0 then -- and userConfirm[source]
        userSelectedItems[source] = xItem
        TriggerClientEvent('okokRequests:RequestMenu', source, source, 60000, "ใช้งานไอเทม "..xItem.label.." หรือไม่ ?", "ต้องการใช้หรือไม่ ?", "cc_coreeffect:accpetedUserItem", "server")
        --userConfirm[source] = true
        return
    end
end)

ESX.RegisterUsableItem('auto_1h', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("auto_1h")

    --if userConfirm[source] == nil then
    --    userConfirm[source] = false
    --    return
    --end
    --
    --if not userConfirm[source] then
    --    notifyAlertUseCashShopItem(xPlayer)
    --    userConfirm[source] = true
    --    return
    --end

    if xItem.count > 0  then --and userConfirm[source]
        userSelectedItems[source] = xItem
                TriggerClientEvent('okokRequests:RequestMenu', source, source, 60000, "ใช้งานไอเทม "..xItem.label.." หรือไม่ ?", "ต้องการใช้หรือไม่ ?", "cc_coreeffect:accpetedUserItem", "server")
        --userConfirm[source] = true
        return
    end
end)

ESX.RegisterUsableItem('gum_eco', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("gum_eco")

    --if userConfirm[source] == nil then
    --    userConfirm[source] = false
    --    return
    --end
    --
    --if not userConfirm[source] then
    --    notifyAlertUseCashShopItem(xPlayer)
    --    userConfirm[source] = true
    --    return
    --end

    if xItem.count > 0  then --and userConfirm[source]
        userSelectedItems[source] = xItem
                TriggerClientEvent('okokRequests:RequestMenu', source, source, 60000, "ใช้งานไอเทม "..xItem.label.." หรือไม่ ?", "ต้องการใช้หรือไม่ ?", "cc_coreeffect:accpetedUserItem", "server")
        --userConfirm[source] = true
        return
    end
end)

ESX.RegisterUsableItem('unlimit_bag', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("unlimit_bag")

    --if userConfirm[source] == nil then
    --    userConfirm[source] = false
    --    return
    --end
    --
    --if not userConfirm[source] then
    --    notifyAlertUseCashShopItem(xPlayer)
    --    userConfirm[source] = true
    --    return
    --end

    if xItem.count > 0 then --and userConfirm[source]
        userSelectedItems[source] = xItem
                TriggerClientEvent('okokRequests:RequestMenu', source, source, 60000, "ใช้งานไอเทม "..xItem.label.." หรือไม่ ?", "ต้องการใช้หรือไม่ ?", "cc_coreeffect:accpetedUserItem", "server")
        --userConfirm[source] = true
        return
    end
end)

ESX.RegisterUsableItem('scuba', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("scuba")
    if xItem.count > 0 then
        TriggerClientEvent('cc_coreeffect:useitem', source, xItem.name)
        --createEffectByEffectName(xPlayer,xItem)
        return
    end
end)

ESX.RegisterUsableItem('gov_scuba', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("gov_scuba")
    if xItem.count > 0 then
        TriggerClientEvent('cc_coreeffect:useitem', source, xItem.name)
        --createEffectByEffectName(xPlayer,xItem)
        return
    end
end)

ESX.RegisterUsableItem('adrenaline', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("adrenaline")
    local xItemGangCard = xPlayer.getInventoryItem("card_gang")
	local xItemFamilyCard = xPlayer.getInventoryItem("card_family")
    if xItem.count > 0 then
        if xItemGangCard.count >= 1 or xItemFamilyCard.count >= 1 then
            TriggerClientEvent('cc_coreeffect:useitem', source, xItem.name)
            --createEffectByEffectName(xPlayer,xItem)
        else
            onNoCardGangCoreEffect(source)
        end
        return
    end
end)


ESX.RegisterUsableItem('r_adrenaline', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("r_adrenaline")
    if xItem.count > 0 then
        TriggerClientEvent('cc_coreeffect:useitem', source, xItem.name)
        --createEffectByEffectName(xPlayer,xItem)
        return
    end
end)

ESX.RegisterUsableItem('gov_adrenaline', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("gov_adrenaline")
    if xItem.count > 0 and xPlayer.job.name == "police" then
        TriggerClientEvent('cc_coreeffect:useitem', source, xItem.name)
        --createEffectByEffectName(xPlayer,xItem)
        return
    else
        onNotBeAPolice(source)
    end
end)

function onNoCardGangCoreEffect(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'คุณไม่มีสิ่งของที่กำหนด', -- หัวเรื่อง
		description = 'คุณไม่มีบัตรแก็งหรือบัตรครอบครัว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		--color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

function notifyAlertUseCashShopItem(xPlayer)
    exports.nc_notify:PushNotification(xPlayer.source,{
        scale = 1.2,  -- ปรับขนาดของ Notify
        title = 'Core Effect',  -- หัวเรื่อง
        description = 'กดอีกครั้งเพื่อยืนยันการใช้ไอเทม',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 5000  -- ระยะเวลาการแสดง Notify
    })
end

function onNotBeAPolice(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0,  -- ปรับขนาดของ Notify
        title = 'ระบบ ตำรวจ',  -- หัวเรื่อง
        description = 'คุณไม่สามารถใช้งานไอเทมชิ้นนี้ได้',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_cop',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 5000  -- ระยะเวลาการแสดง Notify
    })
end