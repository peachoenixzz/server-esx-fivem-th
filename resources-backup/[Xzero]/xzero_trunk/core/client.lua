--[[
	code generated using luamin.js, Herrtt#3868
--]]


--local a = nil;
--RegisEvent(true, events.cl["OnVerifyReceive"], function(b)
--	a = b
--end)
Citizen.CreateThread(function()
--	local c = GetGameTimer()
--	while a == nil and GetGameTimer() - c <= 30 * 1000 do
--		TriggerServerEvent(events.sv["OnVerifyRequest"])
--		Wait(300)
--	end;
	Init()
end)
ESX = nil;
local isLand = false
_InventoryHudInsObj = nil;
_InventoryHudInsObjScriptName = 'esx_inventoryhud'
xZero = {}
xZero.Events = {}
xZero.Threads = {}
xZero.Funcs = {}
xZero.C = {}
_Cache_Inventory = {}
_Cache_Weapons = {}
_storeInventoryData = {}
_storeInventoryDataReceiveCB = nil;
_C_Veh_Last = nil;
_DATA_VEH_Last = nil;
_Prograss = false;
_Debug_Enabled = false;
_openTrunkUpdateDelay = 15 * 1000;
local isSteal = false
Init = function()
	Wait(500)
--	if not a then
--		print('^1Verify:ERROR^7')
--		return
--	end;
	if not Config then
		pr('^1Error Config NotFound!^7')
		return
	end;
	ConfigBaseVaild()
	while ESX == nil do
		TriggerEvent(Config.Base.getSharedObject, function(d)
			ESX = d
		end)
		Wait(1)
	end;
	esxGetPlayerDataInit()
	CacheWeaponsInit()
	InventoryHudInsObjInit()
	if _InventoryHudInsObj == nil then
		return
	end;
	-- collectgarbage()
	print(('Inited - version_current:^3%s^7'):format(version_current))
	EventsInit()
