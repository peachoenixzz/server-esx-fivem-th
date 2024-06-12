

local itemList, jobList = {}, {}
admin = {}
Updateblip = {}
Updateblip_count = 0

players = {}



AddEventHandler('onResourceStart', function()
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT name, label FROM items',{}, function(result)
            itemList = result
        end)

        MySQL.Async.fetchAll('SELECT * FROM jobs ORDER BY name <>  "unemployed", name',{}, function(result)
            for i=1, #result, 1 do
                MySQL.Async.fetchAll('SELECT grade, label FROM job_grades WHERE job_name = @job',{["@job"] = result[i].name}, function(result2)
                    table.insert(jobList, {name = result[i].name, label = result[i].label, ranks = result2})
                end)
            end
        end)
    end)
end)

if Config.SettingSystem.Bansystem then
    AddEventHandler("playerConnecting", function(name, setReason, deferrals)
        local player = source
        local identifier
        for k,v in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(v, 'steam:') then
                identifier = v
                break
            end
        end

        deferrals.defer()
        deferrals.update("Checking Ban Status.")

        MySQL.Async.fetchAll('SELECT * FROM bans WHERE license = @license', {
            ['@license'] = identifier
        }, function(result)
            if result[1] then
                if result[1].time ~= 0 then
                	if result[1].time < os.time() then
                        MySQL.Async.execute('DELETE FROM bans WHERE license = @license',
                            {   
                                ['license'] = result[1].license, 
                            },
                            function(insertId)
                                print("player unbanned")
                        end)
                		deferrals.done()
                		return
                	end

                	local time = math.floor((result[1].time - os.time()) / 60)
                    deferrals.done("[admin] You are temporarily banned for "..time.." mins Reason: "..result[1].reason)
                else
                    deferrals.done("[admin] You have been permanently banned for the reason: "..result[1].reason)
                end
            else
                deferrals.done()
            end
        end)
    end)
end


--[Fetch User Rank CallBack]
ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local playerGroup = player.getGroup()

        if playerGroup then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)


ESX.RegisterServerCallback("admin:TeleportSpectate", function(source, cb, targetId)
    local player = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(targetId)
    local playerCoords = xTarget.getCoords()
    player.setCoords(playerCoords)
    cb(true)
end)

ESX.RegisterServerCallback("admin:getPlayers", function(source,cb)
    cb(players or {})
end)

Citizen.CreateThread(function()
    players = {}
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local playerId = tonumber(xPlayers[i])
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            players[playerId] = {
                name = GetPlayerName(playerId),
                identifier = xPlayer.getIdentifier(),
                group = xPlayer.getGroup(),
                rpname = xPlayer.getName(),
                cash = xPlayer.getMoney(), 
                bank = xPlayer.getAccount("bank").money,
            }
        end
    end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    playerId = tonumber(playerId)
    players[playerId] = {
			name = GetPlayerName(playerId),
			identifier = xPlayer.getIdentifier(),
			group = xPlayer.getGroup(),
			rpname = xPlayer.getName(),
			cash = xPlayer.getMoney(), 
			bank = xPlayer.getAccount("bank").money,
    }
    TriggerClientEvent('admin:UpdatePlayer', -1, playerId, players[playerId])
end)

AddEventHandler('esx:playerDropped', function(playerId)
    playerId = tonumber(playerId)
    if players[playerId] then
        players[playerId] = nil
        TriggerClientEvent('admin:UpdatePlayer', -1, playerId, nil)
    end
end)

ESX.RegisterServerCallback("admin:getItemList", function(source,cb)
    cb(itemList)
end)

ESX.RegisterServerCallback("admin:getBanList", function(source,cb)
    if Config.SettingSystem.Bansystem then
        MySQL.Async.fetchAll('SELECT * FROM bans',{}, function(result)
        	for i=1, #result, 1 do
        		result[i].time = math.floor((result[i].time - os.time()) / 60)
        	end
          	cb(result)
        end)
    else
        cb({})
    end

 end)

ESX.RegisterServerCallback("admin:getJobs", function(source,cb)
    cb(jobList)
 end)


