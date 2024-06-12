local material = nil

local function sendNotification(source, title, description, notificationType)
    exports.nc_notify:PushNotification(source, {
        scale = 1.0,
        title = title,
        description = description,
        type = notificationType or 'info',
        position = 'top',
        direction = 'right',
        priority = 'medium',
        icon = 'no_result',
        duration = 5000
    })
end

local function logEvent(event, content, source)
    pcall(function()
        exports['azael_dc-serverlogs']:insertData({
            event = event,
            content = content,
            source = source,
        })
    end)
end


local function hasSufficientCurrency(xPlayer, items, amount)
    -- Handling currency and price dynamically
    local currencyTypes = type(items.currency) == "table" and items.currency or {items.currency}
    local prices = type(items.price) == "table" and items.price or {items.price}

    for i, currencyType in ipairs(currencyTypes) do
        local requiredAmount = prices[i] * amount
        local availableAmount = currencyType == "money" and xPlayer.getMoney() or xPlayer.getAccount(currencyType).money

        if requiredAmount > availableAmount then
            local eventType = currencyType == "money" and 'InsufficientMoneyToCraft' or 'InsufficientBlackMoneyToCraft'
            logEvent(eventType, string.format('%s ไม่สามารถคราฟ %s ได้เนื่องจากเงินไม่เพียงพอ', xPlayer.name, items.name),  xPlayer.source)
            return false
        end
    end
    return true
end

local function checkMaterial(items, xPlayer)
    if #items.material == 0 then return true end
    for k, v in ipairs(items.material) do
        if material[k].quantity ~= v.quantity then
            print(material[k].quantity, v.quantity)
            print("Cheating",xPlayer.getIdentifier(), material[k].quantity ~= v.quantity)
            return false
        end
        if material[k].success_rate ~= v.success_rate then
            print(material[k].success_rate, v.success_rate)
            print("Cheating",xPlayer.getIdentifier(), material[k].success_rate ~= v.success_rate)
            return false
        end
        if type(material[k].count_per_quantity) ~= "nil" then
            if material[k].count_per_quantity ~= v.count_per_quantity then
                print(material[k].count_per_quantity, v.count_per_quantity)
                print("Cheating",xPlayer.getIdentifier(), material[k].count_per_quantity ~= v.count_per_quantity)
                return false
            end
        end

        if type(material[k].count_per_quantity) == "nil" then
            if type(v.count_per_quantity) ~= "nil" then
                print("Cheating",xPlayer.getIdentifier(), type(v.count_per_quantity) ~= "nil")
                return false
            end
        end
    end
    return true
end

local function validateExpireDateItem(items, xPlayer)
    for k,_ in pairs(Config.CraftTables) do
        for _,v in pairs(Config.CraftTables[k]) do
            if items.specific_name == v.specific_name then
                --init config mat
                material = v.material

                if type(items.expire_date) ~= "nil" then
                    if items.expire_date ~= v.expire_date then
                        print(items.expire_date, v.expire_date)
                        print("Cheating",xPlayer.getIdentifier(), items.expire_date, v.expire_date)
                        return false
                    end

                    local xItem = xPlayer.getInventoryItem(items.name)
                    if xItem.count > 0 then return false end
                end
            end
        end
    end
end

local function validateRequireItem(items, xPlayer)
    local canCraft = false -- Flag to indicate if player can craft or not

    if #items.req ~= 0 then
        if items.once_require then -- If only one item is required
            canCraft = false
            for _, v in ipairs(items.req) do
                local xItem = xPlayer.getInventoryItem(v.req_name)
                if xItem.count > 0 then
                    canCraft = true
                    break
                end
            end
        end

        if not items.once_require then -- If all items are required
            canCraft = true
            for _, v in ipairs(items.req) do
                local xItem = xPlayer.getInventoryItem(v.req_name)
                if xItem.count <= 0 then
                    canCraft = false
                    break
                end
            end
        end
        return canCraft
    end

    if #items.req == 0 then
        return true
    end
end

local function validateWeapon(xPlayer, items, amount)
    for _, v in ipairs(items.material) do
        if v.type == "weapon" then
            local weapon = xPlayer.getWeapon(v.name)
            if not weapon then
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'InsufficientWeaponToCraft',
                        content = ('%s ไม่สามารถคราฟ %s ได้เนื่องจากไม่มี %s ในกระเป๋าต้องมี %s จำนวน %s ชิ้น เพื่อทำการคราฟ %s'):format(xPlayer.name, items.name, v.name, v.name, (v.quantity * amount), items.label),
                        source = xPlayer.source,
                    })
                end) -- End log
                return false
            end
            goto endState
        end

        local xItem =   xPlayer.getInventoryItem(v.name)
        if xItem.count < (v.quantity * amount) then
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'InsufficientMaterialToCraft',
                    content = ('%s ไม่สามารถคราฟ %s ได้เนื่องจากมี %s ไม่เพียงพอมี %s จำนวน %s ชิ้นในกระเป๋าต้องมี %s จำนวน %s ชิ้น เพื่อทำการคราฟ %s'):format(xPlayer.name, items.name, xItem.name, xItem.name, xItem.count, xItem.name, (v.quantity * amount), items.label),
                    source = xPlayer.source,
                })
            end) -- End log
            return false
        end

        if items.currency == "money" then
            --print("money Type ",xPlayer.getMoney())
            if (items.price * amount) > xPlayer.getMoney() then
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'InsufficientMoneyToCraft',
                        content = ('%s ไม่สามารถคราฟ %s ได้เนื่องจากเงินไม่เพียงพอมีเงินในกระเป๋าจำนวน $%s ต้องการเงินจำนวน $%s ในการคราฟ %s'):format(xPlayer.name, items.name, ESX.Math.GroupDigits(xPlayer.getMoney()), (items.price * amount), items.label),
                        source = xPlayer.source,
                    })
                end) -- End log
                return false
            end
        end

        if items.currency== "black_money" then
            if (items.price * amount) > xPlayer.getAccount("black_money").money then
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'InsufficientBlackMoneyToCraft',
                        content = ('%s ไม่สามารถคราฟ %s ได้เนื่องจากเงินผิดกฏหมายไม่เพียงพอมีเงินผิดกฏหมายในกระเป๋าจำนวน $%s ต้องการเงินผิดกฏหมายจำนวน $%s ในการคราฟ %s'):format(xPlayer.name, items.name, ESX.Math.GroupDigits(xPlayer.getAccount("black_money").money), (items.price * amount), items.label),
                        source = xPlayer.source,
                    })
                end) -- End log
                return false
            end
        end
        ::endState::
    end
    return true
