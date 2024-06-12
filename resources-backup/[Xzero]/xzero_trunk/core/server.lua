
Citizen.CreateThread(function()
	Init()
end)
--RegisEvent(true, events.sv["OnVerifyRequest"], function()
--	TriggerClientEvent(events.cl["OnVerifyReceive"], source, a)
--end)
ESX = nil;
MySQL_Init = false;
xZero = {}
xZero.Funcs = {}
xZero.C = {}
Store = {}
StoreOwnerVehicles = {}
VCFG_DATA = {}
_timeOutSaveDBdefault = 5 * 1000;
_openTrunkCheckTime = 15 * 1000;
Init = function()
	Wait(500)
--[[
	if not a then
		return
	end;
	if not Config then
		pr('^1Error Config NotFound!^7')
		return
	end;
	ConfigBaseVaild()
]]
	while ESX == nil do
		TriggerEvent(Config.Base.getSharedObject, function(k)
			ESX = k
		end)
		Wait(1)
	end;
	MySQL.ready(function()
		MySQL_Init = true
	end)
	while MySQL_Init == false do
		Wait(1)
	end;
	VersionInit()
	StoreInit()
	EventsInit()
end;
StoreInit = function()
	-- xZero.Funcs.Store_ClearEmptyDataFromDB()
	-- xZero.Funcs.Store_ClearNPCFromDB()
	xZero.Funcs.Store_LoadedFromDB()
