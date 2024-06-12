TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('RRP_BODYBAG:Trigger')
AddEventHandler('RRP_BODYBAG:Trigger', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem= xPlayer.getInventoryItem('body_bag')
    local xTarget = ESX.GetPlayerFromId(target)
    TriggerClientEvent('RRP_BODYBAG:processBodyBag', source,target)
    -- Trigger a notification if you wish to have one
    pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'StartUseBodyBag',
            content = ('%s ได้เริ่มใช้ %s กับ %s '):format(xPlayer.name, xItem.name, xTarget.name),
            source = xPlayer.source,
        })
    end) -- End Log
    pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'StartGettingBagged',
            content = ('%s ได้ถูก %s ใช้ %s ใส่'):format(xTarget.name, xPlayer.name, xItem.name),
            source = xTarget.source,
        })
    end) -- End Log
end)

RegisterServerEvent('RRP_BODYBAG:success')
AddEventHandler('RRP_BODYBAG:success', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem= xPlayer.getInventoryItem('body_bag')
    local xTarget = ESX.GetPlayerFromId(target)
    if xItem.count > 0 then
        xPlayer.removeInventoryItem('body_bag', 1)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'RemoveBodyBagFromInventory',
                content = ('%s ได้สูญเสีย %s จำนวน 1 ชิ้น จากการห่อศพ %s เหลือ %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xTarget.name, xItem.name, xPlayer.getInventoryItem("body_bag").count),
                source = xPlayer.source,
            })
        end) -- End Log
        TriggerClientEvent('RRP_BODYBAG:success',target)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'BodyBagUseSuccess',
                content = ('%s ได้ทำการห่อศพ %s สำเร็จ'):format(xPlayer.name, xTarget.name),
                source = xPlayer.source,
            })
        end) -- End Log
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'GotFullyBagged',
                content = ('%s โดน %s ห่อศพสำเร็จแล้ว'):format(xTarget.name, xPlayer.name),
                source = xTarget.source,
            })
        end) -- End Log
    end
    -- Trigger a notification if you wish to have one
end)

RegisterCommand('bodybag', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    --args[1] == playerId
    --args[2] == time (mins)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        if args[1] then
            local playerId = tonumber(args[1])
            local time = tonumber(args[2])
            if playerId and ESX.GetPlayerFromId(playerId) then
                TriggerClientEvent('RRP_BODYBAG:successCustom', playerId,time)
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
            end
        end
    end
end)


ESX.RegisterUsableItem('body_bag', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem= xPlayer.getInventoryItem('body_bag')
    local xItemGangCard = xPlayer.getInventoryItem("card_gang")
	local xItemFamilyCard = xPlayer.getInventoryItem("card_family")
    if xItem.count > 0 then
        if xItemGangCard.count >= 1 or xItemFamilyCard.count >= 1 then
            TriggerClientEvent('cc_bodybag:useItem', source)
        else
            onNoCardGangToBodyBag(source)
        end
    end
end)

--==========================================================================================================================================================================================
--===================================================================================sell bodybag npc=======================================================================================
--==========================================================================================================================================================================================

-- RegisterServerEvent('sellBodyBug:calculate')
-- AddEventHandler('sellBodyBug:calculate', function(quantity)
--     if quantity > 0 and quantity <=10 then
--         local source = source
--         local xPlayer =  ESX.GetPlayerFromId(source)
--         local price = quantity*2000 -- 2000 คือราคาถุงห่อศพ
--         local currentAccount = xPlayer.getAccount("black_money")
--         if currentAccount.money >= price then
--             if xPlayer.canCarryItem("body_bag", quantity) then
--                 xPlayer.removeAccountMoney("black_money", price)  
--                 pcall(function() -- Start log
--                     exports['azael_dc-serverlogs']:insertData({
--                         event = 'BuyBodyBag',
--                         content = ('%s ทำการซื้อ ถุงห่อศพ จำนวน %s ชิ้น ราคา $%s เหลือเงินผิดกฏหมายในกระเป๋า $%s'):format(xPlayer.name, quantity, price, ESX.Math.GroupDigits(xPlayer.getAccount('black_money').money)),
--                         source = xPlayer.source,
--                     })
--                 end) -- End log               
--                 xPlayer.addInventoryItem("body_bag", quantity)
--                 pcall(function() -- Start log
--                     exports['azael_dc-serverlogs']:insertData({
--                         event = 'ReceivedBodyBag',
--                         content = ('%s ได้รับ ถุงห่อศพ จำนวน %s ชิ้น'):format(xPlayer.name, quantity),
--                         source = xPlayer.source,
--                     })
--                 end)  -- End log
--             end
--         end
--         if currentAccount.money < price then
--             onNoBlackMoney(xPlayer.source)
--             pcall(function() -- Start log
--                 exports['azael_dc-serverlogs']:insertData({
--                     event = 'NoBlackMoneyToBuyBodyBag',
--                     content = ('%s พยายามทำการซื้อ ถุงห่อศพ จำนวน %s ชิ้น ราคา $%s แต่มีเงินผิดกฏหมายไม่เพียงพอต้องการเงินผิดกฏหมายอีก $%s'):format(xPlayer.name, quantity, price, (price - currentAccount.money)),
--                     source = xPlayer.source,
--                 })
--             end) -- End log
--         end    
--     end
-- end)


function onNoBlackMoney(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบร้านค้า', -- หัวเรื่อง
        description = 'คุณมีเงินผิดกฏหมายไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onNoCardGangToBodyBag(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบห่อศพ', -- หัวเรื่อง
		description = 'คุณไม่มีบัตรแก็งหรือบัตรครอบครัว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		--color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

