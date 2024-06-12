ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.UseESX then
	ESX.RegisterServerCallback("cc_fuel:checkMoney", function(source,cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local money = xPlayer.getMoney()
		cb(money)
	end)

	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	RegisterNetEvent('fuel:pay', function(price, buyTank)
		local playerId = tonumber(source)
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer and type(price) == 'number' then
			local money = xPlayer.getMoney()
			price = math.ceil(price)
			if price > 0 and money >= price then
				xPlayer.removeMoney(price)
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'PayGasStationService',
						content = ('%s ได้สูญเสียเงินจำนวน $%s จากการใช้บริการปั่มน้ำมันเ หลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, price, ESX.Math.GroupDigits(xPlayer.getMoney())),
						source = xPlayer.source,
					})
				end) -- End log
				if buyTank then
					local weaponName, maxAmmo = 'WEAPON_PETROLCAN', 4500
					local _,weapon = xPlayer.getWeapon(weaponName)
					if weapon then
						if xPlayer.addWeaponAmmo and tonumber(weapon.ammo) < maxAmmo then
							xPlayer.addWeaponAmmo(weaponName, maxAmmo - weapon.ammo)
							pcall(function() -- Start log
								exports['azael_dc-serverlogs']:insertData({
									event = 'RefuelJerryCan',
									content = ('%s ได้ทำการเติมน้ำมันใส่ %s จำนวน %s จากปั่มน้ำมัน'):format(xPlayer.name, weaponName, (maxAmmo - weapon.ammo)),
									source = xPlayer.source,
								})
							end) -- End log
						end
					else
						xPlayer.addWeapon(weaponName, maxAmmo)
						pcall(function() -- Start log
							exports['azael_dc-serverlogs']:insertData({
								event = 'BuyJerryCan',
								content = ('%s ได้ทำการซื้อ %s และน้ำมันใน %s จำนวน %s จากปั้มน้ำมัน'):format(xPlayer.name, weaponName, weaponName, maxAmmo),
								source = xPlayer.source,
							})
						end) -- End log
					end
				end
			end
		end
	end)
end
