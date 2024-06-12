-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- Function นี้จะถูกเรียกใช้เพื่อทำ Animation กดกุญแจยานพาหนะ
-- [ LoadAnimDict: Function สำหรับ Request Animation Dictionary | ped: เลข Entity ของตัวละครผู้เล่น ]
Config.ClientAnimation = function(LoadAnimDict, ped)
	LoadAnimDict('anim@mp_player_intmenu@key_fob@')
	ClearPedSecondaryTask(ped)
	TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click_fp', 16.0, 16.0, -1, 48, 1, false, false, false)
end

-- Function นี้จะถูกเรียกใช้ก่อนล็อคยานพาหนะ [ vehicle: เลข Entity ของยานพาหนะ ]
Config.ClientWillLockVehicle = function(vehicle)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถล็อคยานพาหนะได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถล็อคยานพาหนะได้
end

-- Function นี้จะถูกเรียกใช้หลังล็อคยานพาหนะสำเร็จ [ vehicle: เลข Entity ของยานพาหนะ ]
Config.ClientLockedVehicle = function(vehicle)

end

-- Function นี้จะถูกเรียกใช้ก่อนปลดล็อคยานพาหนะ [ vehicle: เลข Entity ของยานพาหนะ ]
Config.ClientWillUnlockVehicle = function(vehicle)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถปลดล็อคยานพาหนะได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถปลดล็อคยานพาหนะได้
end

-- Function นี้จะถูกเรียกใช้หลังปลดล็อคยานพาหนะสำเร็จ [ vehicle: เลข Entity ของยานพาหนะ ]
Config.ClientUnlockedVehicle = function(vehicle)
	
end

-- Function นี้จะถูกเรียกใช้งานเมื่อมี Error
-- errAction จะมี 'general' => ล็อค/ปลดล็อค ยานพาหนะ
-- errType ที่ถูกส่งมาคือ 'error'
-- errText ที่จะถูกส่งมาในรูปแบบต่างๆดังนี้
-- no_vehicle_nearby				=> 'ล็อค/ปลดล็อค ยานพาหนะ' - 'ไม่พบยานพาหนะของคุณในบริเวณใกล้เคียง'
-- not_owner						=> 'ล็อค/ปลดล็อค ยานพาหนะ' - 'เนื่องจากยานพาหนะนี้ไม่ใช่ยานพาหนะของคุณ'
Config.ClientNotificationError = function(errAction, errType, errText)
	-- ตัวอย่างการเขียน Notification ต่างๆ
	-- no_vehicle_nearby					=> 'error' - 'ไม่พบยานพาหนะของคุณในบริเวณใกล้เคียง'
	-- not_owner							=> 'error' - 'เนื่องจากยานพาหนะนี้ไม่ใช่ยานพาหนะของคุณ'
	exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบล็อครถ', -- หัวเรื่อง
        description = 'ไม่พบยานพาหนะของคุณในบริเวณใกล้เคียง', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_vehicle', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end