end;
EventsInit = function()
	RSC(events.sv["OnInventoryDataRequestCB"], function(l, m, n, o)
		local p = ESX.GetPlayerFromId(l)
		local job = p.getJob()
		if not p or not n or not n.plate then
			m(false)
			return
		end;
		local q = p.getIdentifier()
		xZero.Funcs.OwnerVehicles_GetByPlate(function(r)
			local s = r ~= nil and true or false;
			if Config.Vehicle_NPC_Disabled and not s then
				--NotifyT(l, "vehicle_npc_disabled_error", {
				--	n.plate
				--}, "error")
				m(false)
				return
			end;
			if Config.Vehicle_OwnerOnly and s and r ~= q and job.name ~= "police"  then
				local t = VJob(p.getJob().name)
				local canStealVehicle = false
				if GetSelectedPedWeapon(GetPlayerPed(p.source)) == -2067956739 then
					canStealVehicle = true
				end
				if not(t.Vaild and t.OwnerOnly_Allow()) and not canStealVehicle then
					print("callback police")
					onVehicleNotOwn(source)
					m(false)
					return
				end
			end;
			local u = xZero.Funcs.Store_GetByPlate(n.plate, s, r)
			local v = s and 1 or 0;
			if u.isOwner ~= v then
				u.isOwner = v;
				u.DB_Save = true;
				u.SaveAll()
			end;
			if Config.Vehicle_OpenTrunkMax and Config.Vehicle_OpenTrunkMax > 0 and not o then
				if not u.OpenTrunk_Check(Config.Vehicle_OpenTrunkMax) then
					--NotifyT(l, "vehicle_opentrunkmax_error", {
					--	u.plate,
					--	#u.OpenTrunk_PlayerList,
					--	Config.Vehicle_OpenTrunkMax
					--}, "error")
					print("callback open trunk")
					m(false)
					return
				end;
				xZero.Funcs.OpenTrunk_Update(q, u.plate)
			end;
			m(u.InventoryData)
		end, n.plate)
	end)
	RegisEvent(true, events.sv["OnPut"], function(w, x)
		local l = source;
		local p = ESX.GetPlayerFromId(l)
		if not p or not funcs.DATA_VEH_Vaild(w) or not x then
			return
		end;
		local u = Store[w.plate] or nil;
		if not u or not u.IsVaild() then
			pr(('^1ERROR Store Invaild | %s | %s^7'):format(p.getIdentifier(), w.plate))
			return
		end;
		local y = xZero.Funcs.VCFG_Get(w)
		if not y then
			return
		end;
		if u.Prograss then
			return
		end;
		u.Prograss = true;
		local z, A = x.item, x.count;
		local B, C, D = u.getNewCountSlotsWeight("PUT", z, A)
		local E = y.getItemLimit(z.name)
		if E ~= -1 and B > E then
			--NotifyT(l, "limit_error", nil, "error")
			u.Prograss = false;
			return
		end;
		if y.slots_max ~= -1 and C > y.slots_max then
			--NotifyT(l, "slots_error", nil, "error")
			u.Prograss = false;
			return
		end;
		if y.weight_max ~= -1 and D > y.weight_max then
			onVehicleInventoryFull(source)
			u.Prograss = false;
			return
		end;
		local F = false;
		local G = nil;
		if z.type == 'item_standard' then
			local H = p.getInventoryItem(z.name) or nil;
			if A > 0 and H and H.count >= A then
				u.Items_Add(z.name, A)
				p.removeInventoryItem(z.name, A)
				G = {
					item_name = z.name,
					item_label = z.label,
					count = A,
					DC_TYPE = 'item'
				}
				F = true
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'PutItemInTrunk',
						content = ('%s ได้นำ %s จำนวน %s ชิ้น เก็บเข้าช่องเก็บของท้ายรถทะเบียน %s'):format(p.name, z.name, A, w.plate),
						source = p.source,
					 })
				 end) -- End log
			else
				--NotifyT(l, "item_invaild_count", nil, "error")
			end
		elseif z.type == 'item_account' then
			local I = xZero.C.PlayerAccounts(p)
			if I.Get(z.name) >= A then
				u.Accounts_Add(z.name, A)
				I.Remove(z.name, A)
				G = {
					item_name = z.name,
					item_label = z.label,
					count = A,
					DC_TYPE = 'account'
				}
				F = true
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'PutMoneyInTrunk',
						content = ('%s ได้นำ %s จำนวน $%s เก็บเข้าช่องเก็บของท้ายรถทะเบียน %s'):format(p.name, z.name, A, w.plate),
						source = p.source,
					 })
				 end) -- End log
			else
				--NotifyT(l, "item_invaild_count", nil, "error")
			end
		elseif z.type == 'item_weapon' then
			local J, K = p.getWeapon(z.name)
			if K then
				u.Weapons_Add(K.name, K.ammo, K.components)
				p.removeWeapon(K.name)
				G = {
					item_name = z.name,
					item_label = z.label,
					count = K.ammo,
					DC_TYPE = 'weapon'
				}
				F = true
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'PutWeaponInTrunk',
						content = ('%s ได้นำ %s กระสุนจำนวน %s เก็บเข้าช่องเก็บของท้ายรถทะเบียน %s'):format(p.name, K.name, K.ammo, w.plate),
						source = p.source,
					 })
				 end) -- End log
			else
				--NotifyT(l, "item_invaild_count", nil, "error")
			end
		end;
		if F then
			u.slotsCurrent = C;
			u.weightCurrent = D;
			if G and DC_CFG_Vaild(G.DC_TYPE, 'Put') then
				local L = Config.DC[G.DC_TYPE]['Put']
				DC_Log(p, w, u.Owner_Iden, G['item_name'], G['item_label'], G['count'], {
					URL_Webhook = L.URL_Webhook,
					color = L.Template.color,
					title = L.Template.title,
					description = L.Template.description
				})
			end
		end;
		u.Prograss = false
	end)
	RegisEvent(true, events.sv["OnTake"], function(w, x)
		local l = source;
		local p = ESX.GetPlayerFromId(l)
		if not p or not funcs.DATA_VEH_Vaild(w) or not x then
			return
		end;
		local u = Store[w.plate] or nil;
		if not u or not u.IsVaild() then
			pr(('^1ERROR Store Invaild | %s | %s^7'):format(p.getIdentifier(), w.plate))
			return
		end;
		if u.Prograss then
			return
		end;
		u.Prograss = true;
		local z, A = x.item, x.count;
		local B, C, D = u.getNewCountSlotsWeight("TAKE", z, A)
		local M = false;
		local G = nil;
		if z.type == 'item_standard' then
			local N = u.Items_Get(z.name)
			local H = p.getInventoryItem(z.name) or nil;
			if H and A ~= nil and A > 0 and N >= A then
				if H.limit == nil or H.limit == -1 or A + H.count <= H.limit then
					if not Config.UseCarryItem or p["canCarryItem"] == nil or p.canCarryItem(z.name, A) then
						u.Items_Remove(z.name, A)
						p.addInventoryItem(z.name, A)
						G = {
							item_name = z.name,
							item_label = z.label,
							count = A,
							DC_TYPE = 'item'
						}
						M = true
						pcall(function() -- Start log
							exports['azael_dc-serverlogs']:insertData({
								event = 'TakeItemFromTrunk',
								content = ('%s ได้นำ %s จำนวน %s ชิ้น ออกจากท้ายรถทะเบียน %s เข้ากระเป๋า'):format(p.name, z.name, A, w.plate),
								source = p.source,
							 })
						end) -- End log
					else
						onVehicleInventoryFull(source)
					end
				else
					--NotifyT(l, "limit_error", nil, "error")
				end
			else
				--NotifyT(l, "item_invaild_count", nil, "error")
			end
		elseif z.type == 'item_account' then
			local O = u.Accounts_Get(z.name)
			if A ~= nil and A > 0 and O >= A then
				u.Accounts_Remove(z.name, A)
				xZero.C.PlayerAccounts(p).Add(z.name, A)
				G = {
					item_name = z.name,
					item_label = z.label,
					count = A,
					DC_TYPE = 'account'
				}
				M = true
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'TakeMoneyFromTrunk',
						content = ('%s ได้นำ %s จำนวน $%s ออกจากท้ายรถทะเบียน %s เข้ากระเป๋า'):format(p.name, z.name, A, w.plate),
						source = p.source,
					 })
				end) -- End log
			else
				--NotifyT(l, "item_invaild_count", nil, "error")
			end
		elseif z.type == 'item_weapon' and z.wKey then
			local P = u.Weapons_Get(z.wKey)
			if P then
				if not p.hasWeapon(P.name) then
					local Q = P.ammo;
					p.addWeapon(P.name, Q)
					if P.components and #P.components > 0 then
						for R, S in ipairs(P.components) do
							p.addWeaponComponent(P.name, S)
						end
					end;
					u.Weapons_Remove(z.wKey)
					G = {
						item_name = z.name,
						item_label = z.label,
						count = Q,
						DC_TYPE = 'weapon'
					}
					M = true
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							event = 'TakeWeaponFromTrunk',
							content = ('%s ได้นำ %s กระสุนจำนวน %s ออกจากท้ายรถทะเบียน %s เข้ากระเป๋า'):format(p.name, P.name, Q, w.plate),
							source = p.source,
						 })
					end) -- End log
				else
					--NotifyT(l, "item_hasweapon_error", nil, "error")
				end
			else
				--NotifyT(l, "item_invaild_count", nil, "error")
			end
		end;
		if M then
			u.slotsCurrent = C;
			u.weightCurrent = D;
			if G and DC_CFG_Vaild(G.DC_TYPE, 'Take') then
				local L = Config.DC[G.DC_TYPE].Take;
				DC_Log(p, w, u.Owner_Iden, G['item_name'], G['item_label'], G['count'], {
					URL_Webhook = L.URL_Webhook,
					color = L.Template.color,
					title = L.Template.title,
					description = L.Template.description
				})
			end
		end;
		u.Prograss = false
	end)
	RegisEvent(true, events.sv["OnTrunkInventoryOpen"], function(T)
		if Config.Vehicle_OpenTrunkMax and Config.Vehicle_OpenTrunkMax > 0 then
			local p = ESX.GetPlayerFromId(source)
			if p and T then
				xZero.Funcs.OpenTrunk_Update(p.getIdentifier(), T)
			end
		end
	end)
	RegisEvent(true, events.sv["OnTrunkInventoryClose"], function(T)
		if Config.Vehicle_OpenTrunkMax and Config.Vehicle_OpenTrunkMax > 0 then
			local p = ESX.GetPlayerFromId(source)
			if p and T then
				xZero.Funcs.OpenTrunk_Close(p.getIdentifier(), T)
			end
		end
	end)
