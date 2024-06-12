Config = {}

Config.Key = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
-- https://convertingcolors.com สีหาได้จากเว็บนี้
green 					= 56108
grey 		 			= 8421504
red 			  		= 16711680
orange 		 			= 16744192
blue 		 			= 2061822
purple 		 			= 11750815
Config.Logdiscord		= false
--Config.WebHook 			= "https://discord.com/api/webhooks/766657008077897768/JgC_3Aa15u81h2ZBBkEj-vtJ5KJ7Z6vi8cJmhIUUO9MmnVsv8hlmQyFNcgj-urUHzBH3"
Config.color			= 8696736
Config.colorBonus		= red

--Config['Npcped'] = 0xCF623A2C                   -- Name
--Config['Npcname'] = 'u_m_y_antonb'              -- Hash

Config.Setting = {
	["ระบบ"] = 'weight'   -- weight To limit
}

Config.ProcessingZone = {
	WoodProcess = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตไม้',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC
	
		PoliceCount = 0,
		ArmyCount = 0,
	
		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 79,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.2,
			Text = '<font face="font4thai">แปรรูปไม้</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x = -86.8407, y = 1880.3728,z = 197.3184,
				h = 266.1056,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = true,
			auto = true,
			{
				Text = 'ท่อนไม้',
				ItemName = "wood_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'ไม้แท่ง',
					ItemName = "wood_2", -- ไม้เนื้ออ่อน
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "coal",
							ItemCount = 1,
							Text = "ผงถ่าน",
							Percent = 0.10,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_mining",
							ItemCount = 1,
							Text = "Bonus Mining",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlus = {
	
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Copper = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตทองแดง',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC
	
		PoliceCount = 0,
		ArmyCount = 0,
	
		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 77,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปทองแดง</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x = 2710.4988, y=1513.9784,z= 24.5007,
				h = 80.3765,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = true,
			auto = true,
			{
				Text = 'เศษทองแดง',
				ItemName = "copper_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'ทองแดงแท่ง',
					ItemName = "copper_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "sulfur",
							ItemCount = 1,
							Text = "ซัลเฟอร์",
							Percent = 0.10,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_mining",
							ItemCount = 1,
							Text = "Bonus Mining",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlusPercent = 0.08,
					BonusPlusCount = 2,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
					BonusPlus = {
	
					},
				}
			}
		}
	},

	Steel = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตเหล็ก',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC

		PoliceCount = 0,
		ArmyCount = 0,

		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 80,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปเหล็ก</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x = -3153.2996,
				y = 1055.2780,
				z = 20.8388,
				h = 337.6122,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = true,
			auto = true,
			{
				Text = 'เศษเหล็ก',
				ItemName = "steel_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'เหล็กแท่ง',
					ItemName = "steel_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "steel_3",
							ItemCount = 1,
							Text = "เศษอัลลอย",
							Percent = 0.10,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_mining",
							ItemCount = 1,
							Text = "Bonus Mining",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlus = {
					},
					BonusPlusPercent = 0.01,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Gold = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตแร่',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC

		PoliceCount = 0,
		ArmyCount = 0,

		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 78,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text ='<font face="font4thai">แปรรูปแร่</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x=-1925.530029296875, y=2048.110107421875, z= 140.8300018310547,
				h = 257.34,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = true,
			auto = true,
			{
				Text = 'เศษทอง',
				ItemName = "gold_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'ทองแท่ง',
					ItemName = "gold_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_mining",
							ItemCount = 1,
							Text = "Bonus Mining",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlusPercent = 0.14,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
					BonusPlus = {

					},
				}
			}
		}
	},

	Crystal = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตแร่',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC

		PoliceCount = 0,
		ArmyCount = 0,

		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 78,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text ='<font face="font4thai">แปรรูปแร่</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x=-2292.0613, y=367.8064, z= 174.6015,
				h = 359.9994,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = true,
			auto = true,
			{
				Text = 'คริสตัล',
				ItemName = "crystal",
				ItemCount = 5,
				Get = {
					getOneItem = true,
					Text = 'เพชร',
					ItemName = "diamond",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "ruby",
							ItemCount = 1,
							Text = "รูบี้",
							Percent = 0.50,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_mining",
							ItemCount = 1,
							Text = "Bonus Mining",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlusPercent = 0.14,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
					BonusPlus = {

					},
				}
			}
		}
	},


	Weed = {
		jobBuff = false,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตกัญชา',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = false,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC

		PoliceCount = 0,
		ArmyCount = 0,

		WaitProcessing = 5000,
		Blips = {
			Blipopen = false,
			Id = 77,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปกัญชา</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x=-269.1700134277344, y=2209.22998046875, z=130.10000610351565,
				h = 57.14,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'กัญชา',
				ItemName = "weed",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'กัญชาแพ็ค',
					ItemName = "weed_pack",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},

					BonusPlus = {
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Pork = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตหมู',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_m_m_linecook',	-- ตัวละครNPC
		PoliceCount = 0,
		ArmyCount = 0,
	
		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 104,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.1,
			Text = '<font face="font4thai">แปรรูปหมู</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x = 983.1900024414064,
				y = -2125.300048828125,
				z = 30.47999954223632,
				h = 169.3,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = true,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'หมู',
				ItemName = "pork_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'หมูสไลด์',
					ItemName = "pork_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_eco",
							ItemCount = 1,
							Text = "Bonus Eco",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlus = {
	
					},
					BonusPlusPercent = 0.90,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Chicken = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตไก่',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_f_y_factory_01',	-- ตัวละครNPC
	
		PoliceCount = 0,
		ArmyCount = 0,
	
		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 105,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปไก่</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x= 346.3746, y= 3406.6106,z= 36.5165,
				h = 295.1999,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = true,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'ไก่',
				ItemName = "chicken_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'เนื้อไก่',
					ItemName = "chicken_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_eco",
							ItemCount = 1,
							Text = "Bonus Eco",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlus = {
	
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Rice = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตข้าว',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_f_y_factory_01',	-- ตัวละครNPC
	
		PoliceCount = 0,
		ArmyCount = 0,
	
		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 105,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปข้าว</font>',
		},
		Marker = {
			Type = -1,
			Pos = { 
				x= -126.4956, y= 2789.3655,z= 53.1078,
				h = 7.3639,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = true,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'ข้าว',
				ItemName = "rice_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'กระสอบข้าว',
					ItemName = "rice_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_eco",
							ItemCount = 1,
							Text = "Bonus Eco",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlus = {
	
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Cabbage = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตกะหล่ำ',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_f_y_factory_01',	-- ตัวละครNPC
	
		PoliceCount = 0,
		ArmyCount = 0,
	
		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 105,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปกะหล่ำ</font>',
		},
		Marker = {
			Type = -1,
			Pos = {  
				x= 1552.0728, y= 2189.6880, z= 78.8428,
				h = 1.8886,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = true,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'กระหล่ำ',
				ItemName = "cabbage_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'กะหล่ำหั่น',
					ItemName = "cabbage_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_eco",
							ItemCount = 1,
							Text = "Bonus Eco",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlus = {
	
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Milk = {
		jobBuff = true,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตนมกล่อง',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = true,
		NPC = 's_f_y_factory_01',	-- ตัวละครNPC
	
		PoliceCount = 0,
		ArmyCount = 0,
	
		WaitProcessing = 2000,
		Blips = {
			Blipopen = true,
			Id = 105,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปนม</font>',
		},
		Marker = {
			Type = -1,
			Pos = {  
				x= 562.5789, y= 2738.1738, z= 42.2938,
				h = 189.1744,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = true,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'นม',
				ItemName = "milk_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'นมกล่อง',
					ItemName = "milk_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "bonus_eco",
							ItemCount = 1,
							Text = "Bonus Eco",
							Percent = 0.007,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},
					BonusPlus = {
	
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Cocaine = {
		jobBuff = false,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตกัญชา',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = false,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC

		PoliceCount = 2,
		ArmyCount = 0,

		WaitProcessing = 5000,
		Blips = {
			Blipopen = false,
			Id = 77,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปกัญชา</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x=-905.6400146484376, y=154.4900054931641, z=69.12999725341797,
				h = 57.14,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'โคเคน',
				ItemName = "cocaine_1",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'โคเคนแพ็ค',
					ItemName = "cocaine_2",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},

					BonusPlus = {
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},

	Meth = {
		jobBuff = false,
		Text = {
			SubTitle = "",
			TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
			ProcessText = 'กำลังผลิตกัญชา',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
			AnimationScene = "player_search",
			flags = 49,
		},
		NPCopen = false,
		NPC = 's_m_y_construct_01',	-- ตัวละครNPC

		PoliceCount = 2,
		ArmyCount = 0,

		WaitProcessing = 5000,
		Blips = {
			Blipopen = false,
			Id = 77,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
			Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
			Size = 1.0,
			Text = '<font face="font4thai">แปรรูปกัญชา</font>',
		},
		Marker = {
			Type = -1,
			Pos = {
				x=-186.6770, y=63.9957, z=67.8649,
				h = 57.14,
			},
			Color = {
				r = 0,
				g = 255,
				b = 255,
				a = 165
			},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			coreEffect = false,
			coreEffectMining = false,
			auto = true,
			{
				Text = 'เศษยา',
				ItemName = "meth",
				ItemCount = 2,
				Get = {
					getOneItem = false,
					Text = 'ไอซ์แพ็ค',
					ItemName = "meth_a",
					ItemCount = {1,1},
					Bonus = {
						{
							ItemName = "exp",
							ItemCount = 1,
							Text = "EXP",
							Percent = 0.05,
							Animation = "WORLD_HUMAN_CHEERING"
						},
					},

					BonusPlus = {
					},
					BonusPlusPercent = 0.05,
					BonusPlusCount = 1,
					BonusPlusAnim = "WORLD_HUMAN_CHEERING",
				}
			}
		}
	},



	
	----------------------------------------------------------------------------------
	-------------------------------------Meth Process --------------------------------------
	----------------------------------------------------------------------------------
	-- Meth = {
	-- 	jobBuff = false,
	-- 	Text = {
	-- 		SubTitle = "",
	-- 		TextHelper = '<font face="font4thai">กด E เพื่อแปรรูป</font>',
	-- 		ProcessText = 'กำลังผลิตแร่',
	-- 	},
	-- 	Animation = {
	-- 		Scenario = false,
	-- 		AnimationDirect = "anim@gangops@facility@servers@bodysearch@",
	-- 		AnimationScene = "player_search",
	-- 		flags = 49,
	-- 	},
	-- 	NPCopen = false,
	-- 	NPC = 's_m_y_construct_01',	-- ตัวละครNPC

	-- 	PoliceCount = 5,
	-- 	ArmyCount = 0,

	-- 	WaitProcessing = 10000,
	-- 	Blips = {
	-- 		Blipopen = false,
	-- 		Id = 77,		---- จุด ID ใน https://docs.fivem.net/docs/game-references/blips/
	-- 		Color = 0,		---- สีจุดถ้าแก้แล้วแนะนำให้เป็น 0
	-- 		Size = 1.0,
	-- 		Text = '<font face="font4thai">แปรรูปทองแดงแท่ง</font>',
	-- 	},
	-- 	Marker = {
	-- 		Type = -1,
	-- 		Pos = {
	-- 			x=-1715.6300048828125, y=-197.69000244140625, z=57.70000076293945,
	-- 			h = 57.14,
	-- 		},
	-- 		Color = {
	-- 			r = 0,
	-- 			g = 255,
	-- 			b = 255,
	-- 			a = 165
	-- 		},
	-- 		Size = {x = 1.0, y = 1.0, z = 1.0},
	-- 		SizeMark = 2.0
	-- 	},
	-- 	Items = {
	-- 		coreEffect = false,
	-- 		coreEffectMining = false,
	-- 		auto = true,
	-- 		{
	-- 			Text = 'เศษยาไอซ์',
	-- 			ItemName = "meth",
	-- 			ItemCount = 2,
	-- 			Get = {
	-- 				getOneItem = false,
	-- 				Text = 'ไอซ์แพ็ค',
	-- 				ItemName = "meth_a",
	-- 				ItemCount = {1,1},
	-- 				Bonus = {
	-- 				},

	-- 				BonusPlus = {
	-- 				},
	-- 				BonusPlusPercent = 0.05,
	-- 				BonusPlusCount = 1,
	-- 				BonusPlusAnim = "WORLD_HUMAN_CHEERING",
	-- 			}
	-- 		}
	-- 	}
	-- },
}