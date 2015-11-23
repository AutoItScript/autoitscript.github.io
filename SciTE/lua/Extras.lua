local function set_above()
	if tonumber(props["calltips."..props["FileExt"]:lower()..".set.above"]) == 0 then
		scite.SendEditor(SCI_CALLTIPSETPOSITION, false)
	else
		scite.SendEditor(SCI_CALLTIPSETPOSITION, true)
	end
end

local function BGR2Decimal(BGR)
	if string.len(BGR) ~= 7 then
		return nil
	end
	BGR = string.sub(BGR, 2)
	BGR = string.reverse(BGR)
	BGR = "0x"..BGR
	return tonumber(BGR)
end

local function set_highlight_color()
	local calltips_color_highlight = props["calltips."..props["FileExt"]:lower().."color.highlight"]
	if (calltips_color_highlight == "") then
		calltips_color_highlight = "#FF0000"
	end
	calltips_color_highlight = BGR2Decimal(calltips_color_highlight)
	if calltips_color_highlight ~= nil then
		scite.SendEditor(SCI_CALLTIPSETFOREHLT, calltips_color_highlight)
	end
end

AddEventHandler("OnInit", function()
	set_above()
	set_highlight_color()
end)
