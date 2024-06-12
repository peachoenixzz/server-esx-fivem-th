


 
ESX.RegisterServerCallback('s4-vehicleshop:checkPlatePrice', function(source, cb, plate) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(xPlayer.getInventoryItem("money").count) >= 15000 then 
      cardata = MySQL.query.await("SELECT plate FROM owned_vehicles WHERE plate='"..plate.."' ", {})
      if #cardata == 0 then 
        cb(true)
        xPlayer.removeInventoryItem("cash", 15000)
      end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough cash'})
    end
end)

RegisterNetEvent('esx_vehicleshop:setJobVehicleState')
AddEventHandler('esx_vehicleshop:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.update('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('[esx_vehicleshop] [^3WARNING^7] %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)


ESX.RegisterServerCallback('esx_vehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.query('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)




ESX.RegisterServerCallback('s4-vehicleshop:checkPrice', function(source, cb, data) 
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getMoney() >= data.price then
        xPlayer.removeMoney(data.price)
        pcall(function() -- Start log -- ยังไม่เสร็จ
            exports['azael_dc-serverlogs']:insertData({
                event = 'BuyCarFromDealerWithMoney',
                content = ('%s ได้ทำการซื้อรถ %s ในราคา $%s และสูญเสียเงินในกระเป๋าจำนวน $%s เหลือเงินในกระเป๋า $%s'):format(xPlayer.name, data.name, data.price, data.price, ESX.Math.GroupDigits(xPlayer.getMoney())),
                source = xPlayer.source,
            })
        end) -- End log
        cb(true)
    else
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'InsufficientMoneyToBuyCar',
                content = ('%s ไม่สามารถทำการซื้อรถ %s ราคา $%s ได้เนื่องจากเงินในกระเป๋าไม่เพียงพอ เหลือเงินในกระเป๋า $%s ต้องการเงินอีก %s เพื่อทำการซื้อ'):format(xPlayer.name, data.name, data.price, ESX.Math.GroupDigits(xPlayer.getMoney()), ESX.Math.GroupDigits(data.price - xPlayer.getMoney())),
                source = xPlayer.source,
            })
        end) -- End log
        cb(false)
        onNoMoneyToBuyCar(source)
    end
end)


ESX.RegisterServerCallback('s4-vehicleshop:checkCredit', function(source, cb, data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if  tonumber(xPlayer.getAccount('bank').money) >= data.price then
        local fee = tonumber(data.price*0.07)
        xPlayer.removeAccountMoney('bank', tonumber(data.price) + fee)
        pcall(function() -- Start log -- ยังไม่เสร็จ
            exports['azael_dc-serverlogs']:insertData({
                event = 'BuyCarFromDealerWithCredit',
                content = ('%s ได้ทำการซื้อรถ %s ในราคา $%s มีค่าทำเนียม $%s และสูญเสียเงินในบัญชีจำนวน $%s ยอดเงินคงเหลือในบัญชี $%s'):format(xPlayer.name, data.name, data.price, ESX.Round(fee), ESX.Round(data.price + fee), ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)),
                source = xPlayer.source,
            })
        end) -- End log
        cb(true)
    else
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'InsufficientCreditToBuyCar',
                content = ('%s ไม่สามารถทำการซื้อรถ %s ราคา $%s มีค่าทำเนียม $%s ยอดรวม $%s ได้เนื่องจากยอดเงินคงเหลือไม่เพีงพอยอดเงินคงเหลือในบัญชี $%s ต้องการเงินในบัญชีอีก $%s เพื่อทำรายการ'):format(xPlayer.name, data.name, data.price, ESX.Round(tonumber(data.price*0.07)), ESX.Round(tonumber(data.price*0.07) + data.price), ESX.Math.GroupDigits(xPlayer.getAccount('bank').money), ESX.Round(tonumber(data.price*0.07) + data.price) - xPlayer.getAccount('bank').money),
                source = xPlayer.source,
            })
        end) -- End log
        cb(false)
        onNoMoneyToBuyCar(source)
    end
end)
 

RegisterNetEvent('s4-vehicleshop:server:givecar')
AddEventHandler('s4-vehicleshop:server:givecar', function(props,type,newPlate)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    MySQL.insert.await("INSERT INTO owned_vehicles (owner, plate, vehicle, job, stored, type) VALUES ('"..Player.identifier.."', '"..newPlate.."', '"..json.encode(props).."', 'player', 2,'"..type.."')", {  })
    --local info = {model = props.model, plaka = props.plate}
    --Player.addInventoryItem('carkey', 1, false, info)
    exports.nc_inventory:AddItem(src, {
        name = newPlate,
        type = 'vehicle_key'
    })
    exports.nc_vehiclekey:ReloadVehicleKey(newPlate)
    print(Player.source..' success buy items')
end)

function onNoMoneyToBuyCar(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ร้านค้ารถ', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'bottom', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end