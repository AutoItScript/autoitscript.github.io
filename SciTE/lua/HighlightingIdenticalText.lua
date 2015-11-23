--[[--------------------------------------------------
HighlightingIdenticalText.lua
Author: mozers™, TymurGubayev
Version: 1.5.3
------------------------------
Highlighting text that matches the current word or selection
------------------------------
Connection:
In file SciTEStartup.lua add a line:
  dofile (props["SciteDefaultHome"].."\\lua\\HighlightingIdenticalText.lua")

Set in a file .properties:
  command.checked.139.*=$(highlighting.identical.text)
  command.name.139.*=Highlighting Identical Text
  command.139.*=highlighting_identical_text_switch
  command.mode.139.*=subsystem:lua,savebefore:no

Set the style of used markers and other options:
  indic.style.14=#CC99FF,box
  indic.style.15=#FF0000,box

  highlighting.identical.text=0
  highlighting.identical.text.autoselectword=0
  highlighting.identical.text.by.style=0
  highlighting.identical.text.matchcase=0
  highlighting.identical.text.wholeword=0
  highlighting.identical.text.minlength=2
  highlighting.identical.text.max=100
  highlighting.identical.text.reserved.words.lua=and,break,do,else,elseif,end,false,for,function,if,in,local,nil,not,or,repeat,return,then,true,until,while
--]]----------------------------------------------------

local count_max = 100
local len_min = 2
local store_text = ''
local store_pos = 0
local mark_ident = 14
local mark_max = 15

local auto_select_word = false
local use_style = false
local match_case = false
local whole_word = false

if tonumber(props['highlighting.identical.text.autoselectword']) == 1 then auto_select_word = true end
if tonumber(props['highlighting.identical.text.by.style']) == 1 then use_style = true end
if tonumber(props['highlighting.identical.text.matchcase']) == 1 then match_case = true end
if tonumber(props['highlighting.identical.text.wholeword']) == 1 then whole_word = true end

--[[----------------------------------------------------
local reserved_words = props['highlighting.identical.text.reserved.words.' .. props['Language'] ]
if reserved_words == '' then
	reserved_words = props['highlighting.identical.text.reserved.words.*']
end
--]]----------------------------------------------------

local tmp
tmp = props['highlighting.identical.text.max']
if tmp ~= '' then
	count_max = tonumber(tmp)
end
tmp = props['highlighting.identical.text.minlength']
if tmp ~= '' then
	len_min = tonumber(tmp)
	if len_min == 0 then
		len_min = 1
	end
end

function highlighting_identical_text_switch()
	ToggleProp('highlighting.identical.text')
	EditorClearMarks(mark_ident)
	store_text = ''
	store_pos = 0
end

--[[----------------------------------------------------
local function IsReservedWord(cur_text)
	if reserved_words == '' then return false end
	for w in string.gmatch(reserved_words, "%w+") do
		if cur_text:lower() == w:lower() then
			return true
		end
	end
	return false
end
--]]----------------------------------------------------

local function IdenticalTextFinder()
	local current_pos = editor.CurrentPos
	if auto_select_word then
		if current_pos == store_pos then
			return
		end
	end
	store_pos = current_pos
	local cur_text = editor:GetSelText()
	if cur_text:find('^%s+$') then
		return
	end
	local find_flags = 0
	if match_case then find_flags = SCFIND_MATCHCASE end
	if whole_word then find_flags = find_flags + SCFIND_WHOLEWORD end
	if cur_text == '' then
		if auto_select_word then
			cur_text = GetCurrentWord()
		end
		if not whole_word then
			find_flags = find_flags + SCFIND_WHOLEWORD
		end
--		if IsReservedWord(cur_text) then
--			return
--		end
	end
	if not auto_select_word then
		if cur_text == store_text then
			return
		end
	end
	store_text = cur_text

	EditorClearMarks(mark_ident)
	EditorClearMarks(mark_max)

	if string.len(cur_text) < len_min then return end

	local style_cur = nil, style_end
	if use_style then
		style_cur = scite.SendEditor(SCI_GETSTYLEAT, editor.SelectionStart)
		style_end = scite.SendEditor(SCI_GETSTYLEAT, editor.SelectionEnd - 1)
		if style_cur ~= style_end then
			style_cur = -1
		end
	end

	local match_table = {}
	local find_start = 0

	repeat
		local ident_text_start, ident_text_end = editor:findtext(cur_text, find_flags, find_start, editor.Length)
		if (ident_text_start == nil) or (ident_text_start == ident_text_end) then
			break
		end
		if (style_cur == nil) or ((scite.SendEditor(SCI_GETSTYLEAT, ident_text_start) == style_cur) and (scite.SendEditor(SCI_GETSTYLEAT, ident_text_end - 1) == style_cur)) then
			match_table[#match_table + 1] = {ident_text_start, ident_text_end}
			if count_max ~= 0 then
				if #match_table > count_max then
					local err_start, err_end
					if auto_select_word then
						err_start = editor:WordStartPosition(current_pos, true)
						err_end = editor:WordEndPosition(current_pos, true)
					else
						err_start = editor.SelectionStart
						err_end = editor.SelectionEnd
					end
					EditorMarkText(err_start, err_end - err_start, mark_max)
					return
				end
			end
		end
		find_start = ident_text_end + 1
	until false

	if #match_table > 1 then
		for i = 1, #match_table do
			EditorMarkText(match_table[i][1], match_table[i][2] - match_table[i][1], mark_ident)
		end
	end
end

AddEventHandler('OnUpdateUI', function()
	if props['FileName'] ~= '' then
		if tonumber(props['highlighting.identical.text']) == 1 then
			IdenticalTextFinder()
		end
	end
end)
