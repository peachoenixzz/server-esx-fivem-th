RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
     --   TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end

    print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
       -- TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- player join messages
AddEventHandler('chat:init', function()
    --TriggerClientEvent('esx:showNotification', -1,'~g~'.. GetPlayerName(source) .. ' ~y~Joined')
	
	TriggerClientEvent("PorNotify:SendNotification", source, {
            text = '' .. GetPlayerName(source) .. 'Joined to server',
            queue = "global", 
            type = "bottomCenter",
		    timeout = 2000,
		    layout = "top"
		})
end)

AddEventHandler('playerDropped', function(reason)
    --TriggerClientEvent('esx:showNotification', -1,'~r~' .. GetPlayerName(source) ..' ~y~Exting')
	TriggerClientEvent("PorNotify:SendNotification", source, {
            text = '' .. GetPlayerName(source) ..' ออกจากเซิฟเวอร์ (' .. reason .. ')',
            queue = "global", 
		    type = "bottomCenter",
		    timeout = 2000,
		    layout = "top"
		})
end)

RegisterCommand('say', function(source, args, rawCommand)
    --TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)
