
--T[[ แทนที่ในส่วน es_extended\client หาไฟล์ ชื่อ functions.lua จากนั้น ทำตามข้างล่าง ]]
--#################################################### V ของเดิม #####################################
-- ESX.Game.GetVehicleProperties = function(vehicle)
	-- local color1, color2 = GetVehicleColours(vehicle)
	-- local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
	-- local extras = {}

	-- for id=0, 12 do
		-- if DoesExtraExist(vehicle, id) then
			-- local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
			-- extras[tostring(id)] = state
		-- end
	-- end

	-- return {

		-- model             = GetEntityModel(vehicle),

		-- plate             = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)),
		-- plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

		-- health            = GetEntityHealth(vehicle),
		-- dirtLevel         = GetVehicleDirtLevel(vehicle),

		-- color1            = color1,
		-- color2            = color2,

		-- pearlescentColor  = pearlescentColor,
		-- wheelColor        = wheelColor,

		-- wheels            = GetVehicleWheelType(vehicle),
		-- windowTint        = GetVehicleWindowTint(vehicle),

		-- neonEnabled       = {
			-- IsVehicleNeonLightEnabled(vehicle, 0),
			-- IsVehicleNeonLightEnabled(vehicle, 1),
			-- IsVehicleNeonLightEnabled(vehicle, 2),
			-- IsVehicleNeonLightEnabled(vehicle, 3)
		-- },

		-- extras            = extras,

		-- neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
		-- tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

		-- modSpoilers       = GetVehicleMod(vehicle, 0),
		-- modFrontBumper    = GetVehicleMod(vehicle, 1),
		-- modRearBumper     = GetVehicleMod(vehicle, 2),
		-- modSideSkirt      = GetVehicleMod(vehicle, 3),
		-- modExhaust        = GetVehicleMod(vehicle, 4),
		-- modFrame          = GetVehicleMod(vehicle, 5),
		-- modGrille         = GetVehicleMod(vehicle, 6),
		-- modHood           = GetVehicleMod(vehicle, 7),
		-- modFender         = GetVehicleMod(vehicle, 8),
		-- modRightFender    = GetVehicleMod(vehicle, 9),
		-- modRoof           = GetVehicleMod(vehicle, 10),

		-- modEngine         = GetVehicleMod(vehicle, 11),
		-- modBrakes         = GetVehicleMod(vehicle, 12),
		-- modTransmission   = GetVehicleMod(vehicle, 13),
		-- modHorns          = GetVehicleMod(vehicle, 14),
		-- modSuspension     = GetVehicleMod(vehicle, 15),
		-- modArmor          = GetVehicleMod(vehicle, 16),

		-- modTurbo          = IsToggleModOn(vehicle, 18),
		-- modSmokeEnabled   = IsToggleModOn(vehicle, 20),
		-- modXenon          = IsToggleModOn(vehicle, 22),

		-- modFrontWheels    = GetVehicleMod(vehicle, 23),
		-- modBackWheels     = GetVehicleMod(vehicle, 24),

		-- modPlateHolder    = GetVehicleMod(vehicle, 25),
		-- modVanityPlate    = GetVehicleMod(vehicle, 26),
		-- modTrimA          = GetVehicleMod(vehicle, 27),
		-- modOrnaments      = GetVehicleMod(vehicle, 28),
		-- modDashboard      = GetVehicleMod(vehicle, 29),
		-- modDial           = GetVehicleMod(vehicle, 30),
		-- modDoorSpeaker    = GetVehicleMod(vehicle, 31),
		-- modSeats          = GetVehicleMod(vehicle, 32),
		-- modSteeringWheel  = GetVehicleMod(vehicle, 33),
		-- modShifterLeavers = GetVehicleMod(vehicle, 34),
		-- modAPlate         = GetVehicleMod(vehicle, 35),
		-- modSpeakers       = GetVehicleMod(vehicle, 36),
		-- modTrunk          = GetVehicleMod(vehicle, 37),
		-- modHydrolic       = GetVehicleMod(vehicle, 38),
		-- modEngineBlock    = GetVehicleMod(vehicle, 39),
		-- modAirFilter      = GetVehicleMod(vehicle, 40),
		-- modStruts         = GetVehicleMod(vehicle, 41),
		-- modArchCover      = GetVehicleMod(vehicle, 42),
		-- modAerials        = GetVehicleMod(vehicle, 43),
		-- modTrimB          = GetVehicleMod(vehicle, 44),
		-- modTank           = GetVehicleMod(vehicle, 45),
		-- modWindows        = GetVehicleMod(vehicle, 46),
		-- modLivery         = GetVehicleLivery(vehicle)
	-- }
