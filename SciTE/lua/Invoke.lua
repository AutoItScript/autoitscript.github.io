function Invoke(s)
	local obj, fn = s:match("([^%s]+)%.([^%s]+)")
	local args = { }
	for arg in s:gmatch("[^%s]+") do
		table.insert(args, arg)
	end
	if obj and fn then
		obj = _G[obj]
		if obj then
			fn = obj[fn]
			if fn then
				return fn(obj, unpack(args, 2))
			end
		end
	else
		fn = s:match("([^%s]+)")
		print("fn: " .. fn)
		if fn then
			fn = _G[fn]
		end
		if fn then
			return fn(unpack(args, 2))
		end
	end
	error('"' .. s .. '" not found.')
end
