
function coreJobCalculatepickTime(xPlayer, picktime)
    local calculatePicktime = picktime
    for _,v in pairs(Config.allCard) do
        local xItem = xPlayer.getInventoryItem(v.itemname)
        if xItem.count >= 1 then
            local pickDecrease = (calculatePicktime/100) * v.pickPerDecrease
            calculatePicktime = calculatePicktime - pickDecrease
        end
    end

    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'ad_bell') > 0 then
        local pickDecrease = (calculatePicktime/100) * 20
        calculatePicktime = calculatePicktime - pickDecrease
    end

    if exports.cc_coreeffect:coreEffectCheckTimeGlobal('fever_time_event') > 0 then
        local pickDecrease = (calculatePicktime/100) * 15
        calculatePicktime = calculatePicktime - pickDecrease
    end
    --print(calculatePicktime)
    return calculatePicktime
end

function coreJobCalculateproTime(xPlayer, protime)
    local calculateProTime = protime
    for _,v in pairs(Config.allCard) do
        local xItem = xPlayer.getInventoryItem(v.itemname)
        if xItem.count >= 1 then
            local proDecrease = (calculateProTime/100) * v.proPerDecrease
            calculateProTime = calculateProTime - proDecrease
        end
    end

    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'ad_bell') > 0 then
        local pickDecrease = (calculateProTime/100) * 20
        calculateProTime = calculateProTime - pickDecrease
    end

    if exports.cc_coreeffect:coreEffectCheckTimeGlobal('fever_time_event') > 0 then
        local pickDecrease = (calculateProTime/100) * 15
        calculateProTime = calculateProTime - pickDecrease
    end
    --print(calculateProTime)
    return calculateProTime
end


function coreJobCalculatePrice(xPlayer, amount)
    local calculateBonusPrice = 0
    for _,v in pairs(Config.allCard) do
        local xItem = xPlayer.getInventoryItem(v.itemname)
        if xItem.count >= 1 then
            local calculateCard = v.priceFlatIncrease * amount
             calculateBonusPrice = calculateBonusPrice + calculateCard
        end
    end

    if xPlayer.getVip() ~= nil then
        local calculateVip = 0
        for _,v in pairs(Config.VipBenefit) do
            if xPlayer.getVip() == v.name then
                 calculateVip = v.profit * amount
            end
        end
        calculateBonusPrice = calculateBonusPrice + calculateVip
    end
    --print(calculateBonusPrice)
    return calculateBonusPrice
end

function coreJobCalculatefishingTime(xPlayer, fishingTime)
    local calculatefishingTime = fishingTime
    for _,v in pairs(Config.allCard) do
        local xItem = xPlayer.getInventoryItem(v.itemname)
        if xItem.count >= 1 then
            local fishingDecrease = (calculatefishingTime/100) * v.fishingDecrease
            calculatefishingTime = calculatefishingTime - fishingDecrease
        end
    end

    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'ad_bell') > 0 then
        local pickDecrease = (calculatefishingTime/100) * 20
        calculatefishingTime = calculatefishingTime - pickDecrease
    end

    if exports.cc_coreeffect:coreEffectCheckTimeGlobal('fever_time_event') > 0 then
        local pickDecrease = (calculatefishingTime/100) * 15
        calculatefishingTime = calculatefishingTime - pickDecrease
    end
    --print(calculatefishingTime)
    return calculatefishingTime
end

exports("coreJobCalculatepickTime",coreJobCalculatepickTime)
exports("coreJobCalculateproTime",coreJobCalculateproTime)
exports("coreJobCalculatePrice",coreJobCalculatePrice)
exports("coreJobCalculatefishingTime",coreJobCalculatefishingTime)

