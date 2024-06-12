xZR_GiveUI = {}
AddEventHandler(
    "xzero_giveui:export:ImagesLoaded",
    function(a, b)
        local c = 0
        if b == nil or b.Prefix == nil then
            a({status = false, loaded = c})
            return
        end
        if b.ESX_Inventory == nil or #b.ESX_Inventory <= 0 then
            a({status = false, loaded = c})
            return
        end
        Citizen.CreateThread(
            function()
                for d, e in ipairs(b.ESX_Inventory) do
                    CreatedTxd(b.Prefix, e.name, ("html/img/items/%s.png"):format(e.name))
                    c = c + 1
                    Wait(1)
                end
                for d, e in ipairs({"money", "cash", "black_money"}) do
                    CreatedTxd(b.Prefix, e, ("html/img/items/%s.png"):format(e))
                    c = c + 1
                    Wait(1)
                end
                local f = ESX.GetWeaponList()
                if f and #f > 0 then
                    for d, e in ipairs(f) do
                        CreatedTxd(b.Prefix, e.name, ("html/img/items/%s.png"):format(e.name))
                        c = c + 1
                        Wait(1)
                    end
                end
                a({status = true, loaded = c})
            end
        )
    end
)
function CreatedTxd(g, h, i)
    local j = CreateRuntimeTxd(g .. h)
    CreateRuntimeTextureFromImage(j, h, i)
end
