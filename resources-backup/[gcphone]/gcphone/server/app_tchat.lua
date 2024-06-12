--
--  LEAKED BY S3NTEX -- 
--  https://discord.gg/aUDWCvM -- 
--  fivemleak.com -- 
--  fkn crew --
function TchatGetMessageChannel(a,b)
    MySQL.Async.fetchAll("SELECT * FROM phone_app_chat WHERE channel = @channel order by id DESC LIMIT 45",{['@channel']=a},b)
end

function TchatAddMessage(a,b,xPlayer)
    local message = xPlayer.getName().." : "..b
    MySQL.Async.insert("INSERT INTO phone_app_chat (channel, message) VALUES(@channel, @message)",{['@channel']=a,['@message']=message},function(c)
        MySQL.Async.fetchAll("SELECT * from phone_app_chat WHERE id = @id",{['@id']=c},function(d)TriggerClientEvent('gcPhone:tchat_receive',-1,d[1])
        end)
    end)
end

RegisterServerEvent('gcPhone:tchat_channel')
AddEventHandler('gcPhone:tchat_channel',function(a)
    local b=tonumber(source)
    TchatGetMessageChannel(a,function(c)
        TriggerClientEvent('gcPhone:tchat_channel',b,a,c)
    end)
end)

RegisterServerEvent('gcPhone:tchat_addMessage')
AddEventHandler('gcPhone:tchat_addMessage',function(a,b)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    TchatAddMessage(a,b,xPlayer)
end)


