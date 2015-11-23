--[[--------------------------------------------------
SaveSettings.lua
Authors: mozers™, Dmitry Maslov
Version: 1.7.3
---------------------------------------------------
Save current settings on SciTE close
---------------------------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\lua\\SaveSettings.lua")

Set in a file .properties:
  save.settings=1
  import SciTE.session
--]]----------------------------------------------------

local handler_event = true
local init = true
local settings = ''

local function WriteSettings()
	local fn_userprop = props["SciteUserHome"].."\\SciTEUser.properties"
	local fn_settings = props["SciteUserHome"].."\\settings.properties"
	local fh = io.open(fn_userprop, "a+")
	local text = ""
	if fh then
		fh:seek("set", 0)
		text = fh:read("*all")
		text = string.gsub(text, "%s+", " ")
		if not string.find(text:lower(), "import settings.properties") then
			fh:write("\n[Settings]\nimport settings.properties\n")
		end
		fh:close()
	end
	fh = io.open(fn_settings, 'w')
	if not fh then
		return
	end
	fh:write(settings)
	fh:close()
end

local function SaveKey(key)
	value = props[key]
	if value ~= '' then
		settings = settings..key..'='..value..'\n'
	end
end

local function SaveSettings()
	SaveKey('toolbar.visible')
	SaveKey('tabbar.visible')
	SaveKey('statusbar.visible')
	SaveKey('view.whitespace')
	SaveKey('view.eol')
	SaveKey('view.indentation.guides')
	SaveKey('fold.margin.visible')
	SaveKey('line.margin.visible')
	SaveKey('fold.on.open')
	SaveKey('fold.highlight')
--	SaveKey('output.initial.hide')
	SaveKey('split.vertical')
	SaveKey('wrap')
	SaveKey('output.wrap')
	SaveKey('edge.mode')
	SaveKey('strip.trailing.spaces')
--	SaveKey('magnification')
--	SaveKey('output.magnification')
--	SaveKey('print.magnification')
	SaveKey('sidebar.show')
	SaveKey('sidebar.tab.init')
	SaveKey('save.on.deactivate')
	SaveKey('save.session')
	SaveKey('backup.files')
	SaveKey('braces.autoclose')
	SaveKey('highlighting.identical.text')
	SaveKey('use.auto.autocomplete.au3')
	SaveKey('use.auto.calltips.au3')
	SaveKey('utf8.auto.check.toggle')
	SaveKey('utf8.auto.check')
	SaveKey('font.toggle')
	SaveKey('virtual.space.toggle')
	SaveKey('virtual.space')
	SaveKey('eol.mode')
	WriteSettings()
end

AddEventHandler("OnMenuCommand", function(cmd, source)
	if handler_event then
		if cmd == IDM_VIEWTOOLBAR then
			ToggleProp('toolbar.visible')
		elseif cmd == IDM_VIEWTABBAR then
			ToggleProp('tabbar.visible')
		elseif cmd == IDM_VIEWSTATUSBAR then
			ToggleProp('statusbar.visible')
		elseif cmd == IDM_VIEWSPACE then
			ToggleProp('view.whitespace')
		elseif cmd == IDM_VIEWEOL then
			ToggleProp('view.eol')
		elseif cmd == IDM_VIEWGUIDES then
			ToggleProp('view.indentation.guides')
		elseif cmd == IDM_FOLDMARGIN then
			ToggleProp('fold.margin.visible')
		elseif cmd == IDM_LINENUMBERMARGIN then
			ToggleProp('line.margin.visible')
--		elseif cmd == IDM_TOGGLEOUTPUT then
--			ToggleProp('output.initial.hide')
		elseif cmd == IDM_SPLITVERTICAL then
			ToggleProp('split.vertical')
		elseif cmd == IDM_WRAP then
			ToggleProp('wrap')
		elseif cmd == IDM_WRAPOUTPUT then
			ToggleProp('output.wrap')
		elseif cmd == IDM_EOL_CRLF then
			props['eol.mode'] = 'CRLF'
		elseif cmd == IDM_EOL_CR then
			props['eol.mode'] = 'CR'
		elseif cmd == IDM_EOL_LF then
			props['eol.mode'] = 'LF'
		end
	end
end)

AddEventHandler("OnClear", function()
	if init then
		init = false
		if tonumber(props["font.toggle"]) == 1 then
			props["font.override"] = "$(font.monospace)"
		else
			props["font.override"] = ""
		end
	end
end)

AddEventHandler("OnInit", function()
	if tonumber(props["fold.margin.visible"]) == 0 then
		handler_event = false
		scite.MenuCommand(IDM_FOLDMARGIN)
		handler_event = true
	end
end)

AddEventHandler("OnFinalise", function()
	if tonumber(props['save.settings']) == 1 then
		SaveSettings()
	end
end)