end;
-- xZero.Funcs.Store_ClearEmptyDataFromDB = function()
-- 	local U = MySQL.Sync.execute(([[
--         DELETE FROM %s WHERE (accounts = '[]' or accounts = '{}') AND (items = '[]' or items = '{}') AND (weapons = '[]' or weapons = '{}')
--     ]]):format(Config.Store_Table_Name))
-- 	collectgarbage()
-- 	pr(("Store Empty Clear - ^1%s^7"):format(U))
-- end;
-- xZero.Funcs.Store_ClearNPCFromDB = function()
-- 	if Config.Vehicle_NPC and Config.Vehicle_NPC.DB_Clear_Hour > 0 then
-- 		local U = MySQL.Sync.execute(([[
--             DELETE FROM %s WHERE is_owner = 0 AND time_last_update <= date_sub(now(), interval @hour hour)
--         ]]):format(Config.Store_Table_Name), {
-- 			['@hour'] = Config.Vehicle_NPC.DB_Clear_Hour
-- 		})
-- 		collectgarbage()
-- 		pr(('Store NPC Clear - ^1%s^7'):format(U))
-- 	end
-- end;
xZero.Funcs.Store_LoadedFromDB = function()
	local V = 0;
	local W = MySQL.Sync.fetchAll(('SELECT * FROM %s'):format(Config.Store_Table_Name))
	local X = W and #W or 0;
	if X > 0 then
		Store = {}
		for Y = 1, X do
			local Z = W[Y]
			local _ = xZero.C.Store(Z.plate)
			_.isOwner = Z.is_owner;
			_.time_last_update = math.ceil(Z.time_last_update / 1000)
			_.InventoryData['accounts'] = json.decode(Z.accounts)
			_.InventoryData['items'] = json.decode(Z.items)
			_.InventoryData['weapons'] = json.decode(Z.weapons)
			_.InDB = true;
			_.DB_Save = true;
			Store[Z.plate] = _;
			V = V + 1
		end;
		W = nil
	end;
	 collectgarbage()
	pr(('Store Loaded - ^3%s^7'):format(V))
