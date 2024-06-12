--[[

  ESX RP Chat

--]]

ESX = nil
local holfz_ooc_playerlist = {}

TriggerEvent(
  "esx:getSharedObject",
  function(obj)
    ESX = obj
  end
)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end
  
-- TriggerEvent('es:addCommand', 'me', function(source, args, user)
--    local name = getIdentity(source)
--    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
-- end) 



  --- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  ---    local name = getIdentity(source)
  ---    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 
  TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)

--[[
 RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0} ได้ทวีต:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)

 RegisterCommand('anontweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(11)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @Anonymous:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)
]]
RegisterCommand('cc', function(source, args, rawCommand)
    local Player = ESX.GetPlayerFromId(source)
	-- local group = xPlayer.getGroup()
	if Player["job"]["name"] == "admin" then
	
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = 'แอดมิน'

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(255, 204, 50, 0.8), rgba(255, 168, 0, 0.8)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/><img src="https://img2.pic.in.th/pic/announcement.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}<br></div>',
        args = { fal, msg}
    })
	end
end, false)

RegisterCommand('pd', function(source, args, rawCommand)
    
	local Player = ESX.GetPlayerFromId(source)

	if Player["job"]["name"] == "police" then
	
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = 'กรมตำรวจ '
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 80, 245, 0.7), rgba(0, 80, 245, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/><img src="https://img5.pic.in.th/file/secure-sv1/pd.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}<br></div>',
        args = { fal, msg }
    })

	local sendToDiscord = '' .. Player.name .. ' หน่วยงาน: ' .. Player.job.name .. ' ประกาศ: ' .. msg .. ''
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'AnnounceAgency', sendToDiscord, Player.source, '^5')
	end
end, false)
RegisterCommand('md', function(source, args, rawCommand)
    
	local Player = ESX.GetPlayerFromId(source)

	if Player["job"]["name"] == "police" then
	
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = ' โรงพยาบาล'
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(255, 0, 0, 0.7), rgba(255, 0, 0, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/><img src="https://img2.pic.in.th/pic/md.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}<br></div>',
        args = { fal, msg }
    })

	local sendToDiscord = '' .. Player.name .. ' หน่วยงาน: ' .. Player.job.name .. ' ประกาศ: ' .. msg .. ''
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'AnnounceAgency', sendToDiscord, Player.source, '^9')
	end
end, false)

-- RegisterCommand('mc', function(source, args, rawCommand)
    
-- 	local Player = ESX.GetPlayerFromId(source)

-- 	if Player["job"]["name"] == "mechanic" then
	
-- 	local playerName = GetPlayerName(source)
--     local msg = rawCommand:sub(4)
--     local name = getIdentity(source)
--     fal = '⚒ ประกาศจาก อู่ช่าง '
--     TriggerClientEvent('chat:addMessage', -1, {
--         template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(255, 150, 50, 0.7), rgba(255, 150, 50, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center;  font-size: 18px;"/><img src="img/circle.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}<br></div>',
--         args = { fal, msg }
--     })

-- 	local sendToDiscord = '' .. Player.name .. ' หน่วยงาน: ' .. Player.job.name .. ' ประกาศ: ' .. msg .. ''
-- 	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'AnnounceAgency', sendToDiscord, Player.source, '^3')
-- 	end
-- end, false)

-- RegisterCommand('lm', function(source, args, rawCommand)
    
-- 	local Player = ESX.GetPlayerFromId(source)

-- 	if Player["job"]["name"] == "foodpanda" then
	
-- 	local playerName = GetPlayerName(source)
--     local msg = rawCommand:sub(4)
--     local name = getIdentity(source)
--     fal = '🛵 ประกาศจาก LineMan '
--     TriggerClientEvent('chat:addMessage', -1, {
--         template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(260, 179, 113, 0.7), rgba(60, 179, 113, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center;  font-size: 18px;"/><img src="img/circle.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}<br></div>',
--         args = { fal, msg }
--     })

-- 	-- local sendToDiscord = '' .. Player.name .. ' หน่วยงาน: ' .. Player.job.name .. ' ประกาศ: ' .. msg .. ''
-- 	-- TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'AnnounceAgency', sendToDiscord, Player.source, '^3')
-- 	end
-- end, false)

-- RegisterCommand('ooc', function(source, args, rawCommand)
    -- local playerName = GetPlayerName(source)
    -- local msg = rawCommand:sub(5)
    -- local name = getIdentity(source)
	
	-- local isFound = false
	-- local _source = source
	-- if playerName ~= " " or playerName ~= nil or playerName ~= "" then
		-- for _,v in pairs(holfz_ooc_playerlist) do
			-- if(name["identifier"] == v.steam) then
				-- isFound = true
				-- break
			-- end	
		-- end
	-- else
		-- isFound = true
	-- end

	-- if(isFound == false) then

		-- TriggerClientEvent("chatMessage", source, "[OOC]", {0, 255, 0}, " OOC Chat Enabled")
		-- local nameisfound = false
		-- for _,v in pairs(holfz_ooc_playerlist) do
			-- if(name["identifier"] == v.steam) then
				-- if(source == v.id) then
					-- nameisfound = true
					-- break
				-- else
					-- for i=1, #holfz_ooc_playerlist, 1 do
						-- if holfz_ooc_playerlist[i].steam == name["identifier"] then
							-- if holfz_ooc_playerlist[i].steam ~= " " or name["identifier"] ~= " " or holfz_ooc_playerlist[i].steam ~= nil or name["identifier"] ~= nil or holfz_ooc_playerlist[i].steam ~= "" or name["identifier"] ~= "" then
								-- table.remove(holfz_ooc_playerlist, i)
								-- break
							-- end
						-- end
					-- end
					-- nameisfound = false
					-- break
				-- end
			-- end		
		-- end
		-- if not nameisfound then
			-- table.insert(holfz_ooc_playerlist, {steam = name["identifier"], id = source})
		-- end
	-- elseif(isFound == true) then

		-- TriggerClientEvent("chatMessage", source, "[OOC]", {255, 0, 0}, " OOC Chat Disable")
		-- for i=1, #holfz_ooc_playerlist, 1 do
			-- if holfz_ooc_playerlist[i].steam == name["identifier"] then
				-- if holfz_ooc_playerlist[i].steam ~= " " or name["identifier"] ~= " " or holfz_ooc_playerlist[i].steam ~= nil or name["identifier"] ~= nil or holfz_ooc_playerlist[i].steam ~= "" or name["identifier"] ~= "" then
					-- table.remove(holfz_ooc_playerlist, i)
					-- break
				-- end
			-- end
		-- end
	-- end
-- end, false)

--AddEventHandler('chatMessage', function(source, playername, message)
--	local isFound = false
--	local _source = source
--	local name = getIdentity(source)
--
--	if name["identifier"] ~= " " or name["identifier"] ~= nil or name["identifier"] ~= "" then
--		for _,v in pairs(holfz_ooc_playerlist) do
--			if(name["identifier"] == v.steam) then
--				isFound = true
--				break
--			end
--		end
--	else
--		isFound = true
--	end
--
--	if(isFound == true) then
--		if(string.sub(message, 1, 1) ~= "/") then
--			local fal = name.firstname .. " " .. name.lastname
--			for _,v in pairs(holfz_ooc_playerlist) do
--				TriggerClientEvent('chat:addMessage', v.id, {
--					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 7px; width: 605px"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
--					args = { fal, message }
--				})
--			end
--		end
--	end
--end)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