end;
EventsInit = function()
	if Config.Key_OpenInventory then
		Citizen.CreateThread(function()
			while true do
				if IsControlJustPressed(0, Config.Key_OpenInventory) then
					TriggerEvent(events.cl["OnOpenInventory"])
					Wait(500)
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							event = 'OpenTrunk',
							content = ('ผู้เล่นได้ทำการกด H เปิดเมนูช่องเก็บของท้ายรถ'):format(),
						})
					end) -- End log
				end;
				Wait(5)
			end
		end)
	end;
	RegisEvent(false, events.cl["OnInventoryDataReloaded"], function(e, f, g)
		--print(e,f.plate,g)
		if not f then
			if e ~= nil then
				e(false)
			end
		end;
		local haveWeapon , Hash = GetCurrentPedWeapon(PlayerPedId(),true)
		local weaponHash = GetHashKey("WEAPON_CROWBAR")
		local canStealVehicle = false
		if not isSteal then
			if haveWeapon and (weaponHash == Hash) and exports.Dv_Hunter_Check:CheckPolice(4) then
				_C_Veh_Last.AlarmVehicle()
				TriggerEvent("Porpy_policealert:alertNet", "robvehicle")
				local result =  exports.storerobbery:miniGameLockPick(false)
				if result then
					canStealVehicle = true
					isSteal = true
					TriggerEvent("mythic_progbar:client:progress",{
						name = "ongoingopen",
						duration = 3000,
						label = "กำลังเปิดร้านค้า",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							dict = 'veh@break_in@0h@p_m_one@',
							anim = 'low_force_entry_ds',
							flag = 49
						},
					}, function(status)
						if not status then
							TSC(events.sv["OnInventoryDataRequestCB"], function(h) --SV:OnStoreInventoryDataRequestCB
								if not h and not canStealVehicle then
									if e ~= nil then
										e(false)
									end;
									return
								end;
								local i = {}
								local j = 0;
								local k = 0;
								local l, m = TrunkInventoryDataAdd(i, h['accounts'], "item_account")
								j = j + l;
								k = k + m;
								l, m = TrunkInventoryDataAdd(i, h['items'], "item_standard")
								j = j + l;
								k = k + m;
								l, m = TrunkInventoryDataAddWeapon(i, h['weapons'])
								j = j + l;
								k = k + m;
								k = funcs.getNumFormat(k)
								h = nil;
								local n = k * Config.Item_Info_Cal;
								local o = f.weight_max * Config.Item_Info_Cal;
								local p = {
									action = "setInfoText",
									header = Config.HeaderText,
									weight = n,
									limit = n,
									max = o,
									plate = CT['vehicle_textinfo_plate']:format(f.plate, j, f.slots_max > 0 and '/'..f.slots_max or ''),
									text = CT['vehicle_textinfo_text']:format(f.plate, f.weight_max > 0 and n..'/'..o or n, f.slots_max > 0 and j..'/'..f.slots_max or j)

								}
								_InventoryHudInsObj.Inventory_Setup_Second({
									itemList = i,
									setInfoText = p
								})
								_InventoryHudInsObj.Inventory_Setup_Player()
								if e ~= nil then
									e(true)
								end
							end, {
								plate = f.plate
							}, g)
						end
					end)
					return
				end
				if not result then
					TriggerEvent("Porpy_policealert:alertNet", "robvehicle")
					return
				end
			end
			if haveWeapon and (weaponHash == Hash) and not exports.Dv_Hunter_Check:CheckPolice(4) then
				exports.nc_notify:PushNotification({
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบงัดรถ', -- หัวเรื่อง
					description = 'ตำรวจไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'warning',
					color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'jail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})
				return
			end
		end
		if _DATA_VEH_Last == nil then
			local y = xZero.C.Veh(f,true)
			if not y.IsVaild(true) then
				return nil
			end;
			local u = y.Get_VCFG();
			local v = math.random(100, 500)
			_C_Veh_Last = y
			if _C_Veh_Last == nil then
				_Prograss = false
				return
			end
			if _Prograss then
				_Prograss = false
				return
			end
			if _Prograss and _C_Veh_Last == nil then
				_Prograss = false
				return
			end
			_Prograss = true;
			--NotifyOpenInvFunc(v)
			Wait(v)
			f = {
				plate = u.plate,
				slots_max = u.slots_max,
				weight_max = u.weight_max,
				class_name = u.class_name,
				displayname = u.displayname,
				model = u.model,
				VHASH = ('%s-%s-%s-%s'):format(u.plate, u.class_name, u.displayname, u.model)
			}
			_DATA_VEH_Last = f
			isLand = true
		end
		TSC(events.sv["OnInventoryDataRequestCB"], function(h)
			if not h  then
				if e ~= nil then
					e(false)
				end;
				return
			end;
			local i = {}
			local j = 0;
			local k = 0;
			local l, m = TrunkInventoryDataAdd(i, h['accounts'], "item_account")
			j = j + l;
			k = k + m;
			l, m = TrunkInventoryDataAdd(i, h['items'], "item_standard")
			j = j + l;
			k = k + m;
			l, m = TrunkInventoryDataAddWeapon(i, h['weapons'])
			j = j + l;
			k = k + m;
			k = funcs.getNumFormat(k)
			h = nil;
			local n = k * Config.Item_Info_Cal;
			local o = f.weight_max * Config.Item_Info_Cal;
			local p = {
				action = "setInfoText",
				header = Config.HeaderText,
				weight = n,
				limit = n,
				max = o,
				plate = CT['vehicle_textinfo_plate']:format(f.plate, j, f.slots_max > 0 and '/'..f.slots_max or ''),
				text = CT['vehicle_textinfo_text']:format(f.plate, f.weight_max > 0 and n..'/'..o or n, f.slots_max > 0 and j..'/'..f.slots_max or j)

			}
			_InventoryHudInsObj.Inventory_Setup_Second({
				itemList = i,
				setInfoText = p
			})
			_InventoryHudInsObj.Inventory_Setup_Player()
			if isLand then
				_InventoryHudInsObj.Inventory_Open('trunk')
				_Prograss = false
			end
			if e ~= nil then
				e(true)
			end
		end, {
			plate = f.plate
		}, g)
		RegisEvent(false, events.cl["OnPut"], function(q)
			if not xZero.Funcs.Vehicle_Vaild_OT() then
				pcall(function() exports.nc_inventory:CloseInventory() end)
				_InventoryHudInsObj.Inventory_Close()
				return
			end;

			if  IsPedInAnyVehicle(PlayerPedId(), false)  then
				pcall(function() exports.nc_inventory:CloseInventory() end)
				return
			end
			if q and q.item and type(q.number) == 'number' then
				if _Prograss then
					return
				end;
				_Prograss = true;
				local r = q.item;
				if r.type == 'item_money' then
					r.name = 'money'
					r.type = 'item_account'
				end;
				if r.type == 'item_weapon' or (r.type == 'item_standard' or r.type == 'item_account' or r.type == 'item_money') and r.count >= q.number then
					print(json.encode(r))
					if not _C_Veh_Last.VCFG.Check_Item_BlackList(r.name)  then
						onItemCannotStore()
						_Prograss = false;
						return
					end;
					if Config.Vehicle_OpenTrunkMax == -1 or Config.Vehicle_OpenTrunkMax > 1 then
						Wait(math.random(100, 500))
					end;
					TriggerServerEvent(events.sv["OnPut"], _DATA_VEH_Last, {
						item = q.item,
						count = q.number
					})
					if Config.Anim then
						local s = Config.Anim['Put']
						if s and s.Enabled then
							PlayTaskAnim(s.Anim_Dict, s.Anim_Name)
						end
					end;
					Wait(250)
					TriggerEvent(events.cl["OnInventoryDataReloaded"], function()

					end, _DATA_VEH_Last, true)
				else
					--NotifyT("item_invaild_count", nil, "error")
				end;
				_Prograss = false
			end
		end)
		RegisEvent(false, events.cl["OnTake"], function(q)
			if not xZero.Funcs.Vehicle_Vaild_OT() then
				_InventoryHudInsObj.Inventory_Close()
				pcall(function() exports.nc_inventory:CloseInventory() end)
				return
			end;
			if  IsPedInAnyVehicle(PlayerPedId(), false)  then
				pcall(function() exports.nc_inventory:CloseInventory() end)
				return
			end
			if q and q.item and type(q.number) == "number" then
				if _Prograss then
					return
				end;
				_Prograss = true;
				if Config.Vehicle_OpenTrunkMax == -1 or Config.Vehicle_OpenTrunkMax > 1 then
					Wait(math.random(100, 500))
				end;
				TriggerServerEvent(events.sv["OnTake"], _DATA_VEH_Last, {
					item = q.item,
					count = q.number
				})
				if Config.Anim then
					local s = Config.Anim['TakeFrom']
					if s and s.Enabled then
						PlayTaskAnim(s.Anim_Dict, s.Anim_Name)
					end
				end;
				Wait(250)
				TriggerEvent(events.cl["OnInventoryDataReloaded"], function()
				end, _DATA_VEH_Last, true)
				_Prograss = false
			end
		end)
		RegisEvent(false, events.cl["OnInventoryClose"], function()
			if _C_Veh_Last then
				if Config.Vehicle_OpenTrunkMax and Config.Vehicle_OpenTrunkMax > 0 and _DATA_VEH_Last then
					TriggerServerEvent(events.sv["OnTrunkInventoryClose"], _DATA_VEH_Last.plate)
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							event = 'CloseTrunk',
							content = ('ผู้เล่นได้ทำการปิดเมนูช่องเก็บของท้ายรถ'):format(),
						})
					end) -- End log
				end;
				if not isLand then
					_C_Veh_Last.DoorOpenTrunk(false)
				end
				pcall(function() exports.nc_inventory:CloseInventory() end)
				_C_Veh_Last = nil;
				_DATA_VEH_Last = nil
				isSteal = false
				isLand = false
			end
		end)
		if Config.Vehicle_OpenTrunkMax and Config.Vehicle_OpenTrunkMax > 0 then
			Citizen.CreateThread(function()
				while true do
					Wait(_openTrunkUpdateDelay)
					if IsInventoryOpen() and xZero.Funcs.Vehicle_Vaild_OT() and _DATA_VEH_Last then
						TriggerServerEvent(events.sv["OnTrunkInventoryOpen"], _DATA_VEH_Last.plate)
					end
				end
			end)
		end;
		if Config.Debug_Vehicle_Info then
			xZero.VehicleDebugInfoInit()
		end
	end)