end;
xZero.Funcs.OwnerVehicles_GetByPlate = function(a0, T)
	local a1 = StoreOwnerVehicles[T] or nil;
	if a1 and not a1.TimeUpdateCheck(Config.Owner_Vehicles_TimeCheckUpdate) then
		a0(a1.Owner_Iden)
	else
		xZero.Funcs.OwnerVehicles_GetByPlateFromDB(function(a2)
			a0(a2)
		end, T)
	end
end;
xZero.Funcs.OwnerVehicles_GetByPlateFromDB = function(a0, T)
	MySQL.Async.fetchAll(('SELECT owner FROM %s WHERE plate = @plate'):format(Config.Owner_Vehicles_Table_Name), {
		['@plate'] = T
	}, function(a3)
		if a3 and #a3 > 0 then
			local a2 = a3[1].owner;
			StoreOwnerVehicles[T] = xZero.C.OwnerVehicles(T, a2)
			a0(a2)
		else
			if StoreOwnerVehicles[T] then
				StoreOwnerVehicles[T] = nil
			end;
			a0(nil)
		end
	end)
end;
xZero.Funcs.VCFG_Get = function(w)
	local a4 = w.VHASH;
	if VCFG_DATA[a4] then
		return VCFG_DATA[a4]
	else
		VCFG_DATA[a4] = C_VCFG(w.plate, w.class_name:lower(), w.displayname:lower(), tostring(w.model))
		return VCFG_DATA[a4]
	end
end;
xZero.Funcs.OpenTrunk_Update = function(a5, T)
	local u = Store[T]
	if u then
		u.OpenTrunk_Add(a5)
	end
end;
xZero.Funcs.OpenTrunk_Close = function(a5, T)
	local u = Store[T]
	if u then
		u.OpenTrunk_Remove(a5)
	end
end;
xZero.C.PlayerAccounts = function(a6)
	local self = {}
	self.xPlayer = a6;
	self.Get = function(a7)
		if a7 == "money" then
			return self.xPlayer.getMoney()
		end;
		return self.xPlayer.getAccount(a7).money
	end;
	self.Add = function(a7, a8)
		if a7 == "money" then
			self.xPlayer.addMoney(a8)
			return
		end;
		self.xPlayer.addAccountMoney(a7, a8)
	end;
	self.Remove = function(a7, a8)
		if a7 == "money" then
			self.xPlayer.removeMoney(a8)
			return
		end;
		self.xPlayer.removeAccountMoney(a7, a8)
	end;
	return self
