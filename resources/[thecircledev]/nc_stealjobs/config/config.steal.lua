-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --
Config.StealJobs = {
	[1] = {
		name = 'Cement', -- ชื่อของสิ่งของ
		text_ingame = 'กด ~y~E ~s~เพื่อขโมย ~y~%s', -- ข้อความที่ต้องการเขียนบนสิ่งของนั้นๆ
		text_z_offset = 1.1, -- ระยะในแนวแกน Z ของ Text เวลา
		action_radius = 1.9, -- ระยะขโมย
		cooldown = 30 * 60, -- Cooldown หลังขโมย หน่วยเป็นวินาที (1 * 60 = 1 นาที)
		need_cops = 4, -- จำนวนตำรวจที่ต้องการในการขโมย
		disable_collision = false, -- ปิด Collision ของของ Model (สามารถเดินหรือขับรถทะลุได้)
		zone = {
			coords = vector3(-336.19, -929.21, 31.08), -- ตำแหน่งจุดศูนย์กลาง
			radius = 15000.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถขโมยได้
			blocks = { -- Block จุดตาม Zone
				{
					coords = vector3(-466.1499938964844, -988.0999755859376, 23.54999923706054),
					radius = 120.0
				},
				{
					coords = vector3(5187.0400390625, -5115.68994140625, 3.77999997138977),
					radius = 1400.0
				},
				{
					coords = vector3(490.7799987792969, 2947.409912109375, 42.90999984741211),
					radius = 15.0
				}, {
					coords = vector3(225.41000366210935, 3098.159912109375, 42.58000183105469),
					radius = 15.0
				}, {
					coords = vector3(1868.1600341796875, 3854.389892578125, 33.04999923706055),
					radius = 15.0
				}, {
					coords = vector3(1860.22998046875, 3867, 33.5),
					radius = 15.0
				}, {
					coords = vector3(1052.31005859375, 2314.60009765625, 45.31000137329101),
					radius = 15.0
				}, {
					coords = vector3(2003.06005859375, 4980.91015625, 41.95999908447265),
					radius = 15.0
				}, {
					coords = vector3(2193.6201171875, 5601.64013671875, 54.04999923706055),
					radius = 15.0
				}, {
					coords = vector3(2711.56005859375, 3447.159912109375, 55.61999893188476),
					radius = 30.0
				}, {
					coords = vector3(2842.340087890625, 4571.16015625, 47.02999877929687),
					radius = 15.0
				}, {
					coords = vector3(111.52999877929688, 6430.56005859375, 32.18000030517578),
					radius = 15.0
				}, {
					coords = vector3(87.47000122070312, 6575.330078125, 31.86000061035156),
					radius = 15.0
				}, {
					coords = vector3(40.45999908447265, 6507.2900390625, 31.89999961853027),
					radius = 15.0
				}, {
					coords = vector3(-206.6499938964844, 6468.4599609375, 31.5300006866455),
					radius = 15.0
				}, {
					coords = vector3(-343.9500122070313, 6299.6298828125, 33.29000091552734),
					radius = 30.0
				}, {
					coords = vector3(-330.7099914550781, 6277.77978515625, 32.11000061035156),
					radius = 30.0
				}, {
					coords = vector3(991.489990234375, 2358.739990234375, 51.86000061035156),
					radius = 15.0
				}, {
					coords = vector3(1821.7931, 3759.2639, 34.6060),
					radius = 15.0
				}, {
					coords = vector3(1216.469970703125, 1854.72998046875, 78.87000274658203),
					radius = 70.0
				}
			}
		},
		-- use = { name = 'bread', type = 'item', quantity = 0, remove = true },		-- Item ที่ต้องการในการขโมย *หากไม่ต้องการให้ใช้ Item ให้ใส่ quantity = 0 (name: ชื่อสิ่งของ | type: account|item | quantity: จำนวนที่ต้องการ | remove: ลบ Item หรือไม่?)
		rewards = {
			main = {
				name = 'cement',
				type = 'item',
				quantity = 1
			}, -- Item ที่จะได้จากการขโมย (เมื่อ Item นี้เต็มจะไม่สามารถขโมยได้)
			bonus = {																-- ผลตอบแทนจากการขโมย
				{ name = 'exp', type = 'item', quantity = 1, percent = 10.0 },
			}
		},
		models = { -- Model (ใส่ค่าเป็นตัวเลข) *หากใช้ `object_name` จะมีค่าออกมาเป็นตัวเลขเหมือนกัน
			`prop_cementbags01`, `prop_cons_cements01`},
		jobs_blacklist = { -- อาชีพที่ไม่สามารถให้ทำงานนี้ได้
			['police'] = true,
			['ambulance'] = true,
			['circle'] = true
		},
		alert = function(success) -- แจ้งเตือนหน่วยงาน (ถ้าขโมยสำเร็จ success จะส่งค่ามาเป็น true)
			--TriggerEvent("Porpy_policealert:alertNet", "cement")
			--TriggerEvent('nc_alert:alertNet', 'cement')
			exports['Porpy_policealert']:alertNet("cement")
		end,
		minigame = function() -- ใช้งาน Minigame (return true เมื่อผ่าน Minigame | return false เมื่อไม่ผ่าน Minigame) *หากไม่ต้องการใช้งาน Minigame ให้ return true กลับไปเสมอ
			return true
		end,
		on_success = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น true
			duration = 31, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
				anim = 'machinic_loop_mechandplayer',
				flag = 49
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				pcall(function()
					TriggerEvent("mythic_progbar:client:progress", {
						name = "stealCement",
						duration = 30000,
						label = "กำลังขโมยปูน",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true
						}
					}, function(status)
						if not status then
							--TriggerServerEvent("cc_cementrobbery:BonusItem","Joi_Taokha!9!8!7!6")
						end
					end)
				end)

			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)

					TriggerEvent("mythic_progbar:client:cancel")
				pcall(function()
					exports.nc_notify:RemoveNotification('steal_cement')
				end)
			end,
			on_cancel = function()
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
					TriggerEvent("mythic_progbar:client:cancel")
				pcall(function()
					exports.nc_notify:RemoveNotification('steal_cement')
				end)
			end,
			esc_to_cancel = true, -- อนุญาตให้ยกเลิกการขโมยได้เมื่อกด ESC
			remove_cooldown_on_cancel = true -- เปิด/ปิด การล้าง Cooldown เมื่อยกเลิกการขโมย
		},
		on_failed = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น false
			duration = 20, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@mp_player_intupperface_palm',
				anim = 'idle_a',
				flag = 50
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				-- ใส่หลอดโหลดตรงนี้!

				pcall(function()
					exports.nc_notify:PushNotification({
						name = 'steal_cement',
						title = 'ขโมยปูนไม่สำเร็จ',
						description = 'เจ้าหน้าที่ตำรวจกำลังมา ..',
						type = 'error',
						icon = 'clock',
						duration = 30 * 1000
					})
				end)
			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
				pcall(function()
					exports.nc_notify:RemoveNotification('steal_cement')
					exports.nc_notify:PushNotification({
						title = 'หยุดขโมยปูนแล้ว',
						type = 'error',
						duration = 3000
					})
				end)
			end
		},
		on_outside = function() -- Function นี้จะทำเมื่อผู้เล่นมีเจตนาใช้บัคออกนอกระยะการขโมย

		end,
		can_hit_on_block = true, -- เปิด/ปิด อนุญาตให้ผู้อื่นสามารถโจมดีคุณได้ขณะโดนล็อคขา
		remove_cooldown_on_failed = true, -- เปิด/ปิด การล้าง Cooldown เมื่อ Minigame return มาเป็น false
		give_rewards_on_dead = false -- ให้ของรางวัลเมื่อผู้เล่นตาย
	},
	[2] = {
		name = 'Cashier', -- ชื่อของสิ่งของ
		text_ingame = 'กด ~y~E ~s~ เพื่องัด ~y~%s', -- ข้อความที่ต้องการเขียนบนสิ่งของนั้นๆ
		text_z_offset = 0.4, -- ระยะในแนวแกน Z ของ Text เวลา
		action_radius = 1.2, -- ระยะขโมย
		cooldown = 30 * 60, -- Cooldown หลังขโมย หน่วยเป็นวินาที (1 * 60 = 1 นาที)
		need_cops = 6, -- จำนวนตำรวจที่ต้องการในการขโมย--
		disable_collision = false, -- ปิด Collision ของของ Model (สามารถเดินหรือขับรถทะลุได้)
		zone = {
			coords = vector3(-50.22999954223633, -1106.2099609375, 26.43000030517578), -- ตำแหน่งจุดศูนย์กลาง
			radius = 3200.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถขโมยได้
			blocks = { -- Block จุดตาม Zone
				{ coords = vector3(16.786814, -1104.843994, 29.7854000), radius = 10.0},
				{ coords = vector3(843.745056, -1031.103272, 28.184570), radius = 10.0},
				{ coords = vector3(250.443954, -47.828572, 69.938476), radius = 10.0},
				{ coords = vector3(-1307.432984, -392.531860, 36.693726), radius = 10.0},
				{ coords = vector3(-1224.276978, -1455.481324, 4.325318), radius = 100.0},
				{ coords = vector3(-1117.846192, -1623.916504, 4.392700), radius = 100.0},
				{ coords = vector3(123.032966, -224.492310, 54.554566), radius = 5.0},
				{ coords = vector3(-31.767032, -150.738464, 57.065186), radius = 5.0},
				{ coords = vector3(126.567032, -1298.610962, 29.263062), radius = 5.0},
				{ coords = vector3(77.274726, -1390.641724, 29.364136), radius = 5.0},
				{ coords = vector3(2564.373536, 335.129670, 108.440308), radius = 50.0},
				{ coords = vector3(423.309876, -808.298890, 29.482056), radius = 5.0},
				{ coords = vector3(321.613190, 181.094512, 103.570678), radius = 2.0},
				{ coords = vector3(-1190.940674, -768.949462, 17.316528), radius = 5.0},
				{ coords = vector3(-819.692322, -1074.263794, 11.317994), radius = 5.0},
				{ coords = vector3(-1285.068116, -1116.356080, 6.987548), radius = 5.0},
				{ coords = vector3(1210.180176, -471.257142, 66.197754), radius = 5.0},
				{ coords = vector3(134.452744, -1710.369262, 29.279908), radius = 5.0},
				{ coords = vector3(1324.918702, -1652.175782, 52.263062), radius = 5.0},
				{ coords = vector3(-1821.903320, 792.342834, 138.298218), radius = 5.0},
				{ coords = vector3(373.556030, 325.173614, 103.553834), radius = 2.0},
				{ coords = vector3(1164.712036, -326.347260, 69.230712), radius = 2.0},
				{ coords = vector3(815.617554, -2157.692382, 29.616822), radius = 10.0},
				{ coords = vector3(-663.375854, -936.369202, 21.815430), radius = 5.0},
				{ coords = vector3(878.400024, 535.938476, 125.744996), radius = 5.0},
				{ coords = vector3(-417.942872, 1081.305542, 321.253540), radius = 10.0},
				{ coords = vector3(-1386.659302, -589.608764, 30.307740), radius = 5.0},
				{ coords = vector3(-1858.1600341796875, 82.91999816894531, 79.47000122070312), radius = 15.0},
				{ coords = vector3(835.3499755859375, 528.4299926757812, 125.91999816894533), radius = 25.0},
			}
		},
		use = {
			name = 'screwdv',
			type = 'item',
			quantity = 1,
			remove = false
		}, -- Item ที่ต้องการในการขโมย *หากไม่ต้องการให้ใช้ Item ให้ใส่ quantity = 0 (name: ชื่อสิ่งของ | type: account|item | quantity: จำนวนที่ต้องการ | remove: ลบ Item หรือไม่?)
		rewards = {
			-- main = { name = 'sprunk', type = 'item', quantity = 1 },				-- Item ที่จะได้จากการขโมย (เมื่อ Item นี้เต็มจะไม่สามารถขโมยได้)
			-- bonus = {																-- ผลตอบแทนจากการขโมย
			--	{ name = 'black_money', type = 'account', quantity = 1000, percent = 5.0 },
			--	{ name = 'water', type = 'item', quantity = 1, percent = 50.0 },
			-- }
		},
		models = { -- Model (ใส่ค่าเป็นตัวเลข) *หากใช้ `object_name` จะมีค่าออกมาเป็นตัวเลขเหมือนกัน
			`prop_till_01`, `prop_till_02`, `p_till_01_s`},
		jobs_blacklist = { -- อาชีพที่ไม่สามารถให้ทำงานนี้ได้
			-- ['police'] = true,
			-- ['ambulance'] = true,
			-- ['mechanic'] = true
		},
		alert = function(success) -- แจ้งเตือนหน่วยงาน (ถ้าขโมยสำเร็จ success จะส่งค่ามาเป็น true)
			--TriggerEvent("Porpy_policealert:alertNet", "store_rob")
			exports['Porpy_policealert']:alertNet("store_rob")
		end,
		minigame = function() -- ใช้งาน Minigame (return true เมื่อผ่าน Minigame | return false เมื่อไม่ผ่าน Minigame) *หากไม่ต้องการใช้งาน Minigame ให้ return true กลับไปเสมอ
			--TriggerEvent("Porpy_policealert:alertNet", "store_rob")
			exports['Porpy_policealert']:alertNet("store_rob")
			while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
				RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
				Citizen.Wait(100)
			end
			TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, 8.0, -1, 17, 0, false, false, false)
			local result = exports.storerobbery:miniGameLockPick(true)
			return result
		end,
		on_success = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น true
			duration = 31, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'veh@break_in@0h@p_m_one@',
				anim = 'low_force_entry_ds',
				flag = 49
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)
				-- ใส่หลอดโหลดตรงนี้!
				pcall(function()
					TriggerEvent("mythic_progbar:client:progress", {
						name = "storeRobbery",
						duration = 30000,
						label = "กำลังงัดร้านค้า",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true
						}
					}, function(status)
						if not status then
							ESX.TriggerServerCallback('cc_storerobbery:giveItem', function()

							end, "Rpg!@7!8!9!10")
							TriggerServerEvent("cc_blip:sucessStealJobs")
						end
					end)
				end)
			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
				TriggerEvent("mythic_progbar:client:cancel")
			end,
			on_cancel = function()
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
			end,
			esc_to_cancel = false, -- อนุญาตให้ยกเลิกการขโมยได้เมื่อกด ESC
			remove_cooldown_on_cancel = true -- เปิด/ปิด การล้าง Cooldown เมื่อยกเลิกการขโมย
		},
		on_failed = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น false
			duration = 2, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@mp_player_intupperface_palm',
				anim = 'idle_a',
				flag = 50
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)
			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
			end
		},
		on_outside = function() -- Function นี้จะทำเมื่อผู้เล่นมีเจตนาใช้บัคออกนอกระยะการขโมย

		end,
		can_hit_on_block = true, -- เปิด/ปิด อนุญาตให้ผู้อื่นสามารถโจมดีคุณได้ขณะโดนล็อคขา
		remove_cooldown_on_failed = true, -- เปิด/ปิด การล้าง Cooldown เมื่อ Minigame return มาเป็น false
		give_rewards_on_dead = false -- ให้ของรางวัลเมื่อผู้เล่นตาย
	},
	[3] = {
		name = 'ถังขยะ', -- ชื่อของสิ่งของ
		text_ingame = 'กด ~y~E ~s~เพื่อคุ้ย ~y~%s', -- ข้อความที่ต้องการเขียนบนสิ่งของนั้นๆ
		text_z_offset = 1.1, -- ระยะในแนวแกน Z ของ Text เวลา
		action_radius = 1.9, -- ระยะขโมย
		cooldown = 10 * 60, -- Cooldown หลังขโมย หน่วยเป็นวินาที (1 * 60 = 1 นาที)
		need_cops = 0, -- จำนวนตำรวจที่ต้องการในการขโมย
		disable_collision = false, -- ปิด Collision ของของ Model (สามารถเดินหรือขับรถทะลุได้)
		zone = {
			coords = vector3(-336.19, -929.21, 31.08), -- ตำแหน่งจุดศูนย์กลาง
			radius = 15000.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถขโมยได้
			blocks = { -- Block จุดตาม Zone
			}
		},
		-- use = { name = 'bread', type = 'item', quantity = 0, remove = true },		-- Item ที่ต้องการในการขโมย *หากไม่ต้องการให้ใช้ Item ให้ใส่ quantity = 0 (name: ชื่อสิ่งของ | type: account|item | quantity: จำนวนที่ต้องการ | remove: ลบ Item หรือไม่?)
		rewards = {
			main = {
				name = 'money',
				type = 'account',
				quantity = 10000
			}, -- Item ที่จะได้จากการขโมย (เมื่อ Item นี้เต็มจะไม่สามารถขโมยได้)
			bonus = {																-- ผลตอบแทนจากการขโมย
				{ name = 'exp', type = 'item', quantity = math.random(3,5), percent = 100.0 },
			}
		},
		models = { -- Model (ใส่ค่าเป็นตัวเลข) *หากใช้ `object_name` จะมีค่าออกมาเป็นตัวเลขเหมือนกัน
			`prop_trashcan`},
		jobs_blacklist = { -- อาชีพที่ไม่สามารถให้ทำงานนี้ได้
			['police'] = true,
			['ambulance'] = true,
			['circle'] = true
		},
		alert = function(success) -- แจ้งเตือนหน่วยงาน (ถ้าขโมยสำเร็จ success จะส่งค่ามาเป็น true)

		end,
		minigame = function() -- ใช้งาน Minigame (return true เมื่อผ่าน Minigame | return false เมื่อไม่ผ่าน Minigame) *หากไม่ต้องการใช้งาน Minigame ให้ return true กลับไปเสมอ
			return true
		end,
		on_success = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น true
			duration = 31, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
				anim = 'machinic_loop_mechandplayer',
				flag = 49
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				pcall(function()
					TriggerEvent("mythic_progbar:client:progress", {
						name = "stealCement",
						duration = 30000,
						label = "กำลังขโมยปูน",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true
						}
					}, function(status)
						if not status then
							TriggerServerEvent("cc_blip:sucessStealJobs")
						end
					end)
				end)

			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)

				TriggerEvent("mythic_progbar:client:cancel")
			end,
			on_cancel = function()
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
				TriggerEvent("mythic_progbar:client:cancel")
			end,
			esc_to_cancel = true, -- อนุญาตให้ยกเลิกการขโมยได้เมื่อกด ESC
			remove_cooldown_on_cancel = true -- เปิด/ปิด การล้าง Cooldown เมื่อยกเลิกการขโมย
		},
		on_failed = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น false
			duration = 20, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@mp_player_intupperface_palm',
				anim = 'idle_a',
				flag = 50
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				-- ใส่หลอดโหลดตรงนี้!
			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
			end
		},
		on_outside = function() -- Function นี้จะทำเมื่อผู้เล่นมีเจตนาใช้บัคออกนอกระยะการขโมย

		end,
		can_hit_on_block = true, -- เปิด/ปิด อนุญาตให้ผู้อื่นสามารถโจมดีคุณได้ขณะโดนล็อคขา
		remove_cooldown_on_failed = true, -- เปิด/ปิด การล้าง Cooldown เมื่อ Minigame return มาเป็น false
		give_rewards_on_dead = false -- ให้ของรางวัลเมื่อผู้เล่นตาย
	},
	[4] = {
		name = 'กล่องยา', -- ชื่อของสิ่งของ
		text_ingame = 'กด ~y~E ~s~เพื่อค้น ~y~%s', -- ข้อความที่ต้องการเขียนบนสิ่งของนั้นๆ
		text_z_offset = 1.1, -- ระยะในแนวแกน Z ของ Text เวลา
		action_radius = 1.9, -- ระยะขโมย
		cooldown = 15 * 60, -- Cooldown หลังขโมย หน่วยเป็นวินาที (1 * 60 = 1 นาที)
		need_cops = 0, -- จำนวนตำรวจที่ต้องการในการขโมย
		disable_collision = false, -- ปิด Collision ของของ Model (สามารถเดินหรือขับรถทะลุได้)
		zone = {
			coords = vector3(-336.19, -929.21, 31.08), -- ตำแหน่งจุดศูนย์กลาง
			radius = 15000.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถขโมยได้
			blocks = { -- Block จุดตาม Zone
			}
		},
		-- use = { name = 'bread', type = 'item', quantity = 0, remove = true },		-- Item ที่ต้องการในการขโมย *หากไม่ต้องการให้ใช้ Item ให้ใส่ quantity = 0 (name: ชื่อสิ่งของ | type: account|item | quantity: จำนวนที่ต้องการ | remove: ลบ Item หรือไม่?)
		rewards = {
			main = {
				name = 'cement',
				type = 'item',
				quantity = 5
			}, -- Item ที่จะได้จากการขโมย (เมื่อ Item นี้เต็มจะไม่สามารถขโมยได้)
			bonus = {																-- ผลตอบแทนจากการขโมย
				{ name = 'box_amp', type = 'item', quantity = 1, percent = 100.0 },
				{ name = 'screwdv', type = 'item', quantity = 3, percent = 100.0 },
			}
		},
		models = { -- Model (ใส่ค่าเป็นตัวเลข) *หากใช้ `object_name` จะมีค่าออกมาเป็นตัวเลขเหมือนกัน
			`medical_box`},
		jobs_blacklist = { -- อาชีพที่ไม่สามารถให้ทำงานนี้ได้
			['police'] = true,
			['ambulance'] = true,
			['circle'] = true
		},
		alert = function(success) -- แจ้งเตือนหน่วยงาน (ถ้าขโมยสำเร็จ success จะส่งค่ามาเป็น true)

		end,
		minigame = function() -- ใช้งาน Minigame (return true เมื่อผ่าน Minigame | return false เมื่อไม่ผ่าน Minigame) *หากไม่ต้องการใช้งาน Minigame ให้ return true กลับไปเสมอ
			return true
		end,
		on_success = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น true
			duration = 31, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
				anim = 'machinic_loop_mechandplayer',
				flag = 49
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				pcall(function()
					TriggerEvent("mythic_progbar:client:progress", {
						name = "stealCement",
						duration = 30000,
						label = "กำลังขโมยปูน",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true
						}
					}, function(status)
						if not status then
							TriggerServerEvent("cc_blip:sucessStealJobs")
						end
					end)
				end)

			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)

				TriggerEvent("mythic_progbar:client:cancel")
			end,
			on_cancel = function()
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
				TriggerEvent("mythic_progbar:client:cancel")
			end,
			esc_to_cancel = true, -- อนุญาตให้ยกเลิกการขโมยได้เมื่อกด ESC
			remove_cooldown_on_cancel = true -- เปิด/ปิด การล้าง Cooldown เมื่อยกเลิกการขโมย
		},
		on_failed = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น false
			duration = 20, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@mp_player_intupperface_palm',
				anim = 'idle_a',
				flag = 50
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				-- ใส่หลอดโหลดตรงนี้!
			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
			end
		},
		on_outside = function() -- Function นี้จะทำเมื่อผู้เล่นมีเจตนาใช้บัคออกนอกระยะการขโมย

		end,
		can_hit_on_block = true, -- เปิด/ปิด อนุญาตให้ผู้อื่นสามารถโจมดีคุณได้ขณะโดนล็อคขา
		remove_cooldown_on_failed = true, -- เปิด/ปิด การล้าง Cooldown เมื่อ Minigame return มาเป็น false
		give_rewards_on_dead = false -- ให้ของรางวัลเมื่อผู้เล่นตาย
	},
	[5] = {
		name = 'คลังสินค้า', -- ชื่อของสิ่งของ
		text_ingame = 'กด ~y~E ~s~เพื่อขโมย ~y~%s', -- ข้อความที่ต้องการเขียนบนสิ่งของนั้นๆ
		text_z_offset = 1.1, -- ระยะในแนวแกน Z ของ Text เวลา
		action_radius = 1.9, -- ระยะขโมย
		cooldown = 60 * 60, -- Cooldown หลังขโมย หน่วยเป็นวินาที (1 * 60 = 1 นาที)
		need_cops = 6, -- จำนวนตำรวจที่ต้องการในการขโมย
		disable_collision = false, -- ปิด Collision ของของ Model (สามารถเดินหรือขับรถทะลุได้)
		zone = {
			coords = vector3(-336.19, -929.21, 31.08), -- ตำแหน่งจุดศูนย์กลาง
			radius = 15000.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถขโมยได้
			blocks = { -- Block จุดตาม Zone
			}
		},
		use = { name = 'screwdv', type = 'item', quantity = 1, remove = false },-- Item ที่ต้องการในการขโมย *หากไม่ต้องการให้ใช้ Item ให้ใส่ quantity = 0 (name: ชื่อสิ่งของ | type: account|item | quantity: จำนวนที่ต้องการ | remove: ลบ Item หรือไม่?)
		rewards = {
			main = {
				name = 'box_supstore',
				type = 'item',
				quantity = 1
			}, -- Item ที่จะได้จากการขโมย (เมื่อ Item นี้เต็มจะไม่สามารถขโมยได้)
			bonus = {																-- ผลตอบแทนจากการขโมย
				{ name = 'keycard_gold', type = 'item', quantity = 1, percent = 10.0 },
				{ name = 'keycard_red', type = 'item', quantity = 1, percent = 5.0 },
			}
		},
		models = { -- Model (ใส่ค่าเป็นตัวเลข) *หากใช้ `object_name` จะมีค่าออกมาเป็นตัวเลขเหมือนกัน
			`market_box`},
		jobs_blacklist = { -- อาชีพที่ไม่สามารถให้ทำงานนี้ได้
			['police'] = true,
			['ambulance'] = true,
			['circle'] = true
		},
		alert = function(success) -- แจ้งเตือนหน่วยงาน (ถ้าขโมยสำเร็จ success จะส่งค่ามาเป็น true)
			--TriggerEvent("Porpy_policealert:alertNet", "superstore_rob")
			exports['Porpy_policealert']:alertNet("superstore_rob")
		end,
		minigame = function() -- ใช้งาน Minigame (return true เมื่อผ่าน Minigame | return false เมื่อไม่ผ่าน Minigame) *หากไม่ต้องการใช้งาน Minigame ให้ return true กลับไปเสมอ
			--TriggerEvent("Porpy_policealert:alertNet", "superstore_rob")
			exports['Porpy_policealert']:alertNet("superstore_rob")
			while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
				RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
				Citizen.Wait(100)
			end
			TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, 8.0, -1, 17, 0, false, false, false)
			local result = exports.storerobbery:miniGameLockPick(true)
			return result
		end,
		on_success = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น true
			duration = 31, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
				anim = 'machinic_loop_mechandplayer',
				flag = 49
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				pcall(function()
					TriggerEvent("mythic_progbar:client:progress", {
						name = "stealCement",
						duration = 30000,
						label = "กำลังขโมยปูน",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true
						}
					}, function(status)
						if not status then
							TriggerServerEvent("cc_blip:sucessStealJobs")
						end
					end)
				end)

			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)

				TriggerEvent("mythic_progbar:client:cancel")
			end,
			on_cancel = function()
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
			end,
			esc_to_cancel = false, -- อนุญาตให้ยกเลิกการขโมยได้เมื่อกด ESC
			remove_cooldown_on_cancel = true -- เปิด/ปิด การล้าง Cooldown เมื่อยกเลิกการขโมย
		},
		on_failed = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น false
			duration = 20, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@mp_player_intupperface_palm',
				anim = 'idle_a',
				flag = 50
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				-- ใส่หลอดโหลดตรงนี้!
			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
			end
		},
		on_outside = function() -- Function นี้จะทำเมื่อผู้เล่นมีเจตนาใช้บัคออกนอกระยะการขโมย

		end,
		can_hit_on_block = true, -- เปิด/ปิด อนุญาตให้ผู้อื่นสามารถโจมดีคุณได้ขณะโดนล็อคขา
		remove_cooldown_on_failed = true, -- เปิด/ปิด การล้าง Cooldown เมื่อ Minigame return มาเป็น false
		give_rewards_on_dead = false -- ให้ของรางวัลเมื่อผู้เล่นตาย
	},
	[6] = {
		name = 'ของกลาง', -- ชื่อของสิ่งของ
		text_ingame = 'กด ~y~E ~s~เพื่อขโมย ~y~%s', -- ข้อความที่ต้องการเขียนบนสิ่งของนั้นๆ
		text_z_offset = 1.1, -- ระยะในแนวแกน Z ของ Text เวลา
		action_radius = 1.9, -- ระยะขโมย
		cooldown = 20 * 60, -- Cooldown หลังขโมย หน่วยเป็นวินาที (1 * 60 = 1 นาที)
		need_cops = 0, -- จำนวนตำรวจที่ต้องการในการขโมย
		disable_collision = false, -- ปิด Collision ของของ Model (สามารถเดินหรือขับรถทะลุได้)
		zone = {
			coords = vector3(-336.19, -929.21, 31.08), -- ตำแหน่งจุดศูนย์กลาง
			radius = 15000.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถขโมยได้
			blocks = { -- Block จุดตาม Zone
			}
		},
		--use = { name = 'screwdv', type = 'item', quantity = 1, remove = false },-- Item ที่ต้องการในการขโมย *หากไม่ต้องการให้ใช้ Item ให้ใส่ quantity = 0 (name: ชื่อสิ่งของ | type: account|item | quantity: จำนวนที่ต้องการ | remove: ลบ Item หรือไม่?)
		rewards = {
			main = {
				name = 'box_evidence',
				type = 'item',
				quantity = 1
			}, -- Item ที่จะได้จากการขโมย (เมื่อ Item นี้เต็มจะไม่สามารถขโมยได้)
			bonus = {																-- ผลตอบแทนจากการขโมย
				{ name = 'black_money', type = 'account', quantity = math.random(1000,3000), percent = 100.0 },
				{ name = 'cement', type = 'item', quantity = 1, percent = 100.0 },
				{ name = 'meth_a', type = 'item', quantity = 1, percent = 100.0 },
				{ name = 'box_amp', type = 'item', quantity = 1, percent = 100.0 },
			}
		},
		models = { -- Model (ใส่ค่าเป็นตัวเลข) *หากใช้ `object_name` จะมีค่าออกมาเป็นตัวเลขเหมือนกัน
			`prop_black_job`},
		jobs_blacklist = { -- อาชีพที่ไม่สามารถให้ทำงานนี้ได้
			['police'] = true,
			['ambulance'] = true,
			['circle'] = true
		},
		alert = function(success) -- แจ้งเตือนหน่วยงาน (ถ้าขโมยสำเร็จ success จะส่งค่ามาเป็น true)

		end,
		minigame = function() -- ใช้งาน Minigame (return true เมื่อผ่าน Minigame | return false เมื่อไม่ผ่าน Minigame) *หากไม่ต้องการใช้งาน Minigame ให้ return true กลับไปเสมอ
			return true
		end,
		on_success = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น true
			duration = 31, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
				anim = 'machinic_loop_mechandplayer',
				flag = 49
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				pcall(function()
					TriggerEvent("mythic_progbar:client:progress", {
						name = "stealCement",
						duration = 30000,
						label = "กำลังขโมยปูน",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true
						}
					}, function(status)
						if not status then
							TriggerServerEvent("cc_blip:sucessStealJobs")
						end
					end)
				end)

			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)

				TriggerEvent("mythic_progbar:client:cancel")
			end,
			on_cancel = function()
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
				TriggerEvent("mythic_progbar:client:cancel")
			end,
			esc_to_cancel = true, -- อนุญาตให้ยกเลิกการขโมยได้เมื่อกด ESC
			remove_cooldown_on_cancel = true -- เปิด/ปิด การล้าง Cooldown เมื่อยกเลิกการขโมย
		},
		on_failed = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น false
			duration = 20, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
			animation = {
				dict = 'anim@mp_player_intupperface_palm',
				anim = 'idle_a',
				flag = 50
			},
			on_start = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
				end)

				-- ใส่หลอดโหลดตรงนี้!
			end,
			on_end = function(entity)
				pcall(function()
					exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
				end)
			end
		},
		on_outside = function() -- Function นี้จะทำเมื่อผู้เล่นมีเจตนาใช้บัคออกนอกระยะการขโมย

		end,
		can_hit_on_block = true, -- เปิด/ปิด อนุญาตให้ผู้อื่นสามารถโจมดีคุณได้ขณะโดนล็อคขา
		remove_cooldown_on_failed = true, -- เปิด/ปิด การล้าง Cooldown เมื่อ Minigame return มาเป็น false
		give_rewards_on_dead = false -- ให้ของรางวัลเมื่อผู้เล่นตาย
	},
	-- [3] = {
	-- 	name = 'จดหมาย', -- ชื่อของสิ่งของ
	-- 	text_ingame = 'กด ~y~E ~s~ส่ง ~y~%s', -- ข้อความที่ต้องการเขียนบนสิ่งของนั้นๆ
	-- 	text_z_offset = 1.1, -- ระยะในแนวแกน Z ของ Text เวลา
	-- 	action_radius = 1.5, -- ระยะขโมย
	-- 	cooldown = 6 * 60, -- Cooldown หลังขโมย หน่วยเป็นวินาที (1 * 60 = 1 นาที)
	-- 	need_cops = 0, -- จำนวนตำรวจที่ต้องการในการขโมย
	-- 	disable_collision = false, -- ปิด Collision ของของ Model (สามารถเดินหรือขับรถทะลุได้)
	-- 	zone = {
	-- 		coords = vector3(-336.19, -929.21, 31.08), -- ตำแหน่งจุดศูนย์กลาง
	-- 		radius = 15000.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถขโมยได้
	-- 		blocks = { -- Block จุดตาม Zone

	-- 		}
	-- 	},
	-- 	 use = { name = 'letter', type = 'item', quantity = 1, remove = true },		-- Item ที่ต้องการในการขโมย *หากไม่ต้องการให้ใช้ Item ให้ใส่ quantity = 0 (name: ชื่อสิ่งของ | type: account|item | quantity: จำนวนที่ต้องการ | remove: ลบ Item หรือไม่?)
	-- 	rewards = {
	-- 		--main = {
	-- 		--	name = 'money',
	-- 		--	type = 'account',
	-- 		--	quantity = math.random(700,900)
	-- 		--} -- Item ที่จะได้จากการขโมย (เมื่อ Item นี้เต็มจะไม่สามารถขโมยได้)
	-- 		-- bonus = {																-- ผลตอบแทนจากการขโมย
	-- 		-- 	--{ name = 'water', type = 'item', quantity = 1, percent = 50.0 },
	-- 		-- 	--{ name = 'money', type = 'account', quantity = 1, percent = 0.000001 },
	-- 		-- }
	-- 	},
	-- 	models = { -- Model (ใส่ค่าเป็นตัวเลข) *หากใช้ `object_name` จะมีค่าออกมาเป็นตัวเลขเหมือนกัน
	-- 		`postbox2`},
	-- 	jobs_blacklist = { -- อาชีพที่ไม่สามารถให้ทำงานนี้ได้
	-- 		['police'] = false,
	-- 		['ambulance'] = false,
	-- 		['circle'] = false
	-- 	},
	-- 	alert = function(success) -- แจ้งเตือนหน่วยงาน (ถ้าขโมยสำเร็จ success จะส่งค่ามาเป็น true)

	-- 	end,
	-- 	minigame = function() -- ใช้งาน Minigame (return true เมื่อผ่าน Minigame | return false เมื่อไม่ผ่าน Minigame) *หากไม่ต้องการใช้งาน Minigame ให้ return true กลับไปเสมอ
	-- 		local success = exports.cc_minigame:StartLockPickCircle(5,5,0,'whitespace')
	-- 		if not success then
	-- 			Citizen.CreateThread(function()
	-- 			for i = 1,7 do
	-- 				SetEntityCollision(PlayerPedId(), true)
	-- 				FreezeEntityPosition(PlayerPedId(), false)
	-- 				SetTimecycleModifierStrength(1.0)
	-- 				SetTimecycleModifier("Bloom")
	-- 				SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
	-- 				Citizen.Wait(1000)
	-- 			end
	-- 				SetTimecycleModifier("default")
	-- 				SetTimecycleModifierStrength(0.5)
	-- 			end)
	-- 			local currentPed = PlayerPedId()
	-- 			local currentHeal = GetEntityHealth(currentPed)
	-- 			local maxHealth = currentHeal-3
	-- 			SetEntityHealth(currentPed,maxHealth)
	-- 		end
	-- 		return success
	-- 	end,
	-- 	on_success = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น true
	-- 		duration = 11, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
	-- 		animation = {
	-- 			dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
	-- 			anim = 'machinic_loop_mechandplayer',
	-- 			flag = 49
	-- 		},
	-- 		on_start = function(entity)
	-- 			pcall(function()
	-- 				exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
	-- 			end)

	-- 			pcall(function()
	-- 				TriggerEvent("mythic_progbar:client:progress", {
	-- 					name = "sentLetter",
	-- 					duration = 10000,
	-- 					label = "กำลังส่งจดหมาย",
	-- 					useWhileDead = false,
	-- 					canCancel = false,
	-- 					controlDisables = {
	-- 						disableMovement = true,
	-- 						disableCarMovement = true,
	-- 						disableMouse = false,
	-- 						disableCombat = true
	-- 					}
	-- 				}, function(status)
	-- 					if not status then
	-- 						ESX.TriggerServerCallback('cc_spawnmailbox:count', function()

	-- 						end, "Rpg!@7!8!9!10")
	-- 					end
	-- 				end)
	-- 			end)

	-- 		end,
	-- 		on_end = function(entity)
	-- 			pcall(function()
	-- 				exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
	-- 			end)
	-- 			TriggerEvent("mythic_progbar:client:cancel")
	-- 		end,
	-- 		on_cancel = function()
	-- 			pcall(function()
	-- 				exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
	-- 			end)

	-- 		end,
	-- 		esc_to_cancel = false, -- อนุญาตให้ยกเลิกการขโมยได้เมื่อกด ESC
	-- 		remove_cooldown_on_cancel = true -- เปิด/ปิด การล้าง Cooldown เมื่อยกเลิกการขโมย
	-- 	},
	-- 	on_failed = { -- Function นี้จะทำเมื่อ Minigame return มาเป็น false
	-- 		duration = 7, -- หน่วยเป็นวินาที (1 * 60 = 1 นาที)
	-- 		animation = {
	-- 			dict = '',
	-- 			anim = '',
	-- 			flag = 49
	-- 		},
	-- 		on_start = function(entity)
	-- 			pcall(function()
	-- 				exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, true)
	-- 			end)
	-- 			-- ใส่หลอดโหลดตรงนี้!
	-- 			SetEntityCollision(PlayerPedId(), true)
	-- 			FreezeEntityPosition(PlayerPedId(), false)
	-- 		end,
	-- 		on_end = function(entity)
	-- 			pcall(function()
	-- 				exports.nc_inventory:BlockKey({'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, false)
	-- 			end)
	-- 		end
	-- 	},
	-- 	on_outside = function() -- Function นี้จะทำเมื่อผู้เล่นมีเจตนาใช้บัคออกนอกระยะการขโมย

	-- 	end,
	-- 	can_hit_on_block = true, -- เปิด/ปิด อนุญาตให้ผู้อื่นสามารถโจมดีคุณได้ขณะโดนล็อคขา
	-- 	remove_cooldown_on_failed = true, -- เปิด/ปิด การล้าง Cooldown เมื่อ Minigame return มาเป็น false
	-- 	give_rewards_on_dead = false -- ให้ของรางวัลเมื่อผู้เล่นตาย
	-- }
}
