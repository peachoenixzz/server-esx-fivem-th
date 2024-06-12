-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งาน NC Extensions ต่างๆ
Config.Extensions = {
	nc_inventory = {					-- ใช้งาน Extension NC Inventory (1.8.0 ขึ้นไป)
		enable = true
	},
	nc_notify = {						-- ใช้งาน Extension NC Notify
		enable = false,
		options = {
			received = {
				enable = {
					account = true,
					item = true,
					weapon = true,
					vehicle = true
				},
				description = '',
				duration = 4000
			},
			error = {
				enable = true,
				title = {
					receive = 'ไม่สามารถรับสิ่งของได้'
				},
				description = {
					no_more_trigger_items = {
						error	= 'คุณมีสิ่งของไม่เพียงพอในการเปิดใช้งาน'
					},
					no_rewards_received = {
						error	= 'คุณไม่มีสิ่งของที่จะสามารถได้รับได้'
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
			received = {
				enable = true,
				default_webhook = '',
				webhook = {							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config (ในรายชื่อ Config.ItemSets เท่านั้น)
					-- ['cement'] = '',
					-- ['water'] = '',
					-- ['bread'] = '',
				},
				title = 'ได้ใช้งาน %s จำนวน %s ชิ้น',
				description = {
					account = 'ได้รับ %s จำนวน $%s',
					item = 'ได้รับ %s จำนวน %s ชิ้น',
					weapon = 'ได้รับอาวุธ %s',
					vehicle = 'ได้รับยานพาหนะ %s ทะเบียน "%s"',
				},
				color = '67b1ba'
			},
		}
	}
}