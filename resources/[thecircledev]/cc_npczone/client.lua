local currentnpcZone = nil
for _,v in pairs(Config.NpcPolyZone) do
    print(v.name)
    if v.enable == true then
        local npcZone = CircleZone:Create(v.coords, v.distance, {
            name = v.name,
            debugPoly = v.debug, 
        })

        npcZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                if not ongoingDelObj then
                    currentnpcZone = npcZone.name
                    print('In '..currentnpcZone)
                end
            else
                currentnpcZone = nil
            end
        end)
    end
end



