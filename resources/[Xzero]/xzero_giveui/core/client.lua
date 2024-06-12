local a = nil
-- RegisEvent(
--     true,
--     GetName(":client:Verify:Receive:SLZOAJSUZASHIAJOJZAIS"),
--     function(b)
--         a = b
--     end
-- )
Citizen.CreateThread(
    function()
        -- local c = GetGameTimer()
        -- while a == nil and GetGameTimer() - c <= 30 * 1000 do
        --     TriggerServerEvent(GetName(":server:Verify:Request:SLZOAJSUZASHIAJOJZAIS"))
        Wait(1000)
        -- end
        xZero.Init()
    end
)

SetTextFont(fontId)
SetTextProportional(0)
fontId = RegisterFontId('Mitr')
RegisterFontFile('Mitr')

ESX = nil
xZero = {}
xZero.Funcs = {}
C = {}
xZero.Prefix = "giveui_"
xZero.ImagesLoaded = false
_FontId = 0

xZero.Init = function()
    Wait(500)
    -- if a then
        ConfigBaseVaild()
        while ESX == nil do
            TriggerEvent(
                Config.Base.getSharedObject,
                function(d)
                    ESX = d
                end
            )
            Wait(1)
        end
        while true do
            if ESX.GetPlayerData() and ESX.GetPlayerData().inventory and #ESX.GetPlayerData().inventory > 0 then
                break
            end
            Wait(1)
        end
        xZero.Inited()
    -- else
    --     print("^1Verify:ERROR^7")
    -- end
end
xZero.Inited = function()
    pr(("Inited - version_current:^3%s^7"):format(version_current))
    if Config.Text_Font then
        RegisterFontFile(Config.Text_Font)
        _FontId = RegisterFontId(Config.Text_Font)
    end
    xZero.Funcs.ImagesLoaded()
    RegisEvent(
        true,
        GetName(":client:On_GiveItem"),
        function(e)
            if e == nil or e.player == nil or e.item == nil or e.number == nil or type(e.number) ~= "number" then
                return
            end
            if
                e.item.type ~= "item_weapon" and
                    ((e.item.type == "item_standard" or e.item.type == "item_account" or e.item.type == "item_money") and
                        e.item.count < e.number)
             then
                return
            end
            if xZero.Funcs.ItemsBlackList(e.item.name:lower()) then
                return
            end
            local f = e.player
            local g = GetPlayerPed(GetPlayerFromServerId(f))
            if xZero.Funcs.PlayerPed_Vaild(g) then
                TriggerServerEvent(
                    GetName(":server:On_GiveItem_All"),
                    {
                        Source_PlayerSvId = GetPlayerServerId(PlayerId()),
                        Target_PlayerSvId = f,
                        item = e.item,
                        count = e.item.type == "item_weapon" and 0 or e.number,
                        pos = GetEntityCoords(PlayerPedId())
                    }
                )
            end
        end
    )
    RegisEvent(
        true,
        GetName(":client:GiveUI:Receive"),
        function(e)
            if e and e.Source_PlayerSvId and e.Target_PlayerSvId and e.item_name and e.item_label and e.count then
                local h = GetEntityCoords(PlayerPedId())
                local i = e.pos ~= nil and vector3(e.pos.x, e.pos.y, e.pos.z) or nil
                local j = i ~= nil and #(h - i) or nil
                if j ~= nil and j >= 100 then
                    return
                end
                local k = GetPlayerPed(GetPlayerFromServerId(e.Source_PlayerSvId))
                local g = GetPlayerPed(GetPlayerFromServerId(e.Target_PlayerSvId))
                if xZero.Funcs.PlayerPed_Vaild(k) and xZero.Funcs.PlayerPed_Vaild(g) then
                    GiveUIPedToPed(k, g, e.item_name, e.item_label, e.count)
                end
            end
        end
    )
end
xZero.Funcs.ImagesLoaded = function()
    TriggerEvent(
        "xzero_giveui:export:ImagesLoaded",
        function(e)
            local l = 0
            if Config.Images_Custom and #Config.Images_Custom > 0 then
                for m, n in ipairs(Config.Images_Custom) do
                    local o = CreateRuntimeTxd(xZero.Prefix .. n)
                    CreateRuntimeTextureFromImage(o, n, ("images/%s.png"):format(n))
                    l = l + 1
                end
            end
            xZero.ImagesLoaded = true
            pr(("ImagesLoaded | Inventory:^3%s^7 | Custom:^3%s^7 | Finsh:^3%s^7"):format(e.loaded, l, e.loaded + l))
        end,
        {Prefix = xZero.Prefix, ESX_Inventory = ESX.GetPlayerData().inventory or nil}
    )
