-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งาน NC Extensions ต่างๆ
Config.Extensions = {
	nc_inventory = {					-- ใช้งาน Extension NC Inventory (1.6.3 ขึ้นไป)
		enable = true
	},
	nc_notify = {						-- ใช้งาน Extension NC Notify
		enable = false,
		options = {
			create_vault = {
				enable = true,
				text = 'สร้างตู้เซฟสำเร็จ',
				icon = 'vault',
				duration = 4000
			},
			remove_vault = {
				enable = true,
				title = 'ลบตู้เซฟสำเร็จ',
				description = 'คุณจะไม่สามารถใช้งานตู้เซฟนี้ได้อีก',
				icon = 'vault',
				duration = 4000
			},
			upgrade_vault = {
				enable = true,
				title = 'อัพเกรดตู้เซฟสำเร็จ',
				description = 'เลเวลตู้เซฟของคุณมีค่าเพิ่มขึ้น',
				icon = 'vault',
				duration = 4000
			},
			change_name = {
				enable = true,
				title = 'เปลี่ยนชื่อตู้เซฟสำเร็จ',
				description = 'ชื่อปัจจุบันคือ %s',
				icon = 'vault',
				duration = 4000
			},
			share_vault = {
				enable = true,
				title = {
					add = {
						source = 'เปลี่ยนแปลงรายชื่อการอนุญาตใช้งานตู้เซฟสำเร็จ',
						target = 'มีใครบางคนแบ่งปันตู้เซฟให้คุณ'
					},
					remove = {
						source = 'เปลี่ยนแปลงรายชื่อการอนุญาตใช้งานตู้เซฟสำเร็จ',
						target = 'มีใครบางคนถอดคุณออกจากรายชื่อตู้เซฟ'
					}
				},
				description = {
					add = {
						source = '%s สามารถใช้งานตู้เซฟ %s ได้แล้ว',
						target = 'คุณสามารถใช้งานตู้เซฟ %s ได้แล้ว'
					},
					remove = {
						source = '%s ไม่สามารถใช้งานตู้เซฟ %s ได้แล้ว',
						target = 'คุณไม่สามารถใช้งานตู้เซฟ %s ได้แล้ว'
					}
				},
				icon = 'vault',
				duration = 6000
			},
			open_inventory = {
				enable = true,
				description = 'จากการเปิดตู้เซฟ',
				duration = 4000
			},
			move_item = {
				enable = false,
				description = {
					put = 'จากการใส่เข้าตู้เซฟ',
					take = 'จากการนำออกจากตู้เซฟ'
				},
				duration = 4000
			},
			no_nearby_players = {
				enable = true,
				title = 'ไม่สามารถแชร์ตู้เซฟได้',
				description = 'เนื่องจากไม่พบบุคคลอื่นในบริเวณใกล้เคียง',
				icon = 'vault',
				duration = 4000
			},
			error = {
				enable = true,
				title = {
					general = 'ไม่สามารถทำรายการนี้ได้',
					create_vault = 'ไม่สามารถสร้างตู้เซฟได้',
					share_vault = 'ไม่สามารถแบ่งปันตู้เซฟได้',
					open_inventory = 'ไม่สามารถเปิดตู้เซฟได้',
					move_item = 'ไม่สามารถเคลื่อนย้ายสิ่งของได้'
				},
				description = {
					outside_range = {
						error	= 'คุณอยู่นอกระยะตู้เซฟ'
					},
					not_enough_items = {
						error	= 'คุณมีสิ่งของที่ต้องการไม่เพียงพอ'
					},
					vault_exceed_limit = {
						error	= 'คุณมีจำนวนตู้เซฟแห่งนี้จำนวนสูงสุดแล้ว'
					},
					can_not_share = {
						error	= 'ระดับตู้เซฟของคุณยังไม่สามารถเพิ่มรายชื่อผู้อื่นให้เข้าใช้งานได้'
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
					vault_account_blacklist = {
						error	= 'เงินชนิดนี้ไม่สามารถเก็บในตู้เซฟนี้ได้'
					},
					vault_account_exceed_slot = {
						error	= 'ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บเงินชนิดนี้เพิ่ม'
					},
					vault_account_exceed_limit = {
						error	= 'ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บเงินเพิ่มได้อีก'
					},
					vault_account_exceed_weight = {
						error	= 'น้ำหนักของเงินมากเกินไปสำหรับเก็บในตู้เซฟนี้'
					},
					vault_account_not_allow = {
						error	= 'ตู้เซฟนี้ไม่อนุญาตให้เก็บเงินได้'
					},
					vault_item_blacklist = {
						error	= 'ของสิ่งนี้ไม่สามารถเก็บในตู้เซฟนี้ได้'
					},
					vault_item_exceed_slot = {
						error	= 'ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บสิ่งของชนิดนี้เพิ่ม'
					},
					vault_item_exceed_limit = {
						error	= 'ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บสิ่งของชิ้นนี้เพิ่มได้อีก'
					},
					vault_item_exceed_weight = {
						error	= 'น้ำหนักของสิ่งของมากเกินไปสำหรับเก็บในตู้เซฟนี้'
					},
					vault_item_not_allow = {
						error	= 'ตู้เซฟนี้ไม่อนุญาตให้เก็บสิ่งของทั่วไปได้'
					},
					vault_weapon_blacklist = {
						error	= 'อาวุธชนิดนี้ไม่สามารถเก็บในตู้เซฟนี้ได้'
					},
					vault_weapon_exceed_slot = {
						error	= 'ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บอาวุธชนิดนี้เพิ่ม'
					},
					vault_weapon_exceed_limit = {
						error	= 'ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บอาวุธเพิ่มได้อีก'
					},
					vault_weapon_exceed_weight = {
						error	= 'น้ำหนักของอาวุธชิ้นนี้มากเกินไปสำหรับเก็บในตู้เซฟนี้'
					},
					vault_weapon_not_allow = {
						error	= 'ตู้เซฟนี้ไม่อนุญาตให้เก็บอาวุธได้'
					}
				},
				icon = 'vault',
				duration = 4000
			}
		}
	},
	nc_discordlogs = {					-- ใช้งาน Extension NC Discord Logs
		enable = true,
		options = {
			create_vault = {
				enable = true,
				webhook = '',									-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'สร้างตู้เซฟ %s[%s]',
				description = {
					account = 'ใช้ %s จำนวน $%s',
					item = 'ใช้ %s จำนวน %s ชิ้น',
				},
				color = '67b1ba'
			},
			remove_vault = {
				enable = true,
				webhook = '',									-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'ลบตู้เซฟ %s[%s]',
				color = 'e64949'
			},
			upgrade_vault = {
				enable = true,
				webhook = '',									-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'อัพเกรดตู้เซฟ %s[%s]',
				description = 'เพิ่ม EXP: %s หน่วย (EXP ปัจจุบัน %s)',
				sub_description = {
					account = 'สูญเสีย %s จำนวน $%s',
					item = 'สูญเสีย %s จำนวน %s ชิ้น'
				},
				color = '9fdf4c'
			},
			share_vault = {
				enable = true,
				webhook = {										-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
					add = '',
					remove = ''
				},
				title = {
					add = 'แบ่งปันตู้เซฟ %s[%s]',
					remove = 'ยกเลิกการแบ่งปันตู้เซฟ %s[%s]'
				},
				description = {
					add = 'แบ่งปันตู้เซฟให้ %s',
					remove = 'ยกเลิกการแบ่งปันตู้เซฟกับ %s',
				},
				color = {
					add = '9fdf4c',
					remove = 'e64949'
				}
			},
			change_name = {
				enable = true,
				webhook = '',									-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'เปลี่ยนชื่อตู้เซฟ %s[%s]',
				description = 'จาก %s เป็น %s',
				color = 'af63f0'
			},
			open_inventory = {
				enable = true,
				webhook = '',									-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
				title = 'เปิดตู้เซฟ %s[%s]',
				color = '707070'
			},
			move_item = {
				enable = true,
				webhook = {										-- Webhook Name ที่ใส่ไว้ใน nc_discordlogs' config
					group = {
						['NORMAL'] = {
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
					},
					society = {
						['POLICE'] = {
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
						['AMBULANCE'] = {
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
					}
				},
				title = {
					put = 'ใส่สิ่งของเข้าตู้เซฟ %s[%s]',
					take = 'นำสิ่งของออกจากตู้เซฟ %s[%s]'
				},
				description = {
					put = {
						account = 'ใส่ %s จำนวน $%s เข้าตู้เซฟ',
						item = 'ใส่ %s จำนวน %s ชิ้น เข้าตู้เซฟ',
						weapon = 'ใส่อาวุธ %s จำนวนกระสุน %s นัด เข้าตู้เซฟ'
					},
					take = {
						account = 'นำ %s จำนวน $%s ออกจากตู้เซฟ',
						item = 'นำ %s จำนวน %s ชิ้น ออกจากตู้เซฟ',
						weapon = 'นำอาวุธ %s จำนวนกระสุน %s นัด ออกจากตู้เซฟ'
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