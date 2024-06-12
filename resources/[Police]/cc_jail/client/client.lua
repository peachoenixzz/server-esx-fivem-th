local ongoingfreeze = false

RegisterNetEvent('cc_jail:backPlayerToJail' )
AddEventHandler('cc_jail:backPlayerToJail', function()
    --jailPlayer("main_prison")
end	)

RegisterNetEvent('cc_jail:sendPlayerToJail' )
AddEventHandler('cc_jail:sendPlayerToJail', function(jailName, position)
    jailPlayer(jailName,position)
end	)

RegisterNetEvent('cc_jail:releasePlayer' )
AddEventHandler('cc_jail:releasePlayer', function(releaseName)
    releasePlayer(releaseName)
end)

RegisterNetEvent('cc_jail:backPlayerToJail' )
AddEventHandler('cc_jail:backPlayerToJail', function()
    --jailPlayer("main_prison")
end)

RegisterNetEvent('cc_jail:returnClothPrison')
AddEventHandler('cc_jail:returnClothPrison', function()
    Citizen.Wait(10000)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.UniformsList.male)
        else
            TriggerEvent('skinchanger:loadClothes', skin, Config.UniformsList.female)
        end
    end)
end)

local function freezePlayer(id, freeze)
	local player = id
	SetPlayerControl(player, not freeze, false)

	local ped = GetPlayerPed(player)

	if not freeze then
		-- if not IsEntityVisible(ped) then
		-- 	SetEntityVisible(ped, true)
		-- end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		--SetCharNeverTargetted(ped, false)
		SetPlayerInvincible(player, false)
	else
		-- if IsEntityVisible(ped) then
		-- 	SetEntityVisible(ped, false)
		-- end

		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		--SetCharNeverTargetted(ped, true)
		SetPlayerInvincible(player, true)
		--RemovePtfxFromPed(ped)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end

function jailPlayer(jailName,position)
    for k,v in pairs(Config.JailPositions) do
        if jailName ==  v.name then
            --print("before : ",position)
            --print("before : ",v.position[position])
            if position ~= nil then
                position = v.position[position]
            end
            if position == nil then
                --print("in under")
                position = v.position
            end
            --print("after : ",position)
            local ped = PlayerPedId()
            local currentHealth = GetEntityHealth(ped)
	        local currentArmor = GetPedArmour(ped)
			SwitchOutPlayer(ped,0,1)
			Citizen.Wait(1000)
			freezePlayer(PlayerId(), true)
			-- preload collisions for the spawnpoint
			RequestCollisionAtCoord(position.x, position.y, position.z)
			-- spawn the player
			SetEntityCoordsNoOffset(ped, position.x, position.y, position.z+0.3, false, false, false, true)
			NetworkResurrectLocalPlayer(position.x, position.y, position.z, 0.0, true, true, false)
			SetGameplayCamRelativeHeading(0.0)
            SetEntityHealth(ped, currentHealth)
	        SetPedArmour(ped, currentArmor)
			--SetEntityHeading(ped, v.heading)
			Citizen.Wait(1000)
			local time = GetGameTimer()
			while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
				RequestCollisionAtCoord(position.x, position.y, position.z)
				Citizen.Wait(0)
			end
			SwitchInPlayer(ped)
            Citizen.Wait(1000)
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.UniformsList.male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, Config.UniformsList.female)
            end
            end)
            if exports.esx_policejob:getStatusHandcuffed() then
                TriggerEvent('esx_policejob:unrestrain')
            end
			ongoingfreeze = true
			unFreeze()
        end
    end
end

function releasePlayer(releaseName)
    if not exports.cc_bodybag:checkStatusBodyBag() then
        local PlayerPed = PlayerPedId()
        for _,v in pairs(Config.ReleasePosition) do
            if releaseName == v.name then
                --print("release")
                ESX.TriggerServerCallback('cc_jail:checkTeleportPlayer', function(state)
                    if state then
                        local ped = PlayerPedId()
                        local currentHealth = GetEntityHealth(ped)
	                    local currentArmor = GetPedArmour(ped)
                        SwitchOutPlayer(ped,0,1)
                        Citizen.Wait(1000)
                        freezePlayer(PlayerId(), true)
                        -- preload collisions for the spawnpoint
                        RequestCollisionAtCoord(v.position.x, v.position.y, v.position.z)
                        -- spawn the player
                        SetEntityCoordsNoOffset(ped, v.position.x, v.position.y, v.position.z+0.3, false, false, false, true)
                        NetworkResurrectLocalPlayer(v.position.x, v.position.y, v.position.z, 0.0, true, true, false)
                        SetGameplayCamRelativeHeading(0.0)
                        SetEntityHealth(ped, currentHealth)
	                    SetPedArmour(ped, currentArmor)
                        --SetEntityHeading(ped, v.heading)
                        Citizen.Wait(1000)
                        local time = GetGameTimer()
                        while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
                            RequestCollisionAtCoord(v.position.x, v.position.y, v.position.z)
                            Citizen.Wait(0)
                        end
                        SwitchInPlayer(ped)
                        Citizen.Wait(1000)
                        ongoingfreeze = true
                        unFreeze()
                    end
                end)
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end
        end
    end
end

function unFreeze()
	Citizen.Wait(5000)
	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิกแช่แข็ง")
	if ongoingfreeze then
		Citizen.CreateThread(function()
			while ongoingfreeze do
				Citizen.Wait(0)
				if IsControlJustReleased(0, 73) then
					exports.helpnotify:hideHelpNotification()
					freezePlayer(PlayerId(), false)
					ongoingfreeze = false
				end
			end
		end)
	end
end
