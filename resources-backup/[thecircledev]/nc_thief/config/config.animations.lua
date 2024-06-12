-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Animations = {
	rob_dead_player = {
		on = function(ped, cb, DefaultAnimation)			-- DefaultAnimation: Animation การค้นกระเป๋าผู้เล่นหมดสติ ที่ระบบมีให้
			cb(true)										-- Callback กลับไปเป็น true เมื่อต้องการให้ปล้นสำเร็จ
		end,
		off = function(ped)
			ClearPedTasks(ped)
		end
	},

	kneel = {
		enable = true,										-- เปิดใช้งาน Animation คุกเข่า
		anti_spam = 3000,									-- เมื่อผู้เล่นคุกเข่าจะต้องรอกี่ ms ถึงจะลุกได้
		animation = {
			on = function(ped, DefaultAnimation)			-- DefaultAnimation: Animation การคุกเข่า ที่ระบบมีให้
				Anim("busted","idle_2_hands_up", {
					["flag"] = 2,["speed"] = 8.0
				})
			end,
			off = function(ped)
				Anim("busted","hands_up_2_idle", {
					["flag"] = 2,["speed"] = 8.0
				})
				Citizen.Wait(2000)
				ClearPedTasks(ped)
			end
		}
	},


	handsup = {
		enable = false,										-- เปิดใช้งาน Animation ยกมือ
		anti_spam = 1000,									-- เมื่อผู้เล่นยกมือขึ้นจะต้องรอกี่ ms ถึงจะเอามือลงได้
		animation = {
			on = function(ped, DefaultAnimation)			-- DefaultAnimation: Animation การยกมือ ที่ระบบมีให้
				 DefaultAnimation()
			end,
			off = function(ped)
				ClearPedTasks(ped)
				ClearPedSecondaryTask(ped)
			end
		}
	}
}


Anim = function(dict, anim, settings)
	if dict then
		Citizen.CreateThread(function()
			RequestAnimDict(dict)

			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end

			if settings == nil then
				TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			else
				local speed = 1.0
				local speedMultiplier = -1.0
				local duration = 1.0
				local flag = 0
				local playbackRate = 0

				if settings["speed"] then
					speed = settings["speed"]
				end

				if settings["speedMultiplier"] then
					speedMultiplier = settings["speedMultiplier"]
				end

				if settings["duration"] then
					duration = settings["duration"]
				end

				if settings["flag"] then
					flag = settings["flag"]
				end

				if settings["playbackRate"] then
					playbackRate = settings["playbackRate"]
				end

				TaskPlayAnim(PlayerPedId(), dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
			end

			RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(PlayerPedId(), anim, 0, true)
	end
end