end
xZero.Events.On_OpenInventory = function()
	local t = PlayerPedId()
	if not IsEntityDead(t) then
		_C_Veh_Last = xZero.Funcs.VehicleFind()
		if _C_Veh_Last and xZero.Funcs.Vehicle_Vaild(_C_Veh_Last) then
			if _C_Veh_Last == nil then
				_Prograss = false
				return
			end
			if _Prograss then
				_Prograss = false
				return
			end
			if _Prograss and _C_Veh_Last == nil then
				_Prograss = false
				return
			end
			_Prograss = true;
			local u = _C_Veh_Last.VCFG;
			local v = math.random(100, 500)
			--NotifyOpenInvFunc(v)
			Wait(v)
			_DATA_VEH_Last = {
				plate = _C_Veh_Last.plate,
				slots_max = u.slots_max,
				weight_max = u.weight_max,
				class_name = _C_Veh_Last.class_name,
				displayname = _C_Veh_Last.displayname,
				model = _C_Veh_Last.model,
				VHASH = ('%s-%s-%s-%s'):format(_C_Veh_Last.plate, _C_Veh_Last.class_name, _C_Veh_Last.displayname, _C_Veh_Last.model)
			}
			TriggerEvent(events.cl["OnInventoryDataReloaded"], function(w)
				if w then
					_InventoryHudInsObj.Inventory_Open('trunk')
					_C_Veh_Last.DoorOpenTrunk(true)
				else
					_C_Veh_Last = nil;
					_DATA_VEH_Last = nil
				end;
				Wait(500)
				_Prograss = false
			end, _DATA_VEH_Last)
		end
	end
