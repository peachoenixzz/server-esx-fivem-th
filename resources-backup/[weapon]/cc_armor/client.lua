
local isDead = false
local helmetStatus = false
local ongoingusevest = false

local maleHelmet = {
    helmet_1 = 90,
    helmet_2 = 0,
}

local femaleHelmet = {
    helmet_1 = 89,
    helmet_2 = 0,
},


--
--Citizen.CreateThread(function()
--	while true do
--		Wait(1)
--		local ped = PlayerPedId()
--		if not IsEntityDead(ped) then
--			for n,i in pairs(weaponlist) do
--				if  i.name ~= "WEAPON_SNOWBALL" then
--					local WeaponHash = GetHashKey(i.name)
--					N_0x4757f00bc6323cfe(WeaponHash, 0.0001)
--					if HasEntityBeenDamagedByWeapon(ped, WeaponHash, 0) then
--						lastDamage = WeaponHash
--						-- print(lastDamage)
--						if i.name == 'WEAPON_BATTLEAXE_LV3' then
--							ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--							poison = true
--							isPoison(i.name)
--							local heathly = GetEntityHealth(ped)
--							if (heathly - i.damage) > 0 then
--								ClearEntityLastDamageEntity(ped)
--							end
--						elseif i.name == 'WEAPON_BOTTLE_RED' then
--							ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--							bleedout = true
--							isBleedout()
--							local heathly = GetEntityHealth(ped)
--							if (heathly - i.damage) > 0 then
--								ClearEntityLastDamageEntity(ped)
--							end
--						elseif i.name == 'WEAPON_NAVYREVOLVER' then
--							ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--							setNump2()
--
--							local heathly = GetEntityHealth(ped)
--							if (heathly - i.damage) > 0 then
--								ClearEntityLastDamageEntity(ped)
--							end
--						elseif i.name == 'WEAPON_POOLCUE_BLUE' then
--							ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--							StartEntityFire(ped)
--							local heathly = GetEntityHealth(ped)
--							if (heathly - i.damage) > 0 then
--								ClearEntityLastDamageEntity(ped)
--							end
--						elseif i.name == 'WEAPON_MACHETE_BLUE' then
--							local hp = GetEntityHealth(ped)
--							local sh = GetPedArmour(ped)
--							local rate = math.random(100)
--							if rate <= 15 then
--								if sh > 1 then
--									SetPedArmour(ped, 0)
--									ApplyDamageToPed(PlayerPedId(), 1, true)
--									local heathly = GetEntityHealth(ped)
--									if (heathly - i.damage) > 0 then
--										ClearEntityLastDamageEntity(ped)
--									end
--								elseif sh < 1 and hp > 100 then
--									SetEntityHealth(ped, 110)
--									ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--									local heathly = GetEntityHealth(ped)
--									if (heathly - i.damage) > 0 then
--										ClearEntityLastDamageEntity(ped)
--									end
--								end
--							else
--								ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--								local heathly = GetEntityHealth(ped)
--								if (heathly - i.damage) > 0 then
--									ClearEntityLastDamageEntity(ped)
--								end
--							end
--						elseif i.name == 'WEAPON_MACHETE_RED' then
--							local hp = GetEntityHealth(ped)
--							SetEntityHealth(ped, hp - i.damage)
--							ApplyDamageToPed(PlayerPedId(), 1, true)
--							local heathly = GetEntityHealth(ped)
--							if (heathly - i.damage) > 0 then
--								ClearEntityLastDamageEntity(ped)
--							end
--						elseif i.name == 'WEAPON_KNUCKLE_LV7' or i.name == 'WEAPON_KNUCKLE_LV7_AH' then
--							ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--							cantusepainkiller()
--							local heathly = GetEntityHealth(ped)
--							if (heathly - i.damage) > 0 then
--								ClearEntityLastDamageEntity(ped)
--							end
--						else
--							ApplyDamageToPed(PlayerPedId(), i.damage - 1, true)
--							local heathly = GetEntityHealth(ped)
--							if (heathly - i.damage) > 0 then
--								ClearEntityLastDamageEntity(ped)
--							end
--						end
--						break
--					end
--				else
--					if i.name == "WEAPON_SNOWBALL" then
--						local WeaponHash = GetHashKey(i.name)
--						N_0x4757f00bc6323cfe(WeaponHash, 0.00)
--					end
--				end
--			end
--		end
--	end
--end)

-- Citizen.CreateThread(function()
-- 	while true do 
-- 		Wait(1000)
-- 		print(GetPlayerSprintStaminaRemaining(PlayerId()))
-- 	end
-- end)

-- RegisterCommand('sta', function()
	
-- 	SetPlayerSprint(PlayerId(), false)
-- end)


RegisterNetEvent('armor:addGovermentVest')
AddEventHandler('armor:addGovermentVest', function()
    if not ongoingusevest then
        ongoingusevest = true
        local playerPed = GetPlayerPed(-1)
        
        RequestAnimDict("clothingshirt")
        
        while not HasAnimDictLoaded("clothingshirt") do
        
            Citizen.Wait(100)
            
        end
        
        TaskPlayAnim(GetPlayerPed(PlayerId()), "clothingshirt", "try_shirt_positive_d", 1.0, -1, -1, 50, 0, 0, 0, 0)
        
        Citizen.Wait(4000)
        SetPedArmour(playerPed, 100)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'GovermentVestArmorPoint',
                content = ('ผู้เล่นมีค่าความคงทนเกราะ 100 หน่วย'):format(),
            })
        end) -- End log
        StopAnimTask(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 1.0)
        ongoingusevest = false
    end
