local text = editor:GetSelText()
if text:gsub(' ', '') == '' then
	return
end
if text:gsub('[\+\-\/\*\.\( \)\Xx%x]', '') ~= '' then
	print('Invalid expression.')
	return
end
text = 'return '..text
if not pcall(loadstring(text)) then
	print('Invalid expression.')
	return
end
text = loadstring(text)()
if text == nil then
	print('Invalid expression.')
	return
end
local sel_start = editor.SelectionStart
local sel_end = sel_start + string.len(text)
editor:ReplaceSel(text)
editor:SetSel(sel_start, sel_end)
