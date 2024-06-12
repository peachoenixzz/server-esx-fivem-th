
local resourceName = GetCurrentResourceName()
local script_name = 'AutoPilot'



RegisterCommand("autopilot", function(source, args, raw)
    local src = source
    TriggerClientEvent("autopilot:start", src)
end)

if GetCurrentResourceName() == script_name then
    print('^2['..script_name..']^0 Detials :^2 Success !^0')
end