end)

RegisterNetEvent('cc_armor:vestPlayer')
AddEventHandler('cc_armor:vestPlayer', function(armorPoint, itemName)
    if not ongoingusevest then
        ongoingusevest = true
        local playerPed = GetPlayerPed(-1)
        
        RequestAnimDict("clothingshirt")
        
        while not HasAnimDictLoaded("clothingshirt") do
        
            Citizen.Wait(100)
            
        end
        
        TaskPlayAnim(GetPlayerPed(PlayerId()), "clothingshirt", "try_shirt_positive_d", 1.0, -1, -1, 50, 0, 0, 0, 0)
        
        Citizen.Wait(4000)

        ESX.TriggerServerCallback('cc_armor:finalcheckitem', function(haveitem)
            if haveitem then
                SetPedArmour(playerPed, armorPoint)
            else
                exports.nc_notify:PushNotification({
                    scale = 1.0, -- ปรับขนาดของ Notify
                    title = 'ระบบใส่เกราะ', -- หัวเรื่อง
                    description = 'คุณไม่มีไอเทมที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                    type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                    position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                    direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                    priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                    icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                    duration = 3000 -- ระยะเวลาการแสดง Notify
                })
            end
        end, itemName)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'KevlarVestArmorPoint',
                content = ('ผู้เล่นมีค่าความคงทนเกราะ %s หน่วย'):format(armorPoint),
            })
        end) -- End log
        
        StopAnimTask(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 1.0)
        ongoingusevest = false
    end
end)

RegisterNetEvent('cc_armor:vestPlayerTraining')
AddEventHandler('cc_armor:vestPlayerTraining', function(armorPoint)
    if exports.cc_training:checkInZoneTraining() then
        if not ongoingusevest then
            ongoingusevest = true
            local playerPed = GetPlayerPed(-1)
                
            RequestAnimDict("clothingshirt")
                
            while not HasAnimDictLoaded("clothingshirt") do
                
                Citizen.Wait(100)
                    
            end
                
            TaskPlayAnim(GetPlayerPed(PlayerId()), "clothingshirt", "try_shirt_positive_d", 1.0, -1, -1, 50, 0, 0, 0, 0)
                
            Citizen.Wait(4000)
                
            SetPedArmour(playerPed, armorPoint)
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'RentalVestArmorPoint',
                    content = ('ผู้เล่นมีค่าความคงทนเกราะ %s หน่วย'):format(armorPoint),
                })
            end) -- End log

            StopAnimTask(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 1.0)
            ongoingusevest = false
        end
    else
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                 event = 'RentalVestFail',
                 content = ('ผู้เล่นพยายามใส่ชุดเกราะแต่ไม่ได้อยู่ในพื้นที่ฝึกซ้อม (พยายามโกงเกมหรือเปล่านะ)'):format(),
            })
        end) -- End log
        exports.nc_notify:PushNotification({
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'สนามฝึกซ้อม', -- หัวเรื่อง
            description = 'คุณไม่ได้อยู่ในพื้นที่ฝึกซ้อม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
end)

RegisterNetEvent('cc_armor:useHelmet')
AddEventHandler('cc_armor:useHelmet', function(itemName)
    if not ongoingusevest then
        ongoingusevest = true
        local playerPed = GetPlayerPed(PlayerId())

        RequestAnimDict("anim@veh@bike@hemi_trike@front@base")

        while not HasAnimDictLoaded("anim@veh@bike@hemi_trike@front@base") do
            Citizen.Wait(100)
        end
        TaskPlayAnim(GetPlayerPed(PlayerId()), "anim@veh@bike@hemi_trike@front@base", "put_on_helmet", 1.0, -1, -1, 50, 0, 0, 0, 0)
        Citizen.Wait(1500)
        TriggerServerEvent('cc_armor:removeitem',itemName)
        helmetStatus = true
        SetPedSuffersCriticalHits(playerPed, false)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, maleHelmet)
            end
            if skin.sex ~= 0 then
                TriggerEvent('skinchanger:loadClothes', skin, femaleHelmet)
            end
        end)
        StopAnimTask(PlayerPedId(), 'anim@veh@bike@hemi_trike@front@base', 'put_on_helmet', 1.0)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'HelmetDefenceOn',
                content = ('ผู้เล่นได้ทำการสวมหมวกเรียบร้อยแล้ว'):format(),
            })
        end) -- End log
        ongoingusevest = false
    end
end)

function isHelmetOn()
    return helmetStatus
end

function helmetBroken()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        local playerPed = GetPlayerPed(PlayerId())
        helmetStatus = false
        SetPedSuffersCriticalHits(playerPed, true)
        exports.cc_sound:initSound('bong')
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

AddEventHandler('esx:onPlayerDeath', function() 
	ongoingusevest = false
    isDead = true
end)

AddEventHandler("esx:onPlayerSpawn", function()
    isDead = false
    if helmetStatus then
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, maleHelmet)
            end
            if skin.sex ~= 0 then
                TriggerEvent('skinchanger:loadClothes', skin, femaleHelmet)
            end
        end)
    end
end)