end;
xZero.C.Store = function(T, a9, aa)
	local self = {}
	self.plate = T;
	self.isOwner = a9;
	self.Owner_Iden = aa;
	self.time_last_update = math.ceil(os.time() / 1000)
	self.Vaild = false;
	self.Prograss = false;
	self.InDB = false;
	self.DB_Save = false;
	self.OpenTrunk_PlayerList = {}
	self.slotsCurrent = nil;
	self.weightCurrent = nil;
	self.InventoryData = {
		['accounts'] = {},
		['items'] = {},
		['weapons'] = {}
	}
	self.TimeOutCB = {
		['accounts'] = {},
		['items'] = {},
		['weapons'] = {}
	}
	self.IsVaild = function()
		if self.InventoryData and self.InventoryData['accounts'] and self.InventoryData['items'] and self.InventoryData['weapons'] and (self.InDB or not self.DB_Save) then
			self.Vaild = true;
			return self.Vaild
		end;
		self.Vaild = false;
		return self.Vaild
	end;
	self.OpenTrunk_GetPlayer = function(a5)
		local ab = #self.OpenTrunk_PlayerList;
		if ab > 0 then
			for ac = 1, ab do
				local Z = self.OpenTrunk_PlayerList[ac]
				if Z.Iden == a5 then
					return ac, Z
				end
			end
		end;
		return nil, nil
	end;
	self.OpenTrunk_Add = function(a5)
		local ad, R = self.OpenTrunk_GetPlayer(a5)
		local ae = ad ~= nil and self.OpenTrunk_PlayerList[ad] or nil;
		if ae then
			ae.time = GetGameTimer()
		else
			local ab = #self.OpenTrunk_PlayerList;
			self.OpenTrunk_PlayerList[ab + 1] = {
				Iden = a5,
				time = GetGameTimer()
			}
		end
	end;
	self.OpenTrunk_Remove = function(a5)
		local ad, R = self.OpenTrunk_GetPlayer(a5)
		if ad then
			table.remove(self.OpenTrunk_PlayerList, ad)
		end
	end;
	self.OpenTrunk_Check = function(af)
		local ag = #self.OpenTrunk_PlayerList;
		if ag < af then
			return true
		end;
		local ah = 0;
		local ai = {}
		local aj = 0;
		for ad = 1, ag do
			local Z = self.OpenTrunk_PlayerList[ad]
			if GetGameTimer() - Z.time >= _openTrunkCheckTime then
				ah = ah + 1;
				ai[ah] = ad
			else
				aj = aj + 1
			end
		end;
		self.OpenTrunk_TimeOutClear(ai)
		return aj < af and true or false
	end;
	self.OpenTrunk_TimeOutClear = function(ai)
		local ak = #ai;
		if ak > 0 and #self.OpenTrunk_PlayerList > 0 then
			for Y = 1, ak do
				local ad = ai[Y]
				if self.OpenTrunk_PlayerList[ad] then
					table.remove(self.OpenTrunk_PlayerList, ad)
				end
			end
		end
	end;
	self.Items_Get = function(al)
		return self.InventoryData['items'][al] or 0
	end;
	self.Items_Add = function(al, A)
		self.InventoryData['items'][al] = self.Items_Get(al) + A;
		self.Save('items')
		return true
	end;
	self.Items_Remove = function(al, A)
		local am = self.Items_Get(al)
		if am > 0 and am >= A then
			local an = am - A;
			local B = an > 0 and an or nil;
			self.InventoryData['items'][al] = B;
			self.Save('items')
			return true
		end;
		return false
	end;
	self.Accounts_Get = function(ao)
		return self.InventoryData['accounts'][ao] or 0
	end;
	self.Accounts_Add = function(ao, A)
		self.InventoryData['accounts'][ao] = self.Accounts_Get(ao) + A;
		self.Save('accounts')
		return true
	end;
	self.Accounts_Remove = function(ao, A)
		local ap = self.Accounts_Get(ao)
		if ap > 0 and ap >= A then
			local an = ap - A;
			local B = an > 0 and an or nil;
			self.InventoryData['accounts'][ao] = B;
			self.Save('accounts')
			return true
		end;
		return false
	end;
	self.Weapons_Get = function(aq)
		return self.InventoryData['weapons'][aq] or nil
	end;
	self.Weapons_GetCount = function(ar)
		local ab = 0;
		for as, at in pairs(self.InventoryData['weapons']) do
			if at.name == ar then
				ab = ab + 1
			end
		end;
		return ab
	end;
	self.Weapons_GenwKey = function()
		local as = nil;
		while true do
			as = tostring(math.random(10000000, 99999999))
			if self.Weapons_Get(as) == nil then
				return as
			end
		end
	end;
	self.Weapons_Add = function(au, Q, av)
		local aq = self.Weapons_GenwKey()
		local aw = {
			name = au,
			ammo = Q ~= nil and Q > 0 and Q or 0,
			components = av ~= nil and #av > 0 and av or nil
		}
		self.InventoryData['weapons'][aq] = aw;
		self.Save('weapons')
		return true
	end;
	self.Weapons_Remove = function(aq)
		if self.Weapons_Get(aq) then
			self.InventoryData['weapons'][aq] = nil;
			self.Save('weapons')
			return true
		end;
		return false
	end;
	self.Save = function(ax, ay)
		self.time_last_update = os.time()
		if self.DB_Save and self.InDB and ax then
			if self.TimeOutCB and self.TimeOutCB[ax] and #self.TimeOutCB[ax] > 0 then
				for az, Z in ipairs(self.TimeOutCB[ax]) do
					ESX.ClearTimeout(self.TimeOutCB[ax][az])
					self.TimeOutCB[ax][az] = nil
				end
			end;
			ay = ay ~= nil and ay or _timeOutSaveDBdefault;
			local aA = ESX.SetTimeout(ay, function()
				MySQL.Async.execute(([[
                    UPDATE %s SET %s = @%s WHERE plate = @plate
                ]]):format(Config.Store_Table_Name, ax, ax), {
					['@'..ax] = json.encode(self.InventoryData[ax]),
					['@plate'] = self.plate
				})
			end)
			table.insert(self.TimeOutCB[ax], aA)
			return true
		end;
		return false
	end;
	self.SaveAll = function()
		if self.DB_Save and self.InDB then
			MySQL.Async.execute(([[
                UPDATE %s SET is_owner = @is_owner, accounts = @accounts, items = @items, weapons = @weapons 
                WHERE plate = @plate
            ]]):format(Config.Store_Table_Name), {
				["@is_owner"] = self.isOwner,
				["@accounts"] = json.encode(self.InventoryData["accounts"]),
				["@items"] = json.encode(self.InventoryData["items"]),
				["@weapons"] = json.encode(self.InventoryData["weapons"]),
				["@plate"] = self.plate
			}, function(U)
			end)
			return true
		end;
		return false
	end;
	self.SlotsAndWeightCurrent = function()
		local aB = 0;
		local aC = 0;
		for R, ax in ipairs({
			"accounts",
			"items"
		}) do
			if self.InventoryData[ax] then
				for aD, aE in pairs(self.InventoryData[ax]) do
					aB = aB + 1;
					aC = aC + aE * getItemInfoWeight(aD)
				end
			end
		end;
		if self.InventoryData['weapons'] then
			for R, aF in pairs(self.InventoryData['weapons']) do
				aB = aB + 1;
				aC = aC + getItemInfoWeight(aF.name)
			end
		end;
		self.slotsCurrent = aB;
		self.weightCurrent = funcs.getNumFormat(aC)
		return self.slotsCurrent, self.weightCurrent
	end;
	self.getNewCountSlotsWeight = function(aG, z, A)
		if self.slotsCurrent == nil or self.weightCurrent == nil then
			self.SlotsAndWeightCurrent()
		end;
		local B = 0;
		local C = self.slotsCurrent;
		local D = self.weightCurrent;
		local aH = storeItemGetNameFunc[z.type] or nil;
		if aH then
			if z.type == "item_weapon" then
				A = 1
			end;
			local aI = self[aH](z.name)
			B = aG == "PUT" and A + aI or aI - A;
			if aI <= 0 and B > 0 then
				C = C + 1
			elseif B <= 0 then
				C = C - 1
			end;
			if aG == "PUT" then
				D = D + A * getItemInfoWeight(z.name)
			else
				D = D - A * getItemInfoWeight(z.name)
			end
		end;
		return B, C, funcs.getNumFormat(D)
	end;
	return self
