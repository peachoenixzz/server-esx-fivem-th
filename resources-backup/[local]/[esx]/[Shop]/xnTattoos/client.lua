local currentTattoos = {}
local cam = nil
local back = 1
local opacity = 1
local scaleType = nil
local scaleString = ""
local tattoo_zone = false



-- Citizen.CreateThread(function()

-- 	AddTextEntry("ParaTattoos", '<font face="ThaiFont">ร้านสัก</font>')
-- 	for k, v in pairs(Config.Shops) do
-- 		local blip = AddBlipForCoord(v)
-- 		SetBlipSprite(blip, 75)
-- 		SetBlipColour(blip, 1)
-- 		SetBlipScale(blip, 0.7)
-- 		SetBlipAsShortRange(blip, true)
-- 		BeginTextCommandSetBlipName("ParaTattoos")
-- 		EndTextCommandSetBlipName(blip)
-- 	end
-- end)

for _,v in ipairs(Config.Shops) do
	local tattooZone = CircleZone:Create(v.coords, v.distance, {
		name = v.name,
		debugPoly = v.debug,
	})

	tattooZone:onPlayerInOut(function(isPointInside, point)
		if isPointInside then
			exports.helpnotify:showHelpNotification("กด","E","เพื่อสัก")
			tattoo_zone = true
		else
			exports.helpnotify:hideHelpNotification()
			tattoo_zone = false
		end
	end)
end

AddEventHandler('skinchanger:modelLoaded', function()
	ESX.TriggerServerCallback('SmallTattoos:GetPlayerTattoos', function(tattooList)
		if tattooList then
			ClearPedDecorations(PlayerPedId())
			for k, v in pairs(tattooList) do
				if v.Count ~= nil then
					for i = 1, v.Count do
						SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
					end
				else
					SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
				end
			end
			currentTattoos = tattooList
		end
		Wait(100)
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		if not IsMenuOpen() then
			ESX.TriggerServerCallback('SmallTattoos:GetPlayerTattoos', function(tattooList)
				if tattooList then
					ClearPedDecorations(PlayerPedId())
					for k, v in pairs(tattooList) do
						if v.Count ~= nil then
							for i = 1, v.Count do
								SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
							end
						else
							SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
						end
					end
					currentTattoos = tattooList
				end
			end)
		end
	end
end)

function DrawTattoo(collection, name)
	ClearPedDecorations(PlayerPedId())
	for k, v in pairs(currentTattoos) do
		if v.Count ~= nil then
			for i = 1, v.Count do
				SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
			end
		else
			SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
		end
	end
	for i = 1, opacity do
		SetPedDecoration(PlayerPedId(), collection, name)
	end
end

function GetNaked()
	TriggerEvent('skinchanger:getSkin', function()
		if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 0,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 15,
				torso_2  = 0,
				pants_1  = 14,
				pants_2  = 1,
				shoes_1 = 28,
				shoes_2 = 0,
				bags_1 = 0,
				bproof_1 = 0,
				chain_1 = 0,
			})
		else
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 1,
				tshirt_1 = 2,
				tshirt_2 = 0,
				arms     = 13,
				torso_1  = 211,
				torso_2  = 0,
				pants_1  = 168,
				pants_2  = 0,
				shoes_1 = 32,
				shoes_2 = 0,
				bags_1 = 0,
				bproof_1 = 0,
				chain_1 = 0,
			})
		end
	end)
end

function ResetSkin()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	ClearPedDecorations(PlayerPedId())
	for k, v in pairs(currentTattoos) do
		if v.Count ~= nil then
			for i = 1, v.Count do
				SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
			end
		else
			SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
		end
	end
end

function ReqTexts(text, slot)
	RequestAdditionalText(text, slot)
	while not HasAdditionalTextLoaded(slot) do
		Citizen.Wait(0)
	end
end

function OpenTattooShop()
	JayMenu.OpenMenu("tattoo")
	FreezeEntityPosition(PlayerPedId(), true)
	GetNaked()
	ReqTexts("TAT_MNU", 9)
