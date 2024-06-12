-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งาน NC Extensions ต่างๆ
Config.Extensions = {
	nc_inventory = {					-- ใช้งาน Extension NC Inventory (1.7.2 ขึ้นไป)
		enable = true
	},
	nc_notify = {						-- ใช้งาน Extension NC Notify
		enable = true,
		options = {
			move_item = {
				enable = false,
				description = {
					put = 'จากการใส่เข้าช่องเก็บของยานพาหนะ',
					take = 'จากการนำออกจากช่องเก็บของยานพาหนะ'
				},
				duration = 4000
			},
			error = {
				enable = true,
				title = {
					general = 'ไม่สามารถทำรายการนี้ได้',
					open_inventory = 'ไม่สามารถเปิดช่องเก็บของยานพาหนะนี้ได้',
					move_item = 'ไม่สามารถเคลื่อนย้ายสิ่งของได้'
				},
				description = {
					no_vehicle_data = {
						error	= 'ไม่พบข้อมูลยานพาหนะนี้'
					},
					no_vehicle_config = {
						error	= 'ไม่พบข้อมูลช่องเก็บของยานพาหนะนี้'
					},
					vehicle_not_found = {
						error	= 'ไม่พบยานพาหนะนี้'
					},
					different_vehicle_class = {
						error	= 'ตรวจพบชนิดของยานพาหนะที่ไม่ตรงกัน'
					},
					different_vehicle_model = {
						error	= 'ตรวจพบโมเดลของยานพาหนะที่ไม่ตรงกัน'
					},
					not_allowed = {
						error	= 'คุณไม่สามารถใช้งานช่องเก็บของยานพาหนะนี้ได้'
					},
					exceeded_player_limit = {
						error	= 'มีคนใช้งานช่องเก็บของยานพาหนะนี้จำนวนสูงสุดแล้ว'
					},
					action_too_quick = {
						warning	= 'คุณเคลื่อนย้ายสิ่งของเร็วเกินไป'
					},
					player_account_no_account = {
						error	= 'คุณไม่มีเงินชนิดนี้อยู่ในกระเป๋า'
					},
					player_account_exceed_weight = {
						error	= 'น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บเงินชนิดนี้'
					},
					player_item_no_item = {
						error	= 'คุณไม่มีของสิ่งนี้อยู่ในกระเป๋า'
					},
					player_item_exceed_limit = {
						error	= 'พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้'
					},
					player_item_exceed_weight = {
						error	= 'น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้'
					},
					player_weapon_no_weapon = {
						error	= 'คุณไม่มีอาวุธชิ้นนี้อยู่ในกระเป๋า'
					},
					player_weapon_exceed_weight = {
						error	= 'น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บอาวุธชิ้นนี้'
					},
					player_weapon_already_have = {
						error	= 'คุณมีอาวุธชนิดนี้อยู่ในกระเป๋าอยู่แล้ว'
					},
					storage_account_blacklist = {
						error	= 'เงินชนิดนี้ไม่สามารถเก็บในช่องเก็บของยานพาหนะนี้ได้'
					},
					storage_account_exceed_slot = {
						error	= 'ช่องเก็บของยานพาหนะนี้มีช่องไม่พอสำหรับเก็บเงินชนิดนี้เพิ่ม'
					},
					storage_account_exceed_limit = {
						error	= 'ช่องเก็บของยานพาหนะนี้มีที่ว่างไม่พอสำหรับเก็บเงินเพิ่มได้อีก'
					},
					storage_account_exceed_weight = {
						error	= 'น้ำหนักของเงินมากเกินไปสำหรับเก็บในช่องเก็บของยานพาหนะนี้'
					},
					storage_account_not_allow = {
						error	= 'ช่องเก็บของยานพาหนะนี้ไม่อนุญาตให้เก็บเงินได้'
					},
					storage_item_blacklist = {
						error	= 'ของสิ่งนี้ไม่สามารถเก็บในช่องเก็บของยานพาหนะนี้ได้'
					},
					storage_item_exceed_slot = {
						error	= 'ช่องเก็บของยานพาหนะนี้มีช่องไม่พอสำหรับเก็บสิ่งของชนิดนี้เพิ่ม'
					},
					storage_item_exceed_limit = {
						error	= 'ช่องเก็บของยานพาหนะนี้มีที่ว่างไม่พอสำหรับเก็บสิ่งของชิ้นนี้เพิ่มได้อีก'
					},
					storage_item_exceed_weight = {
						error	= 'น้ำหนักของสิ่งของมากเกินไปสำหรับเก็บในช่องเก็บของยานพาหนะนี้'
					},
					storage_item_not_allow = {
						error	= 'ช่องเก็บของยานพาหนะนี้ไม่อนุญาตให้เก็บสิ่งของทั่วไปได้'
					},
					storage_weapon_blacklist = {
						error	= 'อาวุธชนิดนี้ไม่สามารถเก็บในช่องเก็บของยานพาหนะนี้ได้'
					},
					storage_weapon_exceed_slot = {
						error	= 'ช่องเก็บของยานพาหนะนี้มีช่องไม่พอสำหรับเก็บอาวุธชนิดนี้เพิ่ม'
					},
					storage_weapon_exceed_limit = {
						error	= 'ช่องเก็บของยานพาหนะนี้มีที่ว่างไม่พอสำหรับเก็บอาวุธเพิ่มได้อีก'
					},
					storage_weapon_exceed_weight = {
						error	= 'น้ำหนักของอาวุธชิ้นนี้มากเกินไปสำหรับเก็บในช่องเก็บของยานพาหนะนี้'
					},
					storage_weapon_not_allow = {
						error	= 'ช่องเก็บของยานพาหนะนี้ไม่อนุญาตให้เก็บอาวุธได้'
					}
				},
				icon = 'car',
				duration = 4000
			}
		}
	},
	nc_discordlogs = {					-- ใช้งาน Extension NC Discord Logs
		enable = false,
		options = {
			open_inventory = {
				enable = true,
				webhook = '',									-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'เปิดช่องเก็บของ %s[%s]',
				color = '707070'
			},
			move_item = {
				enable = true,
				webhook = {										-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
					inside = {
						put = {
							account = '',
							item = '',
							weapon = ''
						},
						take = {
							account = '',
							item = '',
							weapon = ''
						}
					},
					trunk = {
						put = {
							account = '',
							item = '',
							weapon = ''
						},
						take = {
							account = '',
							item = '',
							weapon = ''
						}
					}
				},
				title = {
					put = 'ใส่สิ่งของเข้าช่องเก็บของ %s[%s]',
					take = 'นำสิ่งของออกจากช่องเก็บของ %s[%s]'
				},
				description = {
					put = {
						account = 'ใส่ %s จำนวน $%s เข้าช่องเก็บของยานพาหนะ',
						item = 'ใส่ %s จำนวน %s ชิ้น เข้าช่องเก็บของยานพาหนะ',
						weapon = 'ใส่อาวุธ %s จำนวนกระสุน %s นัด เข้าช่องเก็บของยานพาหนะ'
					},
					take = {
						account = 'นำ %s จำนวน $%s ออกจากช่องเก็บของยานพาหนะ',
						item = 'นำ %s จำนวน %s ชิ้น ออกจากช่องเก็บของยานพาหนะ',
						weapon = 'นำอาวุธ %s จำนวนกระสุน %s นัด ออกจากช่องเก็บของยานพาหนะ'
					},
				},
				color = {
					account = '9fdf4c',
					item = '67b1ba',
					weapon = 'e64949'
				}
			}
		}
	}
}