-- end



-- ESX.Game.SetVehicleProperties = function(vehicle, props)
	-- SetVehicleModKit(vehicle, 0)

	-- if props.plate ~= nil then
		-- SetVehicleNumberPlateText(vehicle, props.plate)
	-- end

	-- if props.plateIndex ~= nil then
		-- SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
	-- end

	-- if props.health ~= nil then
		-- SetEntityHealth(vehicle, props.health)
	-- end

	-- if props.dirtLevel ~= nil then
		-- SetVehicleDirtLevel(vehicle, props.dirtLevel)
	-- end

	-- if props.color1 ~= nil then
		-- local color1, color2 = GetVehicleColours(vehicle)
		-- SetVehicleColours(vehicle, props.color1, color2)
	-- end

	-- if props.color2 ~= nil then
		-- local color1, color2 = GetVehicleColours(vehicle)
		-- SetVehicleColours(vehicle, color1, props.color2)
	-- end

	-- if props.pearlescentColor ~= nil then
		-- local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		-- SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
	-- end

	-- if props.wheelColor ~= nil then
		-- local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		-- SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
	-- end

	-- if props.wheels ~= nil then
		-- SetVehicleWheelType(vehicle, props.wheels)
	-- end

	-- if props.windowTint ~= nil then
		-- SetVehicleWindowTint(vehicle, props.windowTint)
	-- end

	-- if props.neonEnabled ~= nil then
		-- SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
		-- SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
		-- SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
		-- SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
	-- end

	-- if props.extras ~= nil then
		-- for id,enabled in pairs(props.extras) do
			-- if enabled then
				-- SetVehicleExtra(vehicle, tonumber(id), 0)
			-- else
				-- SetVehicleExtra(vehicle, tonumber(id), 1)
			-- end
		-- end
	-- end

	-- if props.neonColor ~= nil then
		-- SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
	-- end

	-- if props.modSmokeEnabled ~= nil then
		-- ToggleVehicleMod(vehicle, 20, true)
	-- end

	-- if props.tyreSmokeColor ~= nil then
		-- SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	-- end

	-- if props.modSpoilers ~= nil then
		-- SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	-- end

	-- if props.modFrontBumper ~= nil then
		-- SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	-- end

	-- if props.modRearBumper ~= nil then
		-- SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	-- end

	-- if props.modSideSkirt ~= nil then
		-- SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	-- end

	-- if props.modExhaust ~= nil then
		-- SetVehicleMod(vehicle, 4, props.modExhaust, false)
	-- end

	-- if props.modFrame ~= nil then
		-- SetVehicleMod(vehicle, 5, props.modFrame, false)
	-- end

	-- if props.modGrille ~= nil then
		-- SetVehicleMod(vehicle, 6, props.modGrille, false)
	-- end

	-- if props.modHood ~= nil then
		-- SetVehicleMod(vehicle, 7, props.modHood, false)
	-- end

	-- if props.modFender ~= nil then
		-- SetVehicleMod(vehicle, 8, props.modFender, false)
	-- end

	-- if props.modRightFender ~= nil then
		-- SetVehicleMod(vehicle, 9, props.modRightFender, false)
	-- end

	-- if props.modRoof ~= nil then
		-- SetVehicleMod(vehicle, 10, props.modRoof, false)
	-- end

	-- if props.modEngine ~= nil then
		-- SetVehicleMod(vehicle, 11, props.modEngine, false)
	-- end

	-- if props.modBrakes ~= nil then
		-- SetVehicleMod(vehicle, 12, props.modBrakes, false)
	-- end

	-- if props.modTransmission ~= nil then
		-- SetVehicleMod(vehicle, 13, props.modTransmission, false)
	-- end

	-- if props.modHorns ~= nil then
		-- SetVehicleMod(vehicle, 14, props.modHorns, false)
	-- end

	-- if props.modSuspension ~= nil then
		-- SetVehicleMod(vehicle, 15, props.modSuspension, false)
	-- end

	-- if props.modArmor ~= nil then
		-- SetVehicleMod(vehicle, 16, props.modArmor, false)
	-- end

	-- if props.modTurbo ~= nil then
		-- ToggleVehicleMod(vehicle,  18, props.modTurbo)
	-- end

	-- if props.modXenon ~= nil then
		-- ToggleVehicleMod(vehicle,  22, props.modXenon)
	-- end

	-- if props.modFrontWheels ~= nil then
		-- SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
	-- end

	-- if props.modBackWheels ~= nil then
		-- SetVehicleMod(vehicle, 24, props.modBackWheels, false)
	-- end

	-- if props.modPlateHolder ~= nil then
		-- SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
	-- end

	-- if props.modVanityPlate ~= nil then
		-- SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
	-- end

	-- if props.modTrimA ~= nil then
		-- SetVehicleMod(vehicle, 27, props.modTrimA, false)
	-- end

	-- if props.modOrnaments ~= nil then
		-- SetVehicleMod(vehicle, 28, props.modOrnaments, false)
	-- end

	-- if props.modDashboard ~= nil then
		-- SetVehicleMod(vehicle, 29, props.modDashboard, false)
	-- end

	-- if props.modDial ~= nil then
		-- SetVehicleMod(vehicle, 30, props.modDial, false)
	-- end

	-- if props.modDoorSpeaker ~= nil then
		-- SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
	-- end

	-- if props.modSeats ~= nil then
		-- SetVehicleMod(vehicle, 32, props.modSeats, false)
	-- end

	-- if props.modSteeringWheel ~= nil then
		-- SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
	-- end

	-- if props.modShifterLeavers ~= nil then
		-- SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
	-- end

	-- if props.modAPlate ~= nil then
		-- SetVehicleMod(vehicle, 35, props.modAPlate, false)
	-- end

	-- if props.modSpeakers ~= nil then
		-- SetVehicleMod(vehicle, 36, props.modSpeakers, false)
	-- end

	-- if props.modTrunk ~= nil then
		-- SetVehicleMod(vehicle, 37, props.modTrunk, false)
	-- end

	-- if props.modHydrolic ~= nil then
		-- SetVehicleMod(vehicle, 38, props.modHydrolic, false)
	-- end

	-- if props.modEngineBlock ~= nil then
		-- SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
	-- end

	-- if props.modAirFilter ~= nil then
		-- SetVehicleMod(vehicle, 40, props.modAirFilter, false)
	-- end

	-- if props.modStruts ~= nil then
		-- SetVehicleMod(vehicle, 41, props.modStruts, false)
	-- end

	-- if props.modArchCover ~= nil then
		-- SetVehicleMod(vehicle, 42, props.modArchCover, false)
	-- end

	-- if props.modAerials ~= nil then
		-- SetVehicleMod(vehicle, 43, props.modAerials, false)
	-- end

	-- if props.modTrimB ~= nil then
		-- SetVehicleMod(vehicle, 44, props.modTrimB, false)
	-- end

	-- if props.modTank ~= nil then
		-- SetVehicleMod(vehicle, 45, props.modTank, false)
	-- end

	-- if props.modWindows ~= nil then
		-- SetVehicleMod(vehicle, 46, props.modWindows, false)
	-- end

	-- if props.modLivery ~= nil then
		-- SetVehicleMod(vehicle, 48, props.modLivery, false)
		-- SetVehicleLivery(vehicle, props.modLivery)
	-- end
