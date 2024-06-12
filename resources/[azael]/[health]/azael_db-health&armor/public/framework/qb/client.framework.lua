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

---qb-clothing:client:loadPlayerClothing
AddEventHandler('qb-clothing:client:loadPlayerClothing', function()
    FRAMEWORK.EventModelLoaded()
end)

---QBCore:Client:OnPlayerLoaded
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    FRAMEWORK.IsPlayerLoaded = true
end)

---QBCore:Client:OnPlayerUnload
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    FRAMEWORK.IsPlayerLoaded = false
end)

---TriggerServerCallback
---@param name string
---@param cb function
---@param args any
---@type function
FRAMEWORK.TriggerServerCallback = QBCore.Functions.TriggerCallback
