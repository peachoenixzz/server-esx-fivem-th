local function logEvent(eventType, contentParams, xPlayer)
    pcall(function()
        if type(contentParams) == "table" and #contentParams >= 1 then
            -- First element is the format string
            local formatString = contentParams[1]

            -- The rest are parameters to be formatted, dynamically including xPlayer.name
            local args = {select(2, table.unpack(contentParams))}

            -- Format the string with the dynamic list of arguments
            local content = string.format(formatString, xPlayer.getName(),table.unpack(args[1]))

            -- Logging the event
            exports['azael_dc-serverlogs']:insertData({
                event = eventType,
                content = content,
                source = xPlayer.source,
            })
        else
            print("Invalid content structure")
        end
    end)
end


local function removeMaterials(items, amount, protectRemove, protectBroken, success, xPlayer)
    for _, v in ipairs(items.material) do
        local removeFunction = v.type == "weapon" and xPlayer.removeWeapon or xPlayer.removeInventoryItem
        if v.type ~= "weapon" and (protectRemove and not success) then
            goto continue
        end
        if v.type == "weapon" and (protectBroken and not success) then
            goto continue
        end
        removeFunction(v.name, v.quantity * amount)
        logEvent('RemoveCraftMaterial', {
            ('%s ได้สูญเสีย %s จำนวน %s ชิ้น จากการคราฟ %s'),
            {v.name, v.quantity * amount, items.label}
        }, xPlayer)
        ::continue::
    end
end

local function removeCurrencies(currencies, prices, amount, itemLabel, xPlayer)
    for i, currencyType in ipairs(currencies) do
        local total = prices[i]*amount
        local currencyName = currencyType == "money" and "เงิน" or "เงินผิดกฏหมาย"
        xPlayer.removeAccountMoney(currencyType, total)
        logEvent('Remove' .. currencyName .. 'FromCrafting', {
            ('%s ได้สูญเสีย' .. currencyName .. 'จำนวน $%s จากการคราฟ %s เหลือ' .. currencyName .. 'ในกระเป๋า จำนวน $%s'),
            {total, itemLabel, ESX.Math.GroupDigits(xPlayer.getAccount(currencyType).money)}
        }, xPlayer)
    end
end

function checkOnRemoveItem(onGuardRemoveItem, items, xPlayer)
    if onGuardRemoveItem then
        for _, v in ipairs(items.protect_remove_items) do
            local removeFunction = v.type == "weapon" and xPlayer.removeWeapon or xPlayer.removeInventoryItem
            local xItem = xPlayer.getInventoryItem(v.name)
            if xItem then
                if v.quantity > xItem.count then
                    return false
                end
            end
            removeFunction(v.name, v.quantity)
            logEvent('RemoveGuardItem', {
                ('%s ได้สูญเสีย %s จำนวน %s ชิ้น จากการคราฟ %s'),
                {v.name, v.quantity, items.label}
            }, xPlayer)
        end
        return true
    end
    return false
end

function checkOnBrokenItem(onGuardBrokenItem, items, xPlayer)
    if onGuardBrokenItem.status then
        for _, v in ipairs(items.protect_broken_items) do
            if v.name == onGuardBrokenItem.item then
                local removeFunction = v.type == "weapon" and xPlayer.removeWeapon or xPlayer.removeInventoryItem
                local xItem = xPlayer.getInventoryItem(v.name)
                if xItem then
                    if v.quantity > xItem.count then
                        return false
                    end
                end
                local protectRate = math.random(1, 100000)/100000
                removeFunction(v.name, v.quantity)
                if v.protect_percent == 1.0 then
                    return true
                end
                if protectRate <= v.protect_percent then
                    return true
                end
                return false
            end
            logEvent('RemoveGuardItem', {
                ('%s ได้สูญเสีย %s จำนวน %s ชิ้น จากการคราฟ %s'),
                {v.name, v.quantity, items.label}
            }, xPlayer)
        end
    end
    return false
end

function giveItems(validateSet, xPlayer)
    local items = validateSet.item
    local amount = validateSet.amount
    items.count_per_quantity = items.count_per_quantity or 1
    local success = true
    -- Handle success rate
    if items.success_rate ~= 1 then
        local successRate = math.random(1, 100000)/100000
        success = successRate <= items.success_rate
    end

    local currencyTypes = type(items.currency) == "table" and items.currency or {items.currency}
    local prices = type(items.price) == "table" and items.price or {items.price}
    if #prices > 0 and #currencyTypes > 0 then
        removeCurrencies(currencyTypes, prices, amount, items.label, xPlayer)
    end

    local protectRemove = checkOnRemoveItem(validateSet.onGuardRemove, items, xPlayer)
    local protectBroken = checkOnBrokenItem(validateSet.onGuardBroken, items, xPlayer)
    removeMaterials(items, amount, protectRemove, protectBroken, success, xPlayer)

    -- Process based on success
    if success then
        -- Handle item giving and logging
        local addItemFunction = items.type == 'weapon' and xPlayer.addWeapon or xPlayer.addInventoryItem
        addItemFunction(items.name, amount * items.count_per_quantity)
        logEvent('ReceivedCraftItem', {
            ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s'),
            {items.name, amount, items.label}
        }, xPlayer)

        -- Handle item expiration
        if items.expire_date then
            MySQL.Async.execute([[
                INSERT IGNORE INTO items_expire (item_name, player_id, category, expire_timestamp)
                VALUES (@item_name, @player_id, @category, SYSDATE() + INTERVAL @expire_date DAY)
            ]], {
                ['@item_name'] = items.name,
                ['@player_id'] = xPlayer.identifier,
                ['@category'] = "economy",
                ['@expire_date'] = items.expire_date
            }, function(rowsChanged)
                if rowsChanged then
                    logEvent('ReceivedCraftItemExpireDate', {
                        ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s และ ถูกบันทึกลงใน Database ว่าหมดอายุในเวลา %s'),
                        {items.name, amount, items.label, items.expire_date}
                    }, xPlayer)
                end
            end)
        end
    end

    if not success then
        -- Handle failure scenarios
        if not protectBroken then
            if items.failed_items then
                for _, failedItem in ipairs(items.failed_items) do
                    local addItemFunction = failedItem.type == 'weapon' and xPlayer.addWeapon or xPlayer.addInventoryItem
                    addItemFunction(failedItem.name, amount * failedItem.quantity)
                    logEvent('ReceivedCraftItemFail', {
                        ('%s ได้รับ %s จำนวน %s ชิ้น จากการคารฟ %s แต่เนื่องจากคาร์ฟไม่สำเร็จ จึงได้รับ %s แทน'),
                        {failedItem.name, amount, items.label, failedItem.label}
                    }, xPlayer)
                end
            end
        end
        logEvent('CraftingFail', {
            ('%s ได้ทำการคราฟ %s ไม่สำเร็จ'),
            {items.label}
        }, xPlayer)
    end

    return success and "success" or "failed"
end
