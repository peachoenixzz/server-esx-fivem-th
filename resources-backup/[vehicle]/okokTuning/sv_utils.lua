ESX = exports.es_extended:getSharedObject()

Webhook = '' -- PUT YOUR WEBHOOK LINK HERE

function okokRegisterCallback(event, cb)
      ESX.RegisterServerCallback(event, cb)
end

function MySQLfetchAll(query, values, func)
	return MySQL.Async.fetchAll(query, values, func)
end

function GetPlayerMoney(identifier)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	return xPlayer.getAccount(Config.UseMoneyAccount).money
end

function RemovePlayerMoney(xPlayer, amount)
	xPlayer.removeAccountMoney(Config.UseMoneyAccount, amount)
end

okokRegisterCallback("okokTuning:Server:GetName", function(source, cb, target_source)
      local Player = ESX.GetPlayerFromId(target_source)
      cb(getName(Player.identifier) or ('uknown'))
end)

function Notify(src, id)
      if Config.UseOkokNotify then
            TriggerClientEvent('okokNotify:Alert', src, Locale(id).title, Locale(id).text, Locale(id).time, Locale(id).type)
      else
            TriggerClientEvent('esx:showNotification', src, Locale(id).text, Locale(id).type, Locale(id).time)
      end
end

okokRegisterCallback('okok:server:CheckPermission', function(src, cb, perm)
      if perm == 'admin' then
            cb(IsPlayerAceAllowed(src, 'okokTuning.admin'))
      elseif perm == 'repair' then
            cb(IsPlayerAceAllowed(src, 'okokTuning.repair'))
      end
end)

--[[ Commands ]]
RegisterCommand(Config.AdminCommand, function(source, args)
	local hasPermission = IsPlayerAceAllowed(source, 'okokTuning.admin')
	if not hasPermission then
		  Notify(source, 'no_permission')
		  return
	end
	AdminMenuUsers[tostring(source)] = true
	TriggerClientEvent(Config.EventPrefix .. ':Client:OpenAdminMenu', source)
end)

function getName(identifier)
	local name = nil
	MySQLfetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(db_name)
		if db_name[1] ~= nil then
			name = db_name[1].firstname.." "..db_name[1].lastname
		else
			name = ""
		end
	end)
	while name == nil do
		Citizen.Wait(2)
	end
	return name
end

VehiclePrices = {}
function GetVehiclePrices()
      if Config.UseOkokVehicleShop then
            MySQLfetchAll('SELECT * FROM okokvehicleshop_vehicles', {
            }, function(result)
                  if result[1] ~= nil then
                        for _, vehicle in ipairs(result) do
                              local model = string.lower(vehicle.vehicle_id)
                              local price = vehicle.max_price
                              if model and price and VehiclePrices[model] == nil then
                                    VehiclePrices[model] = price
                              end
                        end
                  end
            end)
      else
			MySQLfetchAll('SELECT * FROM vehicles', {
			}, function(result)
				if result[1] ~= nil then
			for _, vehicle in ipairs(result) do
				local model = string.lower(vehicle.model)
				local price = vehicle.price
							if model and price and VehiclePrices[model] == nil then
						VehiclePrices[model] = price
				end
			end
				end
			end)
      end
end
CreateThread(GetVehiclePrices)

okokRegisterCallback('okokTunning:Server:GetVehiclePrices', function(source, cb)
      cb(VehiclePrices)
end)

-------------------------- IDENTIFIERS

function ExtractIdentifiers(id)
	local identifiers = {
		steam = "",
		ip = "",
		discord = "",
		license = "",
		xbl = "",
		live = ""
	}

	for i = 0, GetNumPlayerIdentifiers(id) - 1 do
		local playerID = GetPlayerIdentifier(id, i)

		if string.find(playerID, "steam") then
			identifiers.steam = playerID
		elseif string.find(playerID, "ip") then
			identifiers.ip = playerID
		elseif string.find(playerID, "discord") then
			identifiers.discord = playerID
		elseif string.find(playerID, "license") then
			identifiers.license = playerID
		elseif string.find(playerID, "xbl") then
			identifiers.xbl = playerID
		elseif string.find(playerID, "live") then
			identifiers.live = playerID
		end
	end

	return identifiers
end

-------------------------- WEBHOOK

function discordWebhook(data)
	local color = '65352'
	local category = 'default'
	local list = ''
	local identifierlist = ExtractIdentifiers(data.playerid)
	local identifier = identifierlist.license:gsub("license2:", "")
	local discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"

	if data.type == 'paied-tuning' then
		color = Config.WebhookColor
		category = 'Tuned a vehicle'
		for k,v in pairs(data.items) do
                  list = list..'\n'..k.." ("..v..")"
            end
	end
	
	local information = {
		{
			["color"] = color,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'GARAGE',
			["description"] = '**Action:** '..category..'\n\n**Plate:** '..data.plate..'\n\n**Item list:** '..list..'\n\n**Price:** '..data.price..'\n\n**ID:** '..data.playerid..'\n**Identifier:** '..identifier..'\n**Discord:** '..discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}

	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end