--[[
	code generated using luamin.js, Herrtt#3868
--]]


scriptName = 'esx_inventoryhud'
xZTScriptName = 'xzero_trunk'
GetName = function(a)
	return scriptName..a
end;
RegisEvent = function(b, a, c)
	if b then
		RegisterNetEvent(a)
	end;
	AddEventHandler(a, c)
end;
xZT = {}
xZT.Inventory_Open = function(d)
	SendNUIMessage({
		action = 'display',
		type = d
	})
	SetNuiFocus(true, true)
	isInInventory = true
end;
xZT.Inventory_Setup_Second = function(e)
	SendNUIMessage({
		action = 'setSecondInventoryItems',
		itemList = e.itemList
	})
	if e.setInfoText then
		SendNUIMessage(e.setInfoText)
	end
end;
xZT.Inventory_Setup_Player = function()
	loadPlayerInventory()
end;
xZT.Inventory_Close = function()
	closeInventory()
	isInInventory = false
end;
xZT.Inventory_IsIn = function()
	return isInInventory
end;
RegisterNUICallback('PutIntoTrunk', function(f, g)
	TriggerEvent(xZTScriptName..":CL:OnPut", f)
	g(true)
end)
RegisterNUICallback('TakeFromTrunk', function(f, g)
	TriggerEvent(xZTScriptName..":CL:OnTake", f)
	g(true)
end)
RegisterNUICallback('NUIFocusOff', function()
	isInInventory = false;
	TriggerEvent(xZTScriptName..":CL:OnInventoryClose")
end)
RegisEvent(false, GetName(":CL:GetInstanceObject"), function(h)
	h(xZT.GetIns())
end)
xZT.GetIns = function()
	return xZT
end;
TriggerEvent(xZTScriptName..":CL:OnInventoryHudInsObjReceive", xZT)