Config                        = {}
Config.Locale                 = 'en'

Config.VaultBox = 'p_v_43_safe_s'
Config.Vault = {
	vault = {
		coords = vector3(1737.5899658203125, 3323.14990234375, 41.22000122070312),
		heading = 115.05,
		needItemLicense = 'vault_key', --'licence_vault' -- If you don't want to use items Allow you to leave it blank or needItemLicense = nil
		InfiniteLicense = true -- Should one License last forever?

	},
	police = {
		coords = vector3(1738.0699462890625, 3321.030029296875, 41.22000122070312),
		heading = 115.05,
		-- needItemLicense = 'pd_key', --'licence_vault' -- If you don't want to use items Allow you to leave it blank or needItemLicense = nil
		-- InfiniteLicense = true -- Should one License last forever?

	},
	ambulance = {
		coords = vector3(1738.5699462890625, 3318.949951171875, 41.22000122070312),
		heading = 115.05,
		-- needItemLicense = 'am_key', --'licence_vault' -- If you don't want to use items Allow you to leave it blank or needItemLicense = nil
		-- InfiniteLicense = true -- Should one License last forever?

		},
	mechanic = {
		coords = vector3(1739.3199462890625, 3316.3701171875, 41.22000122070312),
		heading = 115.05,
		-- needItemLicense = 'mc_key', --'licence_vault' -- If you don't want to use items Allow you to leave it blank or needItemLicense = nil
		-- InfiniteLicense = true -- Should one License last forever?

		},
}



-- ใส่ข้อความการแจ้งเตือน
Config.Text = {
	NoLicense = "<b style='color:#ffffff'>คุณไม่มี กุญแจ ในการเปิดตู้เซฟ!</b>",
	Nojobs = 'คุณไม่ได้รับอนุญาตเพราะไม่ใช่หน่วยงาน!!'
	
}