
local authKey = {}
local responseData = {}

ESX.RegisterServerCallback('cc_authlogin:checkLogin', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if type(authKey[source]) == "nil" then
        authKey[source] = nil
    end
    if authKey[source] == nil then
        local url = "https://mongkol.dev/api/login/users"
        local data = json.encode({identifier = xPlayer.identifier}) -- convert data to JSON format
        PerformHttpRequest(url, function(statusCode, responseText, headers)
            if statusCode == 200 then
                responseData[source] = json.decode(responseText) -- convert response to Lua table
                authKey[source] = responseData[source].token
                cb(authKey[source])
                Wait(1000)
                print("Server response:", authKey[source])
                authKey[source] = nil
                responseData[source] = nil
                collectgarbage("collect")
            else
                cb(authKey[source])
                print("err:",json.decode(responseText).." authkey ="..authKey[source])
                print("Server returned status code:", statusCode)
                authKey[source] = nil
                responseData[source] = nil
                collectgarbage("collect")
                return
            end
        end, "POST", data, {["Content-Type"] = "application/json"})
    end
end )