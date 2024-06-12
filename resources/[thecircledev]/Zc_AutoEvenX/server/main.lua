ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local daysoftheweek = {
    "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
}

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.AutoEven) do
            local daynow = daysoftheweek[os.date("*t").wday]
            if v.day == daynow or v.day == 'Everyday' then
                local currentTime = os.date("%X")
                if currentTime == v.time then
                    Citizen.CreateThread(function() v.event() end)
                end
            end
        end
        Wait(1000)
    end
end)