end;
xZero.Funcs.Store_GetByPlate = function(T, v, a2)
	local u = Store[T] or nil;
	if u then
		u.Owner_Iden = a2;
		return u
	else
		u = xZero.C.Store(T, v, a2)
		if v or not Config.Vehicle_NPC or Config.Vehicle_NPC and Config.Vehicle_NPC.DB_Save then
			u.DB_Save = true;
			MySQL.Async.execute(([[
                INSERT INTO %s (plate, is_owner, accounts, items, weapons) 
                VALUES (@plate, @is_owner, @accounts, @items, @weapons)
            ]]):format(Config.Store_Table_Name), {
				['@plate'] = T,
				['@is_owner'] = v,
				['@accounts'] = '{}',
				['@items'] = '{}',
				['@weapons'] = '{}'
			}, function(aJ)
				if aJ ~= nil and aJ > 0 then
					Store[T].InDB = true;
					pr(('Insert Store | ^3%s^7 | is_owner:^3%s^7'):format(T, v))
				else
					pr(('^1Insert Store Error | %s | is_owner:%s^7'):format(T, v))
				end
			end)
		end;
		Store[T] = u;
		return u
	end
end;
storeItemGetNameFunc = {
	["item_standard"] = "Items_Get",
	["item_account"] = "Accounts_Get",
	["item_weapon"] = "Weapons_GetCount"
}
xZero.C.OwnerVehicles = function(T, a2)
	local self = {}
	self.plate = T;
	self.Owner_Iden = a2;
	self.timeLast = GetGameTimer()
	self.TimeUpdateCheck = function(aK)
		aK = aK ~= nil and aK or 60;
		return GetGameTimer() - self.timeLast >= aK * 1000 and true or false
	end;
	return self