end;
RegisEvent(true, events.cl["OnOpenInventory"], xZero.Events.On_OpenInventory)
xZero.Funcs.VehicleFind = function()
	local t = PlayerPedId()
	local x = nil;
	local y = nil;
	if IsPedInAnyVehicle(t, false) then
		x = GetVehiclePedIsIn(t, false)
		y = xZero.C.Veh(x)
		if not y.IsVaild() then
			return nil
		end;
		if not Config.Vehicle_IsIn then
			--NotifyT("vehicle_isin_error", {
			--	y.plate
			--}, "error")
			return nil
		end
	else
		if Config.Vehicle_IsInOnly and not IsPedInAnyVehicle(t, false) then
			--NotifyT("vehicle_isinonly_error", nil, "error")
			return nil
		end;
		local z = GetEntityCoords(t)
		local A = GetOffsetFromEntityInWorldCoords(t, 0.0, 4.0, 0.0)
		local B = CastRayPointToPoint(z.x, z.y, z.z, A.x, A.y, A.z, 3, t, 0)
		local C, D, E, F, G = GetRaycastResult(B)
		x = G;
		if not DoesEntityExist(x) or x <= 0 then
			local H, I = ESX.Game.GetClosestVehicle()
			if H and H > 0 and I <= 1.8 then
				x = H
			end
		end;
		y = xZero.C.Veh(x)
		if not y.IsVaild() then
			return nil
		end
	end;
	return y
