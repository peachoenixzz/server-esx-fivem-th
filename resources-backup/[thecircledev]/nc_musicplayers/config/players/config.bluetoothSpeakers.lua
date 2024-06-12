-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.BluetoothSpeakers = {
	{
		name = 'hifi',						-- ชื่อของลำโพง
		item = 'hifi',								-- ชื่อสิ่งของกดใช้งาน
		max_volume = 0.6,								-- ความดังเสียงสูงสุด [0.0 - 1.0]
		radius = { min = 5.0, max = 8.0 },				-- ระยะของเสียง [min: ระยะภายใน เสียงจะดังที่สุด | max: เมื่อพ้นระยะนี้เสียงจะเงียบ]
		save_playlist = true,							-- บันทึกรายชื่อเพลง (เมื่อรีสคริปต์/รีเซิฟ จะหายไป)
		can_place_on_vehicle = true,					-- อนุญาตให้วางบนยานพาหนะได้
		text = {
			title = 'Press ~b~E ~s~to Play Music',
			size = 0.65,
			z_offset = 1.0
		},
		controller = {
			interact_radius = 1.8,						-- ระยะที่สามารถเปิดหน้าต่างลำโพงได้
			model = {
				name = 'nc_bluetoothspeaker',
				z_offset = 0.0,
				scale = 1.0								-- ขนาดจะเป็น 1.0 เสมอหากวางบนยานพาหนะ
			}
		},
		animations = {
			place = {									-- Animation ตอนวางลำโพง
				enable = true,
				dict = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@',
				name = 'plant_floor',
				flags = 1,
				duration = 1000
			},
			pickup = {									-- Animation ตอนเก็บลำโพง
				enable = true,
				dict = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@',
				name = 'plant_floor',
				flags = 1,
				duration = 1000
			}
		}
	},
}