-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

local playerServerId = GetPlayerServerId(PlayerId())
local bluetoothSpeakerConfig = {}
for i = 1, #Config.BluetoothSpeakers do
	local config = Config.BluetoothSpeakers[i]
	bluetoothSpeakerConfig[config.name] = config
end

-- Function นี้จะถูกเรียกใช้ก่อนจะวางลำโพง
-- [ name: ชื่อของลำโพง | coords: ตำแหน่งของลำโพง | vehicle: Entity ID ของยานพาหนะ *ค่านี้จะไม่ถูกส่งมาหากไม่ได้วางลำโพงบนยานพาหนะ ]
Config.ClientWillPlaceBluetoothSpeaker = function(name, coords, vehicle)
	return true
end

-- Function นี้จะถูกเรียกใช้หลังจากวางลำโพงสำเร็จ
-- [ name: ชื่อของลำโพง | coords: ตำแหน่งของลำโพง | vehicle: Entity ID ของยานพาหนะ *ค่านี้จะไม่ถูกส่งมาหากไม่ได้วางลำโพงบนยานพาหนะ ]
Config.ClientPlacedBluetoothSpeaker = function(name, coords, vehicle)
	
end

-- Function นี้จะถูกเรียกใช้ก่อนจะเก็บลำโพง *Function นี้จะไม่ถูกเรียกใช้ หากผู้เล่นออกนอกระยะลำโพง
-- [ name: ชื่อของลำโพง ]
Config.ClientWillPickupBluetoothSpeaker = function(name)
	return true
end

-- Function นี้จะถูกเรียกใช้หลังจากเก็บลำโพงสำเร็จ *Function นี้จะไม่ถูกเรียกใช้ หากผู้เล่นออกนอกระยะลำโพง
-- [ name: ชื่อของลำโพง ]
Config.ClientPickedupBluetoothSpeaker = function(name)
	
end

-- Function นี้จะถูกเรียกใช้หลังจากเพิ่มลำโพงในระบบสำเร็จ
-- [ name: ชื่อของลำโพง | ownerId: เลข ID ของเจ้าของลำโพง | coords: ตำแหน่งของลำโพง ]
Config.ClientAddedBluetoothSpeaker = function(name, ownerId, coords)
	if ownerId == playerServerId then
		local config = bluetoothSpeakerConfig[name]
		pcall(function()
			exports.nc_inventory:AddBadge({
				key = 'speaker',
				icon = 'emojione:white-heavy-check-mark',
				name = config.item,
				type = 'item',
				options = {
					priority = 1,
					iconScale = 1.0
				}
			})
		end)
	end
end

-- Function นี้จะถูกเรียกใช้หลังจากลบลำโพงออกจากระบบสำเร็จ
-- [ name: ชื่อของลำโพง | ownerId: เลข ID ของเจ้าของลำโพง ]
Config.ClientRemovedBluetoothSpeaker = function(name, ownerId)
	if ownerId == playerServerId then
		local config = bluetoothSpeakerConfig[name]
		pcall(function()
			exports.nc_inventory:RemoveBadge({
				key = 'speaker',
				name = config.item,
				type = 'item'
			})
		end)
	end
end

-- Function นี้จะถูกเรียกใช้ก่อนจะเพิ่มเพลงลงรายชื่อ
-- [ controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' | name: ชื่อของลำโพง | youtubeId: ID ของคลิป YouTube ]
Config.ClientWillAddMusic = function(controllerType, name, youtubeId)
	return true
end

-- Function นี้จะถูกเรียกใช้ก่อนจะลบเพลงออกจากรายชื่อ
-- [ controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' | name: ชื่อของลำโพง | youtubeId: ID ของคลิป YouTube ]
Config.ClientWillRemoveMusic = function(controllerType, name, youtubeId)
	return true
end