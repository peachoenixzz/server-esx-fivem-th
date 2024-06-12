listitem    = {}

local lastsource

RegisterServerEvent('economy:callback')
AddEventHandler('economy:callback', function()
    lastsource = source
    TriggerClientEvent('sent:economy', lastsource , listitem)
end)

RegisterServerEvent('economy:shopall')
AddEventHandler('economy:shopall', function(position)
    lastsource = source
    TriggerClientEvent('sent:economysell', lastsource , listitem,position)
end)

RegisterCommand('economy', function(source, args, user)
	lastsource = source
    if Config.oncommand then
    TriggerClientEvent('sent:economy', lastsource , listitem)
    end	
end)

-- TriggerEvent('es:addGroupCommand', 'economy', 'user', function(source, args, user)
    -- lastsource = source
    -- if Config.oncommand then
    -- TriggerClientEvent('sent:economy', lastsource , listitem)
    -- end
    
    
    
-- end, function(source, args, user)
    -- TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
-- end, {help = ('economy')})



MySQL.ready(function()
    for k,v in pairs(Config.listitem) do
        listitem[v.item] = {id  = v.id , item  = v.item , label = v.label , price = v.price , pricemin = v.pricemin , pricemax = v.pricemax , count = 0, priceold = v.price , randomprice = v.randomprice , typemoney = v.typemoney,position_item=v.position_item,max_count = v.max_count,category=v.category,
                            sellPosition = v.sellPosition,
                            processPosition = v.processPosition,
                            packagePosition = v.packagePosition,
                            pickPosition = v.pickPosition
        }
    end
    
    if Config.randomprice then
            --print("random")
        for k,v in pairs(listitem) do
            local priceran = math.random(v.pricemin,v.pricemax)
            v.price = v.price --priceran
            v.priceold = v.price --priceran
        end
    end

end)

--Citizen.CreateThread(function()
--	while true do
--
--	for k,v in pairs(Config.listitem) do
--		 listitem[v.item] = {id  = v.id , item  = v.item , label = v.label , price = v.price , pricemin = v.pricemin , pricemax = v.pricemax , count = 0, priceold = v.price , randomprice = v.randomprice , typemoney = v.typemoney,position_item=v.position_item,max_count = v.max_count,category=v.category}
--        print(v.item , v.price,v.priceold)
--    end
--	print(Config.randomprice)
--	if Config.randomprice then
--        for k,v in pairs(listitem) do
--            print("random")
--            local priceran = math.random(v.pricemin,v.pricemax)
--            v.price = priceran
--            v.priceold = priceran
--        end
--	end
--		Citizen.Wait(Config.Time)
--		Citizen.Wait(1000)
--		 print('Economy_Update')
--
--		 -- TriggerClientEvent('chat:addMessage', -1, { args = {
--                -- '^1ECONOMY^0: ', 'ราคาตลาดเปลี่ยนแล้ว.'
--            -- }})
--
--		 NotificationNoitemWorkEconomy()
--
--	end
--end)


