-- ================================================================================================--
-- ==                                VARIABLES - DO NOT EDIT                                     ==--
-- ================================================================================================--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then

    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'BankDeposit',
				content = ('%s ได้ทำการฝากเงินเข้าธนาคาร จำนวน $%s เงินในกระเป๋าคงเหลือ $%s มีเงินในธนาคารทั้งหมด $%s'):format(xPlayer.name, ESX.Math.GroupDigits(amount), ESX.Math.GroupDigits(xPlayer.getMoney()), ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)),
				source = xPlayer.source,
				options = {
					important = (amount >= 100000 and true)
				}
			})
		end) -- End log
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 then

    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'BankWithdraw',
				content = ('%s ได้ทำการถอนเงินจากธนาคาร จำนวน $%s เงินในกระเป๋าคงเหลือ $%s มีเงินในธนาคารทั้งหมด $%s'):format(xPlayer.name, ESX.Math.GroupDigits(amount), ESX.Math.GroupDigits(xPlayer.getMoney()), ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)),
				source = xPlayer.source,
				options = {
					important = (amount >= 100000 and true)
				}
			})
		end) -- End log
    end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local balanceBank = xPlayer.getAccount('bank').money
	local balanceMoney = xPlayer.getAccount('money').money
    TriggerClientEvent('currentbalance1', source, balanceBank,balanceMoney)
end)


RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local xPlayer = ESX.GetPlayerFromId(source)
    local zPlayer = ESX.GetPlayerFromId(to)
    if zPlayer then
        if tonumber(xPlayer.getAccount('bank').money) >= tonumber(amountt) and  tonumber(xPlayer.getAccount('bank').money) > 0  then
            local remove = tonumber(amountt*0.05)
            xPlayer.removeAccountMoney('bank', tonumber(amountt))
            xPlayer.removeAccountMoney('bank', tonumber(remove))
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'BankTransfer',
                    content = ('%s ได้ทำการโอนเงินจากธนาคารให้กับ %s จำนวน $%s ค่าบริการจำนวน $%s เงินในกระเป๋าคงเหลือ $%s มีเงินในธนาคารทั้งหมด $%s'):format(xPlayer.name, zPlayer.name, ESX.Math.GroupDigits(amountt), ESX.Round(remove), ESX.Math.GroupDigits(xPlayer.getMoney()), ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)),
                    source = xPlayer.source,
                    options = {
                        important = (tonumber(amountt) >= 100000 and true)
                    }
                })
            end) -- End log
            exports.nc_notify:PushNotification(xPlayer.source,{
                scale = 1.0,  -- ปรับขนาดของ Notify
                title = 'ระบบธนาคาร',  -- หัวเรื่อง
                description = "<p>คุณได้โอนเงินจำนวน "..amountt.." บาท</p>",  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'error',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'bank',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000  -- ระยะเวลาการแสดง Notify
            })
            zPlayer.addAccountMoney('bank', tonumber(amountt))
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'BankReceivedTransfer',
                    content = ('%s ได้รับเงินโอนจากธนาคารของ %s จำนวน $%s เงินในกระเป๋าคงเหลือ $%s มีเงินในธนาคารทั้งหมด $%s'):format(zPlayer.name, xPlayer.name, ESX.Math.GroupDigits(amountt), ESX.Math.GroupDigits(zPlayer.getMoney()), ESX.Math.GroupDigits(zPlayer.getAccount('bank').money)),
                    source = zPlayer.source,
                    options = {
                        important = (tonumber(amountt) >= 100000 and true)
                    }
                })
            end) -- End log

            exports.nc_notify:PushNotification(zPlayer.source,{
                scale = 1.0,  -- ปรับขนาดของ Notify
                title = 'ระบบธนาคาร',  -- หัวเรื่อง
                description = "<p>"..xPlayer.getName().." ได้โอนเงินให้คุณจำนวน "..amountt.." บาท</p>",  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'bank',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000  -- ระยะเวลาการแสดง Notify
            })
        else
            onNoMoneyToTransfer(source)
        end
    else
        onNoPlayerToTransfer(source)
    end    
end)

-- RegisterServerEvent('bank:transfer')
-- AddEventHandler('bank:transfer', function(to, amountt)
    -- local xPlayer = ESX.GetPlayerFromId(source)
    -- local zPlayer = ESX.GetPlayerFromId(exports["Tomlock"]:f5shoplockid(to))
    -- local balance = 0
    -- if zPlayer ~= nil and GetPlayerEndpoint(to) ~= nil then
        -- balance = xPlayer.getAccount('bank').money
        -- zbalance = zPlayer.getAccount('bank').money
        -- if tonumber(_source) == tonumber(to) then
            -- advanced notification with bank icon
            -- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank',
                               -- 'Transfer Money',
                               -- 'You cannot transfer to your self!',
                               -- 'CHAR_BANK_MAZE', 9)
        -- else
            -- if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                -- 0 then
                -- advanced notification with bank icon
                -- TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   -- 'Bank', 'Transfer Money',
                                   -- 'Not enough money to transfer!',
                                   -- 'CHAR_BANK_MAZE', 9)
            -- else
                -- xPlayer.removeAccountMoney('bank', tonumber(amountt))
                -- zPlayer.addAccountMoney('bank', tonumber(amountt))
                -- advanced notification with bank icon
                -- TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   -- 'Bank', 'Transfer Money',
                                   -- 'You transfered ~r~$' .. amountt ..
                                       -- '~s~ to ~r~' .. to .. ' .',
                                   -- 'CHAR_BANK_MAZE', 9)
                -- TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank',
                                   -- 'Transfer Money', 'You received ~r~$' ..
                                       -- amountt .. '~s~ from ~r~' .. _source ..
                                       -- ' .', 'CHAR_BANK_MAZE', 9)
            -- end

        -- end
    -- end

-- end)

function onNoMoneyToTransfer(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบธนาคาร', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_bank', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onNoPlayerToTransfer(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบธนาคาร', -- หัวเรื่อง
        description = 'ผู้เล่นนี้ไม่อยู่ในประเทศ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_bank', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end