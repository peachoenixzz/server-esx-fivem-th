local intraining = false
local clothSave = nil
local survivalStatus = {
	hunger = 1000000,
	thirst = 1000000,
	stress = 2000000,
}
local playerArmor = 0
local saveInTraining = false
local ongoingfreeze = false

Citizen.CreateThread(function()
	RegisterFontFile('font4thai') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('font4thai') -- the name from the .xml
end)

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

function checkInZoneTraining()
    return intraining
end


for _,v in pairs(Config.trainingPoly) do
    local trainingTheCircle = PolyZone:Create(v.coords, {
        name = v.name,
        debugPoly = v.debug,
        minZ = v.minZ,
        maxZ = v.maxZ,
    })

    trainingTheCircle:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            intraining = true
			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				survivalStatus.stress = status.val
			end)
			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				survivalStatus.thirst = status.val
			end)
			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				survivalStatus.hunger = status.val
			end)
			saveInTraining = true
			playerArmor =  GetPedArmour(PlayerPedId())
        else
            intraining = false
			TriggerServerEvent('cc_training:exittraining')
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
			for k,status in pairs(survivalStatus) do
				TriggerEvent("esx_status:set" ,  k , status)
			end
			SetPedArmour(PlayerPedId(), playerArmor)
        end
    end)
end

-- ESX.RegisterInput("circle:trainingMap", "(ESX trainingMap) Quick Actions", "keyboard", "F11", function()
-- 	if exports.cc_training:checkInZoneTraining() then
-- 		handleSelectUI()
-- 	end
-- end)


function initClothes(playerColor)
	TriggerEvent('skinchanger:getSkin', function(skin)
		Citizen.Wait(500)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes[playerColor].male)
			clothSave = Config.Clothes[playerColor].male
		end
		if skin.sex ~= 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes[playerColor].female)
			clothSave = Config.Clothes[playerColor].female
		end
	end)
end


function handleSelectUI()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'training_skinmenu',
			{
				title    = '',
				align    = 'top-right',
				elements = {
					{ label = 'เขียว',	value = 'green'},
					{ label = 'แดง',	value = 'red'},
					{ label = 'น้ำเงิน',	value = 'blue'},
					{ label = 'ดำ',	value = 'black'},
					{ label = 'ขาว',	value = 'white'},
					{ label = 'ชุดปกติ',	value = 'default'},
				}
			},
			function(data, menu)
				local selectedAction = data.current.value
				if selectedAction == "green" then
					initClothes(selectedAction)
				end
				if selectedAction == "red" then
					initClothes(selectedAction)
				end
				if selectedAction == "blue" then
					initClothes(selectedAction)
				end
				if selectedAction == "black" then
					initClothes(selectedAction)
				end
				if selectedAction == "white" then
					initClothes(selectedAction)
				end
				if selectedAction == "default" then
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
						clothSave = nil
					end)
				end
			end,
			function(data, menu)
				menu.close()
			end
	)
end


AddEventHandler('esx:onPlayerSpawn', function()
	if exports.cc_training:checkInZoneTraining() then
		TriggerEvent('skinchanger:getSkin', function(skin)
			Citizen.Wait(500)
			if skin.sex == 0 and clothSave ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, clothSave)
			end
			if skin.sex ~= 0 and clothSave ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, clothSave)
			end
			if clothSave == nil then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skinLoad)
					TriggerEvent('skinchanger:loadSkin', skinLoad)
				end)
			end
		end)
	end
end)

function IsNightTime()
	local hour = GetClockHours()
	return hour >= 20 or hour < 6
end

local sleep = 5000
Citizen.CreateThread(function()
	while true do
		if IsNightTime() then
			sleep = 0
			for _, spotlightData in ipairs(Config.spotlights) do
				DrawSpotLight(
						spotlightData.posX,
						spotlightData.posY,
						spotlightData.posZ,
						spotlightData.dirX,
						spotlightData.dirY,
						spotlightData.dirZ,
						spotlightData.colorR,
						spotlightData.colorG,
						spotlightData.colorB,
						spotlightData.distance,
						spotlightData.brightness,
						spotlightData.hardness,
						spotlightData.radius,
						spotlightData.falloff
				)
			end
		end
		if not IsNightTime() then
			sleep = 5000
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
			if(GetDistanceBetweenCoords(coords, -3747.02001953125, -1347.0999755859375, 906.280029296875, false) < 10.0) then
				DrawMarker(1, -3747.02001953125, -1347.0999755859375, 905.280029296875, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
						3.00, 3.00, 1.00, 255, 204, 0, 100,
						false, true, 2, false, false, false, false)
				Draw3DText(-3747.02001953125, -1347.0999755859375, 906.280029296875+1, 0.5,"กด ~y~[E]~w~ เพื่อเปลี่ยนชุด")
				sleep = 0
			end

			if(GetDistanceBetweenCoords(coords, -3747.02001953125, -1347.0999755859375, 906.280029296875, false) < 3.00) then
				isInMarker = true
				if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
					handleSelectUI()
				end
			end

		if not isInMarker then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'training_skinmenu')
		end
		Citizen.Wait(sleep)
    end
end)

function Draw3DText(x, y, z, scl_factor, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov * scl_factor
	if onScreen then
		SetTextScale(0.0, scale)
		SetTextFont(fontId)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end