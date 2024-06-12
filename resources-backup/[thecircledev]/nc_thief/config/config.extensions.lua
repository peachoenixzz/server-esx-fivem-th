-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งาน NC Extensions ต่างๆ
Config.Extensions = {
	nc_inventory = {					-- ใช้งาน Extension NC Inventory (1.5.7 ขึ้นไป)
		enable = true
	},
	nc_notify = {						-- ใช้งาน Extension NC Notify
		enable = true,
		options = {
			rob_alert = {
				enable = false,
				title = 'คุณกำลังถูกปล้น!!',
				description = 'คุณจะไม่สามารถขยับตัวได้เนื่องจากคุณกำลังถูกปล้นอยู่',
				priority = 'high'
			},
			error = {
				enable = false,
				title = {
					general = 'ไม่สามารถทำรายการนี้ได้',
					rob_player = 'ไม่สามารถปล้นคนๆนี้ได้'
				},
				description = {
					outside_range = {
						error	= 'เนื่องจากไม่พบบุคคลในระยะใกล้เคียง'
					},
					not_enough_jobs = {
						error	= 'เนื่องจากจำนวนหน่วยงานในเมืองยังไม่เพียงพอ'
					},
					player_on_protection = {
						error	= 'เนื่องจากคนๆนี้มีสิ่งของป้องกันการถูกปล้น'
					},
					account_blacklist = {
						error	= 'เนื่องจากเงินชนิดนี้ไม่สามารถเคลื่อนย้ายได้'
					},
					item_blacklist = {
						error	= 'เนื่องจากของสิ่งนี้ไม่สามารถเคลื่อนย้ายได้'
					},
					weapon_blacklist = {
						error	= 'เนื่องจากอาวุธชนิดนี้ไม่สามารถเคลื่อนย้ายได้'
					},
				},
				icon = 'default',
				duration = 4000
			}
		}
	}
}