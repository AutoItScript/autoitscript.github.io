require "shell"

local path = props["AutoIt3Dir"]
local init = false
local exec = true
local root = {}

local function UpdateRootDirectory()
	if props["Language"] == "au3" then
		local line, name, rep
		local count = 0
		local index = 0
		repeat
			line = editor:GetLine(index)
			if not line then
				break
			end
			if line:gsub("[%s\r\n]", ""):len() ~= 0 then
				line = line:lower()
				if string.find(line:gsub("^%s*", ""):gsub("%s+", " "), "#pragma compile") == 1 then
					name, rep = line:gsub("^%s*#pragma%s+compile%s*%(%s*root%s*,%s*(.+)%s*%)%s*", "%1")
					if rep ~= 0 then
						for k, v in pairs(root) do
							if name == k then
								props["AutoIt3Dir"] = v
								return
							end
						end
						break
					end
				else
					break
				end
				count = 0
			else
				count = count + 1
				if count > 5 then
					break
				end
			end
			index = index + 1
		until false
	end
	props["AutoIt3Dir"] = path
end

function CreateRootTable(s)
	local item = false
	for w in string.gmatch(s, "[^\n]+") do
		root[string.gsub(w, "=.+", "")] = string.gsub(w, "^[^=]+=", "")
		item = true
	end
	if item then
		UpdateRootDirectory()
		init = true
	end
end

AddEventHandler("OnUpdateUI", function()
	if exec then
		exec = false
		if not shell.exec('"'..props['SciteDefaultHome']..'\\lua\\Root.exe'..'" /crt') then

		end
	end
	if init then
		UpdateRootDirectory()
	end
end)
