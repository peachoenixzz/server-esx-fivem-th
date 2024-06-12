_onSpot = false
isMinigame = false
_SafeCrackingStates = "Setup"
local firstRotate = nil
local lastCorrect = false
function createSafe(combination)
	local res
	pcall(function()-- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'StartMinigameSafe',
			content = ('เริ่มต้นมินิเกมส์ตู้เซฟ'):format(),
		})
	end)-- End Log
	isMinigame = not isMinigame
	RequestStreamedTextureDict("MPSafeCracking",false)
	RequestAmbientAudioBank("SAFE_CRACK",false)

	if isMinigame then
		InitializeSafe(combination)
		while isMinigame do
			playFx("mini@safe_cracking","idle_base")
			DrawSprites(true)
			res = RunMiniGame()

			if res == true then
				return res
			elseif res == false then
				return res
			end

			Citizen.Wait(0)
		end
	end
end

function InitializeSafe(safeCombination)
	_initDialRotationDirection = "Clockwise"
	_safeCombination = safeCombination

	RelockSafe()
	SetSafeDialStartNumber()
end

function DrawSprites(drawLocks)
	local textureDict = "MPSafeCracking"
	local _aspectRatio = GetAspectRatio(true)
    
	DrawSprite(textureDict,"Dial_BG",0.48,0.3,0.3,_aspectRatio*0.3,0,255,255,255,255)
	DrawSprite(textureDict,"Dial",0.48,0.3,0.3*0.5,_aspectRatio*0.3*0.5,SafeDialRotation,255,255,255,255)

	if not drawLocks then
		return
	end

	local xPos = 0.6
	local yPos = (0.3*0.5)+0.035
	for _,lockActive in pairs(_safeLockStatus) do
		local lockString
		if lockActive then
			lockString = "lock_closed"
		else
			lockString = "lock_open"
		end

		DrawSprite(textureDict,lockString,xPos,yPos,0.025,_aspectRatio*0.015,0,231,194,81,255)
		yPos = yPos + 0.05
	end
end

function RunMiniGame()
	if _SafeCrackingStates == "Setup" then
		_SafeCrackingStates = "Cracking"
	elseif _SafeCrackingStates == "Cracking" then
		local isDead = GetEntityHealth(PlayerPedId()) <= 101
		if isDead then
			EndMiniGame(false)
			return false
		end

		if IsControlJustPressed(0,322) then
			EndMiniGame(false)
			return false
		end

		if IsControlJustPressed(0,38) then
			if _onSpot then
				ReleaseCurrentPin()
				_onSpot = false
				if IsSafeUnlocked() then
					firstRotate = nil
					lastCorrect = false
					pcall(function()-- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'EndMiniGame',
							content = ('ผู้เล่น จบมินิเกมส์ และ เปิดตู้เซฟได้สำเร็จ'):format(),
						})
					end)-- End Log
					EndMiniGame(true,false)
					return true
				end
				if not IsSafeUnlocked() then
					pcall(function()-- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'EndMiniGame',
							content = ('ผู้เล่น จบมินิเกมส์ และ เปิดตู้เซฟได้สำเร็จ (ในรอบย่อย)'):format(),
						})
					end)-- End Log
					firstRotate = nil
					lastCorrect = false
				end
			else
				pcall(function()-- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'EndMiniGame',
						content = ('ผู้เล่น จบมินิเกมส์ และ เปิดตู้เซฟไม่สำเร็จเนื่องจากไม่เจอข้อมูลที่ถูกต้องและพยายามเปิดเซฟ (กด E)'):format(),
					})
				end)-- End Log
				EndMiniGame(false)
				return false
			end
 		end

		local isDropMiniGame = HandleSafeDialMovement()
		if isDropMiniGame then
			EndMiniGame(false)
			return false
		end

		local incorrectMovement = _currentLockNum ~= 0 and _requiredDialRotationDirection ~= "Idle" and _currentDialRotationDirection ~= "Idle" and _currentDialRotationDirection ~= _requiredDialRotationDirection
		if not incorrectMovement then
			local currentDialNumber = GetCurrentSafeDialNumber(SafeDialRotation)
			local correctMovement = _requiredDialRotationDirection ~= "Idle" and (_currentDialRotationDirection == _requiredDialRotationDirection or _lastDialRotationDirection == _requiredDialRotationDirection)  
			if correctMovement then
				local pinUnlocked = _safeLockStatus[_currentLockNum] and currentDialNumber == _safeCombination[_currentLockNum]
				if pinUnlocked then
					pcall(function()-- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'FindCorrectMiniGameSafe',
							content = ('ผู้เล่น หาเลขที่ถูกต้องในหน้าปัดตู้เซฟเจอแล้ว'):format(),
						})
					end)-- End Log
					lastCorrect = true
					PlaySoundFrontend(0,"TUMBLER_PIN_FALL","SAFE_CRACK_SOUNDSET",true)
					_onSpot = true
				end
			end
		elseif incorrectMovement then
			_onSpot = false
		end
	end
end