end

function CloseTattooShop()
	ClearAdditionalText(9, 1)
	FreezeEntityPosition(PlayerPedId(), false)
	EnableAllControlActions(0)
	back = 1
	opacity = 1
	ResetSkin()
	return true
end

function ButtonPress()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
end

function IsMenuOpen()
	return (JayMenu.IsMenuOpened('tattoo') or string.find(tostring(JayMenu.CurrentMenu() or ""), "ZONE_"))	
end

function BuyTattoo(collection, name, label, price)
	ESX.TriggerServerCallback('SmallTattoos:PurchaseTattoo', function(success)
		if success then
			table.insert(currentTattoos, {collection = collection, nameHash = name, Count = opacity})
		end
	end, currentTattoos, price, {collection = collection, nameHash = name, Count = opacity}, GetLabelText(label))
end

function RemoveTattoo(name, label)
	for k, v in pairs(currentTattoos) do
		if v.nameHash == name then
			table.remove(currentTattoos, k)
		end
	end
	TriggerServerEvent("SmallTattoos:RemoveTattoo", currentTattoos)
end

RegisterFontFile('athiti')
function Draw3DText(textInput)
	local x = GetEntityCoords(PlayerPedId()).x
	local y = GetEntityCoords(PlayerPedId()).y
	local z = GetEntityCoords(PlayerPedId()).z-2
	local fontId = RegisterFontId('athiti')
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local dist       = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)    
	local scale      = (1 / dist) * 20
	local fov        = (1 / GetGameplayCamFov()) * 100
	local scale      = scale * fov   
	SetTextScale(0.05 * scale, 0.05 * scale)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(250, 250, 250, 255)
	SetTextDropshadow(1, 1, 1, 1, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(textInput)
	SetDrawOrigin(x, y, z + 2, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end

function CreateScale(sType)
	if scaleString ~= sType and sType == "OpenShop" then
		scaleType = setupScaleform("instructional_buttons", "Open Tattoo Shop", 38)
		scaleString = sType
	elseif scaleString ~= sType and sType == "Control" then
		scaleType = setupScaleform2("instructional_buttons", "Change Camera View", 21, "Change Opacity", {90, 89}, "Buy/Remove Tattoo", 191)
		scaleString = sType
	end
end

Citizen.CreateThread(function()
	JayMenu.CreateMenu("tattoo", "Tattoo Shop", function()
        return CloseTattooShop()
    end)
    JayMenu.SetSubTitle('tattoo', "Categories")
	
	for k, v in ipairs(Config.TattooCats) do
		JayMenu.CreateSubMenu(v[1], "tattoo", v[2])
		JayMenu.SetSubTitle(v[1], v[2])
	end

    while true do 
        Citizen.Wait(0)
		local CanSleep = true
		if not IsMenuOpen() then
			if tattoo_zone then
				CanSleep = false
				if not IsPedInAnyVehicle(PlayerPedId(), false) then
					CreateScale("OpenShop")
					if IsControlJustPressed(0, 38) then
						exports.helpnotify:hideHelpNotification() --
						OpenTattooShop()
					end
				end
			end
		end

		if IsMenuOpen() then
			DisableAllControlActions(0)
			CanSleep = false
		end
		
        if JayMenu.IsMenuOpened('tattoo') then
			CanSleep = false
            for k, v in ipairs(Config.TattooCats) do
				JayMenu.MenuButton(v[2], v[1])
			end
			ClearPedDecorations(PlayerPedId())
			for k,v in pairs(currentTattoos) do
				if v.Count ~= nil then
					for i = 1, v.Count do
						SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
					end
				else
					SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
				end
			end
			if DoesCamExist(cam) then
				DetachCam(cam)
				SetCamActive(cam, false)
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
			end
			JayMenu.Display()
        end
		for k, v in ipairs(Config.TattooCats) do
			if JayMenu.IsMenuOpened(v[1]) then
				CanSleep = false
				if not DoesCamExist(cam) then
					cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
					SetCamActive(cam, true)
					RenderScriptCams(true, false, 0, true, true)
					StopCamShaking(cam, true)
				end
				CreateScale("Control")
				DrawScaleformMovieFullscreen(scaleType, 255, 255, 255, 255, 0)
				if IsDisabledControlJustPressed(0, 21) then
					ButtonPress()
					if back == #v[3] then
						back = 1
					else
						back = back + 1
					end
				end
				if IsDisabledControlJustPressed(0, 90) then
					ButtonPress()
					if opacity == 10 then
						opacity = 10
					else
						opacity = opacity + 1
					end
				end
				if IsDisabledControlJustPressed(0, 89) then
					ButtonPress()
					if opacity == 1 then
						opacity = 1
					else
						opacity = opacity - 1
					end
				end
				if GetCamCoord(cam) ~= GetOffsetFromEntityInWorldCoords(PlayerPedId(), v[3][back]) then
					SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(PlayerPedId(), v[3][back]))
					PointCamAtCoord(cam, GetOffsetFromEntityInWorldCoords(PlayerPedId(), v[4]))
				end
				for _, tattoo in pairs(Config.AllTattooList) do
					if tattoo.Zone == v[1] then
						--print("in zone")
						--print(tattoo.Name)
						if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
							if tattoo.HashNameMale ~= '' then
								local found = false
								for k, v in pairs(currentTattoos) do
									if v.nameHash == tattoo.HashNameMale then
										found = true
										break
									end
								end
								if found then
									local clicked, hovered = JayMenu.SpriteButton(GetLabelText(tattoo.Name), "commonmenu", "shop_tattoos_icon_a", "shop_tattoos_icon_b")
									if clicked then
										RemoveTattoo(tattoo.HashNameMale, tattoo.Name)
									end
								else
									--local price = math.ceil(tattoo.Price / 10) == 0 and 100 or math.ceil(tattoo.Price / 10)
									local price = 1000
									local clicked, hovered = JayMenu.Button(GetLabelText(tattoo.Name), "~HUD_COLOUR_GREENDARK~$" .. price)
									if clicked then
										BuyTattoo(tattoo.Collection, tattoo.HashNameMale, tattoo.Name, price)
									elseif hovered then
										DrawTattoo(tattoo.Collection, tattoo.HashNameMale)
									end
								end
							end
						else
							if tattoo.HashNameFemale ~= '' then
								local found = false
								for k, v in pairs(currentTattoos) do
									if v.nameHash == tattoo.HashNameFemale then
										found = true
										break
									end
								end
								if found then
									local clicked, hovered = JayMenu.SpriteButton(GetLabelText(tattoo.Name), "commonmenu", "shop_tattoos_icon_a", "shop_tattoos_icon_b")
									if clicked then
										RemoveTattoo(tattoo.HashNameFemale, tattoo.Name)
									end
								else
									--local price = math.ceil(tattoo.Price / 10) == 0 and 100 or math.ceil(tattoo.Price / 10)
									local price = 1000
									local clicked, hovered = JayMenu.Button(GetLabelText(tattoo.Name), "~HUD_COLOUR_GREENDARK~$" .. price)
									if clicked then
										BuyTattoo(tattoo.Collection, tattoo.HashNameFemale, tattoo.Name, price)
									elseif hovered then
										DrawTattoo(tattoo.Collection, tattoo.HashNameFemale)
									end
								end
							end
						end
					end
				end
				JayMenu.Display()
			end
		end
		if CanSleep then
			Citizen.Wait(3000)
		end
    end
end)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

function setupScaleform2(scaleform, message, button, message2, buttons, message3, button2)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
	
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, buttons[1], true))
    Button(GetControlInstructionalButton(2, buttons[2], true))
    ButtonMessage(message2)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, button, true))
    ButtonMessage(message)
    PopScaleformMovieFunctionVoid()
	
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(2, button2, true))
    ButtonMessage(message3)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function setupScaleform(scaleform, message, button)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, button, true))
    ButtonMessage(message)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end