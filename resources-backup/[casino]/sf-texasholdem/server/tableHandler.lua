local tableString = [[
    -- %s
    {
		coords = %s,
		heading = %s,
		model = %s,
		spawn = %s,
		texture = %s,
		type = "normal",
		smallBlind = 50,
	},
]]
if(Config.DevMode) then
    RegisterNetEvent("sf-txh:saveTable", function(model, coords, heading, texture)
        local text = LoadResourceFile(GetCurrentResourceName(), "tables.txt")
        if(not text) then text = "" end
        text = text .. tableString:format(os.date("%x %X"), coords, heading, model, texture ~= nil, tostring(texture)) .. "\n"
        SaveResourceFile(GetCurrentResourceName(), "tables.txt", text, -1)
    end)
end