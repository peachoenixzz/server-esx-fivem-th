--[[
	file: config.lua
	resource: scotty-casino-baccarat
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

Config = Config or {} 

Config["debug"] = false -- เปิดโหมดผู้พัฒนา (สามารถใช้คำสั่ง sc_baccarat เพื่อสร้างโต๊ะมาก๊อปที่อยู่ได้)

Config["reward"] = {
	["player"] = 1, -- 1 ผู้เล่นชนะ
	["banker"] = 0.9, -- 2 เจ้ามือชนะ
	["tie"] = 8, -- 3 เสมอ
	["player_pair"] = 10, -- 4 ผู้เล่นได้ pair
	["banker_pair"] = 10, -- 5 เจ้ามือได้ pair
}

Config["desk"] = {
	--{
	--	["name"] = "~b~Low Risk Baccarat", -- ชื่อโต๊ะ
	--	["limit"] = {10, 100}, -- จำนวนเงินเดิมพัน ขั้นต่ำ - สูงสุด
	--	["pos"] = {x = 954.59, y = -197.30, z = 72.21, h = 56.41  }, -- ที่อยู่โต๊ะ
	--	["currency"] = "black_money", -- ใช้เงินดำเป็นตัวเล่น
	--	["ped"] = "s_m_m_bouncer_01",
	--	["map_blip"] = {
	--		["enable"] = false,
	--		["name"] = "Black Baccarat",
	--		["scale"] = 0.5,
	--		["color"] = 35,
	--		["sprite"] = 431,
	--	}
	--},
	{
		["name"] = "~y~1,000 - 50,000 Baccarat",
		["limit"] = {1000, 50000},
		["pos"] = { x = 186.98, y = -922.64, z = 29.71, h = 324.58 }, 
		["currency_item"] = "casino_chip", -- หากต้องการใช้ไอเทมเป็นสกุลเงินแทน
		["currency_label"] = "~y~CASINO CHIPS~s~", -- ต้องใส่ชื่อ currency ด้วย
	},
	{
		["name"] = "~y~1,000 - 50,000 Baccarat",
		["limit"] = {1000, 50000},
		["pos"] = { x = 179.75, y = -917.68, z = 29.71, h = 325.50 },
		["currency_item"] = "casino_chip", -- หากต้องการใช้ไอเทมเป็นสกุลเงินแทน
		["currency_label"] = "~y~CASINO CHIPS~s~", -- ต้องใส่ชื่อ currency ด้วย
	},
}

Config["game_time"] = { -- time adjust
	wait_time = 10, -- waiting round
	deal_time = 5, -- deal card
	
	player_deal = 2.5, -- deal more card
	banker_deal = 2.5, -- deal more card
	
	restart_time = 7, -- time before table reset
}

Config["discord"] = {
	["name"] = "Casino Manager", -- ชื่อของ bot
	["hook"] = {
		["player"] = "",
	},
}

Config["pattern"] = true -- เปิดระบบ pattern อัตราการชนะจะขึ้นอยู่กับ pattern ที่ตั้งไว้
Config["pattern_term"] = 5 -- ใช้ pattern แค่กี่รอบก่อนจะเปลี่ยนไป pattern อื่น
Config["pattern_list"] = { -- ตาราง pattern (1 คือ player, 2 คือ banker, 3 คือ เสมอ)
	{1,1,2,3,2,1,2,1,1,1,2,2,1,2,1,1,3},
	{2,1,1,2,1,2,2,3,1,1,2,2,2,1,2,1,1},
	{1,1,1,1,2,2,1,3,3,1,1,2,2,1,2,2,1},
	{1,2,2,2,1,2,1,3,2,2,1,2,2,2,2,2,3},
}

-- Function to generate a new pattern based on the original patterns
local function generatePattern(originalPatterns)
	local pattern = {}
	for i = 1, #originalPatterns[1] do
		-- Choose a random original pattern
		local originalPattern = originalPatterns[math.random(#originalPatterns)]

		-- Introduce randomness to reduce the probability of "3"
		local value = originalPattern[i]
		if value == 3 then
			-- Reduce the probability of "3" (e.g., make it rare)
			if math.random(10) <= 2 then
				value = math.random(2)
			end
		end

		-- Append the value to the new pattern
		table.insert(pattern, value)
	end
	return pattern
end

for i = 1, 200 do
	table.insert(Config["pattern_list"], generatePattern(Config["pattern_list"]))
end

-- รูปแบบ Pattern ที่จะ win (หากไม่รู้ว่าทำอะไรอยู่กรุณาอย่าตั้งค่าส่วนนี้)
Config["pattern_win_list"] = {
	[1] = {
		{{2,3,8}, {7,5,8}},
		{{5,9,2}, {10,3,{1,2}}},
		{{1,1,6}, {7,9,1}},
		{{4,9,5}, {10,7}},
		{{1,5}, {10,10,10}},
		{{5,6,8}, {1,6}},
		{{7,8,3}, {5,9,6}},
		{{10,7}, {10,2,10}},
		{{7,10}, {4,1,7}},
		{{10,8}, {10,1}},
		{{9,9}, {10,7}},
		{{4,5}, {10,10}},
		{{8,10}, {10,10}},
		{{2,10,5}, {2,2,9}},
		{{1,10,4}, {3,10,8}},
		{{10,6}, {2,10,2}},
		{{4,10,2}, {1,10,1}},
		{{4,5}, {7,10}},
		{{1,10,5}, {10,3,10}},
		{{7,3,6}, {7,4,4}},
		{{10,5,9}, {1,10,10}},
		{{4,2}, {10,2,10}},
		{{10,9}, {6,5}},
		{{9,10}, {1,10}},
	},
	[2] = {
		{{2,5}, {9,10}},
		{{6,10}, {2,5}},
		{{4,10,6}, {10,5,10}},
		{{5,8,10}, {9,8}},
		{{3,10,8}, {10,4}},
		{{8,5,10}, {5,5,{6,8}}},
		{{3,10,8}, {10,4}},
		{{7,5,8}, {3,7,7}},
		{{1,4}, {6,3}},
		{{5,10,10}, {10,10,8}},
		{{5,10}, {3,5}},
		{{4,10}, {8,10}},
		{{8,2,2}, {3,1,1}},
		{{3,7,10}, {7,7}},
		{{10,10,10}, {10,4}},
		{{3,7}, {7,2}},
		{{3,10}, {9,10}},
		{{10,2}, {2,6}},
		{{7,10}, {5,10,3}},
		{{10,7}, {9,10}},
		{{10,10}, {10,8}},
		{{9,7}, {9,8}},
		{{5,2}, {10,9}},
		{{1,10,9}, {4,9,10}},
		{{4,3}, {8,10}},
		{{5,10}, {3,5}},
		{{10,4}, {10,8}},
		{{5,10,5}, {10,6}},
		{{10,10,7}, {6,5,7}},
		{{9,3,8}, {2,2}},
		{{8,8}, {1,8}},
		{{8,7,10}, {8,9}},
	},
	[3] = {
		{{1,1,10}, {9,1,2}},
		{{7,10}, {6,1}},
		{{10,9}, {2,7}},
		{{2,4}, {3,3}},
		{{9,10}, {10,9}},
		{{9,7}, {2,1,3}},
		{{4,10,10}, {4,10}},
		{{9,1,7}, {7,10}},
		{{1,10,6}, {3,8,6}},
		{{10,10,5}, {1,3,1}},
		{{4,9,7}, {1,2,7}},
	}
}

Config["translate"] = {
	player = "Player",
	banker = "Banker",
	tie = "Tie",
	
	state_waiting = "กำลังรอเดิมพัน...",
	state_open = "เริ่มเปิดรับเดิมพันแล้ว!",
	state_closed = "ปิดรับเดิมพัน",
	state_drawing = "กำลังจั่วไพ่",
	state_pdrawing = "กำลังรอฝั่งผู้เล่นจั่ว",
	state_ddrawing = "กำลังรอฝั่งเจ้ามือ",
	
	winner_banker = "Banker เป็นฝ่ายชนะ",
	winner_draw = "ผลคือเสมอกัน",
	winner_player = "Player เป็นฝ่ายชนะ",
	
	noti_win = "คุณได้รับเงิน $@amount จากบาคาร่า",
	noti_draw = "คุณได้รับเงิน $@amount คืนจากผลเสมอ",
	noti_lose = "คุณเสียเงิน $@amount จากการเล่นบาคาร่า",

	ui_3d_minimum = "[ขั้นต่ำ ~g~@minimum~s~ สูงสุด ~o~@maximum~s~]",
	
	currency_money = "เงินสด",
	currency_black_money = "เงินแดง",
	currency_bank = "เงินธนาคาร",
	
	ui_baccarat = "บาคาร่า",
	ui_bet_dl_place = "ลงเดิมพัน",
	ui_bet_dl_place2 = "กรุณาใส่จำนวนที่ต้องการจะเดิมพัน<br>เงินเดิมพันที่ลงได้: <tmaroon>$@min</tmaroon>, <torange>$@max</torange><br>สกุลเงินเดิมพัน: <tgold>@currency</tgold>",
	ui_bet_not_enough_chip = "จำนวนเงินไม่เพียงพอที่จะลง<br>ขาดอีก <tred>$@amount</tred> ถึงจะลงได้",

	ui_amount = "จำนวนเงิน",
	ui_amount_invalid = "จำนวนเงินไม่ถูกต้อง",
	ui_minimum = "ขั้นต่ำ $@amount",
	ui_maximum = "สูงสุด $@amount",
	ui_unknown = "ไม่ทราบ",
	
	ui_result_win = "คุณชนะ ได้รับเงิน $@amount",
	ui_result_draw = "คุณแพ้ เสียชิปทั้งหมด",
	ui_result_lose = "คุณแพ้ เสียชิปทั้งหมด",
	
	ui_pok = "ป๊อก @value",
	ui_blind = "บอด",
	ui_score = "@value แต้ม",
	ui_pair = "Pair",
	
	ui_time_left = "เหลืออีก @sec วินาที",
	
	press_e = "press ~INPUT_CONTEXT~ to join ~y~Baccarat",
	desk_pcount =  "จำนวนคนที่ลง %d คน",
	
	discord_profit = "คุณ @name ได้@cur $@profit จากการลง @result",
	discord_even = "คุณ @name ได้@curคืน $@profit จากการเสมอ เพราะลง @result",
	discord_lose = "คุณ @name ได้เสีย@cur $@profit จากการลง @result",
	discord_identifier = "\nSteam Identifier: %s\ntime: %s",
	discord_desk_number = "Desk:",
}