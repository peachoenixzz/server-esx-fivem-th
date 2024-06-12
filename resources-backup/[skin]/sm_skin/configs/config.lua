--[[ 
    script: Skin System & Clothe Shop
    author: SM Developer
    discord: https://discord.gg/ZbJP9wptwB
    ทางเราขอบคุณเป็นอย่างยิ่งที่ท่านได้สนับสนุนสินค้าของเรา
]]

Config = Config or {}

Config['router_base'] = {
    ['getSharedObject'] = 'esx:getSharedObject',
    ['playerLoaded'] = 'esx:playerLoaded',
    ['onPlayerDeath'] = 'esx:onPlayerDeath',

    ['setAccountMoney'] = 'esx:setAccountMoney',				-- Default: 'esx:setAccountMoney'
    ['addedMoney'] = 'es:addedMoney',							-- Default: 'es:addedMoney'
    ['removedMoney'] = 'es:removedMoney'						-- Default: 'es:removedMoney'
}

Config['MainSetting'] = {
    ['skinchnager_advance'] = false, -- New and Old
    ['cost_cloth_shop'] = { -- ราคา ร้านเสื้อผ้า
        faverite = 0,
        buy = 0,
    },
    ['cost_baber_shop'] = { -- ราคา ร้านตัดผม
        faverite = 0,
        buy = 0,
    },
    ['cost_mask_shop'] = 0, -- ราคา ร้านหน้ากาก
}

Config['Reskin_Items'] = {
    enable = true,
    name = 'card_reskin',
    remove = true
}


Config['Light'] = {
    color = {255, 255,255},
    brightness = 6.0
}

EnableControlOpenUi = function() -- ปุ่มที่สามารภกดได้เมื่ออยู่ใน UI
    EnableControlAction(0, 73) -- X
	EnableControlAction(0, 249) -- N
end

OnActive = function() --เมื่อเปิดหน้าต่างระบบ
    exports.nc_inventory:BlockKey({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, true)
end

OnUnactive = function() --เมื่อออกจากหน้าต่างระบบ
    ClearPedTasks(PlayerPedId())
    exports.nc_inventory:BlockKey({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, false)
end