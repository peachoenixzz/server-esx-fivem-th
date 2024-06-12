local TxhGames = {}
local TxhSources = {}

for txhId, coords in ipairs(Config.Tables) do
	TxhGames[txhId] = CreateGame(txhId);
end

function GetObjectKeys(object)
	local keys = {}
	for key, _ in pairs(object) do
		table.insert(keys, key)
	end
	return keys
end

RegisterServerCallback('sf-txh:canUse', function(source, txhId, seat, modelId)
	if(TxhGames[txhId] and not TxhGames[txhId].seats[seat]) then
		local canUse, reason = CanUseTable(source, Config.Tables[txhId].type)
		if(not canUse) then
			ShowNotification(source, _L(reason))
			return
		end
		local txh = Config.Tables[txhId]
		if(Bridge.GetItemCount(source, (txh.moneyItem or Config.MoneyItem)) < (txh.smallBlind*2)) then
			ShowNotification(source, _L("not_enough_money"))
			return
		end
		local txhGame = TxhGames[txhId]
		if(not txhGame.modelId) then 
			txhGame.modelId = modelId
		end
		local speech = GetGreetSpeech(source)
		if(speech == "MINIGAME_DEALER_GREET_DRUNK") then
			DealerSpeech(txhId, speech)
		elseif(txhGame.lastPlayers[source] and os.time() - txhGame.lastPlayers[source] < (15 * 60)) then
			DealerSpeech(txhId, "MINIGAME_DEALER_REJOIN_TABLE")
		else
			DealerSpeech(txhId, speech)
		end
		txhGame.lastPlayers[source] = os.time()
		txhGame.seats[seat] = source
		txhGame.playerSeats[source] = seat
		TxhSources[tonumber(source)] = { id = txhId, seat = seat }
		if(not txhGame.started and (not txhGame.time or os.time() - txhGame.time < Config.PrepareTime - 5) and (not txhGame.lastWelcome or os.time() - txhGame.lastWelcome > 5)) then
			txhGame.lastWelcome = os.time()
			TriggerClientEvent('sf-txh:dealerAnims', -1, txhId, { "acknowledge_p02" }, "anim_casino_b@amb@casino@games@shared@dealer@", seat)
			Citizen.SetTimeout(3000, function()
				TriggerClientEvent('sf-txh:dealerAnims', -1, txhId, { "dealer_idle" }, "anim_casino_b@amb@casino@games@shared@dealer@")
			end)
		end
		Citizen.SetTimeout(4000, function()
			txhGame.onPlayerAdd(source)
		end)
		EnsureTxhThread(txhId)
		return true, txhGame.time and (Config.PrepareTime - (os.time() - txhGame.time)) or Config.PrepareTime
	else
		return false
	end
end)

function DealerSpeech(txhId, speech)
	Citizen.CreateThread(function()
		local timeout = 0
		while Config.Tables[txhId].speaking do
			timeout += 1
			if(timeout > 30) then break end
			Citizen.Wait(100)
		end
		Config.Tables[txhId].speaking = true
		TriggerClientEvent('sf-txh:dealerSpeech', -1, txhId, speech)
		Citizen.Wait(3000)
		Config.Tables[txhId].speaking = false
	end)
end

