RegisterNetEvent("cc_alertui:alertDepartment")
AddEventHandler("cc_alertui:alertDepartment", function(title, actionType, value, tip, location,timeout,department,sex,streetName)
    --print(department)
    SendNUIMessage({
            title = title,
            actionType = actionType,
            value = value,
            tip = tip,
            location = location,
            timeout = timeout,
            type = department,
            sex = sex,
            streetName = streetName
        })
end)

RegisterNetEvent("cc_alertui:confirmDepartment")
AddEventHandler("cc_alertui:confirmDepartment", function(playerName,tip,department,timeout)
    --print(department)
    SendNUIMessage({
        playerName = playerName,
        tip = tip,
        type=department,
        timeout = timeout,
    })
end)
