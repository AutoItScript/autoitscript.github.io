local event = true

AddEventHandler("OnSendEditor", function(msg, wp, lp)
	if msg == SCI_GOTOLINE and event then
		event = false
		local line_onscreen_cur = editor:LineFromPosition(editor.CurrentPos) - editor.FirstVisibleLine
		editor:GotoLine(wp)
		local line_onscreen = wp - editor.FirstVisibleLine
		if line_onscreen ~= line_onscreen_cur then
			editor:LineScroll(0, line_onscreen - line_onscreen_cur)
		end
		event = true
	end
end)