function EnsureTxhThread(txhId)
	if(not TxhGames[txhId] or TxhGames[txhId].running) then return end
	TxhGames[txhId].time = os.time()
	TxhGames[txhId].running = true
	Citizen.CreateThread(function()
		local txhGame = TxhGames[txhId]
		txhGame.running = true
		txhGame.time = os.time()
		for seatIndex, source in pairs(txhGame.seats) do
			TriggerClientEvent('sf-txh:timeLeft', source, Config.PrepareTime)
		end
		while txhGame.running do
			-- no players
			if(#GetObjectKeys(txhGame.seats) == 0) then break end
			if(os.time() - txhGame.time >= Config.PrepareTime and not txhGame.started) then
				if(#GetObjectKeys(txhGame.seats) < 2) then
					txhGame.time = os.time()
					for seatIndex, source in pairs(txhGame.seats) do
						TriggerClientEvent('sf-txh:timeLeft', source, Config.PrepareTime)
					end
				else
					txhGame.startGame(Config.Tables[txhId].smallBlind)
				end
			end
			Citizen.Wait(500)
		end
		txhGame.started = false
		txhGame.reset()
		txhGame.running = false
	end)
end

RegisterNetEvent('sf-txh:exitTable', function()
	local _source = source
	if(TxhSources[_source]) then
		local txhId = TxhSources[_source].id
		local seat = TxhSources[_source].seat
		local txhGame = TxhGames[txhId]
		if(txhGame.lastWon[_source]) then
			DealerSpeech(txhId, "MINIGAME_DEALER_LEAVE_GOOD_GAME")
		elseif(txhGame.lastLose[_source]) then
			DealerSpeech(txhId, "MINIGAME_DEALER_LEAVE_BAD_GAME")
		else
			DealerSpeech(txhId, "MINIGAME_DEALER_LEAVE_NEUTRAL_GAME")
		end
		-- if(not txhGame.started and txhGame.anteBets[_source] and txhGame.anteBets[_source] > 0) then
		-- 	Bridge.AddItem(_source, Config.MoneyItem, txhGame.anteBets[_source])
		-- end
		-- if(not txhGame.started and txhGame.pairBets[_source] and txhGame.pairBets[_source] > 0) then
		-- 	Bridge.AddItem(_source, Config.MoneyItem, txhGame.pairBets[_source])
		-- end
		-- txhGame.pairBets[_source] = nil
		-- txhGame.anteBets[_source] = nil
		txhGame.handleExit(_source)
		txhGame.seats[seat] = nil
		txhGame.playerSeats[_source] = nil
		TxhSources[_source] = nil
		if(not txhGame.started and (not txhGame.time or os.time() - txhGame.time < Config.PrepareTime - 5)) then
			TriggerClientEvent('sf-txh:dealerAnims', -1, txhId, { "acknowledge_p02" }, "anim_casino_b@amb@casino@games@shared@dealer@", seat)
			Citizen.SetTimeout(3000, function()
				TriggerClientEvent('sf-txh:dealerAnims', -1, txhId, { "dealer_idle" }, "anim_casino_b@amb@casino@games@shared@dealer@")
			end)
		end
	end
end)

RegisterServerEvent('sf-txh:autoActionToggle', function()
	local _source = source
	if(TxhSources[_source]) then
		local txhId = TxhSources[_source].id
		local seat = TxhSources[_source].seat
		local txhGame = TxhGames[txhId]

		if txhGame.started and txhGame.playerHands[_source] then
			txhGame.autoAction[_source] = not txhGame.autoAction[_source];
			local hand = txhGame.playerHands[_source];

			TriggerClientEvent("sf-txh:setValues", _source, txhGame.board.bet, hand?.bet or 0, txhGame.currentBet, hand?.currentBet, txhGame.autoAction[_source]);
		end
	end
end)

AddEventHandler('playerDropped', function(reason)
	local _source = tonumber(source)
	for k, v in pairs(TxhGames) do
		v.lastPlayers[_source] = nil
	end
	if(TxhSources[_source]) then
		local txhId = TxhSources[_source].id
		local seat = TxhSources[_source].seat
		TxhGames[txhId].seats[seat] = nil
		TxhGames[txhId].handleExit(_source)
		TxhGames[txhId].playerSeats[_source] = nil
		TxhSources[_source] = nil
	end
end)


AddEventHandler("onResourceStop", function(resourceName)
	if(resourceName == GetCurrentResourceName()) then
	end
end)

if(GetResourceState("es_extended") ~= "missing") then
    function ShowNotification(source, notification)
        TriggerClientEvent("esx:showNotification", source, notification)
    end
elseif(GetResourceState("qb-core") ~= "missing") then
    function ShowNotification(source, notification)
        TriggerClientEvent("QBCore:Notify", source, notification)
    end
else
	function ShowNotification(source, notification)
        TriggerClientEvent("sf-txh:addNotification", source, notification)
    end
end

function string.split(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return table.unpack(t)
end

function GetGreetSpeech(source)
	local rnd = math.random(1, 2)
	if(Player(source).state.Drunk) then
		return "MINIGAME_DEALER_GREET_DRUNK"
	end
	if(rnd == 2) then
		local playerPed = GetPlayerPed(source)
		if(GetEntityModel(playerPed) == `mp_f_freemode_01`) then
			return "MINIGAME_DEALER_GREET_FEMALE"
		else
			return "MINIGAME_DEALER_GREET_MALE"
		end
	end
	return "MINIGAME_DEALER_GREET"
end

function GetDealerIdle(txhId)
	-- local txhGame = TxhGames[txhId]
	-- local currentSeat = nil
	-- local seatCount = 0
	-- for k, v in pairs(txhGame.seats) do
	-- 	currentSeat = k
	-- 	seatCount += 1
	-- end
	-- if(seatCount > 1 or seatCount == 0) then
		return "dealer_idle"
	-- else
	-- 	return "idle_single_p0"..currentSeat
	-- end
end

function CanUseTable(source, tableType)
	-- example
	-- if(tableType == "high" and not IsPlayerVIP(source)) then
	-- 	return false, "need_vip"
	-- end
	return true
end

function GetClosestBetId(amount)
	local closestValue = 999999
	local closestId
	for k, v in pairs(BetChips) do
		if(tonumber(k) and math.abs(tonumber(k) - amount) < closestValue) then
			closestValue = math.abs(tonumber(k) - amount)
			closestId = k
		end
	end
	return closestId or 10
end