-- Discord Log (Webhook)
Config.DC = {
	--------------- ไอเทมทั่วไป ---------------
	['item'] = {
		Put = { -- เอาไอเทมเข้าหลังเข้ารถ
			Enabled = true, -- true = เปิดใช้งาน
			URL_Webhook = '',
			Template = {
				color = 0xCCFF00,
				title = 'เอาเข้า [ประเภท - ไอเทมทั่วไป]',
				description = 'Plate: **%s** \n Vehicle: **%s** \n Owner: **%s** \n Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s**'
			}
		},
		Take = { -- เอาไอเทมออกหลังรถ
			Enabled = true, -- true = เปิดใช้งาน
			URL_Webhook = '',
			Template = {
				color = 0xFF0000,
				title = 'เอาออก [ประเภท - ไอเทมทั่วไป]',
				description = 'Plate: **%s** \n Vehicle: **%s** \n Owner: **%s** \n Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s**'
			}
		}
	},
	--------------- ไอเทมประเภทเงิน ---------------
	['account'] = {
		Put = { -- เอาไอเทมเข้าหลังเข้ารถ
			Enabled = true, -- true = เปิดใช้งาน
			URL_Webhook = '',
			Template = {
				color = 0xCCFF00,
				title = 'เอาเข้า [ประเภท - เงิน]',
				description = 'Plate: **%s** \n Vehicle: **%s** \n Owner: **%s** \n Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s**'
			}
		},
		Take = { -- เอาไอเทมออกหลังรถ
			Enabled = true, -- true = เปิดใช้งาน
			URL_Webhook = '',
			Template = {
				color = 0xFF0000,
				title = 'เอาออก [ประเภท - เงิน]',
				description = 'Plate: **%s** \n Vehicle: **%s** \n Owner: **%s** \n Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s**'
			}
		}
	},
	--------------- ไอเทมประอาวุธ ---------------
	['weapon'] = {
		Put = { -- เอาไอเทมเข้าหลังเข้ารถ
			Enabled = true, -- true = เปิดใช้งาน
			URL_Webhook = '',
			Template = {
				color = 0xCCFF00,
				title = 'เอาเข้า [ประเภท - อาวุธ]',
				description = 'Plate: **%s** \n Vehicle: **%s** \n Owner: **%s** \n Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s**'
			}
		},
		Take = { -- เอาไอเทมออกหลังรถ
			Enabled = true, -- true = เปิดใช้งาน
			URL_Webhook = '',
			Template = {
				color = 0xFF0000,
				title = 'เอาออก [ประเภท - อาวุธ]',
				description = 'Plate: **%s** \n Vehicle: **%s** \n Owner: **%s** \n Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s**'
			}
		}
	}
}