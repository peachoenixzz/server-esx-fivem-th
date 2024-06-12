--===== FiveM Script: ========================================
--= DB - Health and Armor
--===== Developed By: ========================================
--= Azael Dev <contact@azael.dev>
--===== Website: =============================================
--= https://www.azael.dev/
--===== License: =============================================
--= You are not allowed to sell this script or edit
--============================================================

---@type string, string qb-core, qb
local RESOURCE, DIRECTORY = ...                             -- WARN: DO NOT EDIT !!!

---@type table
local QBCore = exports[RESOURCE]:GetCoreObject()

---Database (Query)
FRAMEWORK.Database = {
    SELECT_HEALTH_COLUMN = 'SELECT `health` FROM `players`',
    ADD_HEALTH_COLUMN = 'ALTER TABLE `players` ADD COLUMN `health` INT(11) DEFAULT NULL',
    SELECT_ARMOUR_COLUMN = 'SELECT `armour` FROM `players`',
    ADD_ARMOUR_COLUMN = 'ALTER TABLE `players` ADD COLUMN `armour` INT(11) DEFAULT NULL',
    SELECT_PLAYER_STATUS = 'SELECT health, armour FROM players WHERE citizenid = ? LIMIT 1',
    UPDATE_PLAYER_STATUS = 'UPDATE players SET health = ?, armour = ? WHERE citizenid = ?'
}

---QBCore:Server:PlayerLoaded
---@param Player table
AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    FRAMEWORK.EventPlayerLoaded(Player.PlayerData.source, Player.PlayerData.citizenid)
end)

---RegisterServerCallback
---@param name string
---@param handler function<{ source: number, cb: function, args: any
---@return function cb
---@type function
FRAMEWORK.RegisterServerCallback = QBCore.Functions.CreateCallback

---GetPlayerFromId
---@param source number
---@return table<{ source: number, identifier: string > | nil
function FRAMEWORK.GetPlayerFromId(source)
    local Player = QBCore.Functions.GetPlayer(source)

    return Player and { source = Player.PlayerData.source, identifier = Player.PlayerData.citizenid }
end

---GetPlayers
---@return table<{ [1]: number players Player ID’s
---@type function
FRAMEWORK.GetPlayers = QBCore.Functions.GetPlayers