end

local function validateGuardRemoveItem(xPlayer, items, removeSet)
    if not removeSet then return true end
    for k,_ in pairs(Config.CraftTables) do
        for _,v in pairs(Config.CraftTables[k]) do
            if items.specific_name == v.specific_name then
                for _, itemRemove in pairs(v.protect_remove_items) do
                    if "cron" == itemRemove.name then
                        local xItem = xPlayer.getInventoryItem(itemRemove.name)
                        if xItem.count < itemRemove.quantity then return false end
                    end
                end
            end
        end
    end
    return true
end

local function validateGuardBrokenItem(xPlayer, items, brokenSet)
    if not brokenSet.status then return true end
    for k,_ in pairs(Config.CraftTables) do
        for _,v in pairs(Config.CraftTables[k]) do
            if items.specific_name == v.specific_name then
                for _, itemBroken in pairs(v.protect_broken_items) do
                    if brokenSet.item == itemBroken.name then
                        local xItem = xPlayer.getInventoryItem(brokenSet.item)
                        if xItem.count < itemBroken.quantity then return false end
                    end
                end
            end
        end
    end
    return true
end


function validateConfig(xPlayer, valid)
    local source = xPlayer.source
    if type(valid.amount) == "nil" then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'จำนวนไม่ถูกต้อง', 'warning')
        logEvent('InvalidAmount', string.format('%s ไม่สามารถคราฟ %s ได้เนื่องจากจำนวนไม่ถูกต้อง', xPlayer.name, valid.item.name), source)
        return false
    end
    if valid.amount < 0 or valid.amount == 0 or valid.amount > valid.item.max_quantity then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'จำนวนไม่ถูกต้อง', 'warning')
        logEvent('InvalidAmount', string.format('%s ไม่สามารถคราฟ %s ได้เนื่องจากจำนวนไม่ถูกต้อง', xPlayer.name, valid.item.name), source)
        return false
    end
    if validateExpireDateItem(valid.item, xPlayer) then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'คุณมีไอเทมชนิดนี้แล้ว', 'warning')
        logEvent('ItemAlreadyExist', string.format('%s มีไอเทมชนิดนี้แล้ว', xPlayer.name), source)
        return false
    end

    if not hasSufficientCurrency(xPlayer, valid.item, valid.amount) then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'คุณมีเงินไม่เพียงพอ', 'warning')
        logEvent('InsufficientCurrencyToCraft', string.format('%s ไม่สามารถคราฟ %s ได้เนื่องจากเงินไม่เพียงพอ', xPlayer.name, valid.item.name), source)
        return false
    end

    if not checkMaterial(valid.item, xPlayer) then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'ทรัพยากรของคุณไม่เพียงพอ', 'warning')
        logEvent('InsufficientMaterialToCraft', string.format('%s ไม่สามารถคราฟ %s ได้เนื่องจากทรัพยากรไม่เพียงพอ', xPlayer.name, valid.item.name), source)
        return false
    end

    if not validateRequireItem(valid.item, xPlayer) then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'คุณไม่มีไอเทมที่จำเป็น (ไอเทม)', 'warning')
        logEvent('InsufficientItemsToCraft', string.format('%s ไม่สามารถคราฟ %s ได้เนื่องจากไม่มีไอเทมที่จำเป็น', xPlayer.name, valid.item.name), source)
        return false
    end

    if not validateWeapon(xPlayer, valid.item, valid.amount) then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'คุณไม่มีไอเทมที่จำเป็น (อาวุธ)', 'warning')
        return false
    end

    if not validateGuardRemoveItem(xPlayer, valid.item,valid.onGuardRemove) then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'คุณไม่มีหินครอน', 'warning')
        return false
    end

    if not validateGuardBrokenItem(xPlayer, valid.item, valid.onGuardBroken) then
        sendNotification(source, 'ระบบโต๊ะคราฟ', 'กันแตกที่คุณเลือกจำนวนไม่ถูกต้อง', 'warning')
        return false
    end

    return true
end
