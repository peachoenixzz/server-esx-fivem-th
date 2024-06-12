ESX                           = nil
local PlayerData              = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local kerfil = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('redzone:firstSpawn')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-- RegisterNetEvent("panicbutton:openMenu")
-- AddEventHandler("panicbutton:openMenu", function()
	-- OpenWantedMenu()
-- end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 344) and GetLastInputMethod( 0 ) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then -- Set to the "F11" Key
			if kerfil == false then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'esx_panicbutton',
			{
				title = "สถานที่"
			}, function(data, menu)

				local result = tostring(data.value)

				if result == "nil" then
					exports.pNotify:SendNotification({
						text = "ค่าไม่ถูกต้อง",
						type = "error", theme= "mint", timeout = 7000, layout = "bottomCenter",
					})
				else
					menu.close()
					TriggerServerEvent('esx_panicbutton:send',result)
				end

			end, function(data, menu)
				menu.close()
			end)
			else
			YesorNo()
			
			end
        end
    end
end)

-- Citizen.CreateThread(function()
    -- while true do
        -- Citizen.Wait(0)
        -- if IsControlJustReleased(0, 344) and GetLastInputMethod( 0 ) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then -- Set to the "F11" Key
			-- if kerfil == false then
			-- ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'esx_panicbutton',
			-- {
				-- title = "สถานที่"
			-- }, function(data, menu)

				-- local result = tostring(data.value)

				-- if result == "nil" then
					-- exports.pNotify:SendNotification({
						-- text = "ค่าไม่ถูกต้อง",
						-- type = "error", theme= "mint", timeout = 7000, layout = "bottomCenter",
					-- })
				-- else
					-- menu.close()
					-- TriggerServerEvent('esx_panicbutton:send',result)
				-- end

			-- end, function(data, menu)
				-- menu.close()
			-- end)
			-- else
			-- YesorNo()
			
			-- end
        -- end
    -- end
-- end)

function YesorNo()

    	ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'panic',
        {
          title = 'ยกเลิกเคอร์ฟิว',
          align = 'center',
          elements = {
            {label = 'yes', value = 'yes'},
            {label = 'no',  value = 'no'},
          },
        },
        function (data, menu)
          if data.current.value == 'yes' then   
			TriggerServerEvent('esx_panicbutton:send', '')
			menu.close()			
          end
			
          if data.current.value == 'no' then			
				menu.close()			
          end

        end,
        function (data, menu)
          menu.close()
        end
      )
end

--Redzone -----------------------------------------------------------------------------
local location = {}
RegisterNetEvent('redzone:setposition')
AddEventHandler('redzone:setposition', function(result)
	x1,y1,z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	TriggerServerEvent('redzone:sentlocation', x1,y1,z1,result)
end)
local results = ''
RegisterNetEvent('redzone:stopredzone')
AddEventHandler('redzone:stopredzone', function()
	kerfil = false
	if location[0] ~= nil then
		exports.pNotify:SendNotification({
			text = "<span style='color:OrangeRed'>*โซนอันตราย*</span><br><span style='color:Red'>ประกาศเคอร์ฟิว  </span><span style='color:Gold'>"..results.."</span><br> ได้ถูกยกเลิกแล้ว",
			type = "alert", theme= "gta", timeout = 10000, layout = "topCenter",
		})
		-- TriggerServerEvent('chathitman', -1, "Police ", {255, 0, 0}, "^8ประกาศยกเลิกเคอร์ฟิว ^3"..results)
		TriggerEvent('chatMessage', "Police ", {255, 0, 0}, "^8ประกาศยกเลิกเคอร์ฟิว ^3"..results)
		RemoveBlip(location[0].blip)
		location[0] = nil
	end
end)

RegisterNetEvent('redzone:createForAll')
AddEventHandler('redzone:createForAll', function(x2,y2,z2,result)
	results = result
	kerfil = true
	local textStreet = ""
	local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
	if tostring(GetStreetNameFromHashKey(var2)) == "" then
		textStreet = "<span style='color:OrangeRed'>*โซนอันตราย*</span> <br><span style='color:Red'>ประกาศเคอร์ฟิว </span><span style='color:Gold'>"..result.."</span><br>โดย: <span style='color:OrangeRed'>[เจ้าหน้าที่ตำรวจ]</span><br><span style='color:OrangeRed'>ผู้ไม่เกี่ยวข้องห้ามเข้าพื้นที่สีแดง</span>"
		-- TriggerServerEvent('chathitman', -1, "Police ", {255, 0, 0}, "^8ประกาศเคอร์ฟิว ^3 "..result.." ^8ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่ด้วยครับ!!")
		TriggerEvent('chatMessage', "Police ", {255, 0, 0}, "^8ประกาศเคอร์ฟิว ^3 "..result.." ^8ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่ด้วยครับ!!")
		location[0] = { x=x2,y=y2,z=z2-220.0,streetname=tostring(GetStreetNameFromHashKey(var1)),zone=current_zone }
		location[0].blip = AddBlipForRadius(x2, y2, z2,200.0) 
		SetBlipColour(location[0].blip,1)
		SetBlipAlpha(location[0].blip,100)
	else 
		textStreet = "<span style='color:OrangeRed'>*โซนอันตราย*</span> <br><span style='color:Red'>ประกาศเคอร์ฟิว </span><span style='color:Gold'>"..result.."</span><br>โดย: <span style='color:OrangeRed'>[เจ้าหน้าที่ตำรวจ]</span><br><span style='color:OrangeRed'>ผู้ไม่เกี่ยวข้องห้ามเข้าพื้นที่สีแดง</span>"
		-- TriggerServerEvent('chathitman', -1, "Police ", {255, 0, 0}, "^8ประกาศเคอร์ฟิว ^3 "..result.." ^8ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่ด้วยครับ!!")
		TriggerEvent('chatMessage', "Police ", {255, 0, 0}, "^8ประกาศเคอร์ฟิว ^3 "..result.." ^8ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่ด้วยครับ!!")
		location[0] = { x=x2,y=y2,z=z2-220.0,streetname=tostring(GetStreetNameFromHashKey(var1)),zone=current_zone }
		location[0].blip = AddBlipForRadius(x2, y2, z2,200.0) 
		SetBlipColour(location[0].blip,1)
		SetBlipAlpha(location[0].blip,100)
	end
	exports.pNotify:SendNotification({
		text = textStreet,
		type = "alert", theme= "gta", timeout = 10000, layout = "topCenter",
	})
end)

-- Draw zone
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
		for k,pos in pairs(location) do
			rgb = RGBRainbow(1)
			DrawMarker(1, pos.x, pos.y, pos.z , 0, 0, 0, 0, 0, 0, 400.0001, 400.0001, 400.0001, 1000, 0, 0, rgb.r, rgb.g, rgb.b, 0.4,0)
		end
	end
end)

function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end
