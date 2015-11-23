--[[----------------------------------------------------------
NewFile.lua
Authors: mozers™, VladVRO
Version: 3.3.1
----------------------------------------------
Replaces SciTE command "File|New" (Ctrl+N)
Creates new buffer in the current folder with current file extension
----------------------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\lua\\NewFile.lua")

Set in a file .properties:
  file.make.as.utf8=htm,html
--]]----------------------------------------------------------

require 'shell'

props["untitled.file.number"] = 1

local last_open_path = props["SciteUserHome"]
local handler_event = true
local unsaved_files = {}
local init = true

local function isMakeUTF8()
	local create_utf8_ext = props["file.make.as.utf8"]:lower()
	local current_ext = props["FileExt"]:lower()
	for ext in create_utf8_ext:gmatch("%w+") do
		if current_ext == ext then return true end
	end
	return false
end

local function CreateUntitledFile()
	local file_ext = "."..props["FileExt"]
	if file_ext == "." then file_ext = props["default.file.ext"] end
	local file_dir = props["FileDir"]
	if file_dir == "" then file_dir = last_open_path end
	repeat
--		local file_path = file_dir.."\\"..scite.GetTranslation("Untitled").." "..props["untitled.file.number"]..file_ext
		local file_path = file_dir.."\\Untitled".." "..props["untitled.file.number"]..file_ext
		props["untitled.file.number"] = tonumber(props["untitled.file.number"]) + 1
		if not shell.fileexists(file_path) then
			local warning_couldnotopenfile_disable = props["warning.couldnotopenfile.disable"]
			props["warning.couldnotopenfile.disable"] = 1
			scite.Open(file_path)
			if isMakeUTF8() then scite.MenuCommand(IDM_ENCODING_UCOOKIE) end
			unsaved_files[file_path:upper()] = true
			props["warning.couldnotopenfile.disable"] = warning_couldnotopenfile_disable
			return true
		end
	until false
end

AddEventHandler("OnBeforeSave", function(file)
	if handler_event then
		if isMakeUTF8() and tonumber(props["editor.unicode.mode"]) == IDM_ENCODING_DEFAULT then
			editor.TargetStart = 0
			editor.TargetEnd = editor.Length
			local txt_in = editor:GetText()
			editor:ReplaceTarget(txt_in:to_utf8(editor:codepage()))
			scite.MenuCommand(IDM_ENCODING_UCOOKIE)
		end
		if unsaved_files[file:upper()] then
			if shell.fileexists(file) then
				unsaved_files[file:upper()] = nil
			else
				handler_event = false
				scite.MenuCommand(IDM_SAVEAS)
				handler_event = true
				return true
			end
		end
	end
end)

--[[--------------------------------------------------
AddEventHandler("OnInit", function()
	if props["FilePath"] == "" then
		CreateUntitledFile()
	end
end)
--]]--------------------------------------------------

AddEventHandler("OnMenuCommand", function(msg, source)
	if msg == IDM_NEW then return CreateUntitledFile() end
end)

AddEventHandler("OnOpen", function(path)
	if path ~= "" then
		last_open_path = path:gsub('\\[^\\]*$', "")
	end
end)

AddEventHandler("OnUpdateUI", function()
	if init then
		init = false
		if props["FilePath"] == "" then
			CreateUntitledFile()
		end
	end
end)
