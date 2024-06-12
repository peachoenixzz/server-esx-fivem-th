function UpdateBet(betIndex)

end


function GetTxhId(data)
    for index, txh in ipairs(Config.Tables) do
		if(#(vector3(txh.coords.x, txh.coords.y, txh.coords.z) - data.coords) <= 0.5 and txh.model == data.model) then
			return index
		end
        if(index % 20 == 0) then
            Citizen.Wait(0)
        end
	end
end

function GetTime(value)
	local minutes = math.floor(value/60)
	local seconds = value - minutes*60
	return string.format("%02d:%02d", minutes, seconds)
end

RegisterNetEvent("sf-txh:gameEnd", function()
	CurrentTable.cardsVisible = false
	CurrentTable.cardsToggle = false
	CurrentTable.handMode = false
	SetCards({"empty", "empty"})
	SendAppAction("setHandVisible", false)
	SendAppAction("setDisplayCommonCards", false)
	SendAppAction("setTopSegments", {
		{
			title = _L("small_blind"),
			content = CurrentTable.smallBlind
		},
		{
			title = _L("time_left"),
			content = GetTime(CurrentTable.timeLeft)
		},
	})
	SendAppAction("setKeys", {
		{
			keys = { "ESC" },
			label = _L("exit_table")
		},
	})
	SendAppAction("setDisplayTop", true)
end)

function SetCards(cards)
	SendAppAction("setHand", cards)
end

RegisterNetEvent("sf-txh:setValues", function(pot, bet, currentBet, playerCurrentBet, autoAction)
	CurrentTable.handMode = true
	SendAppAction("setTopSegments", {
		{
			title = _L("pot"),
			content = pot
		},
		{
			title = _L("total_bet"),
			content = bet
		},
		{
			title = _L("your_current_bet"),
			content = playerCurrentBet
		},
		{
			title = _L("current_bet"),
			content = currentBet
		},
	})
	SendAppAction("setKeys", {
		{
			keys = { "ESC" },
			label = _L("exit_table")
		},
		{
			keys = { "X" },
			label = Config.CardsToggle and _L("toggle_cards") or _L("look_at_cards")
		},
		{
			keys = { "␣" },
			label = _L("auto_check_fold", autoAction and _L("yes") or _L("no"))
		}
	})
end)

RegisterNetEvent("sf-txh:setOpCards", function(pArr)
	if(not CurrentTable) then return end
	SendAppAction("setPlayerHands", pArr)
	SendAppAction("setOpHandsVisible", true)
	Citizen.Wait(1000)
	if(not CurrentTable) then
		SendAppAction("setOpHandsVisible", false)
	end
end)

RegisterNetEvent("sf-txh:setComCards", function(cards, isFirst)
	for i=1, 5 do
		if(not cards[i]) then
			cards[i] = "empty"
		end
	end
	if(isFirst) then
		SendAppAction("setCommonCards", { "empty", "empty", "empty", "empty", "empty" })
	end
	SendAppAction("setDisplayCommonCards", true)
	if(isFirst) then
		Citizen.Wait(1100)
		local setCards = { "empty", "empty", "empty", "empty", "empty" }
		for i=1, 5 do
			setCards[i] = cards[i]
			SendAppAction("setCommonCards", setCards)
			Citizen.Wait(100)
		end
	else
		SendAppAction("setCommonCards", cards)
	end
end)

function SetHUDState(state)
	if(state) then
		CurrentTable.cardsVisible = false
		CurrentTable.cardsToggle = false
		SetCards({"empty", "empty"})
		CurrentTable.handMode = false
		SendAppAction("setHandVisible", false)
		SendAppAction("setDisplayCommonCards", false)
		SendAppAction("setTopSegments", {
			{
				title = _L("small_blind"),
				content = CurrentTable.smallBlind
			},
			{
				title = _L("time_left"),
				content = GetTime(CurrentTable.timeLeft)
			},
		})
		SendAppAction("setKeys", {
			{
				keys = { "ESC" },
				label = _L("exit_table")
			},
		})
		SendAppAction("setDisplayTop", true)
	else
		SendAppAction("setHandVisible", false)
		SendAppAction("setOpHandsVisible", false)
		SendAppAction("setDisplayCommonCards", false)
	end
	SendAppAction("setVisible", state)
end

function UpdateHUDValue(key, value)
	if(key == "bet") then
		SendAppAction("setBet", value)
	elseif(key == "time_left") then
		SendAppAction("setTopSegments", {
			{
				title = _L("small_blind"),
				content = CurrentTable.smallBlind
			},
			{
				title = _L("time_left"),
				content = GetTime(value)
			},
		})
	end
end

RegisterNetEvent("sf-txh:addNotification", function(message)
	HudAddNotification(message)
end)

if(GetResourceState("es_extended") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("esx:showNotification", notification)
    end
elseif(GetResourceState("qb-core") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("QBCore:Notify", notification)
    end
else
	function HudAddNotification(notification)
        ShowNotification("Casino txh", notification, "")
    end
end


function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('txhNotification', message)
    BeginTextCommandThefeedPost("txhNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("txhHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("txhHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("txhHelpNotification")
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function SendAppAction(action, payload)
    SendNUIMessage({
        event = "sendAppEvent",
        app = "os",
        action = action,
        payload = payload,
    })
end

function ShouldExit()
	-- here you can apply your own dead logic to automatically exit game (It checks every 500ms)
	return false
end

RegisterClientCallback("sf-txh:requestInteraction", function(isBet, canCheck, maxBet)
	CurrentTable.busy = true
	local keys = {
		{
			keys = { "F" },
			label = _L("fold")
		},
		{
			keys = { "↵" },
			label = isBet and _L("bet") or _L("raise")
		},
		{
			keys = { "X" },
			label = Config.CardsToggle and _L("toggle_cards") or _L("look_at_cards")
		},
	}
	if(canCheck) then
		table.insert(keys, {
			keys = { "␣" },
			label = _L("check")
		});
	else
		table.insert(keys, {
			keys = { "C" },
			label = _L("call")
		});
	end
	SendAppAction("setKeys", keys)
	local time = GetGameTimer()
	local choice, declaredAmount = "fold", 0
	local foldTimer = nil
	while true do
		if(GetGameTimer() - time > (30 * 1000)) then break end
		DisableControlAction(0, 26, true)
		if(IsControlJustPressed(0, Config.Controls["bet"])) then
			choice, declaredAmount = GetBet(maxBet)
			if(choice) then
				break
			end
		end
		if(canCheck and IsControlJustPressed(0, Config.Controls["check"])) then
			choice = "check"
			break
		end
		if(IsControlJustPressed(0, Config.Controls["fold"])) then
			foldTimer = GetGameTimer()
		end
		if(IsControlJustReleased(0, Config.Controls["fold"]) or (foldTimer and GetGameTimer() - foldTimer > 700)) then
			local diff = foldTimer and (GetGameTimer() - foldTimer) or 0
			choice = diff > 300 and "fold_reveal" or "fold"
			break
		end
		if(not canCheck and IsDisabledControlJustPressed(0, Config.Controls["call"])) then
			choice = "call"
			break
		end
		Citizen.Wait(0)
	end
	Citizen.CreateThread(function()
		for i=1, 100 do
			DisableControlAction(0, 26, true)
			Citizen.Wait(0)
		end
	end)
	CurrentTable.busy = false
	return choice, declaredAmount
end)