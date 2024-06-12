local playerBlips = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)


RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

for _,v in pairs(Config.Prisonzone) do
    local prisonZone = PolyZone:Create(v.coords, {
        name = v.name,
        debugPoly = v.debug, 
		minZ = v.minZ,
        maxZ = v.maxZ,
    })

    prisonZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            --print("in prison")
        else
            --print("out prison")
            triggerOutPrison()
            alertPolicePrisionBreak()
        end
    end)
end

function alertPolicePrisionBreak()
    ESX.TriggerServerCallback('cc_prisongps:checkPrisonJailCoreEffect', function(haveJail)
        if haveJail then
            --TriggerEvent("Porpy_policealert:alertNet", "prisonbreak")
            exports['Porpy_policealert']:alertNet('prisonbreak')
        end
    end)
end

function triggerOutPrison()
    TriggerServerEvent('cc_prisongps:outPrison')
end

--===============================================================================================================================================================================================
--===============================================================================================================================================================================================
--===============================================================================================================================================================================================


RegisterNetEvent('cc_prisongps:checkPlayerClosest')
AddEventHandler('cc_prisongps:checkPlayerClosest', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local playerPed = PlayerPedId()
	if closestPlayer ~= -1 and closestDistance <= 1.0 then
        local closestPlayerServerId = GetPlayerServerId(closestPlayer)
        local playerheading = GetEntityHeading(GetPlayerPed(-1))
		local playerlocation = GetEntityForwardVector(PlayerPedId())
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
        ESX.TriggerServerCallback('cc_prisongps:checkPrisonGpsCoreEffect', function(haveCore)
            if haveCore then
                local success = exports.cc_minigame:StartLockPickCircle(3 , 5, 0,'whitespace')
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'StartCutGpsMiniGame',
                        content = ('ผู้เล่นได้เริ่มเล่น Mini Game ตัดสัญญาณ ให้กับ %s'):format(GetPlayerName(closestPlayer)),
                     })
                end) -- End log
                if success then
                    TriggerServerEvent('cc_prisongps:checkCutPrisonGps', closestPlayerServerId, playerheading, playerCoords, playerlocation)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'CutGpsMiniGameSuccess',
                            content = ('ผู้เล่นได้เล่น Mini Game ตัดสัญญาณให้กับ %s สำเร็จ'):format(GetPlayerName(closestPlayer)),
                         })
                    end) -- End log
                else
                    TriggerServerEvent('cc_prisongps:failMiniGameCutGps')
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'CutGpsMiniGameFail',
                            content = ('ผู้เล่นได้เล่น Mini Game ตัดสัญญาณให้กับ %s ล้มเหลว'):format(GetPlayerName(closestPlayer)),
                         })
                    end) -- End log
                end
            else
                print("no gps")
            end
        end, closestPlayerServerId)
    end
end)

RegisterNetEvent('cc_prisongps:getDisruptor')
AddEventHandler('cc_prisongps:getDisruptor', function(playerheading, playercoords, playerlocation,handcuffServer)
	local playerPed = PlayerPedId()
	local x, y, z   = table.unpack(playercoords + playerlocation) --*1.0
	SetEntityCoords(playerPed, x, y, z-1.0)
	SetEntityHeading(playerPed, playerheading)
	ESX.Streaming.RequestAnimDict("mp_arrest_paired", function()
		TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p3', 8.0, -8,900, 2, 0, 0, 0, 0)
		--Citizen.Wait(3060)
	end)
end)

RegisterNetEvent('cc_prisongps:doDisruptor')
AddEventHandler('cc_prisongps:doDisruptor', function()
    local playerPed = PlayerPedId()
	ESX.Streaming.RequestAnimDict("mp_arrest_paired", function()
	    TaskPlayAnim(playerPed, 'mp_arrest_paired', 'cop_p3_fwd', 8.0, -8, 900, 2, 0, 0, 0, 0)
	end)
end)

RegisterNetEvent('cc_prisongps:updateprisonGpsBlips')
AddEventHandler('cc_prisongps:updateprisonGpsBlips', function(playersData)
    for _, blip in pairs(playerBlips) do
        RemoveBlip(blip)
    end

    playerBlips = {}  -- Reset the playerBlips table

    -- Now, create new blips based on received coordinates
    for _, data in ipairs(playersData) do
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(blip, 188)
        -- ... [other blip configurations] ...
        table.insert(playerBlips, blip)
    end
end)