-- end


--#################################################### V ของเดิม #####################################


--#################################################### V นำส่วนนี้ไปแทน ข้างบน  #####################################
ESX.Game.GetVehicleProperties = function(vehicle)
	local color1, color2 = GetVehicleColours(vehicle)
	
	local color1Custom = {}
	color1Custom[1], color1Custom[2], color1Custom[3] = GetVehicleCustomPrimaryColour(vehicle)
	
	local color2Custom = {}
	color2Custom[1], color2Custom[2], color2Custom[3] = GetVehicleCustomSecondaryColour(vehicle)
	
	local color1Type = GetVehicleModColor_1(vehicle)
	local color2Type = GetVehicleModColor_2(vehicle)

	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
	
	local extras = {}
	for id = 0, 25 do
		if (DoesExtraExist(vehicle, id)) then
			extras[tostring(id)] = IsVehicleExtraTurnedOn(vehicle, id)
		end
	end

	local neonColor = {}
	neonColor[1], neonColor[2], neonColor[3] = GetVehicleNeonLightsColour(vehicle)

	local tyreSmokeColor = {}
	tyreSmokeColor[1], tyreSmokeColor[2], tyreSmokeColor[3] = GetVehicleTyreSmokeColor(vehicle)
	
	local tempData = {
		model             = GetEntityModel(vehicle),

		plate             = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)),
		plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

		bodyHealth        = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 1),
		engineHealth      = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 1),

		fuelLevel         = ESX.Math.Round(GetVehicleFuelLevel(vehicle), 1),
		dirtLevel         = ESX.Math.Round(GetVehicleDirtLevel(vehicle), 1),

		color1            = color1,
		color1Custom      = color1Custom,
		
		color2            = color2,
		color2Custom      = color2Custom,

		pearlescentColor  = pearlescentColor,

		color1Type 		  = GetVehicleModColor_1(vehicle),
		color2Type 		  = GetVehicleModColor_2(vehicle),

		wheelColor        = wheelColor,
		wheels            = GetVehicleWheelType(vehicle),
		windowTint        = GetVehicleWindowTint(vehicle),

		extras            = extras,

		neonEnabled       = {
			IsVehicleNeonLightEnabled(vehicle, 0),
			IsVehicleNeonLightEnabled(vehicle, 1),
			IsVehicleNeonLightEnabled(vehicle, 2),
			IsVehicleNeonLightEnabled(vehicle, 3)
		},
		
		neonColor         = neonColor,
		tyreSmokeColor    = tyreSmokeColor,

		modSpoilers       = GetVehicleMod(vehicle, 0),
		modFrontBumper    = GetVehicleMod(vehicle, 1),
		modRearBumper     = GetVehicleMod(vehicle, 2),
		modSideSkirt      = GetVehicleMod(vehicle, 3),
		modExhaust        = GetVehicleMod(vehicle, 4),
		modFrame          = GetVehicleMod(vehicle, 5),
		modGrille         = GetVehicleMod(vehicle, 6),
		modHood           = GetVehicleMod(vehicle, 7),
		modFender         = GetVehicleMod(vehicle, 8),
		modRightFender    = GetVehicleMod(vehicle, 9),
		modRoof           = GetVehicleMod(vehicle, 10),

		modEngine         = GetVehicleMod(vehicle, 11),
		modBrakes         = GetVehicleMod(vehicle, 12),
		modTransmission   = GetVehicleMod(vehicle, 13),
		modHorns          = GetVehicleMod(vehicle, 14),
		modSuspension     = GetVehicleMod(vehicle, 15),
		modArmor          = GetVehicleMod(vehicle, 16),

		modTurbo          = IsToggleModOn(vehicle, 18),
		modSmokeEnabled   = IsToggleModOn(vehicle, 20),
		modXenon          = GetVehicleXenonLightsColour(vehicle),

		modFrontWheels    = GetVehicleMod(vehicle, 23),
		modBackWheels     = GetVehicleMod(vehicle, 24),

		modPlateHolder    = GetVehicleMod(vehicle, 25),
		modVanityPlate    = GetVehicleMod(vehicle, 26),
		modTrimA          = GetVehicleMod(vehicle, 27),
		modOrnaments      = GetVehicleMod(vehicle, 28),
		modDashboard      = GetVehicleMod(vehicle, 29),
		modDial           = GetVehicleMod(vehicle, 30),
		modDoorSpeaker    = GetVehicleMod(vehicle, 31),
		modSeats          = GetVehicleMod(vehicle, 32),
		modSteeringWheel  = GetVehicleMod(vehicle, 33),
		modShifterLeavers = GetVehicleMod(vehicle, 34),
		modAPlate         = GetVehicleMod(vehicle, 35),
		modSpeakers       = GetVehicleMod(vehicle, 36),
		modTrunk          = GetVehicleMod(vehicle, 37),
		modHydrolic       = GetVehicleMod(vehicle, 38),
		modEngineBlock    = GetVehicleMod(vehicle, 39),
		modAirFilter      = GetVehicleMod(vehicle, 40),
		modStruts         = GetVehicleMod(vehicle, 41),
		modArchCover      = GetVehicleMod(vehicle, 42),
		modAerials        = GetVehicleMod(vehicle, 43),
		modTrimB          = GetVehicleMod(vehicle, 44),
		modTank           = GetVehicleMod(vehicle, 45),
		modWindows        = GetVehicleMod(vehicle, 46),
		modLivery         = GetVehicleMod(vehicle, 48),
		livery            = GetVehicleLivery(vehicle)
	}

	tempData.modTurbo = tempData.modTurbo or 0
	
	return tempData