RegisterNetEvent("admin:GiveWeapon")
AddEventHandler("admin:GiveWeapon", function(playerID, weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(playerID)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveWeapon then
        if xTarget.hasWeapon(weapon) then
            xTarget.addWeaponAmmo(weapon, 50)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Added Ammo to your weapon') 
            local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มกระสุน '..ESX.GetWeaponLabel(weapon)..' ให้ '..GetPlayerName(playerID)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
            xTarget.addWeapon(weapon, 10)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'You have been given a '..ESX.GetWeaponLabel(weapon)) 
            local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มปืน '..ESX.GetWeaponLabel(weapon)..' ให้ '..GetPlayerName(playerID)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
            
        end
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You gave '..GetPlayerName(playerID)..' a '..ESX.GetWeaponLabel(weapon)) 
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:AddItem")
AddEventHandler("admin:AddItem", function(playerID, selectedItem, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveItem then
        local target = ESX.GetPlayerFromId(playerID)
        target.addInventoryItem(selectedItem, amount)
        TriggerClientEvent('esx:showNotification', source, "Gave "..selectedItem.." to "..GetPlayerName(playerID))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ให้ของกับ '..GetPlayerName(playerID).. ' ไอเทม '..ESX.GetItemLabel(selectedItem).. ' จำนวน '..amount
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)


RegisterNetEvent("admin:AddCash")
AddEventHandler("admin:AddCash", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddCash then
        local target = ESX.GetPlayerFromId(playerID)
        target.addMoney(amount)
        TriggerClientEvent('esx:showNotification', source, "Gave $"..amount.." Cash to "..GetPlayerName(playerID))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มเงิน '..GetPlayerName(playerID).. ' จำนวน '..amount
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:AddBank")
AddEventHandler("admin:AddBank", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddBank then
        local target = ESX.GetPlayerFromId(playerID)
        target.addAccountMoney("bank", amount)
        TriggerClientEvent('esx:showNotification', source, "Transfered $"..amount.." to "..GetPlayerName(playerID).."'s Bank Account")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มเงินธนาคาร '..GetPlayerName(playerID).. ' จำนวน '..amount
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent('admin:Kick')
AddEventHandler('admin:Kick', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanKick then
        DropPlayer(playerId, reason)
        TriggerClientEvent('esx:showNotification', source, "Kicked "..GetPlayerName(playerId))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เตะผู้เล่น '..GetPlayerName(playerId)
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

if Config.SettingSystem.Bansystem then
    RegisterNetEvent('admin:Ban')
    AddEventHandler('admin:Ban', function(playerId, time, reason)
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(playerId)
        local playerGroup = xPlayer.getGroup()
        if Config.Perms[playerGroup] and (Config.Perms[playerGroup].CanBanTemp and time ~= 0) or (Config.Perms[playerGroup].CanBanPerm and time == 0) then
            if time ~= 0 then
            	local timeToSeconds = time * 60
            	time = (os.time() + timeToSeconds)
            end

            MySQL.Async.execute('INSERT INTO bans (license, name, time, reason) VALUES (@license, @name, @time, @reason)',
                {   
                    ['license'] = xTarget.getIdentifier(), 
                    ['name'] = xTarget.getName(), 
                    ['time'] = time, 
                    ['reason'] = reason 
                },
                function(insertId)
                    DropPlayer(playerId, "You have been banned")
            end)
            TriggerClientEvent('esx:showNotification', source, "Banned "..GetPlayerName(playerId))
            local sendToDiscord = '' .. GetPlayerName(source) .. ' แบนผู้เล่น '..GetPlayerName(playerId)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
           admin.Error(source, "noPerms")
        end
    end)
end

RegisterNetEvent("admin:Promote")
AddEventHandler("admin:Promote", function (playerID, group)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local targetPlayer = ESX.GetPlayerFromId(playerID)
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanPromote then
        if group ~= "superadmin" or playerGroup == "superadmin" then
            targetPlayer.setGroup(group)
            TriggerClientEvent('esx:showNotification', source, "Promoted "..GetPlayerName(playerID).." to "..group)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ตั้งยศแอดมินกับ '..GetPlayerName(playerID)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        end
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Announcement")
AddEventHandler("admin:Announcement", function (message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAnnounce then
        TriggerClientEvent('chat:addMessage', -1, {color = { 255, 0, 0}, args = {"ANNOUNCEMENT ", message}})
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ประกาศ '..message
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Notification")
AddEventHandler("admin:Notification", function (playerID, message)
    local _source = playerID
    TriggerClientEvent('chat:addMessage', _source, {args = {"admin ", message}})
end)

RegisterNetEvent("admin:Teleport")
AddEventHandler("admin:Teleport", function (targetId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local temp_id = nil
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanTeleport then
        if action == "bring" then
            sourceMessage = "You brought a player"
            targetMessage = "You were summoned"
            xPlayer = ESX.GetPlayerFromId(source)
            xTarget = ESX.GetPlayerFromId(targetId)
            temp_id = source
        elseif action == "goto" then
            targetMessage = "You teleported to a player"
            xPlayer = ESX.GetPlayerFromId(targetId)
            xTarget = ESX.GetPlayerFromId(source)
            temp_id = targetId
        end
    
    
        if xTarget then
            local playerCoords = xPlayer.getCoords()
            TriggerClientEvent('admin_:teleport', xTarget.source, playerCoords)
            --xTarget.setCoords(playerCoords)
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ วาปกับ '..GetPlayerName(targetId)
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Player is not online.')        
        end
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterCommand('healall', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        TriggerClientEvent("admin.request", -1, "heal")
    end
    local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ healall'
    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
end)

RegisterCommand('tp', function(source, args)
    -- Check if the player is in the admin group
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        -- Assuming you have the player's server ID, you can get their PlayerPed object
        local player = GetPlayerPed(source)

        -- Set the player's position to the specified x, y, z coordinates
        SetEntityCoords(player, tonumber(args[1]), tonumber(args[2]), tonumber(args[3]), false, false, false, false)

        -- Send a message to the player to confirm the teleportation
        TriggerClientEvent('chat:addMessage', source, { args = { '^1Teleported to x:' .. args[1] .. ' y:' .. args[2] .. ' z:' .. args[3] }})
    else
        -- Send a message to the player if they are not in the admin group
        TriggerClientEvent('chat:addMessage', source, { args = { '^1You do not have permission to use this command.' }})
    end
end, true)

RegisterCommand('heal', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'admin' then
		-- heal another player - don't heal source
		if args[1] then
			local target = tonumber(args[1])
			
			-- is the argument a number?
			if target ~= nil then
				
				-- is the number a valid player?
				if GetPlayerName(target) then
					print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing a player!')
					TriggerClientEvent('esx_basicneeds:healPlayer', target)
					TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "You have been healed!")
                    local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ heal กับ '..GetPlayerName(target)
                    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
				else
					TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Player not found!")
				end
			else
				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
			end
		else
			-- heal source
			print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing!')
			TriggerClientEvent('esx_basicneeds:healPlayer', source)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ heal '
                    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
		end
	end
end)

RegisterCommand('kickall', function(source, args, user)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getGroup() == 'admin' then
		TriggerClientEvent('esx:kickall', -1)

    -- Azael Logs
    local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ kickall'
    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
	end
end)

RegisterServerEvent('esx:kickall')
AddEventHandler('esx:kickall', function (security_code, message)
    DropPlayer(source,'รีเซิฟนะอิอิ')
end)

RegisterCommand('reviveall', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
		TriggerClientEvent("admin.request", -1, "revive")
    end
    local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ reviveall'
    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
end)

RegisterCommand('fix', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
		TriggerClientEvent( 'wk:fixVehicle', source )
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ fix'
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end
end)

RegisterCommand('hij', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
		TriggerClientEvent( 'wk:hijack', source )
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ hij'
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end
end)

local frozen = {}

RegisterCommand('goto', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        targetMessage = "You teleported to a player"
        xPlayer = ESX.GetPlayerFromId(args[1])
        xTarget = ESX.GetPlayerFromId(source)
        temp_id = args[1]
        if xPlayer then
            if xTarget then
                local playerCoords = xPlayer.getCoords()
                TriggerClientEvent('admin_:teleport', xTarget.source, playerCoords)
                --xTarget.setCoords(playerCoords)
                if sourceMessage then
                    TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
                end
                TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
                local sendToDiscord = '' .. GetPlayerName(source) .. ' วาปไปยัง ' ..GetPlayerName(args[1])
                TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Player is not online.')        
            end
        end
    end
end)

local frozen = {}

RegisterCommand('bring', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        sourceMessage = "You brought a player"
            targetMessage = "You were summoned"
            xPlayer = ESX.GetPlayerFromId(source)
            xTarget = ESX.GetPlayerFromId(args[1])
            temp_id = source
        if xTarget then
            local playerCoords = xPlayer.getCoords()
            TriggerClientEvent('admin_:teleport', xTarget.source, playerCoords)
            --xTarget.setCoords(playerCoords)
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ได้ดึงผู้เล่นเข้าหาตัว ' ..GetPlayerName(args[1])
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Player is not online.')        
        end
    end
end)

local frozen = {}
RegisterCommand('tpm', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('admin.tpm', source)
    end
end)

RegisterNetEvent("admin:Slay")
AddEventHandler("admin:Slay", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSlay then
        TriggerClientEvent('admin:Slay', target)
        TriggerClientEvent('esx:showNotification', source, "You slayed "..GetPlayerName(target))
        TriggerClientEvent('esx:showNotification', target, "You were slayn by an admin.")
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:God")
AddEventHandler("admin:God", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGodmode then
        TriggerClientEvent('admin:God', target)
        TriggerClientEvent('esx:showNotification', source, "You enabled/disabled Godmode for "..GetPlayerName(target))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เปิด God '
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanFreeze then
        TriggerClientEvent('admin:Freeze', target)
        TriggerClientEvent('esx:showNotification', source, "You Froze/Unfroze "..GetPlayerName(target))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ได้แช่แข็ง ' ..GetPlayerName(args[1])
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

if Config.SettingSystem.Bansystem then
    RegisterNetEvent("admin:Unban")
    AddEventHandler("admin:Unban", function(license)
        local xPlayer = ESX.GetPlayerFromId(source)
        local playerGroup = xPlayer.getGroup()
        if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanUnban then
            MySQL.Async.execute('DELETE FROM bans WHERE license = @license',
                {   
                    ['license'] = license, 
                },
                function(insertId)
                    print("player unbanned")
            end)
            TriggerClientEvent('esx:showNotification', source, "Unbanned Player. ("..license..")")
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ได้ปลดแบน ' ..license
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
           admin.Error(source, "noPerms")
        end
    end)
end

RegisterNetEvent("admin:setJob")
AddEventHandler("admin:setJob", function(target, job, rank)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSetJob then
        targetPlayer.setJob(job, rank)
        TriggerClientEvent('esx:showNotification', source, "Changed "..GetPlayerName(target).." job to "..job)
        TriggerClientEvent('esx:showNotification', target, "Your job was changed to "..job)
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ตั้งหน่วยงานให้กับ '..GetPlayerName(target)..' เป็น ' ..job.. ' '
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:revive")
AddEventHandler("admin:revive", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanRevive then
        TriggerClientEvent("admin.request", target, "revive")
        TriggerClientEvent('esx:showNotification', source, "You revived "..GetPlayerName(target))
        TriggerClientEvent('esx:showNotification', target, "You have been revived by an admin")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ revive '..GetPlayerName(target)
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:healspecific")
AddEventHandler("admin:healspecific", function(target) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].healspecific then 
        TriggerClientEvent("admin.request", target, "heal")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ heal '..GetPlayerName(target)
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:reviveall")
AddEventHandler("admin:reviveall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].reviveall then 
        TriggerClientEvent("admin.request", -1, "revive")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ reviveall '
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:healall")
AddEventHandler("admin:healall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].healall then 
        TriggerClientEvent("admin.request", -1, "heal")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ healall '
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
        admin.Error(source, "noPerms")
    end
end)

function admin.Error(source, message)
    if message == "noPerms" then
        --TriggerClientEvent('chat:addMessage', source, {args = {"admin ", " You do not have permission for this."}})
    else
        TriggerClientEvent('chat:addMessage', source, {args = {"admin ", message}})
    end
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end
