script_name = GetCurrentResourceName()
GetName = function(a)
    return script_name .. a
end
RegisEvent = function(b, a, c)
    if b then
        RegisterNetEvent(a)
    end
    AddEventHandler(a, c)
end
pr = function(d)
    print(("^2[%s]^7 %s"):format(script_name, d))
end