RegisterServerEvent('economy:shopsellmoney')
AddEventHandler('economy:shopsellmoney', function(itemName, amount)
    lastsource = source
    amount = math.floor(amount)
    local xPlayer = ESX.GetPlayerFromId(lastsource)
    local xItem = xPlayer.getInventoryItem(itemName)
    if tonumber(xItem.count) < tonumber(amount) then
        return
    end

        xPlayer.removeInventoryItem(xItem.name, amount)
        local price = listitem[itemName].price
        randomprice = listitem[itemName].randomprice
        typemoney = listitem[itemName].typemoney
        local pricemin = listitem[itemName].pricemin
        local pricemax = listitem[itemName].pricemax
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'RemoveItemFormEconomy',
                content = (' %s ได้สูญเสีย %s จำนวน %s ชิ้น จากการขายสินค้าใน Economy Shop'):format(xPlayer.name, xItem.label, ESX.Math.GroupDigits(amount)),
                source = xPlayer.source,
             })
         end) -- End Log
    --if randomprice then
    --    price = math.random(pricemin,pricemax)
    --    price = (price * amount)
    --else
        price = math.random(pricemin,pricemax) * amount
    --end

    local calculateBonusPrice = exports.cc_corejob:coreJobCalculatePrice(xPlayer, amount)
    price = price + calculateBonusPrice
    

    listitem[itemName].count = listitem[itemName].count + amount         
    pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'EconomyPriceUpdate',
            content = ('ราคาสินค้าได้มีการ Update ใน Economy Shop'),
            source = xPlayer.source,
         })
     end) -- End Log  

    if typemoney then
    xPlayer.addMoney(price)
        
    senddis("Economy",("ผู้ขาย : **"..xPlayer.identifier.."  |  "..xPlayer.name.."**\nสินค้า : **"..xItem.name.."**\nจำนวน : **"..amount.." | "..listitem[itemName].count.." / "..Config.num.."**\nราคา : **"..price.."$ | "..math.floor(price/amount).."$ / 1 ชิ้น**\nชนิดเงิน : **เงินเขียว**"),56108)
    pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'ReceiveMoneyFormEconomy',
            content = ('ผู้ขาย %s | ขาย %s จำนวน %s ชิ้น ได้รับ Cash จำนวน $%s (%s / 1ชิ้น) เหลือเงินในกระเป๋าทั้งหมด $%s'):format(xPlayer.name, xItem.label, ESX.Math.GroupDigits(amount), ESX.Math.GroupDigits(price), math.floor(price/amount), ESX.Math.GroupDigits(xPlayer.getMoney())),
            source = xPlayer.source,
            options = {
                important = (price >= 100000 and true)
            }
         })
     end) -- End Log
    else
    xPlayer.addAccountMoney('black_money', price)
        
    senddis("Economy",("ผู้ขาย : **"..xPlayer.identifier.."  |  "..xPlayer.name.."**\nสินค้า : **"..xItem.name.."**\nจำนวน : **"..amount.." | "..listitem[itemName].count.." / "..Config.num.."**\nราคา : **"..price.."$ | "..math.floor(price/amount).."$ / 1 ชิ้น**\nชนิดเงิน : **เงินแดง**"),16711680)
    end

    if typemoney then
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'EconomyItemSell',
                content = ('%s ขาย %s จำนวน %s ชิ้น ได้รับ Cash จำนวน $%s (%s / 1ชิ้น)'):format(xPlayer.name, xItem.label, ESX.Math.GroupDigits(amount), ESX.Math.GroupDigits(price), math.floor(price/amount)),
                source = xPlayer.source,
                options = {
                    important = (price >= 100000 and true)
                }
             })
         end) -- End Log
    else
        local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ' ($' .. math.floor(price/amount) .. ' / 1 ชิ้น)'
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'EconomyItemSell', sendToDiscord, xPlayer.source, '^3')
    end


    --print("count : ",listitem[itemName].count)
    --print("max : ",listitem[itemName].max_count)
    if listitem[itemName].count >= listitem[itemName].max_count then
        print("validate check count")
        checkeconomy(itemName)
    end
end)


function checkeconomy(item)
    lastsource = source
    itemCategory = nil
    local itemName = item
        for k, v in pairs(listitem) do
            --print(v.item , v.price,v.priceold)
            if itemName == v.item then
                --v.priceold = v.price
            listitem[itemName].count = 0
                if  listitem[itemName].item == listitem[itemName].item then
                    listitem[itemName].priceold =  listitem[itemName].price
                    local pricedis = math.floor(listitem[itemName].price-((listitem[itemName].price)*(0.01*Config.discount)))
                    --print("Discount : ",listitem[itemName].item)
                    if pricedis <= listitem[itemName].pricemin then
                        listitem[itemName].price = listitem[itemName].pricemin
                    else
                        listitem[itemName].price = pricedis
                    end
                    print("Price : " , listitem[itemName].item , listitem[itemName].price)
            end
            else
                --print(listitem[itemName].category)
                if listitem[itemName].category == v.category then
                    --v.priceold = v.price
                    local priceinc = math.floor(v.price+((v.price)*(0.01*Config.incre)))
                    --print("category main : ",listitem[itemName].category)
                    --print("category : ",v.category)
                    --print("increase : ",v.item)
                    if priceinc >= v.pricemax then
                        v.price = v.pricemax
                    else
                        v.price = priceinc
                    end
                    --print("price : ", v.price ,v.item)
                end
            end
        end
end


function senddis (name,message,color)
    local DiscordWebHook = Config.discord
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds

  local embeds = {
      {
            ["color"] = color,
            ["title"] = "แจ้งเตือน Economy",
            ["type"]="rich",
            ["description"] = message,
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
  end
  
  
  -- function senddis2 (name,message,color)
    -- local DiscordWebHook = "https://discordapp.com/api/webhooks/602682447410495488/ENebBqjVRvRsfir0BGOGG_faogdyH7AMy6Sly2-Trw0rcKc8Vn2snCB9UYZ3uuNFKsdH"
  -- local embeds = {
      -- {
            -- ["color"] = color,
            -- ["title"] = "Check Economy",
            -- ["type"]="rich",
            -- ["description"] = message,
      -- }
  -- }
  
    -- if message == nil or message == '' then return FALSE end
    -- PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
  -- end