end;
--xZero.Funcs.VehicleDetail = function(vehEntity)
--	local y = xZero.C.Veh(vehEntity,true)
--	return y
--end;
xZero.Funcs.Vehicle_Vaild = function(J)
	local t = PlayerPedId()
	local haveWeapon , Hash = GetCurrentPedWeapon(t,true)
	local weaponHash = GetHashKey("WEAPON_CROWBAR")
	local canStealVehicle = false
	if haveWeapon and (weaponHash == Hash) then
		print("have crownbar")
		canStealVehicle = true
	end
	if Config.Vehicle_IsIn_DriverOnly then
		local K = J.Get_PedInSeat(-1)
		if K and K ~= t then
			--NotifyT("vehicle_isin_driveronly_error", {
			--	J.plate
			--}, "error")
			return false
		end
	end;
	local L = VJob(ESX.GetPlayerData().job.name)
	local M = false;
	if L.Vaild then
		M = L.Locked_Allow()
	end;
	if (J.Get_IsLocked() and not M) and not canStealVehicle then
		onVehicleLock()
		return false
	end;
	local N = #(GetEntityCoords(t) - J.Get_Coords())
	if N > Config.Vehicle_Distance then
		onVehicleTooFar()
		return false
	end;
	local O = false;
	if not Config.Vehicle_IsIn_PedAny then
		local P = J.Get_Passengers()
		if P > 0 then
			for Q = -1, P - 1 do
				local R = J.Get_PedInSeat(Q)
				if R and R ~= t then
					O = true;
					break
				end
			end
		else
			local R = J.Get_PedInSeat(-1)
			if R and R ~= t then
				O = true
			end
		end
	end;
	if O then
		--NotifyT("vehicle_isin_pedany_error", {
		--	J.plate
		--}, "error")
		return false
	end;
	local S = {
		["Vehicle_BlackList_Class"] = {
			J.class_name
		},
		["Vehicle_BlackList_NameAndModel"] = {
			J.displayname,
			tostring(J.model)
		},
		["Vehicle_BlackList_Plate"] = {
			J.plate
		}
	}
	for T, U in pairs(S) do
		if xZero.Funcs.Vehicle_BL(T, U) then
			onVehicleNoTrunk()
			return false
		end
	end;
	local u = J.Get_VCFG()
	if u.slots_max == 0 then
		--NotifyT("vehicle_slots_error", {
		--	J.plate
		--}, "error")
		return false
	end;
	if u.weight_max == 0 then
		onVehicleNoTrunk()
		return false
	end;
	local V = ESX.GetPlayerData().job;
	if not u.Check_Job(V.name) then
		--NotifyT("vehicle_job_error", {
		--	J.plate
		--}, "error")
		return false
	end;
	return true
end;
xZero.Funcs.Vehicle_BL = function(T, W)
	local X = Config[T] and #Config[T] or 0;
	if X > 0 then
		for Y = 1, X do
			local G = Config[T][Y]
			for Z, _ in ipairs(W) do
				if G:lower() == _:lower() then
					return true
				end
			end
		end
	end;
	return false
end;
xZero.Funcs.Vehicle_Vaild_OT = function() --validate vehicle
	local t = PlayerPedId()
	if isLand then
		return true
	end
	if IsEntityDead(t) or _C_Veh_Last == nil or not _C_Veh_Last.IsVaild() or not funcs.DATA_VEH_Vaild(_DATA_VEH_Last) then
		return false
	end;
	if #(GetEntityCoords(t) - _C_Veh_Last.Get_Coords()) > Config.Vehicle_Distance * 1.5 then
		return false
	end;
	return true
end;
xZero.VehicleDebugInfoInit = function()
	local a0 = true;
	local a1 = nil;
	RegisterCommand('vehinfo', function(a2, a3)
		_Debug_Enabled = not _Debug_Enabled;
		Notify(('Debug Vehicle Info - %s'):format(_Debug_Enabled), _Debug_Enabled and 'success' or 'error')
	end, false)
	Citizen.CreateThread(function()
		while true do
			Wait(1500)
			if _Debug_Enabled then
				local t = PlayerPedId()
				local x = GetVehiclePedIsIn(t, false)
				if not IsEntityDead(t) and DoesEntityExist(x) then
					local a4 = xZero.C.Veh(x)
					a4.IsVaild()
					a1 = {
						plate = a4.plate,
						class_name = a4.class_name:lower(),
						displayname = a4.displayname:lower(),
						model = tostring(a4.model)
					}
					a0 = true
				else
					a0 = false;
					a1 = nil
				end
			end
		end
	end)
	Citizen.CreateThread(function()
		while true do
			Wait(1)
			if _Debug_Enabled and a0 and a1 then
				xZero.Funcs.DrawText(('Plate: ~y~%s~s~ \n Class Name: ~y~%s~s~ \n DisplayName: ~y~%s~s~ \n Model: ~y~%s~s~'):format(a1.plate, a1.class_name, a1.displayname, a1.model), 0.4, 0.5, 0.5)
			else
				Wait(1500)
			end
		end
	end)
