-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- Function นี้จะถูกเรียกใช้งานเมื่อมีการโหลดข้อมูลครั้งแรก (ในฝั่ง Server)
Config.ServerOnFirstLoaded = function()
	-- local soundSystem = nc_musicplayers.GetSoundSystem('sound_system')
	-- soundSystem.AddMusic('jfKfPfyJRdk')
end

-- Function นี้จะถูกเรียกใช้ก่อนจะวางลำโพง
-- [ playerId: เลข ID ของผู้เล่น | name: ชื่อของลำโพง | coords: ตำแหน่งของลำโพง ]
Config.ServerWillPlaceBluetoothSpeaker = function(playerId, name, coords)
	return true
end

-- Function นี้จะถูกเรียกใช้หลังจากวางลำโพงสำเร็จ
-- [ playerId: เลข ID ของผู้เล่น | name: ชื่อของลำโพง | coords: ตำแหน่งของลำโพง ]
Config.ServerPlacedBluetoothSpeaker = function(playerId, name, coords)

end

-- Function นี้จะถูกเรียกใช้ก่อนจะเก็บลำโพง
-- [ playerId: เลข ID ของผู้เล่น | name: ชื่อของลำโพง]
Config.ServerWillPickupBluetoothSpeaker = function(playerId, name)
	return true
end

-- Function นี้จะถูกเรียกใช้หลังจากเก็บลำโพงสำเร็จ
-- [ playerId: เลข ID ของผู้เล่น | name: ชื่อของลำโพง]
Config.ServerPickedupBluetoothSpeaker = function(playerId, name)

end

-- Function นี้จะถูกเรียกใช้ก่อนใช้งานลำโพง
-- [ playerId: เลข ID ของผู้ทำรายการ | controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' ]
-- [ name: ชื่อของลำโพง | ownerId: เลข ID ของเจ้าของลำโพง (ไม่มีค่าเมื่อ controllerType เป็น soundsystem) ]
Config.ServerWillEnterController = function(playerId, controllerType, name, ownerId)
	return true
end

-- Function นี้จะถูกเรียกใช้หลังจากใช้งานลำโพง
-- [ playerId: เลข ID ของผู้ทำรายการ | controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' ]
-- [ name: ชื่อของลำโพง | ownerId: เลข ID ของเจ้าของลำโพง (ไม่มีค่าเมื่อ controllerType เป็น soundsystem) ]
Config.ServerEnteredController = function(playerId, controllerType, name, ownerId)

end

-- Function นี้จะถูกเรียกใช้หลังจากยกเลิกการใช้งานลำโพง
-- [ playerId: เลข ID ของผู้ทำรายการ | controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' ]
-- [ name: ชื่อของลำโพง | ownerId: เลข ID ของเจ้าของลำโพง (ไม่มีค่าเมื่อ controllerType เป็น soundsystem) ]
Config.ServerLeftController  = function(playerId, controllerType, name, ownerId)

end

-- Function นี้จะถูกเรียกใช้ก่อนจะเพิ่มเพลงลงรายชื่อ
-- [ playerId: เลข ID ของผู้ทำรายการ | controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' | name: ชื่อของลำโพง ]
-- [ youtubeId : ID ของคลิป YouTube | ownerId: เลข ID ของเจ้าของลำโพง (ไม่มีค่าเมื่อ controllerType เป็น soundsystem) ]
Config.ServerWillAddMusic = function(playerId, controllerType, name, youtubeId, ownerId)
	return true
end

-- Function นี้จะถูกเรียกใช้หลังจากเพิ่มเพลงลงรายชื่อสำเร็จ
-- [ playerId: เลข ID ของผู้ทำรายการ | controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' | name: ชื่อของลำโพง ]
-- [ youtubeId : ID ของคลิป YouTube | ownerId: เลข ID ของเจ้าของลำโพง (ไม่มีค่าเมื่อ controllerType เป็น soundsystem) ]
Config.ServerAddedMusic = function(playerId, controllerType, name, youtubeId, ownerId)

end

-- Function นี้จะถูกเรียกใช้ก่อนจะลบเพลงออกจากรายชื่อ
-- [ playerId: เลข ID ของผู้ทำรายการ | controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' | name: ชื่อของลำโพง ]
-- [ youtubeId : ID ของคลิป YouTube | ownerId: เลข ID ของเจ้าของลำโพง (ไม่มีค่าเมื่อ controllerType เป็น soundsystem) ]
Config.ServerWillRemoveMusic = function(playerId, controllerType, name, youtubeId, ownerId)
	return true
end

-- Function นี้จะถูกเรียกใช้หลังจากลบเพลงออกจากรายชื่อสำเร็จ
-- [ playerId: เลข ID ของผู้ทำรายการ | controllerType: ชนิดของเครื่องเสียง 'bluetooth|soundsystem' | name: ชื่อของลำโพง ]
-- [ youtubeId : ID ของคลิป YouTube | ownerId: เลข ID ของเจ้าของลำโพง (ไม่มีค่าเมื่อ controllerType เป็น soundsystem) ]
Config.ServerRemovedMusic = function(playerId, controllerType, name, youtubeId, ownerId)

end