--print("test")

local customJob = {
    card_merchant_1 = {
        item = "card_merchant_1",
        label = 'พ่อค้า',
        grade_label = "พ่อค้ามือใหม่"
    },
    card_merchant_2 = {
        item = "card_merchant_2",
        label = 'พ่อค้า',
        grade_label = "พ่อค้าฝึกฝน"
    },
    card_merchant_3 = {
        item = "card_merchant_3",
        label = 'พ่อค้า',
        grade_label = "พ่อค้าเชี่ยวชาญ"
    },
    card_merchant_4 = {
        item = "card_merchant_4",
        label = 'พ่อค้า',
        grade_label = "พ่อค้าเซียน"
    },
}
RegisterNetEvent('cc_uicard:showCardClosetPlayer')
AddEventHandler('cc_uicard:showCardClosetPlayer', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetSource = ESX.GetPlayerFromId(target)
    local xPlayerJob = "None"

    for _,v in pairs(customJob) do
       local xItem =  xPlayer.getInventoryItem(v.item)
        xPlayerJob = xPlayer.getJob()
        if xItem then
            if xItem.count > 0 then
                xPlayerJob = v
                break
            end
        end
    end
        local data = {
            name = xPlayer.getName(),
            dob = xPlayer.get('dateofbirth'),
            height = xPlayer.get('height'),
            job = xPlayerJob.label,
            position = xPlayerJob.grade_label,
        }
            if xPlayer.get('sex') == 'm' then data.sex = 'MALE' else data.sex = 'FEMALE' end

    TriggerClientEvent("cc_uicard:showCardClosetPlayer",targetSource.source,data)
end )

RegisterNetEvent('cc_uicard:showCardYourself')
AddEventHandler('cc_uicard:showCardYourself', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerJob = "None"

    for _,v in pairs(customJob) do
        local xItem =  xPlayer.getInventoryItem(v.item)
        xPlayerJob = xPlayer.getJob()
        if xItem then
            if xItem.count > 0 then
                xPlayerJob = v
                break
            end
        end
    end
    local data = {
        name = xPlayer.getName(),
        dob = xPlayer.get('dateofbirth'),
        height = xPlayer.get('height'),
        job = xPlayerJob.label,
        position = xPlayerJob.grade_label,
    }
    if xPlayer.get('sex') == 'm' then data.sex = 'MALE' else data.sex = 'FEMALE' end

    TriggerClientEvent("cc_uicard:showCardClosetPlayer",xPlayer.source,data)
end )