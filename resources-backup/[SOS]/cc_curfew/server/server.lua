ESX = nil
local breakDelCar = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




RegisterCommand('sos', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
    if args[1] then
        if xPlayer.getJob().name == 'police' then
            TriggerClientEvent("cc_curfew:showMenu",-1,table.unpack(args))
            local fal = 'กรมตำรวจ '
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 80, 245, 0.7), rgba(0, 80, 245, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/><img src="https://img5.pic.in.th/file/secure-sv1/pd.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}<br></div>',
                args = { fal, "SOS จะทำการ \"เคอร์ฟิว\" โดยจะใช้มาตราการสูงสุดกับทุกคนในพื้นที่ ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่ดังกล่าวด้วย" }
            })

        end
    end
end)

RegisterCommand('csos', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getJob().name == 'police' then
        TriggerClientEvent("cc_curfew:hideMenu",-1)
        local fal = 'กรมตำรวจ '
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 80, 245, 0.7), rgba(0, 80, 245, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/><img src="https://img5.pic.in.th/file/secure-sv1/pd.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}<br></div>',
            args = { fal, "ยกเลิกการเคอร์ฟิว" }
        })

    end
end)
