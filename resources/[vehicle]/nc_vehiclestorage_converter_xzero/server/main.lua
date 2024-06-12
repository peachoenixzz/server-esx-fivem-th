Config = {}
Config.TableName = 'xzero_trunk'

local Charset = {}
local chars = 'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ123456789'
for c in chars:gmatch('.') do
	table.insert(Charset, c)
end
local function GetRandomString(length)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

CreateThread(function()
	local countStorage = MySQL.Sync.fetchScalar('SELECT COUNT(1) FROM `nc_vehicle_trunk_storage`')
	if countStorage > 0 then
		return print('^3Database is not empty, please empty database first.^0')
	end

	local TRUNK = {}

	local xzero_trunk = MySQL.Sync.fetchAll('SELECT `plate`, `accounts`, `items`, `weapons` FROM `' .. Config.TableName .. '`') or {}

	print(string.format('^5Converting database .. ^0(xzero_trunk%s)', #xzero_trunk > 0 and (', ' .. #xzero_trunk) or ''))

	for _, v in ipairs(xzero_trunk or {}) do
		local plate, accounts, items, weapons = v.plate, v.accounts or '', v.items or '', v.weapons and json.decode(v.weapons) or {}

		local WEAPONS = {}
		for _, u in pairs(weapons or {}) do
			local weaponName, weaponAmmo, weaponComponents = u.name and string.upper(u.name), tonumber(u.ammo) or 0, u.components
			if weaponName then
				local key = GetRandomString(4)
				while true do
					if WEAPONS[key] then
						Wait(0)
						key = GetRandomString(4)
					else
						break
					end
				end
				WEAPONS[key] = { weaponName, weaponAmmo, weaponComponents }
			end
		end

		TRUNK[plate] = {
			accounts = accounts,
			items = items,
			weapons = WEAPONS
		}
	end

	local count = 0

	for plate, v in pairs(TRUNK) do
		local rowsChanged = MySQL.Sync.execute('INSERT INTO `nc_vehicle_trunk_storage` SET `plate` = @plate, `accounts` = @accounts, `items` = @items, `weapons` = @weapons', {
			['@plate'] = plate,
			['@accounts'] = v.accounts,
			['@items'] = v.items,
			['@weapons'] = json.encode(v.weapons)
		})
		if rowsChanged == 1 then
			count = count + 1
		end
	end

	print('^2Converting successful. ^0Created ^5' .. count .. ' ^0trunk storages.^0')
end)