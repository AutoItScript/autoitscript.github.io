--[[-----------------------------------------------------------------
EventManagerEx.lua
Authors: Tymur Gubayev
Version: 1.1.0
---------------------------------------------------------------------
Description:
  Simple event manager realization for SciTE
  Exported functions (self-descriptive):
    * AddEventHandler ( EventName, Handler[, RunOnce] ) => Handler
    * RemoveEventHandler ( EventName, Handler )
---------------------------------------------------------------------
History:
  1.0.0 Initial release
  1.0.1 RemoveEventHandler bug fix
  1.0.2 Dispatch bug fix (non-existent event raised error) RunOnce bug fix
  1.0.3 Dispatch bug workaround (rare OnOpen event bug)
  1.0.4 Rearrange "_remove" table (doesn't affect managers behavior)
  1.1.0 "AddEventHandler" now returns added function handler, use this value to remove handler added with RunOnce option
--]]-----------------------------------------------------------------

local _remove = {}
local events  = {}

local function RemoveAllOutstandingEventHandlers()
	for i = 1, #_remove do
		local ename, h_rem = next(_remove[i])
		local t_rem = events[ename]
		for j = 1, #t_rem do
			if t_rem[j] == h_rem then
				table.remove(t_rem, j)
				break
			end
		end
	end
	_remove = {}
end

local function Dispatch (name, ...)
	RemoveAllOutstandingEventHandlers()
	local event = events[name]
	local res
	for i = 1, #event do
		local h = event[i]
		if h then
			res = {h(...)}
			if res[1] then
				return unpack(res)
			end
		end
	end
	return res and unpack(res)
end

local function NewDispatcher(EventName)
	local dispatch = function(...)
		return Dispatch(EventName, ...)
	end
	local old_handler = _G[EventName]
	if old_handler then
		AddEventHandler(EventName, old_handler)
	end
	_G[EventName] = dispatch
end

function AddEventHandler(EventName, Handler, RunOnce)
	local event = events[EventName]
	if not event then
		events[EventName] = {}
		event = events[EventName]
		NewDispatcher(EventName)
	end
	local OnceHandler
	if not RunOnce then
		event[#event + 1] = Handler
	else
		OnceHandler = function(...)
			RemoveEventHandler(EventName, OnceHandler)
			return Handler(...)
		end
		event[#event + 1] = OnceHandler
	end
	return OnceHandler or Handler
end

function RemoveEventHandler(EventName, Handler)
	_remove[#_remove + 1] = {[EventName] = Handler}
end
