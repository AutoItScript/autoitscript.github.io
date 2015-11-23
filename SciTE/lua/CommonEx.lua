function EditorClearMarks(indic_number, start, length)
	local _first_indic, _end_indic
	local current_indic_number = scite.SendEditor(SCI_GETINDICATORCURRENT)
	if indic_number == nil then
		_first_indic, _end_indic = 0, 31
	else
		_first_indic, _end_indic = indic_number, indic_number
	end
	if start == nil then
		start, length = 0, editor.Length
	end
	for indic = _first_indic, _end_indic do
		scite.SendEditor(SCI_SETINDICATORCURRENT, indic)
		scite.SendEditor(SCI_INDICATORCLEARRANGE, start, length)
	end
	scite.SendEditor(SCI_SETINDICATORCURRENT, current_indic_number)
end

function EditorMarkText(start, length, indic_number)
	local current_indic_number = scite.SendEditor(SCI_GETINDICATORCURRENT)
	scite.SendEditor(SCI_SETINDICATORCURRENT, indic_number)
	scite.SendEditor(SCI_INDICATORFILLRANGE, start, length)
	scite.SendEditor(SCI_SETINDICATORCURRENT, current_indic_number)
end

function GetCurrentWord()
	local current_pos = editor.CurrentPos
	return editor:textrange(editor:WordStartPosition(current_pos, true), editor:WordEndPosition(current_pos, true))
end

function IsLexer(lexer)
	return editor.Lexer == lexer
end

function MatchWordAtStart(word, line)
	local word_pos = editor.LineIndentPosition[line] + 1
	local word_start = editor:WordStartPosition(word_pos)
	local word_end = editor:WordEndPosition(word_pos)
	local word_found = editor:textrange(word_start, word_end)
	return string.lower(word_found) == string.lower(word), word_start, word_end, word_found
end

function ReadAbbrevFile(file, abbr_table)
	local function scite_io_lines(file)
		local line_iter = type(file)=='string' and io.lines(file) or file:lines()
		local scite_iter = function()
			local line = line_iter()
			if not line then return end
			while string.sub(line,-1)=='\\' do
				line = string.sub(line,1,-2)..line_iter()
			end
			return line
		end
		return scite_iter
	end
	local abbrev_file, err, errcode = io.open(file)
	if not abbrev_file then return abbrev_file, err, errcode end
	local abbr_table = abbr_table or {}
	local ignorecomment = tonumber(props['abbrev.'..props['Language']..'.ignore.comment'])==1
	for line in scite_io_lines(abbrev_file) do
		if line ~= '' and (ignorecomment or line:sub(1,1) ~= '#' ) then
			local _abr, _exp = line:match('^(.-)=(.+)')
			if _abr then
				abbr_table[#abbr_table+1] = {abbr=_abr, exp=_exp}
			else
				local import_file = line:match('^import%s+(.+)')
				if import_file then
					ReadAbbrevFile(file:match('.+\\')..import_file, abbr_table)
				end
			end
		end
	end
	abbrev_file:close()
	return abbr_table
end

function ToggleProp(prop_name)
	if props[prop_name] ~= "1" then
		props[prop_name] = "1"
	else
		props[prop_name] = "0"
	end
end

local function encodeRGB2WIN(color)
	if string.sub(color,1,1)=="#" and string.len(color)>6 then
		return tonumber(string.sub(color,6,7)..string.sub(color,4,5)..string.sub(color,2,3), 16)
	else
		return color
	end
end

local function InitMarkStyle(indic_number, indic_style, indic_color, indic_alpha)
	editor.IndicStyle[indic_number] = indic_style
	editor.IndicFore[indic_number] = encodeRGB2WIN(indic_color)
	editor.IndicAlpha[indic_number] = indic_alpha
end

local function EditorInitMarkStyles()
	local string2value = {
		plain    = INDIC_PLAIN,    squiggle = INDIC_SQUIGGLE,
		tt       = INDIC_TT,       diagonal = INDIC_DIAGONAL,
		strike   = INDIC_STRIKE,   hidden   = INDIC_HIDDEN,
		roundbox = INDIC_ROUNDBOX, box      = INDIC_BOX,
		hotspot  = INDIC_HOTSPOT
	}
	for indic_number = 0, 31 do
		local mark = props["indic.style."..indic_number]
		if mark ~= "" then
			local indic_color = mark:match("#%x%x%x%x%x%x") or (props["find.mark"]):match("#%x%x%x%x%x%x") or "#0F0F0F"
			local indic_style = string2value[mark:match("%l+")] or INDIC_ROUNDBOX
			local indic_alpha = tonumber((mark:match("%@%d+") or ""):sub(2)) or 30
			InitMarkStyle(indic_number, indic_style, indic_color, indic_alpha)
		end
	end
end

function string.pattern(s)
	return s:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", '%%%0')
end

function UpdateTheme()
	if props["Language"] == 'au3' then
		scite.MenuCommand(IDM_LANGUAGE + 3)
	end
	EditorInitMarkStyles()
end

AddEventHandler("OnInit", function()
	EditorInitMarkStyles()
end)
