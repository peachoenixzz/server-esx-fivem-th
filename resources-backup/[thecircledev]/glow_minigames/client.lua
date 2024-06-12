local callback = nil
local inMinigame = false

local minigamesTable = { -- default game settings
    path = {game = "path", settings = {gridSize = 7, lives = 1, timeLimit = 10000}},
    spot = {game = "spot", settings = {gridSize = 2, timeLimit = 8000, charSet = "runes", required = 5}},
    math = {game = "math", settings = {timeLimit = 300000}}
}

local function StartMinigame(cb, gameName, gameSettings)
    if inMinigame then return end

    if minigamesTable[gameName] then
        if not gameSettings then
            gameSettings = minigamesTable[gameName].settings
        end

        SendNUIMessage({
            action = "startGame",
            game = gameName,
            settings = gameSettings
        })
        
        SetNuiFocus(true, true)
        inMinigame = true

        callback = cb
    end
end

RegisterNUICallback("endGame", function(data, cb)
    callback(data.success)
    inMinigame = false
    SetNuiFocus(false, false)
end)

exports('StartMinigame', StartMinigame)

RegisterCommand("minitest", function(source, args)
    StartMinigame(function(success)
        print(success)
    end, args[1])
end, false)
