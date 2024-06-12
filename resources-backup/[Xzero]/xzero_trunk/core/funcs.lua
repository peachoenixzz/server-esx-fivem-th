--[[
	code generated using luamin.js, Herrtt#3868
--]]


script_name = GetCurrentResourceName()
GetName = function(a)
	return script_name..a
end;
RegisEvent = function(b, a, c)
	if b then
		RegisterNetEvent(a)
	end;
	AddEventHandler(a, c)
end;
pr = function(d)
	print(('^2[%s]^7 %s'):format(script_name, d))
end;
events = {}
events.sv = {
	["OnVerifyRequest"] = GetName(":SV:OnVerifyRequest"),
	["TSC_Request"] = GetName(":SV:TSC_Request"),
	["OnInventoryDataRequestCB"] = GetName(":SV:OnStoreInventoryDataRequestCB"),
	["OnPut"] = GetName(":SV:OnPut"),
	["OnTake"] = GetName(":SV:OnTake"),
	["OnTrunkInventoryOpen"] = GetName(":SV:OnTrunkInventoryOpen"),
	["OnTrunkInventoryClose"] = GetName(":SV:OnTrunkInventoryClose")
}
events.cl = {
	["OnVerifyReceive"] = GetName(":CL:OnVerifyReceive"),
	["TSC_Receive"] = GetName(":CL:TSC_Receive"),
	["OnInventoryDataReloaded"] = GetName(":CL:OnInventoryDataReloaded"),
	["OnInventoryDataReceive"] = GetName(":CL:OnInventoryDataReceive"),
	["OnPut"] = GetName(":CL:OnPut"),
	["OnTake"] = GetName(":CL:OnTake"),
	["OnInventoryClose"] = GetName(":CL:OnInventoryClose"),
	["OnInventoryHudInsObjReceive"] = GetName(":CL:OnInventoryHudInsObjReceive"),
	["OnOpenInventory"] = GetName(":CL:On_OpenInventory"),
	["OnNotify"] = GetName(":CL:OnNotify")
}
getItemInfoWeight = function(e)
	local f = Config.Item_Info_Weight_Default or 0;
	local g = Config.Item_Info[e] or Config.Item_Info[e:lower()] or nil;
	if g and g.weight ~= nil then
		f = g.weight
	end;
	return f
end;
VJob = function(h)
	local self = {}
	self.jobName = h;
	self.CFG = nil;
	self.Vaild = false;
	self.IsVaild = function()
		local i = Config.Vehicle_Job and self.jobName and Config.Vehicle_Job[self.jobName] or nil;
		if not i then
			return false
		end;
		self.CFG = i;
		self.Vaild = true;
		return self.Vaild
	end;
	self.OwnerOnly_Allow = function()
		return self.CFG.OwnerOnly_Allow ~= nil and self.CFG.OwnerOnly_Allow or not Config.Vehicle_OwnerOnly
	end;
	self.Locked_Allow = function()
		return self.CFG.Locked_Allow ~= nil and self.CFG.Locked_Allow or false
	end;
	self.IsVaild()
	return self
end;
C_VCFG = function(j, k, l, m)
	local self = {}
	self.plate = j;
	self.class_name = k;
	self.displayname = l;
	self.model = m;
	self.slots_max = nil;
	self.weight_max = nil;
	self.CFGList = {
		{
			CFG_Type = 'Vehicle_Weight_Class',
			DATA = {
				self.class_name
			}
		},
		{
			CFG_Type = 'Vehicle_Weight_NameAndModel',
			DATA = {
				self.displayname,
				self.model
			}
		},
		{
			CFG_Type = 'Vehicle_Weight_Plate',
			DATA = {
				self.plate
			}
		}
	}
	self.DATA = {
		['slots'] = nil,
		['weight'] = nil,
		['item_blacklist'] = nil,
		['item_limit'] = nil,
		['job'] = nil
	}
	self.GetDataInit = function()
		for n, o in ipairs(self.CFGList) do
			local p = Config[o.CFG_Type]
			if p and o.DATA and #o.DATA > 0 then
				local q = nil;
				for n, r in ipairs(o.DATA) do
					if p[r] then
						q = r
					end
				end;
				local s = p[q]
				if s then
					for n, t in ipairs({
						"slots",
						"weight",
						"item_blacklist",
						"item_limit",
						"job"
					}) do
						local u = s[t]
						if u ~= nil then
							self.DATA[t] = u
						end
					end
				end
			end
		end;
		self.slots_max = self.DATA['slots'] or Config.Vehicle_Slots_Default or -1;
		self.weight_max = self.DATA['weight'] or Config.Vehicle_Weight_Default or -1
	end;
	self.Check_Slots = function(v)
		return self.slots_max ~= -1 and v > self.slots_max and false or true
	end;
	self.Check_Weight = function(w)
		return self.weight_max ~= -1 and w > self.weight_max and false or true
	end;
	self.Check_Item_BlackList = function(e)
		if funcs.ArrayIsInOne(Config.Item_BlackList_Name, e) then
			return false
		end;
		if funcs.ArrayIsInOne(self.DATA['item_blacklist'], e) then
			return false
		end;
		return true
	end;
	self.getItemLimit = function(e)
		local x = Config.Item_Info_Limit_Default or -1;
		local y = Config.Item_Info[e] or nil;
		if y and y.limit ~= nil then
			x = y.limit
		end;
		local z = self.DATA['item_limit'] or nil;
		if z and z[e] ~= nil then
			x = z[e]
		end;
		return x
	end;
	self.Check_Job = function(A)
		local B = funcs.ArrayIsInOne(self.DATA['job'], A)
		return B ~= nil and B == false and false or true
	end;
	self.GetDataInit()
	return self
end;
ConfigBaseVaild = function()
	if Config.Base == nil then
		Config.Base = {
			getSharedObject = "esx:getSharedObject"
		}
	end
end;
funcs = {}
funcs.ArrayIsInOne = function(C, D)
	local E = C and #C or 0;
	if E > 0 then
		for F = 1, E do
			if C[F]:lower() == D:lower() then
				return true
			end
		end;
		return false
	end;
	return nil
end;
funcs.DATA_VEH_Vaild = function(G)
	if G then
		local H = {
			'plate',
			'slots_max',
			'weight_max',
			'class_name',
			'displayname',
			'model',
			'VHASH'
		}
		for I, J in ipairs(H) do
			if not G[J] then
				return false
			end
		end;
		return true
	end;
	return false
end;
funcs.getNumFormat = function(K)
	return tonumber(string.format("%.4f", K))
end