end	

ESX.Game.SetVehicleProperties = function(vehicle, props)
		if (props == nil) then return end

	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (props == nil or vehicle == nil or not DoesEntityExist(vehicle)) then return end
	
	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (props.plate) then
		SetVehicleNumberPlateText(vehicle, props.plate)
	end

	if (props.plateIndex) then
		SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
	end

	if (props.bodyHealth) then
		SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
	end

	if (props.engineHealth) then
		SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
	end

	if (props.fuelLevel) then
		SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
	end

	if (props.dirtLevel) then
		SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
	end

	if (props.color1) then
		ClearVehicleCustomPrimaryColour(vehicle)
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, props.color1, color2)
	end

	if (props.color1Custom) then
		SetVehicleCustomPrimaryColour(vehicle, props.color1Custom[1], props.color1Custom[2], props.color1Custom[3])
	end

	if (props.color2) then
		ClearVehicleCustomSecondaryColour(vehicle)

		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, color1, props.color2)
	end

	if (props.color2Custom) then
		SetVehicleCustomSecondaryColour(vehicle, props.color2Custom[1], props.color2Custom[2], props.color2Custom[3])
	end

	if (props.color1Type) then
		SetVehicleModColor_1(vehicle, props.color1Type)
	end

	if (props.color2Type) then
		SetVehicleModColor_2(vehicle, props.color2Type)
	end

	if (props.pearlescentColor) then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
	end

	if (props.wheelColor) then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
	end

	if (props.wheels) then
		SetVehicleWheelType(vehicle, props.wheels)
	end

	if (props.windowTint) then
		SetVehicleWindowTint(vehicle, props.windowTint)
	end

	if (props.extras) then
		for id = 0, 25 do
			if (DoesExtraExist(vehicle, id)) then
				SetVehicleExtra(vehicle, id, props.extras[tostring(id)] and 0 or 1)
			end
		end
	end

	if (props.neonEnabled) then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1] == true or props.neonEnabled[1] == 1)
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2] == true or props.neonEnabled[2] == 1)
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3] == true or props.neonEnabled[3] == 1)
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4] == true or props.neonEnabled[4] == 1)
	end

	if (props.neonColor) then
		SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
	end

	if (props.modSmokeEnabled) then
		ToggleVehicleMod(vehicle, 20, true)
	end

	if (props.tyreSmokeColor) then
		SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	end

	if (props.modSpoilers) then
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	end

	if (props.modFrontBumper) then
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	end

	if (props.modRearBumper) then
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	end

	if (props.modSideSkirt) then
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	end

	if (props.modExhaust) then
		SetVehicleMod(vehicle, 4, props.modExhaust, false)
	end

	if (props.modFrame) then
		SetVehicleMod(vehicle, 5, props.modFrame, false)
	end

	if (props.modGrille) then
		SetVehicleMod(vehicle, 6, props.modGrille, false)
	end

	if (props.modHood) then
		SetVehicleMod(vehicle, 7, props.modHood, false)
	end

	if (props.modFender) then
		SetVehicleMod(vehicle, 8, props.modFender, false)
	end

	if (props.modRightFender) then
		SetVehicleMod(vehicle, 9, props.modRightFender, false)
	end

	if (props.modRoof) then
		SetVehicleMod(vehicle, 10, props.modRoof, false)
	end

	if (props.modEngine) then
		SetVehicleMod(vehicle, 11, props.modEngine, false)
	end

	if (props.modBrakes) then
		SetVehicleMod(vehicle, 12, props.modBrakes, false)
	end

	if (props.modTransmission) then
		SetVehicleMod(vehicle, 13, props.modTransmission, false)
	end

	if (props.modHorns) then
		SetVehicleMod(vehicle, 14, props.modHorns, false)
	end

	if (props.modSuspension) then
		SetVehicleMod(vehicle, 15, props.modSuspension, false)
	end

	if (props.modArmor) then
		SetVehicleMod(vehicle, 16, props.modArmor, false)
	end

	if (props.modTurbo) then
		ToggleVehicleMod(vehicle,  18, props.modTurbo)
	end

	if (props.modXenon) then
        ToggleVehicleMod(vehicle, 22, true)
        SetVehicleXenonLightsColour(vehicle, props.modXenon)
	end

	if (props.modFrontWheels) then
		SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
	end

	if (props.modBackWheels) then
		SetVehicleMod(vehicle, 24, props.modBackWheels, false)
	end

	if (props.modPlateHolder) then
		SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
	end

	if (props.modVanityPlate) then
		SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
	end

	if (props.modTrimA) then
		SetVehicleMod(vehicle, 27, props.modTrimA, false)
	end

	if (props.modOrnaments) then
		SetVehicleMod(vehicle, 28, props.modOrnaments, false)
	end

	if (props.modDashboard) then
		SetVehicleMod(vehicle, 29, props.modDashboard, false)
	end

	if (props.modDial) then
		SetVehicleMod(vehicle, 30, props.modDial, false)
	end

	if (props.modDoorSpeaker) then
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
	end

	if (props.modSeats) then
		SetVehicleMod(vehicle, 32, props.modSeats, false)
	end

	if (props.modSteeringWheel) then
		SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
	end

	if (props.modShifterLeavers) then
		SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
	end

	if (props.modAPlate) then
		SetVehicleMod(vehicle, 35, props.modAPlate, false)
	end

	if (props.modSpeakers) then
		SetVehicleMod(vehicle, 36, props.modSpeakers, false)
	end

	if (props.modTrunk) then
		SetVehicleMod(vehicle, 37, props.modTrunk, false)
	end

	if (props.modHydrolic) then
		SetVehicleMod(vehicle, 38, props.modHydrolic, false)
	end

	if (props.modEngineBlock) then
		SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
	end

	if (props.modAirFilter) then
		SetVehicleMod(vehicle, 40, props.modAirFilter, false)
	end

	if (props.modStruts) then
		SetVehicleMod(vehicle, 41, props.modStruts, false)
	end

	if (props.modArchCover) then
		SetVehicleMod(vehicle, 42, props.modArchCover, false)
	end

	if (props.modAerials) then
		SetVehicleMod(vehicle, 43, props.modAerials, false)
	end

	if (props.modTrimB) then
		SetVehicleMod(vehicle, 44, props.modTrimB, false)
	end

	if (props.modTank) then
		SetVehicleMod(vehicle, 45, props.modTank, false)
	end

	if (props.modWindows) then
		SetVehicleMod(vehicle, 46, props.modWindows, false)
	end

	if (props.modLivery) then
		SetVehicleMod(vehicle, 48, props.modLivery, false)
	end

	if (props.livery) then
		SetVehicleLivery(vehicle, props.livery)
	end	
	
end
--#################################################### V นำส่วนนี้ไปแทน ข้างบน  #####################################