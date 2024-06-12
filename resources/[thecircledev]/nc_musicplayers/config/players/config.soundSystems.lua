-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.SoundSystems = {
	{
		name = 'sound_system',							-- ชื่อของระบบเสียง
		max_volume = 0.6,								-- ความดังเสียงสูงสุด [0.0 - 1.0]
		text = {
			title = 'Press ~b~E ~s~to interact',
			size = 0.65,
			z_offset = 0.1
		},
		controller = {
			interact_radius = 1.8,						-- ระยะที่สามารถเปิดหน้าต่างลำโพงได้
			coords = vector3(-1382.6306152344, -614.74780273438, 31.488885879517),
			rotation = vector3(0, 0, 0),
			model = {
				enable = false,
				name = 'h4_prop_battle_dj_stand',
				z_offset = 0.0,
				scale = 1.0
			}
		},
		speakers = {
			model = {
				enable = true,
				name = 'ba_prop_battle_club_speaker_small',
				z_offset = 0.0,
				scale = 1.0
			},
			list = {
				{ coords = vector3(-1395.7757568359, -624.23248291016, 32.155445098877), rotation = vector3(20.0, 0, 123.6131362915), radius = { min = 8.0, max = 18.0 } },
				{ coords = vector3(-1387.2106933594, -626.61755371094, 32.655445098877), rotation = vector3(20.0, 0, 163.94195556641), radius = { min = 8.0, max = 18.0 } },
				{ coords = vector3(-1371.15625, -626.38244628906, 32.673625946045), rotation = vector3(20.0, 0, 253.36312866211), radius = { min = 8.0, max = 18.0 } },
				{ coords = vector3(-1378.2298583984, -614.98040771484, 32.133613586426), rotation = vector3(20.0, 0, 303.80810546875), radius = { min = 8.0, max = 18.0 } },
			}
		},
		allowed_everyone = true,						-- การอนุญาตให้ทุกคนใช้งานเครื่องเสียงได้
		allowed_identifiers = {							-- การอนุญาตให้ที่มี Identifier ในรายชื่อใช้งานเครื่องเสียงได้
			-- ['steam:XXXXXXXXXXXXXXX'] = true,
		},
		allowed_jobs = {								-- การอนุญาตให้ Job ในรายชื่อใช้งานเครื่องเสียงได้
			-- ['police'] = true,
		}
	},
	{
		name = 'sound_system_chickentop',							-- ชื่อของระบบเสียง
		max_volume = 0.6,								-- ความดังเสียงสูงสุด [0.0 - 1.0]
		text = {
			title = 'Press ~b~E ~s~to interact',
			size = 0.65,
			z_offset = 0.1
		},
		controller = {
			interact_radius = 1.8,						-- ระยะที่สามารถเปิดหน้าต่างลำโพงได้
			coords = vector3(213.7400054931641, -866.510009765625, 32.06000137329101),
			rotation = vector3(0, 0, 0),
			model = {
				enable = false,
				name = 'h4_prop_battle_dj_stand',
				z_offset = 0.0,
				scale = 1.0
			}
		},
		speakers = {
			model = {
				enable = false,
				name = 'ba_prop_battle_club_speaker_small',
				z_offset = 0.0,
				scale = 1.0
			},
			list = {
				{ coords = vector3(198.17999267578128, -885.5999755859375, 31.84000015258789), rotation = vector3(20.0, 0, 123.6131362915), radius = { min = 8.0, max = 16.0 } },
				{ coords = vector3(180.67999267578128, -886.97998046875, 31.77000045776367), rotation = vector3(20.0, 0, 163.94195556641), radius = { min = 6.0, max = 14.0 } },
				{ coords = vector3(195.8800048828125, -863.8300170898438, 32.02000045776367), rotation = vector3(20.0, 0, 253.36312866211), radius = { min = 6.0, max = 14.0 } },
				{ coords = vector3(211.6199951171875, -870.469970703125, 32.0099983215332), rotation = vector3(20.0, 0, 303.80810546875), radius = { min = 6.0, max = 14.0 } },
			}
		},
		allowed_everyone = false,						-- การอนุญาตให้ทุกคนใช้งานเครื่องเสียงได้
		allowed_identifiers = {							-- การอนุญาตให้ที่มี Identifier ในรายชื่อใช้งานเครื่องเสียงได้
			-- ['steam:XXXXXXXXXXXXXXX'] = true,
		},
		allowed_jobs = {								-- การอนุญาตให้ Job ในรายชื่อใช้งานเครื่องเสียงได้
			 ['admin'] = true,
		}
	},
}