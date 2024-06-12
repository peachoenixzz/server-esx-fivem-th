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

---skinchanger:modelLoaded
AddEventHandler('skinchanger:modelLoaded', function()
    FRAMEWORK.EventModelLoaded()
end)

---esx:playerLoaded
---@param xPlayer table
RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    FRAMEWORK.IsPlayerLoaded = true
end)

---esx:onPlayerLogout
RegisterNetEvent('esx:onPlayerLogout', function()
    FRAMEWORK.IsPlayerLoaded = false
end)

---TriggerServerCallback
---@param name string
---@param cb function
---@param args any
---@type function
FRAMEWORK.TriggerServerCallback = ESX.TriggerServerCallback
