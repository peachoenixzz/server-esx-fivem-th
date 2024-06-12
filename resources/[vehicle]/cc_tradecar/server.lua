function checkZoneTradeCar()
    RegisterServerCallback("cc_tradecar:checkInZone", function(source, cb)
        TriggerClientEvent("cc_tradecar:checkInZone", source, function(result)
            -- Handle the result returned by the client-side callback
            return cb(result)
        end)
    end)
end

