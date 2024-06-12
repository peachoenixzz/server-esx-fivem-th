--===== FiveM Script: ========================================
--= DB - Health and Armor
--===== Developed By: ========================================
--= Azael Dev <contact@azael.dev>
--===== Website: =============================================
--= https://www.azael.dev/
--===== License: =============================================
--= You are not allowed to sell this script or edit
--============================================================

DATABASE = {}                                               -- WARN: DO NOT EDIT !!!

local QUERY = FRAMEWORK.Database

---ติดตั้งฐานข้อมูลของทรัพยากรนี้
local function InitDatabase()
    if not pcall(MySQL.scalar.await, QUERY.SELECT_HEALTH_COLUMN) then
        MySQL.query(QUERY.ADD_HEALTH_COLUMN)
    end
    
    if not pcall(MySQL.scalar.await, QUERY.SELECT_ARMOUR_COLUMN) then
        MySQL.query(QUERY.ADD_ARMOUR_COLUMN)
    end
end

MySQL.ready(InitDatabase) -- ดำเนินการตรวจสอบและติดตั้งฐานข้อมูลเมื่อ MySQL พร้อมใช้งาน

---รับข้อมูลสถานะ "พลังชีวิต" และ "เกราะ"
---@param identifier string ตัวระบุผู้เล่น
---@return table<{ health: number|nil, armour: number|nil status ตารางข้อมูลสถานะ "พลังชีวิต" และ "เกราะ"
function DATABASE.FetchPlayerStatus(identifier)
    return MySQL.prepare.await(QUERY.SELECT_PLAYER_STATUS, { identifier })
end

---อัพเดทข้อมูลสถานะ "พลังชีวิต" และ "เกราะ"
---@async
---@param identifier string ตัวระบุผู้เล่น
---@param status table<{ health: number, armour: number ตารางข้อมูลสถานะ "พลังชีวิต" และ "เกราะ"
function DATABASE.UpdatePlayerStatus(identifier, status)
    MySQL.prepare(QUERY.UPDATE_PLAYER_STATUS, { status.health, status.armour, identifier }, function(affectedRows)
        -- print(affectedRows)
    end)
end

---อัพเดทข้อมูลสถานะ "พลังชีวิต" และ "เกราะ" ตามเวลา (ป้องกันข้อมูล Rollback)
---@async
---@param data table<table<{ [1]: number, [2]: number, [3]: string ตารางข้อมูลสถานะ "พลังชีวิต" และ "เกราะ" ของผู้เล่นทั้งหมดที่ออนไลน์ { { health, armour, identifier } }
function DATABASE.UpdateAllPlayerStatus(data)
    MySQL.prepare(QUERY.UPDATE_PLAYER_STATUS, data, function(results)
        -- print(results)
    end)
end
