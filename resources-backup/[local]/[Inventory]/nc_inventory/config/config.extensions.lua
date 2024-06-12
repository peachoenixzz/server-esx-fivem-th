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
			give = {
				enable = {
					account = true,
					item = true,
					weapon = true,
					vehicle_key = true,
					house_key = true,
					accessory = true
				},
				description = {
					give = 'จากการมอบให้ผู้อื่น',
					receive = 'จากการที่มีผู้อื่นมอบให้'
				},
				duration = 4000
			},
			drop = {
				enable = {
					account = true,
					item = true,
					weapon = true,
					vehicle_key = true,
					house_key = true,
					accessory = true
				},
				description = 'จากการทิ้งสิ่งของในกระเป๋า',
				duration = 4000
			},
			search = {
				enable = true,
				description = {
					put = {
						source = 'จากการใส่เข้ากระเป๋าผู้อื่น',
						target = 'จากการที่ผู้ค้นตัวใส่เข้ามาในกระเป๋า'
					},
					take = {
						source = 'จากการหยิบออกมาจากกระเป๋าผู้อื่น',
						target = 'จากการที่ผู้ค้นตัวนำออกจากกระเป๋า'
					}
				},
				duration = 4000
			},
			spam = {
				enable = true,
				title = {
					use = 'ไม่สามารถใช้สิ่งๆนี้ได้ในขณะนี้',
				},
				description = {
					use = 'คุณใช้งานสิ่งของติดต่อกันเร็วเกินไป',
				},
				icon = 'default',
				duration = 4000
			},
			no_nearby_players = {
				enable = true,
				title = 'ไม่สามารถมอบของสิ่งนี้ได้',
				description = 'เนื่องจากไม่พบบุคคลอื่นในบริเวณใกล้เคียง',
				icon = 'default',
				duration = 4000
			},
			error = {
				enable = true,
				title = {
					give = 'ไม่สามารถมอบสิ่งๆนี้ได้',
					search = 'ไม่สามารถย้ายสิ่งๆนี้ได้',
					search_busy = 'ไม่สามารถค้นกระเป๋าคนๆนี้ได้ในขณะนี้'
				},
				description = {
					source_account_not_enough = {
						error	= 'คุณไม่มีเงินในกระเป๋า',
						warning	= 'คุณมีเงินไม่มากพอสำหรับเงินจำนวนที่คุณต้องการ'
					},
					source_account_exceed_weight = {
						error	= 'น้ำหนักกระเป๋าคุณเต็มแล้ว',
						warning	= 'นำหนักที่เหลือกระเป๋าของคุณไม่มากพอสำหรับเงินทั้งหมด'
					},
					source_item_not_enough = {
						error	= 'คุณไม่มีของสิ่งนี้',
						warning	= 'คุณมีของสิ่งนี้ไม่มากพอสำหรับในจำนวนที่คุณต้องการ'
					},
					source_item_exceed_weight = {
						error	= 'น้ำหนักกระเป๋าคุณเต็มแล้ว',
						warning	= 'นำหนักที่เหลือกระเป๋าของคุณไม่มากพอสำหรับของทั้งหมด'
					},
					source_item_exceed_limit = {
						error	= 'คุณมีของสิ่งนี้จำนวนสูงสุดแล้ว',
						warning	= 'พื้นที่ในกระเป๋าของคุณไม่มากพอสำหรับของจำนวนที่คุณต้องการ'
					},
					source_weapon_exceed_weight = {
						error	= 'นำหนักที่เหลือกระเป๋าของคุณไม่เพียงพอที่จะเก็บอาวุธชิ้นนี้ได้'
					},
					source_weapon_exceed_limit = {
						error	= 'คุณมีอาวุธชนิดนี้อยู่แล้ว'
					},
					target_account_not_enough = {
						error	= 'คนๆนี้ไม่มีเงินในกระเป๋า',
						warning	= 'คนๆนี้มีเงินไม่มากพอสำหรับเงินจำนวนที่คุณต้องการ'
					},
					target_account_exceed_weight = {
						error	= 'น้ำหนักกระเป๋าของคนๆนี้เต็มแล้ว',
						warning	= 'นำหนักที่เหลือกระเป๋าของคนๆนี้ไม่มากพอสำหรับเงินทั้งหมด'
					},
					target_item_not_enough = {
						error	= 'คนๆนี้ไม่มีของสิ่งนี้',
						warning	= 'คนๆนี้มีของสิ่งนี้ไม่มากพอสำหรับในจำนวนที่คุณต้องการ'
					},
					target_item_exceed_weight = {
						error	= 'น้ำหนักกระเป๋าของคนๆนี้เต็มแล้ว',
						warning	= 'นำหนักที่เหลือกระเป๋าของคนๆนี้ไม่มากพอสำหรับของทั้งหมด'
					},
					target_item_exceed_limit = {
						error	= 'คนๆนี้มีของสิ่งนี้จำนวนสูงสุดแล้ว',
						warning	= 'พื้นที่ในกระเป๋าของคนๆนี้ไม่มากพอสำหรับของจำนวนที่คุณต้องการ'
					},
					target_weapon_exceed_weight = {
						error	= 'นำหนักที่เหลือกระเป๋าของคนๆนี้ไม่เพียงพอที่จะเก็บอาวุธชิ้นนี้ได้'
					},
					target_weapon_exceed_limit = {
						error	= 'คนๆนี้มีอาวุธชนิดนี้อยู่แล้ว'
					},
					target_block_giving = {
						error	= 'คนๆนี้ไม่ต้องการรับของจากผู้อื่น'
					},
					target_being_searched = {
						error	= 'เนื่องจากคนๆนี้กำลังถูกผู้อื่นค้นกระเป๋าอยู่'
					},
					target_not_found = {
						error	= 'ไม่พบคนๆนี้อยู่ในเมือง'
					}
				},
				icon = 'default',
				duration = 4000
			}
		}
	},
	nc_discordlogs = {					-- ใช้งาน Extension NC Discord Logs
		enable = true,
		options = {
			give = {
				enable = true,
				webhook = {							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
					account = '',
					item = '',
					weapon = '',
					vehicle_key = '',
					house_key = '',
					accessory = ''
				},
				title = 'มอบสิ่งของให้ผู้อื่น',
				description = {
					account = 'มอบ %s จำนวน $%s ให้ %s',
					item = 'มอบ %s จำนวน %s ชิ้นให้ %s',
					weapon = 'มอบอาวุธ %s ให้ %s',
					vehicle_key = 'มอบกุญแจยานพาหนะทะเบียน "%s" ให้ %s',
					house_key = 'มอบกุญแจบ้าน "%s" ให้ %s',
					accessory = 'มอบเครื่องประดับ %s ให้ %s'
				},
				sub_description = {
					account = 'เหลือ **%s** ในกระเป๋าจำนวน **$%s**',
					item = 'เหลือ **%s** ในกระเป๋าจำนวน **%s** ชิ้น'
				},
				color = {
					account = '9fdf4c',
					item = '67b1ba',
					weapon = 'e64949',
					vehicle_key = 'f0ae3b',
					house_key = '707070',
					accessory = 'af63f0'
				}
			},
			drop = {
				enable = true,
				webhook = {							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
					account = '',
					item = '',
					weapon = '',
					vehicle_key = '',
					house_key = '',
					accessory = ''
				},
				title = 'ทิ้งสิ่งของ',
				description = {
					account = 'ทิ้ง %s จำนวน $%s',
					item = 'ทิ้ง %s จำนวน %s ชิ้น',
					weapon = 'ทิ้งอาวุธ %s',
					vehicle_key = 'ทิ้งกุญแจยานพาหนะทะเบียน "%s"',
					house_key = 'ทิ้งกุญบ้าน "%s"',
					accessory = 'ทิ้งเครื่องประดับ %s'
				},
				sub_description = {
					account = 'เหลือ **%s** ในกระเป๋าจำนวน **$%s**',
					item = 'เหลือ **%s** ในกระเป๋าจำนวน **%s** ชิ้น'
				},
				color = {
					account = '9fdf4c',
					item = '67b1ba',
					weapon = 'e64949',
					vehicle_key = 'f0ae3b',
					house_key = '707070',
					accessory = 'af63f0'
				}
			},
			search = {
				enable = true,
				webhook = {							-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
					['default'] = {
						put = '',
						take = '',
					},
					['admin'] = {
						put = '',
						take = '',
					},
					['police'] = {
						put = '',
						take = '',
					},
					['thief'] = {
						put = '',
						take = '',
					},
				},
				custom_webhook_by_identifier = {
					-- ['steam:XXXXXXXXXXXXXXX'] = '',
				},
				title = {
					['default'] = {
						put = 'ใส่สิ่งของเข้ากระเป๋าผู้อื่น',
						take = 'นำสิ่งของออกจากกระเป๋าผู้อื่น'
					},
					['admin'] = {
						put = 'ใส่สิ่งของเข้ากระเป๋าผู้อื่น',
						take = 'นำสิ่งของออกจากกระเป๋าผู้อื่น'
					},
					['police'] = {
						put = 'ใส่สิ่งของเข้ากระเป๋าผู้อื่น',
						take = 'ยึดสิ่งของจากกระเป๋าผู้อื่น'
					},
					['thief'] = {
						put = 'ยัดสิ่งของใส่กระเป๋าผู้อื่น',
						take = 'ปล้นสิ่งของจากกระเป๋าผู้อื่น'
					},
				},
				description = {
					['default'] = {
						put = {
							account = 'ใส่ %s จำนวน $%s เข้ากระเป๋าของ %s',
							item = 'ใส่ %s จำนวน %s ชิ้น เข้ากระเป๋าของ %s',
							weapon = 'ใส่อาวุธ %s เข้ากระเป๋าของ %s'
						},
						take = {
							account = 'นำ %s จำนวน $%s ออกจากกระเป๋าของ %s',
							item = 'นำ %s จำนวน %s ชิ้น ออกจากกระเป๋าของ %s',
							weapon = 'นำอาวุธ %s ออกจากกระเป๋าของ %s'
						}
					},
					['admin'] = {
						put = {
							account = 'ใส่ %s จำนวน $%s เข้ากระเป๋าของ %s',
							item = 'ใส่ %s จำนวน %s ชิ้น เข้ากระเป๋าของ %s',
							weapon = 'ใส่อาวุธ %s เข้ากระเป๋าของ %s'
						},
						take = {
							account = 'นำ %s จำนวน $%s ออกจากกระเป๋าของ %s',
							item = 'นำ %s จำนวน %s ชิ้น ออกจากกระเป๋าของ %s',
							weapon = 'นำอาวุธ %s ออกจากกระเป๋าของ %s'
						}
					},
					['police'] = {
						put = {
							account = 'ใส่ %s จำนวน $%s เข้ากระเป๋าของ %s',
							item = 'ใส่ %s จำนวน %s ชิ้น เข้ากระเป๋าของ %s',
							weapon = 'ใส่อาวุธ %s เข้ากระเป๋าของ %s'
						},
						take = {
							account = 'ยึด %s จำนวน $%s ออกจากกระเป๋าของ %s',
							item = 'ยึด %s จำนวน %s ชิ้น ออกจากกระเป๋าของ %s',
							weapon = 'ยึดอาวุธ %s ออกจากกระเป๋าของ %s'
						}
					},
					['thief'] = {
						put = {
							account = 'ยัด %s จำนวน $%s เข้ากระเป๋าของ %s',
							item = 'ยัด %s จำนวน %s ชิ้น เข้ากระเป๋าของ %s',
							weapon = 'ยัดอาวุธ %s เข้ากระเป๋าของ %s'
						},
						take = {
							account = 'ปล้น %s จำนวน $%s ออกจากกระเป๋าของ %s',
							item = 'ปล้น %s จำนวน %s ชิ้น ออกจากกระเป๋าของ %s',
							weapon = 'ปล้นอาวุธ %s ออกจากกระเป๋าของ %s'
						}
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