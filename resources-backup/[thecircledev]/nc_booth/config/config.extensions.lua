-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งาน NC Extensions ต่างๆ
Config.Extensions = {
	nc_playersname = {					-- ใช้งาน Extension NC Players Name (หากมี Script นี้ควรเปิดใช้งาน)
		enable = false,
		options = {
			rp_name = true				-- แสดง IC (RP Name)
		}
	},
	nc_notify = {						-- ใช้งาน Extension NC Notify
		enable = true,
		options = {
			use_item = {
				enable = true,
				description = {
					normal = 'เพื่อเปิดร้านค้าส่วนตัว',
					service = 'เพื่อเปิดร้านค้าฝากขาย',
				},
				duration = 4000
			},
			start_booth = {
				enable = false,
				title = 'ตั้งร้านค้าสำเร็จ',
				description = {
					normal = 'ประเภทร้าน: ร้านค้าส่วนตัว',
					service = 'ประเภทร้าน: ร้านค้าฝากขาย'
				},
				icon = 'default',
				duration = 4000
			},
			stop_booth = {
				enable = true,
				title = 'ร้านค้านี้ถูกปิด',
				description = {
					owner = {
						normal = 'เนื่องจากคุณยกเลิกการตั้งร้านค้าส่วนตัว',
						service = 'เนื่องจากคุณยกเลิกการฝากขายสินค้า<br/>สามารถเบิกสินค้าของคุณคืนได้ที่จุดเบิกสินค้า'
					},
					viewer = 'เจ้าของร้านค้านี้ได้ยกเลิกการขายสินค้าแล้ว'
				},
				icon = 'default',
				duration = 4000
			},
			sell = {
				enable = false,
				description = {
					with_commission = 'จากการขาย %s จำนวน %s ชิ้น (ถูกหัก %s%%)',
					without_commission = 'จากการขาย %s จำนวน %s ชิ้น'
				},
				duration = 4000
			},
			buy = {
				enable = false,
				duration = 4000
			},
			storage_get = {
				enable = false,
				duration = 4000
			},
			error = {
				enable = false,
				title = {
					title = 'ไม่สามารถใช้ชื่อร้านนี้ได้',
					start_booth = 'ไม่สามารถตั้งร้านค้าได้',
					buy = 'ไม่สามารถซื้อสินค้าชินนี้ได้',
					storage_open = 'คลังสินค้าของคุณว่างเปล่า',
					storage_get = 'ไม่สามารถเบิกสินค้าจากคลังได้'
				},
				description = {
					no_title = {
						error	= 'เนื่องจากชื่อร้านของคุณว่างเปล่า'
					},
					service_exceed_limit = {
						error	= 'คุณใช้บริการตั้งร้านฝากขายสินค้าถึงจำนวนสูงสุดแล้ว'
					},
					service_storage_not_empty = {
						error	= 'คุณยังมีสินค้าคงค้างอยู่ในคลัง'
					},
					source_too_close = {
						error	= 'คุณอยู่ใกล้ร้านค้าอื่นมากเกินไป'
					},
					storage_too_close = {
						error	= 'คุณอยู่ใกล้จุดเบิกสินค้ามากเกินไป'
					},
					source_in_vehicle = {
						error	= 'กรุณาลงจากยานพาหนะก่อน'
					},
					no_items_selected = {
						error	= 'คุณยังไม่ได้เลือกสินค้าเพื่อวางขาย'
					},
					source_account_not_enough = {
						error	= 'คุณมีเงินไม่เพียงพอสำหรับซื้อสินค้าชิ้นนี้'
					},
					source_inventory_full = {
						error	= 'พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้',
						warning	= 'พื้นที่ในกระเป๋าของคุณไม่สามารถเก็บของสิ่งนี้ได้ครบตามจำนวน'
					},
					storage_empty = {
						error	= 'คุณไม่มีของคงค้างในคลังเบิกสินค้าฝากขาย'
					},
					storage_inventory_full = {
						error	= 'พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของใดๆจากคลัง',
						warning	= 'พื้นที่ในกระเป๋าของคุณไม่สามารถเก็บของจากคลังได้ครบตามจำนวน'
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
			selling = {					-- Log วางขายสินค้า
				enable = true,
				webhook = '',			-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = {
					normal = 'ตั้งร้านขายของ (ร้านค้าส่วนตัว)',
					service = 'ตั้งร้านขายของ (ร้านค้าฝากขาย)'
				},
				description = {
					items = 'ขาย %s จำนวน %s ชิ้น ราคา $%s',
					weapons = 'ขายอาวุธ %s จำนวนกระสุน %s นัด ราคา $%s'
				},
				color = {
					normal = '67b1ba',
					service = '67ba7b'
				}
			},
			buying = {					-- Log การซื้อสินค้า
				enable = true,
				webhook = '',			-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'ซื้อสินค้าจากร้านค้าของ %s',
				description = {
					items = 'ซื้อ %s จำนวน %s ชิ้น ราคา $%s',
					weapons = 'ซื้ออาวุธ %s จำนวนกระสุน %s นัด ราคา $%s'
				},
				color = 'dbb14b'
			},
			storage_get = {
				enable = true,
				webhook = '',			-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'เบิกของจากคลังสินค้าฝากขาย',
				description = {
					items = 'เบิก %s จำนวน %s ชิ้น',
					weapons = 'เบิกอาวุธ %s จำนวนกระสุน %s นัด'
				},
				color = '67ba7b'
			},
		}
	}
}