--[[--------------------------------------------------
AutoBackup.lua
Authors: mozers™
Version: 1.5.3
------------------------------------------------------
Creating a backup files
------------------------------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\lua\\AutoBackup.lua")

Set in a file .properties number saved variants and backup path:
  The number of backup files you want to keep (1-9, 0=none)
  backup.files=1

  The absolute or relative path for backup files
  backup.path=$(TEMP)\SciTE
--]]--------------------------------------------------

require 'shell'

local function GetPath()
	local path = props["backup.path"]
	if not string.find(path, "^%a:\\") then
		path = props["FileDir"].."\\"..path
	end
	if not shell.fileexists(path) then
		shell.exec('CMD /C MD "'..path..'"', nil, true, true)
	end
	return path
end

local function BakupFile(filename)
	local sbck = tonumber(props["backup.files"])
	if (sbck == nil) or (sbck == 0) then
		return false
	end
	local sfilename = filename
	filename = GetPath().."\\"..string.gsub(filename, ".*\\", "")
	local nbck = 1
	while (sbck > nbck ) do
		local fn1 = sbck - nbck
		local fn2 = sbck - nbck + 1
		os.remove(filename.."."..fn2..".bak")
		if fn1 == 1 then
			os.rename(filename..".bak", filename.."."..fn2..".bak")
		else
			os.rename(filename.."."..fn1..".bak", filename.."."..fn2..".bak")
		end
		nbck = nbck + 1
	end
	os.remove(filename..".bak")
	if not shell.fileexists(sfilename) then
		io.output(sfilename)
		io.close()
	end
	os.rename(sfilename, filename..".bak")
	if not shell.fileexists(filename..".bak") then
		_ALERT("=>\tERROR CREATE BACKUP FILE: "..filename..".bak".."\t"..sbck)
	end
	return false
end

AddEventHandler("OnBeforeSave", BakupFile)
