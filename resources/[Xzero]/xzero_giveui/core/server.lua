-- local a = nil
Citizen.CreateThread(
    function()

        -- a = true
        -- -- version_lasted = g.version_lasted
        -- pr(("^0Verify Success^7"):format())
        
        xZero.Init()
    --[[     local b =
            json.encode(
            {
                Server = GetConvar("sv_hostname"),
                MaxClients = GetConvar("sv_maxclients"),
                CurrentResourceName = script_name,
                version_current = version_current
            }
        )
        local c = "http://xzero.in.th/xFiveM/xzero_scripts/xzero_giveui.php?x=" .. math.random(10000000, 99999999)
        PerformHttpRequest(
            c,
            function(d, e, f)
                if d == 200 then
                    local g = json.decode(e)
                    if g and g.status == "success" then
                        a = true
                        version_lasted = g.version_lasted
                        pr(("^0Verify Success^7"):format())
                        xZero.Init()
                    else
                        a = false
                        pr(("^1Verify Error^7"):format())
                    end
                else
                    a = false
                    pr(("^1Verify Error Request TimeOut - %s^7"):format(d))
                end
            end,
            "POST",
            b,
            {["Content-Type"] = "application/json"}
        ) ]]
    end
)
-- RegisEvent(
--     true,
--     GetName(":server:Verify:Request:SLZOAJSUZASHIAJOJZAIS"),
--     function()
--         TriggerClientEvent(GetName(":client:Verify:Receive:SLZOAJSUZASHIAJOJZAIS"), source, a)
--     end
-- )
ESX = nil
xZero = {}
xZero.Init = function()
    Wait(500)
    -- if a then
        while ESX == nil do
            TriggerEvent(
                Config.Base.getSharedObject,
                function(h)
                    ESX = h
                end
            )
            Wait(1)
        end
        -- __Version_Init()
        xZero.Inited()
    -- end
end
xZero.Inited = function()
    RegisEvent(
        true,
        GetName(":server:On_GiveItem"),
        function(i)
            if i and i.Target_PlayerSvId and i.item and i.count then
                local j = source
                TriggerClientEvent(
                    GetName(":client:GiveUI:Receive"),
                    -1,
                    {
                        Source_PlayerSvId = j,
                        Target_PlayerSvId = i.Target_PlayerSvId,
                        item_name = i.item.name,
                        item_label = i.item.label,
                        count = i.count
                    }
                )
            end
        end
    )
    RegisEvent(
        true,
        GetName(":server:On_GiveItem_All"),
        function(i)
            if i and i.Source_PlayerSvId and i.Target_PlayerSvId and i.item and i.count then
                TriggerClientEvent(
                    GetName(":client:GiveUI:Receive"),
                    -1,
                    {
                        Source_PlayerSvId = i.Source_PlayerSvId,
                        Target_PlayerSvId = i.Target_PlayerSvId,
                        item_name = i.item.name,
                        item_label = i.item.label,
                        count = i.count,
                        pos = i.pos or nil
                    }
                )
            end
        end
    )
end
-- __Version_Init = function()
--     if tonumber(version_current) < tonumber(version_lasted) then
--         pr(("Inited - version_current:^1%s^7 (version_lasted:^3%s^7)"):format(version_current, version_lasted))
--     else
--         pr(("Inited - version_current:^3%s^7"):format(version_current))
--     end
-- end
