-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งาน NC Extensions ต่างๆ
Config.Extensions = {
	nc_notify = {						-- ใช้งาน Extension NC Notify
		enable = true,
		options = {
			use = {
				enable = false,
				description = 'เพื่อขโมย %s',
				duration = 4000
			},
			 rewards = {
			 	enable = false,
			 	description = 'จากการขโมย %s',
			 	duration = 4000
			 },
			error = {
				enable = true,
				title = 'ไม่สามารถขโมยของสิ่งนี้ได้',
				description = {
					no_cops = 'ต้องการเจ้าหน้าที่ตำรวจเข้าเวรภายในเมืองจำนวน %s นายขึ้นไป',
					source_inventory_full = 'พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บ %s เพิ่มได้อีก',
					source_no_use_item = 'คุณมี %s ไม่เพียงพอสำหรับขโมยของสิ่งนี้'
				},
				icon = 'no_cop',
				duration = 4000
			}
		}
	},
	nc_discordlogs = {					-- ใช้งาน Extension NC Discord Logs
		enable = false,
		options = {
			steal = {
				enable = true,
				webhook = '',			-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'ขโมย %s',
				description = {
					account = 'ได้รับ %s จำนวน $%s',
					item = 'ได้รับ %s จำนวน %s ชิ้น'
				},
				color = '67b1ba'
			}
		}
	}
}