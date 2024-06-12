currentNPCZone = nil
for _,v in pairs(Config.NpcPolyZone) do
    print(v.name)
    if v.enable == true then
        local npcZone = CircleZone:Create(v.coords, v.distance, {
            name = v.name,
            debugPoly = v.debug,
        })

        npcZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                settingNPC()
                currentNPCZone = npcZone.name
                print('In '..currentNPCZone)
            else
                currentNPCZone = nil
            end
        end)
    end
end