function HandleSafeDialMovement()
	if IsControlJustPressed(0,34) then
		-- pcall(function()-- Start Log
		-- 	exports['azael_dc-serverlogs']:insertData({
		-- 		event = 'PressAntiClockWiseMiniGameSafe',
		-- 		content = ('ผู้เล่น หมุนทวนเข็มนาฬิกา'):format(),
		-- 	})
		-- end)-- End Log
		if firstRotate ~= nil then
			if  firstRotate ~= "Anticlockwise" then
				pcall(function()-- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'FailLastCurrentClockWiseMiniGameSafe',
						content = ('ผู้เล่น หมุนทวนเข็มนาฬิกา แต่รอบล่าสุดหมุนตามเข็มนาฬิกา มินิเกมส์ล้มเหลว'):format(),
					})
				end)-- End Log
				firstRotate = nil
				lastCorrect = false
				return true
			end
		end
		if lastCorrect then
			pcall(function()-- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'FailAfterFindCorrectMinigameSafe',
					content = ('ผู้เล่น หมุนตู้เซฟเลยเลขที่กำหนดไว้ มินิเกมส์ล้มเหลว (ในรอบนี้หมุนทวนเข็มนาฬิกา)'):format(),
				})
			end)-- End Log
			firstRotate = nil
			lastCorrect = false
			return true
		end
		firstRotate = "Anticlockwise"
		RotateSafeDial("Anticlockwise")
		return false
	elseif IsControlJustPressed(0,35) then
		-- pcall(function()-- Start Log
		-- 	exports['azael_dc-serverlogs']:insertData({
		-- 		event = 'PressClockWiseMiniGameSafe',
		-- 		content = ('ผู้เล่น หมุนตามเข็มนาฬิกา'):format(),
		-- 	})
		-- end)-- End Log
		if firstRotate ~= nil then
			if firstRotate ~= "Clockwise" then
				pcall(function()-- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'FailLastCurrentAntiClockWiseMiniGameSafe',
						content = ('ผู้เล่น หมุนตามเข็มนาฬิกา แต่รอบล่าสุดหมุนทวนเข็มนาฬิกา มินิเกมส์ล้มเหลว'):format(),
					})
				end)-- End Log
				--TriggerEvent("Porpy_policealert:alertNet", "house_rob")
				firstRotate = nil
				lastCorrect = false
				return true
			end
		end
		if lastCorrect then
			pcall(function()-- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'FailAfterFindCorrectMinigameSafe',
					content = ('ผู้เล่น หมุนตู้เซฟเลยเลขที่กำหนดไว้ มินิเกมส์ล้มเหลว (ในรอบนี้หมุนตามเข็มนาฬิกา)'):format(),
				})
			end)-- End Log
			--TriggerEvent("Porpy_policealert:alertNet", "house_rob")
			firstRotate = nil
			lastCorrect = false
			return true
		end
		firstRotate = "Clockwise"
		RotateSafeDial("Clockwise")
		return false
	else
		RotateSafeDial("Idle")
		return false
	end
end

function RotateSafeDial(rotationDirection)
	if rotationDirection == "Anticlockwise" or rotationDirection == "Clockwise" then
		local multiplier
		local rotationPerNumber = 3.6
		if rotationDirection == "Anticlockwise" then
			multiplier = 1
		elseif rotationDirection == "Clockwise" then
			multiplier = -1
		end

		local rotationChange = multiplier * rotationPerNumber
		SafeDialRotation = SafeDialRotation + rotationChange
		PlaySoundFrontend(0,"TUMBLER_TURN","SAFE_CRACK_SOUNDSET",true)
	end

	_currentDialRotationDirection = rotationDirection
	_lastDialRotationDirection = rotationDirection
end

function SetSafeDialStartNumber()
	local dialStartNumber = math.random(0,100)
	SafeDialRotation = 3.6 * dialStartNumber
end

function RelockSafe()
	if not _safeCombination then
		return
	end
    
	_safeLockStatus = InitSafeLocks()
	_currentLockNum = 1
	_requiredDialRotationDirection = _initDialRotationDirection
	_onSpot = false

	for i = 1,#_safeCombination do
		_safeLockStatus[i] = true
	end
end

function InitSafeLocks()
	if not _safeCombination then
		return
	end
    
	local locks = {}
 	for i = 1,#_safeCombination do
		table.insert(locks,true)
	end

	return locks
end

function GetCurrentSafeDialNumber(currentDialAngle)
	local number = math.floor(100*(currentDialAngle/360))
	if number > 0 then
		number = 100 - number
	end

	return math.abs(number)
end

function ReleaseCurrentPin()
	_safeLockStatus[_currentLockNum] = false
	_currentLockNum = _currentLockNum + 1

	if _requiredDialRotationDirection == "Anticlockwise" then
		_requiredDialRotationDirection = "Clockwise"
	end
	if _requiredDialRotationDirection == "Clockwise" then
		_requiredDialRotationDirection = "Anticlockwise"
	end

	PlaySoundFrontend(0,"TUMBLER_PIN_FALL_FINAL","SAFE_CRACK_SOUNDSET",true)
end

function IsSafeUnlocked()
	return _safeLockStatus[_currentLockNum] == nil
end

function EndMiniGame(safeUnlocked)
	if safeUnlocked then
		PlaySoundFrontend(0,"SAFE_DOOR_OPEN","SAFE_CRACK_SOUNDSET",true)
	else
		PlaySoundFrontend(0,"SAFE_DOOR_CLOSE","SAFE_CRACK_SOUNDSET",true)
	end
	isMinigame = false
	SafeCrackingStates = "Setup"
	ClearPedTasksImmediately(PlayerPedId())
end

function playFx(dict,anim)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(10)
	end

	TaskPlayAnim(PlayerPedId(),dict,anim,3.0,3.0,-1,1,0,0,0,0)
end

exports("createSafe",createSafe)