end
GiveUIPedToPed = function(p, q, r, s, t)
    local u = C.PedUI(p, "source")
    local v = C.PedUI(q, "target")
    local w = {dict = xZero.Prefix .. r, name = r}
    u.PlayTaskAnim()
    v.PlayTaskAnim()
    u.ShowUI(
        true,
        w,
        s,
        t,
        function()
            v.ShowUI(
                true,
                w,
                s,
                t,
                function()
                end
            )
        end
    )
end
C.PedUI = function(x, y)
    local self = {}
    self.ped = x
    self.type = y
    self.CFG = Config.Options[self.type]
    self.IsShow = false
    self.IsClear = false
    self.IsPrograss = false
    self.IsDead = function()
        return IsEntityDead(self.ped)
    end
    self.GetBoneCoord = function(z)
        local A = GetPedBoneIndex(self.ped, z)
        if A and A > 0 then
            return GetWorldPositionOfEntityBone(self.ped, A)
        end
        return nil
    end
    self.PlayTaskAnim = function()
        if not self.IsDead() and self.CFG.anim.enabled then
            ESX.Streaming.RequestAnimDict(
                self.CFG.anim.dict,
                function()
                    Citizen.CreateThread(
                        function()
                            TaskPlayAnim(
                                self.ped,
                                self.CFG.anim.dict,
                                self.CFG.anim.name,
                                8.0,
                                8.0,
                                -1,
                                50,
                                0,
                                false,
                                false,
                                false
                            )
                            Wait(1500)
                            ClearPedTasks(self.ped)
                        end
                    )
                end
            )
        end
    end
    self.ShowUI = function(B, w, s, t, D)
        if Config.Time_Show <= 0 then
            D(self)
            return
        end
        self.IsShow = B
        if self.IsShow then
            Wait(10)
            if self.IsPrograss then
                return
            end
            self.IsPrograss = true
            Citizen.CreateThread(
                function()
                    while self.IsShow and DoesEntityExist(self.ped) do
                        Wait(1)
                        local E = self.GetBoneCoord(0x6F06)
                        if E then
                            if #(GetGameplayCamCoords() - E) <= Config.Distance then
                                if Config.Text_Show or Config.Text_Count_Show then
                                    xZero.Funcs.DrawText3D(
                                        E + vector3(0.0, 0.0, 0.25),
                                        ("~y~%s~g~%s"):format(
                                            Config.Text_Show and s or "",
                                            Config.Text_Count_Show and t > 0 and " [x" .. t .. "]" or ""
                                        ),
                                        Config.Text_Size,
                                        _FontId
                                    )
                                end
                                if Config.Image_Show then
                                    xZero.Funcs.DrawImage(w, E)
                                end
                            end
                        end
                    end
                    self.IsShow = false
                    self.IsPrograss = false
                    if D ~= nil then
                        D(self)
                        return
                    end
                end
            )
            if Config.Time_Show and Config.Time_Show > 0 then
                SetTimeout(
                    Config.Time_Show,
                    function()
                        self.IsShow = false
                    end
                )
            end
        end
    end
    return self
end
xZero.Funcs.DrawText3D = function(F, G, H, I)
    local J, K, L = World3dToScreen2d(F.x, F.y, F.z)
    if J then
        local M = GetGameplayCamCoords()
        local N = GetDistanceBetweenCoords(M.x, M.y, M.z, F.x, F.y, F.z, 1)
        local O = H / N * 2
        local P = 1 / GetGameplayCamFov() * 100
        O = O * P
		SetTextFont(fontId)
        SetTextProportional(0)
        fontId = RegisterFontId('Mitr')
        RegisterFontFile('Mitr')
        SetTextScale(0.0 * O, 0.55 * O)
        SetTextFont(I or 0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(G)
        DrawText(K, L)
    end
end
xZero.Funcs.DrawImage = function(w, E)
    if HasStreamedTextureDictLoaded(w.dict) then
        local Q, R, S = World3dToScreen2d(E.x, E.y, E.z)
        if Q then
            local T = GetGameplayCamCoords()
            local U = #(E - T)
            local V = 1 / U * Config.Image_Size_H
            local W = 1 / U * Config.Image_Size_W
            DrawSprite(w.dict, w.name, R, S, V, W, 0.0, 255, 255, 255, 255)
        end
    end
end
xZero.Funcs.PlayerPed_Vaild = function(X)
    if X and X > 0 and DoesEntityExist(X) then
        return true
    end
    return false
end
xZero.Funcs.ItemsBlackList = function(Y)
    if Config.Item_BlackList and #Config.Item_BlackList > 0 then
        for m, n in ipairs(Config.Item_BlackList) do
            if n:lower() == Y then
                return true
            end
        end
    end
    return false
end
ConfigBaseVaild = function()
    if Config.Base == nil then
        Config.Base = {getSharedObject = "esx:getSharedObject"}
    end
end