end;
Notify = function(l, aL, aM, aN)
	TriggerClientEvent(events.cl["OnNotify"], l, aL, aM, aN)
end;
NotifyT = function(l, aO, aP, aQ, aR)
	local aS = CT[aO] or nil;
	if aS then
	end;
	if aS ~= nil then
		Notify(l, aS:format(table.unpack(aP or {})), aQ, aR)
	end
end;
function DC_Log(p, w, aT, al, aU, aV, G)
	Citizen.CreateThread(function()
		local aW = {
			embeds = {
				{
					color = G.color,
					title = G.title,
					description = G.description:format(w.plate, ('%s | %s (%s)'):format(w.displayname, w.model, w.class_name), aT, p.getIdentifier(), p.getName(), al, aU, aV),
					footer = {
						text = ('เวลา: %s'):format(os.date('%d/%m/%Y | %H:%M:%S', os.time()))
					}
				}
			}
		}
		PerformHttpRequest(G.URL_Webhook, function(g, h, i)
		end, 'POST', json.encode(aW), {
			['Content-Type'] = 'application/json'
		})
	end)
end;
function DC_CFG_Vaild(aX, aY)
	if Config.DC and Config.DC[aX] then
		local aZ = Config.DC[aX][aY]
		if aZ and aZ.Enabled and aZ.URL_Webhook and aZ.Template then
			return true
		end;
		return false
	end;
	return false
end;
VersionInit = function()
	if version_lasted ~= nil and tonumber(version_current) < tonumber(version_lasted) then
		pr(string.format('Inited - version_current:^1%s^7 (version_lasted:^3%s^7)', version_current, version_lasted))
	else
		pr(string.format('Inited - version_current:^3%s^7', version_current))
	end
end;
_TSC = {}
_TSC.Callbacks = {}
RSC = function(a_, b0)
	_TSC.Callbacks[a_] = b0
end;
_TSC.Callback = function(a_, b1, l, b0, ...)
	if _TSC.Callbacks[a_] then
		_TSC.Callbacks[a_](l, b0, ...)
	end
end;
RegisEvent(true, events.sv["TSC_Request"], function(a_, b1, ...)
	local l = source;
	_TSC.Callback(a_, b1, l, function(...)
		TriggerClientEvent(events.cl["TSC_Receive"], l, b1, ...)
	end, ...)
end)

function onVehicleInventoryFull(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบเปิดท้ายรถ', -- หัวเรื่อง
		description = 'น้ำหนักท้ายรถเต็ม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end	


function onVehicleNotOwn(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบเปิดท้ายรถ', -- หัวเรื่อง
		description = 'คุณไม่ได้เป็นเจ้าของรถ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_vehicle', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end	