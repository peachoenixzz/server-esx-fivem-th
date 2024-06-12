--===== FiveM Script: ========================================
--= DB - Health and Armor
--===== Developed By: ========================================
--= Azael Dev <contact@azael.dev>
--===== Website: =============================================
--= https://www.azael.dev/
--===== License: =============================================
--= You are not allowed to sell this script or edit
--============================================================

---@type string, string es_extended, esx
local RESOURCE, DIRECTORY = ...                             -- WARN: DO NOT EDIT !!!

---@type table
local ESX = exports[RESOURCE]:getSharedObject()

---Database (Query)
FRAMEWORK.Database = {
    SELECT_HEALTH_COLUMN = 'SELECT `health` FROM `users`',
    ADD_HEALTH_COLUMN = 'ALTER TABLE `users` ADD COLUMN `health` INT(11) DEFAULT NULL',
    SELECT_ARMOUR_COLUMN = 'SELECT `armour` FROM `users`',
    ADD_ARMOUR_COLUMN = 'ALTER TABLE `users` ADD COLUMN `armour` INT(11) DEFAULT NULL',
    SELECT_PLAYER_STATUS = 'SELECT health, armour FROM users WHERE identifier = ? LIMIT 1',
    UPDATE_PLAYER_STATUS = 'UPDATE users SET health = ?, armour = ? WHERE identifier = ?'
}

---esx:playerLoaded
---@param source number
---@param xPlayer table
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    FRAMEWORK.EventPlayerLoaded(xPlayer.source, xPlayer.identifier)
end)

---RegisterServerCallback
---@param name string
---@param handler function<{ source: number, cb: function, args: any
---@return function cb
---@type function
FRAMEWORK.RegisterServerCallback = ESX.RegisterServerCallback

---GetPlayerFromId
---@param source number
---@return table<{ source: number, identifier: string > | nil
---@type function
FRAMEWORK.GetPlayerFromId = ESX.GetPlayerFromId

---GetPlayers
---@return table<{ [1]: number players Player ID’s
---@type function
FRAMEWORK.GetPlayers = ESX.GetPlayers

---GetExtendedPlayers (Support in version 1.9)
---@param key string|nil
---@param val string|nil
---@return table<{ source: number, identifier: string > | nil
---@type function
FRAMEWORK.GetExtendedPlayers = ESX.GetExtendedPlayers