end;
xZero.C.Veh = function(x)
	local self = {}
	self.vehicle = x;
	self.Vaild = false;
	self.plate = nil;
	self.class = nil;
	self.class_name = nil;
	self.displayname = nil;
	self.model = nil;
	self.VCFG = nil;
	self.IsVaild = function(isOnLand)
		isOnLand = isOnLand or false
		if not isOnLand then
			if not self.vehicle or not DoesEntityExist(self.vehicle) or not self.Get_Plate() or not self.Get_DisplayName() or not self.Get_Class()  then
				self.Vaild = false;
				return false
			end;
		end;
		if isOnLand then
			if not self.vehicle or not self.Get_Plate(true) or not self.Get_DisplayName(true) or not self.Get_Class(true)  then
				self.Vaild = false;
				return false
			end;
		end
		self.Vaild = true;
		return true
	end;
	self.Get_Plate = function(isOnLand)
		if isOnLand then
			self.plate = ESX.Math.Trim(self.vehicle.plate) or nil;
			--print(self.plate)
			return self.plate
		end
		self.plate = ESX.Math.Trim(GetVehicleNumberPlateText(self.vehicle)) or nil;
		return self.plate
	end;
	self.Get_Class = function(isOnLand)
		if isOnLand then
			self.class = GetVehicleClassFromName(self.vehicle.model) or -1;
			self.class_name = Config.Vehicle_CL[self.class] or nil;
			--print(self.class_name)
			return self.class_name
		end
		self.class = GetVehicleClass(self.vehicle) or -1;
		self.class_name = Config.Vehicle_CL[self.class] or nil;
		return self.class_name
	end;
	self.Get_Model = function()
		self.model = GetEntityModel(self.vehicle) or nil;
		return self.model
	end;
	self.Get_DisplayName = function(isOnLand)
		if isOnLand then
			self.displayname = ESX.Math.Trim(GetDisplayNameFromVehicleModel(self.vehicle.model)) or nil;
			--print(self.displayname)
			return self.displayname
		end
		if self.model == nil then
			self.Get_Model()
		end;
		self.displayname = ESX.Math.Trim(GetDisplayNameFromVehicleModel(self.model)) or nil;
		return self.displayname
	end;
	self.Get_Coords = function()
		return GetEntityCoords(self.vehicle)
	end;
	self.Get_IsLocked = function()
		local a5 = GetVehicleDoorLockStatus(self.vehicle) or nil;
		return a5 ~= nil and a5 >= 2 and true or false
	end;
	self.DoorOpenTrunk = function(a6)
		if a6 then
			SetVehicleDoorOpen(self.vehicle, 5, false, false)
		else
			SetVehicleDoorShut(self.vehicle, 5, false)
		end
	end;
	self.AlarmVehicle = function()
		SetVehicleAlarmTimeLeft(self.vehicle, 1000 * 60 * 5)
	end
	self.Get_Passengers = function()
		return GetVehicleMaxNumberOfPassengers(self.vehicle) or 0
	end;
	self.Get_PedInSeat = function(a7)
		local a8 = GetPedInVehicleSeat(self.vehicle, a7) or nil;
		return a8 ~= nil and a8 > 0 and a8 or nil
	end;
	self.Get_VCFG = function()
		if self.Vaild then
			self.VCFG = C_VCFG(self.plate, self.class_name:lower(), self.displayname:lower(), tostring(self.model))
			return self.VCFG
		end;
		self.VCFG = nil;
		return self.VCFG
	end;
	return self
end;
function PlayTaskAnim(a9, aa)
	ESX.Streaming.RequestAnimDict(a9, function()
		TaskPlayAnim(PlayerPedId(), a9, aa, 8.0, 2.0, -1, 48, 2, 0, 0, 0)
	end)
end;
xZero.Funcs.DrawText = function(ab, ac, ad, ae)
	SetTextFont(0)
	SetTextScale(ac, ac)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(ab)
	DrawText(ad, ae)
end;
Notify = function(ab, type, af)
	type = type and type or 'info'
	af = af and af or 2000;
	if Config.notifyFunc then
		Config.notifyFunc(ab, type, af)
		return
	end;
	TriggerEvent("pNotify:SendNotification", {
		text = ab,
		type = type,
		queue = script_name,
		timeout = af,
		layout = layout
	})
end;
RegisEvent(true, events.cl["OnNotify"], Notify)
NotifyOpenInvFunc = function(ag)
	if Config.notifyOpenInvFunc then
		Config.notifyOpenInvFunc(ag)
		return
	end;
	Notify("กรุณารอสักครู่...", "info", ag)
end;
NotifyT = function(ah, ai, aj, ag)
	local ak = CT[ah] or nil;
	if ak then
	end;
	if ak ~= nil then
		Notify(ak:format(table.unpack(ai or {})), aj, ag)
	end
