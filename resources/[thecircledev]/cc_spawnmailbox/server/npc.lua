ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local positionObj = {}
local currentTime = GetGameTimer()
local auth = "Rpg!@7!8!9!10"
local alreadySent = 0
local totalNPC = 10
local cachePlayer = 0
local onSpawn = false
local NPC = {
    {position=vector3(1584.2080, 6451.6523, 25.5171), head=156.3757, id=1},
    {position=vector3(1681.2476, 6429.3242, 32.4664), head=332.369, id=2},
    {position=vector3(1465.5769, 6547.7983, 13.8652), head=87.7163, id=3},
    {position=vector3(-46.9229, 6508.1880, 31.8357), head=221.9742, id=4},
    {position=vector3(-162.6391, 6411.0176, 31.6159), head=312.1495, id=5},
    {position=vector3(-377.8978, 6121.7988, 31.1796), head=38.1248, id=6},
    {position=vector3(-426.8393, 6003.1704, 31.1901), head=316.0132, id=7},
    {position=vector3(162.7665, 6361.0688, 32.0440), head=209.8559, id=8},
    {position=vector3(-757.0068, 5594.1973, 36.4062), head=88.2458, id=9},
    {position=vector3(-1058.7412, 4915.4121, 211.5187), head=193.7245, id=10},
    {position=vector3(-2196.0115, 4270.9863, 48.2628), head=150.7594, id=11},
    {position=vector3(-1845.8877, 3220.5706, 32.4448), head=60.7253, id=12},
    {position=vector3(-1729.4895, 3027.1775, 32.4333), head=99.4940, id=13},
    {position=vector3(-1893.9808, 2052.2766, 140.6827), head=162.3962, id=14},
    {position=vector3(-1930.4155, 1782.8488, 172.7750), head=115.2805, id=15},
    {position=vector3(-2553.1274, 1914.3522, 168.6384), head=151.8664, id=16},
    {position=vector3(-3160.0830, 1086.5890, 20.4535), head=243.5901, id=17},
    {position=vector3(-1113.6122, 2687.7659, 18.2195), head=221.8964, id=18},
    {position=vector3(180.6355, 2793.3445, 45.3552), head=279.3527, id=19},
    {position=vector3(46.5878, 3703.7534, 39.4550), head=334.8530, id=20},
    {position=vector3(456.6835, 3554.2952, 32.8386), head=171.1649, id=21},
    {position=vector3(917.4821, 3655.8994, 32.0844), head=0.4492, id=22},
    {position=vector3(1701.8336, 3754.2778, 34.0485), head=226.8492, id=23},
    {position=vector3(1526.6949, 3775.4104, 34.2113), head=218.7878, id=24},
    {position=vector3(2506.2102, 4096.2002, 38.3110), head=64.2103, id=25},
    {position=vector3(1820.0420, 4588.8096, 35.5963), head=97.2351, id=26},
    {position=vector3(1695.8625, 4787.7793, 41.6094), head=88.4047, id=27},
    {position=vector3(2306.7170, 4882.0527, 41.4083), head=44.5312, id=28},
    {position=vector3(2589.5786, 4678.3062, 33.6768), head=316.4664, id=29},
    {position=vector3(2900.4314, 4420.2437, 48.3204), head=286.7254, id=30},
    {position=vector3(2983.6575, 3473.1917, 71.1419), head=164.3105, id=31},
    {position=vector3(2746.0842, 3463.2354, 55.4108), head=244.2103, id=32},
    {position=vector3(2555.1321, 2609.2141, 37.7877), head=285.7902, id=33},
    {position=vector3(2471.2500, 1598.8556, 32.4203), head=91.5291, id=34},
    {position=vector3(2135.8364, 1936.2158, 93.4869), head=87.7308, id=35},
    {position=vector3(2579.0571, 464.8409, 108.3259), head=180.1697, id=36},
    {position=vector3(1146.1571, -451.1395, 66.6844), head=167.4927, id=45},
    {position=vector3(1074.1624, -775.8958, 57.9204), head=1.0742, id=46},
    {position=vector3(1172.7728, -295.8255, 68.7027), head=277.5840, id=47},
    {position=vector3(1581.2699, -1691.8918, 87.8590), head=198.2675, id=48},
    {position=vector3(858.9673, -2302.0537, 30.0458), head=174.6678, id=49},
    {position=vector3(1199.9268, -3251.0298, 6.7952), head=357.2841, id=50},
    {position=vector3(457.7265, -3075.6001, 5.7693), head=92.6968, id=51},
    {position=vector3(211.2417, -3084.6052, 5.4723), head=94.1213, id=52},
    {position=vector3(-64.6967, -2443.1787, 5.6012), head=144.1143, id=53},
    {position=vector3(385.9431, -2030.8657, 22.7062), head=63.1537, id=54},
    {position=vector3(-186.5395, -1542.7396, 34.0124), head=230.1021, id=55},
    {position=vector3(76.6456, -871.2183, 31.2093), head=71.3021, id=56},
    {position=vector3(-384.5085, 154.6296, 65.2313), head=101.5901, id=57},
    --{position=vector3(-369.4215, 275.6292, 86.1219), head=32.7409, id=58}, --bug
    {position=vector3(-953.7500, 570.1301, 101.2900), head=337.6849, id=59},
    {position=vector3(-1573.1466, 127.8476, 58.1905), head=158.2522, id=60},
    {position=vector3(-1564.6912, -232.7632, 49.2718), head=137.5910, id=61},
    --{position=vector3(-1170.9818, -498.8770, 36.0812), head=79.9960, id=62}, --bug
    --{position=vector3(-1331.6450, -740.2609, 25.0636), head=127.1598, id=63}, --bug
    {position=vector3(-1086.9631, -1673.1565, 4.5024), head=304.8677, id=64},
    {position=vector3(-1203.7262, -1804.5773, 3.7086), head=68.6176, id=65},
    {position=vector3(-925.9706, -1509.8998, 4.9763), head=20.6121, id=66},
    {position=vector3(-1045.4355, -1156.6195, 1.9586), head=28.3232, id=67},
    {position=vector3(-581.4542, -803.2455, 30.3982), head=3.1985, id=68},
    {position=vector3(-39.0517, -662.6854, 33.1804), head=186.4343, id=69},
    {position=vector3(466.3938, -575.8947, 28.2998), head=177.2210, id=70},
    {position=vector3(810.8732, -752.0533, 26.7111), head=272.9195, id=71},
    {position=vector3(735.8953, -1375.6055, 26.3455), head=91.5397, id=72},
    {position=vector3(577.2225, -1634.1169, 25.6813), head=53.5809, id=73},
    {position=vector3(535.9396, -1940.4170, 24.5851), head=303.1866, id=74},
    {position=vector3(452.0173, -1569.7837, 32.3923), head=144.3052, id=75},
    {position=vector3(-266.0445, -2017.3004, 29.8456), head=231.9574, id=76},
    --{position=vector3(-353.3401, -1513.6903, 27.5196), head=181.2680, id=77}, -- bug
    {position=vector3(-337.3884, -1058.8094, 29.1851), head=158.7886, id=78},
    {position=vector3(-759.4382, -209.7509, 36.9721), head=121.8639, id=79},
    {position=vector3(-1349.2861, -128.7473, 49.7874), head=348.9253, id=80},
    {position=vector3(-538.1671, 475.8109, 102.8936), head=57.4034, id=81},
    {position=vector3(-21.70000076293945, 218.05999755859375, 106.5999984741211), head=349.26, id=82},
    {position=vector3(-937.0447, -376.4451, 38.6613), head=118.2721, id=83},
    {position=vector3(1667.5431, -62.6318, 173.7957), head=258.9359, id=84},
    {position=vector3(2521.5168, -454.1637, 92.6928), head=180.9465, id=85},
    {position=vector3(1438.7484, -1495.6121, 62.9245), head=78.4366, id=86},
    {position=vector3(-300.6563, 2814.5278, 59.0388), head=324.8667, id=87},
    {position=vector3(-440.6317, 1595.0870, 358.1679), head=231.8360, id=88}
}

