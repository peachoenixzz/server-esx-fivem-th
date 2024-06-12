-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งาน NC Extensions ต่างๆ
Config.Extensions = {
	nc_notify = {						-- ใช้งาน Extension NC Notify
		enable = false,
		options = {
			error = {
				enable = true,
				title = {
					general = 'ไม่สามารถทำรายการนี้ได้',
					bluetooth_speaker = 'ไม่สามารถใช้งานลำโพงนี้ได้',
					sound_system = 'ไม่สามารถใช้งานเครื่องเสียงนี้ได้',
					place = 'ไม่สามารถวางลำโพงตรงนี้ได้',
				},
				description = {
					player_not_found = {
						error	= 'ไม่พบเครื่องเสียงเครื่องนี้ในระบบ'
					},
					someone_using = {
						error	= 'มีใครบางคนกำลังใช้งานอยู่'
					},
					can_not_fetch_music_data = {
						error	= 'ไม่พบข้อมูลเพลงๆนี้'
					},
					music_not_found = {
						error	= 'ไม่พบข้อมูลเพลงๆนี้'
					},
					already_placed = {
						error	= 'คุณจำเป็นจะต้องเก็บลำโพงเก่าของคุณก่อน'
					},
					no_permission = {
						error	= 'คุณไม่มีสิทธิ์เข้าถึงการใช้งานนี้'
					},
					no_ground_detected = {
						error	= 'คุณจะต้องวางลำโพงบนพื้นเท่านั้น'
					}
				},
				icon = 'default',
				duration = 4000
			}
		}
	},
	nc_discordlogs = {					-- ใช้งาน Extension NC Discord Logs
		enable = false,
		options = {
			place = {
				enable = true,
				webhook = '',							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'วางลำโพง',
				color = 'aa56f8'
			},
			pickup = {
				enable = true,
				webhook = '',							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'เก็บลำโพง',
				color = 'f0b937'
			},
			add = {
				enable = true,
				webhook = '',							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'เพิ่มเพลงลงรายชื่อ (%s)',
				color = '37f06b'
			},
			remove = {
				enable = true,
				webhook = '',							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'ลบเพลงออกจากรายชื่อ (%s)',
				color = 'f03737'
			}
		}
	}
}