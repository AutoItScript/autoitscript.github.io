--[[--------------------------------------------------
ROCheck.lua
Authors: Midas, VladVRO
Version: 1.1.1
------------------------------------------------------
Sets automatically R/O mode for files with the RHS attributes
------------------------------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\lua\\ROCheck.lua")
--]]--------------------------------------------------

AddEventHandler("OnOpen", function()
	local FileAttr = props["FileAttr"]
	if (string.find(FileAttr, "[RHS]")) and (not editor.ReadOnly) then
		scite.MenuCommand(IDM_READONLY)
	end
end)

AddEventHandler("OnSave", function()
	local FileAttr = props["FileAttr"]
	if (not string.find(FileAttr, "[RHS]")) and (editor.ReadOnly) then
		scite.MenuCommand(IDM_READONLY)
	end
end)