ESX.RegisterServerCallback('cc_spawnmailbox:requestDataSpawnMailbox', function(source, cb)
    cb(positionObj)
end)

Citizen.CreateThread(function()
    while cachePlayer <= 2  do
        Citizen.Wait(5000)
        local Players = ESX.GetExtendedPlayers()
        cachePlayer =  #Players
        if #positionObj <= 0 and not onSpawn and #Players > 0 then
            print("on reCreate Mailbox position <= 0")
            reMailbox()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        local blipCondition = true
        local interval = 300000
        local lastCheckTime = GetGameTimer()
        local elapsed = lastCheckTime - currentTime
        for _,po in pairs(positionObj) do
            if not po.blip_done then
                blipCondition = false
            end
        end

        --print("time in real : ",elapsed,alreadySent,blipCondition)
        if (elapsed >= interval and alreadySent >= 10) or (blipCondition and elapsed >= interval) then
            currentTime = GetGameTimer()
            reMailbox()
        end
    end
end)

function deleteAllObj()
    for _,v in ipairs(GetAllObjects()) do
        if GetEntityType(v) == 3 then
            local mailBox = GetEntityCoords(v)
            for _,po in pairs(NPC) do
                if (#po.position - #mailBox) <= 20 then
                    DeleteEntity(v)
                end
            end
        end
    end
end

function reMailbox()
    if onSpawn then return end
    onSpawn = true
    for i=1,totalNPC do
        local position,head,id = checkPosition()
        positionObj[i] = {
            blip = nil,
            position = position,
            head = head,
            id = id,
            blip_done = false,
        }
        Wait(400)
    end
    alreadySent = 0
    Wait(400)
    TriggerClientEvent('cc_spawnmailbox:collectData',-1)
    print("CREATED EMAIL BOX SUCCESS")
    print("CREATED EMAIL BOX SUCCESS")
    print("CREATED EMAIL BOX SUCCESS")
    print("CREATED EMAIL BOX SUCCESS")
    print("CREATED EMAIL BOX SUCCESS")
    onSpawn = false
end

function checkPosition()
    local NPCPosition = NPC[math.random(#NPC)]
    for _,v in pairs(positionObj) do
        if v.id == NPCPosition.id then
            return checkPosition()
        end
    end
    return NPCPosition.position,NPCPosition.head,NPCPosition.id
end

ESX.RegisterServerCallback('cc_spawnmailbox:count', function(source, cb, basicAuth)
    alreadySent = alreadySent+1
    print("count ++ from client",alreadySent)
    local isFarFromPosition = false
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped) -- Gets the player's current coordinates
    for _, npc in ipairs(NPC) do

        -- Check if the distance is greater than 10 units
        if  #(playerCoords - npc.position) > 10 then
            isFarFromPosition = true
        end
        isFarFromPosition = false
    end
    if isFarFromPosition then
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'Exploit',
                content = ('ผู้เล่นพยายาม Trigger การส่งจดหมายด้วยวิธีผิดปกติ'):format(),
                source = source,
            })
        end) -- End log
    end
    if basicAuth == auth and not isFarFromPosition then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            handleBlipPlayer(xPlayer.source)
            handleGiveItem(xPlayer,basicAuth)
            currentTime = GetGameTimer()
        end
    end
    cb()
