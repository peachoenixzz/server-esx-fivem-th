local events = {}
local cbEvent = ('Giant_CB_%s')
local cache = {}
cache.resource = GetCurrentResourceName()

RegisterNetEvent(cbEvent:format(cache.resource), function(key, ...)
	local cb = events[key]
	return cb and cb(...)
end)

---@param _ any
---@param event string
---@param playerId number
---@param cb function|false
---@param ... any
---@return unknown?
local function triggerClientCallback(_, event, playerId, cb, ...)
	local key

	repeat
		key = ('%s:%s:%s'):format(event, math.random(0, 100000), playerId)
	until not events[key]

	TriggerClientEvent(cbEvent:format(event), playerId, cache.resource, key, ...)

	---@type promise | false
	local promise = not cb and promise.new()

	events[key] = function(response, ...)
        response = { response, ... }
		events[key] = nil

		if promise then
			return promise:resolve(response)
		end

        if cb then
            cb(table.unpack(response))
        end
	end

	if promise then
		return table.unpack(Citizen.Await(promise))
	end
end

---@overload fun(event: string, playerId: number, cb: function, ...)
callback = setmetatable({}, {
	__call = triggerClientCallback
})

local function callbackResponse(success, result, ...)
	if not success then
		if result then
			return print(('^1SCRIPT ERROR: %s^0\n%s'):format(result , Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString()) or ''))
		end

		return false
	end

	return result, ...
end

local pcall = pcall

---@param name string
---@param cb function
--- Registers an event handler and callback function to respond to client requests.
function callback.register(name, cb)
	RegisterNetEvent(cbEvent:format(name), function(resource, key, ...)
		TriggerClientEvent(cbEvent:format(resource), source, key, callbackResponse(pcall(cb, source, ...)))
	end)
end

return callback