end;
TrunkInventoryDataAdd = function(al, am, an)
	local l = 0;
	local m = 0;
	if am and al then
		local ao = #al;
		for ap, aq in pairs(am) do
			if aq > 0 then
				ao = ao + 1;
				l = l + 1;
				m = m + aq * getItemInfoWeight(ap)
				al[ao] = {
					name = ap,
					count = aq,
					label = getItemLabel[an](ap),
					type = an,
					usable = false,
					rare = false,
					weight = -1,
					limit = -1,
					canRemove = false
				}
			end
		end
	end;
	return l, m
end;
TrunkInventoryDataAddWeapon = function(al, am)
	local l = 0;
	local m = 0;
	if am and al then
		local ao = #al;
		for ar, as in pairs(am) do
			ao = ao + 1;
			l = l + 1;
			m = m + getItemInfoWeight(as.name)
			al[ao] = {
				name = as.name,
				count = as.ammo,
				label = getItemLabel["item_weapon"](as.name),
				type = "item_weapon",
				usable = false,
				rare = false,
				weight = -1,
				limit = -1,
				canRemove = false,
				wKey = ar
			}
		end
	end;
	return l, m
end;
esxGetPlayerDataInit = function()
	while true do
		local at = ESX.GetPlayerData() or nil;
		if at and at.inventory and #at.inventory > 0 then
			break
		end;
		Wait(1)
	end;
	local au = ESX.GetPlayerData().inventory;
	for Y = 1, #au do
		local G = au[Y]
		_Cache_Inventory[G.name] = G
	end;
	au = nil
end;
CacheWeaponsInit = function()
	local av = ESX.GetWeaponList()
	local aw = av and #av or 0;
	if aw > 0 then
		for Y = 1, aw do
			local G = av[Y]
			_Cache_Weapons[G.name] = G.label
		end
	end
end;
InventoryHudInsObjInit = function()
	local ax = GetGameTimer()
	while _InventoryHudInsObj == nil and GetGameTimer() - ax <= 10 * 1000 do
		TriggerEvent(_InventoryHudInsObjScriptName..":CL:GetInstanceObject", function(ay)
			_InventoryHudInsObj = ay
		end)
		Wait(100)
	end;
	if _InventoryHudInsObj == nil then
		print('^1ERROR:InventoryHud Get Instance Object^7')
	end;
	RegisEvent(false, events.cl["OnInventoryHudInsObjReceive"], function(ay)
		if ay ~= nil then
			_InventoryHudInsObj = ay
		end
	end)
end;
getItemLabel = {
	['item_account'] = function(az)
		return CT[az] or nil
	end,
	['item_standard'] = function(az)
		return _Cache_Inventory[az].label
	end,
	['item_weapon'] = function(az)
		return _Cache_Weapons[az] or nil
	end
}
IsInventoryOpen = function()
	return _InventoryHudInsObj and _InventoryHudInsObj.Inventory_IsIn() and true or false
end;
_TSC = {}
_TSC.CurrentReqId = 0;
_TSC.Callbacks = {}
TSC = function(az, aA, ...)
	_TSC.Callbacks[_TSC.CurrentReqId] = aA;
	TriggerServerEvent(events.sv["TSC_Request"], az, _TSC.CurrentReqId, ...)
	_TSC.CurrentReqId = _TSC.CurrentReqId + 1
end;
RegisEvent(true, events.cl["TSC_Receive"], function(aB, ...)
	_TSC.Callbacks[aB](...)
	_TSC.Callbacks[aB] = nil
end)


function onItemCannotStore()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบเปิดท้ายรถ', -- หัวเรื่อง
		description = 'ไอเทมไม่สามารถเก็บได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end	


function onVehicleLock()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบเปิดท้ายรถ', -- หัวเรื่อง
		description = 'รถคันนี้ถูกล็อด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'lock', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end


function onVehicleTooFar()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบเปิดท้ายรถ', -- หัวเรื่อง
		description = 'คุณอยู่ห่างจากรถเกินไป', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end


function onVehicleNoTrunk()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบเปิดท้ายรถ', -- หัวเรื่อง
		description = 'รถคันนี้เปิดท้ายรถไม่ได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_vehicle', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end