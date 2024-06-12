ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(100)
end)

Citizen.CreateThread(function()
	local npctradeChip = GetHashKey("ig_ramp_mex") 
	RequestModel(npctradeChip)
	while not HasModelLoaded(npctradeChip) do
		Wait(1)
	end
 
	local npcCasino = CreatePed(4, npctradeChip, 187.7287, -913.6777, 29.7804, 144.3017, false, true) 
	SetEntityAsMissionEntity(npcCasino, true, true)
	SetBlockingOfNonTemporaryEvents(npcCasino, true)
	FreezeEntityPosition(npcCasino, true)
	SetEntityInvincible(npcCasino, true)

end)

local inzonetradeChip = false

local selltradeChip = PolyZone:Create({
    vector3(187.7201, -914.4592, 30.7698), 
    vector3(186.5524, -913.5922, 30.7753),
    vector3(187.5378, -912.3433, 30.7894),
    vector3(188.6228, -913.4506, 30.7865),
},{
    name = "casino_trade_chip",
    debugPoly = false,
    minZ = 29,
    maxZ = 35,
})

selltradeChip:onPlayerInOut(function(isPointInside, point)
    if isPointInside then
        inzonetradeChip = true
        exports.helpnotify:showHelpNotification("กด","E","เพื่อแลกเงิน")
    else
        inzonetradeChip = false
        exports.helpnotify:hideHelpNotification()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inzonetradeChip == true then
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                exports.helpnotify:hideHelpNotification()
                casinotradeMenu()
                --putamounttoTrade()
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

function casinotradeMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'casino_trade_zone', {
                title    = 'Drug Zone',
                align    = 'top-right',
                elements = {
                    {label = "แลกคาสิโนชิป", name = 'moneytochip'},
                    {label = "แลกเงินคืน", name = 'chiptomoney'},
                }
    },  function(data, menu)
        if inzonetradeChip ~= false then
            if data.current.name == 'moneytochip' then
                trademoneytoChip()
                menu.close()
            end
            if data.current.name == 'chiptomoney' then 
                tradechiptoMoney()
                menu.close()
            end
        else 
            menu.close()
        end
        end, function(data, menu)
            menu.close()
    end)
end

function trademoneytoChip()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createamount_buybodybag',
    {
        title = "แลกเหรียญขั้นต่ำ 100",
    }, function(data, menu)
        if inzonetradeChip then     
            if tonumber(data.value) and tonumber(data.value) >= 100 then
                --print("Int : "..data.value)
                TriggerServerEvent('casinoTradeChip:moneytochip', tonumber(data.value))
                menu.close()
            else
                --print("Char : "..data.value)
                menu.close()
            end
        else    
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function tradechiptoMoney()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createamount_buybodybag',
    {
        title = "แลกเงินคืนขั้นต่ำ 100",
    }, function(data, menu)
        if inzonetradeChip then     
            if tonumber(data.value) and tonumber(data.value) >= 100 then
                --print("Int : "..data.value)
                TriggerServerEvent('casinoTradeChip:chiptomoney', tonumber(data.value))
                menu.close()
            else
                --print("Char : "..data.value)
                menu.close()
            end
        else    
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end