end)

function handleGiveItem(xPlayer,authBasic)
    local oldmoney = xPlayer.getMoney()
    if authBasic == auth then
        local xItemBonusRate = math.random(1, 100000)/100000
        --print(xItemBonusRate)
        local matchingBonusItems = {}
        local minMatchingBonusPercent = 1.0

        for _, v in pairs(Config.BonusItem) do
            if xItemBonusRate <= v.percent then
                table.insert(matchingBonusItems, v)
                if v.percent < minMatchingBonusPercent then
                    minMatchingBonusPercent = v.percent
                end
            end
        end

        local finalMatchingBonusItems = {}
        for _, v in pairs(matchingBonusItems) do
            if v.percent == minMatchingBonusPercent then
                table.insert(finalMatchingBonusItems, v)
            end
        end

        if #finalMatchingBonusItems > 0 then
            local randomBonusIndex = math.random(1, #finalMatchingBonusItems)
            local randomBonusItem = finalMatchingBonusItems[randomBonusIndex]
            local addItemCount = math.random(randomBonusItem.quantity[1], randomBonusItem.quantity[2])
            if xPlayer.canCarryItem(randomBonusItem.itemName, addItemCount) then
                xPlayer.addInventoryItem(randomBonusItem.itemName, addItemCount)
            end
        end
        xPlayer.addAccountMoney("money", math.random(1500,2000))

        local newmoney = xPlayer.getMoney()
        pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'ReceivedMailDerivelyMoney',
				content = ('%s ได้รับเงินจากการส่งจดหมายจำนวน $%s และเหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, (newmoney - oldmoney), newmoney),
				source = xPlayer.source,
			})
		end) -- End log
    end
end

function handleBlipPlayer(source)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    for k,po in pairs(positionObj) do
        if #(playerCoords - po.position) <= 50 then
            positionObj[k].blip_done = true
            --print(po.blip_done)
            Wait(100)
        end
        Wait(100)
    end
    Wait(100)
    TriggerClientEvent('cc_spawnmailbox:updateBlip',-1)
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        positionObj = {}
        alreadySent = 0
    end
end)

