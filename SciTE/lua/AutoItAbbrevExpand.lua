AddEventHandler("OnChar", function(c)
	if IsLexer(SCLEX_AU3) then
		local style = editor.StyleAt[editor.CurrentPos - 2]
		if (style == SCE_AU3_EXPAND) and (c == " ")  then
			editor:DeleteBack()
			scite.MenuCommand(IDM_ABBREV)
		end
	end
end)
