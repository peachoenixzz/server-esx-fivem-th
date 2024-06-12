local coming = false
Config.Weaponlis = {}
for n,i in pairs(Config.Weaponlist) do
    Config.Weaponlis[GetHashKey(n)] = i
	--print(i)
	Config.Weaponlist[n] = nil
end

if Config.damageZone then
	Citizen.CreateThread(function() 
		while true do
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			for k, v in pairs(Config.Zone) do
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < v.radius then
					coming = true
					Wait(3000)	
				else
					coming = false
				end	
			end						
			Citizen.Wait(1000)	
		end	
	end)
end

ApplyDamageToPeds = function(playerPed, damage, status)
	if damage ~= nil then
		local armour = GetPedArmour(playerPed)
		if armour > 0 then
			if (armour - damage) > 0 then
				local health = GetEntityHealth(playerPed)
				SetEntityHealth(playerPed, (health + 1))
				SetPedArmour(playerPed, (armour - damage))
			elseif (armour > 0) then
				local dd = damage - armour
				local health = GetEntityHealth(playerPed)
				SetEntityHealth(playerPed, (health - (dd + 1)))
			end
		else
			local health = GetEntityHealth(playerPed)
			--print(health,damage)
			SetEntityHealth(playerPed, ((health + 1) - damage))
		end
	end
end

	Citizen.CreateThread(function()
		while true do
			local sleep = Config.updatedamage
			local player = PlayerPedId()
			if not IsEntityDead(player) then
				for k,v in pairs(Config.Weaponlis) do
						if coming then
							N_0x4757f00bc6323cfe(k, Config.damageinzone)
						else
							N_0x4757f00bc6323cfe(k, Config.damageoutzone)
						end
					if HasPedBeenDamagedByWeapon(player, k, 0) then
						ApplyDamageToPeds(player, v, false) -- Config.Weaponlis
						ClearEntityLastDamageEntity(player)
						break
					end
				end
			end
			Citizen.Wait(sleep)
		end
	end)

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

AddEventHandler('gameEventTriggered', function (name, args)
	if name == "CEventNetworkEntityDamage" and args[1] ~= 514 and args[4] ~= 1 and not IsPedAPlayer(args[1]) then -- and GetPedType(args[1]) ~= 0
		ApplyDamageToPeds(args[1], Config.Weaponlis[args[5]], false) -- Config.Weaponlis
	end
end)
