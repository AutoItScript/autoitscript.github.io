local function FindCount(text, textToFind)
	local count = 0
	for _ in string.gmatch(text, textToFind:pattern()) do
		count = count + 1
	end
	return count
end

local function GetCurrLineNumber()
	return editor:LineFromPosition(editor.CurrentPos)
end

local function GetEOL()
	local eol = "\r\n"
	if editor.EOLMode == SC_EOL_CR then
		eol = "\r"
	elseif editor.EOLMode == SC_EOL_LF then
		eol = "\n"
	end
	return eol
end

local function GetLineIndentation(num_line)
	if num_line < 0 then num_line = 0 end
	if num_line >= editor.LineCount then num_line = editor.LineCount - 1 end
	return editor.LineIndentation[num_line] / editor.Indent
end

local function IsEOLlast(text)
--	if string.find(text, GetEOL(), string.len(text) - 1) then
--		return true
--	end
--	return false
	return text:sub(-1) == GetEOL()
end

local function IsInLineEnd(num_line, text)
	local endpos = editor.LineEndPosition[num_line]
	if (endpos >= string.len(text)) and (string.find(editor:textrange(editor:PositionBefore(endpos - string.len(text) + 1), endpos), text:pattern())) then
		return true
	end
	return false
end

local function IsLineStartPos(pos)
	return editor.LineIndentPosition[editor:LineFromPosition(pos)] == pos
end

local function nextIs(pos, text)
	if string.find(editor:textrange(pos, editor:PositionAfter(pos + string.len(text) - 1)), text:pattern()) then
		return true
	end
	return false
end

local function nextIsEOL(pos)
	if (pos == editor.Length) or (nextIs(pos, GetEOL())) then
		return true
	end
	return false
end

local function BracesBalanced (s, bracebegin, braceend)
	if (#bracebegin + #braceend) > 2 then return true end
	local b,e = s:find("%b"..bracebegin..braceend)
	local b2 = s:find(bracebegin, 1, true)
	local e2 = s:find(braceend, 1, true)
	return (b == b2) and (e == e2)
end

local function BlockBraces(bracebegin, braceend)
	local text = editor:GetSelText()
	local selbegin = editor.SelectionStart
	local selend = editor.SelectionEnd
	local b, e = string.find(text, "^%s*"..bracebegin:pattern())
	local b2, e2 = string.find(text, braceend:pattern().."%s*$")
	local add = (IsEOLlast(text) and GetEOL()) or ("")
	editor:BeginUndoAction()
	if (b and b2) and (BracesBalanced(text:sub(e + 1, b2 - 1) , bracebegin, braceend)) then
		text = string.sub(text, e + 1, b2 - 1)
		editor:ReplaceSel(text..add)
		editor:SetSel(selbegin, selbegin + #(text..add))
	else
		editor:insert(selend - #add, braceend)
		editor:insert(selbegin, bracebegin)
		editor:SetSel(selbegin, selend + #(bracebegin..braceend))
	end
	editor:EndUndoAction()
	return true
end

local function GetCharInProps(value, index)
	return string.sub(props[value], index, index)
end

local function GetIndexFindCharInProps(value, findchar)
	if findchar then
		local resIndex = string.find(props[value], findchar:pattern() , 1)
		if	(resIndex ~= nil) and (string.sub(props[value], resIndex,resIndex) == findchar) then
			return resIndex
		end
	end
	return nil
end

local function GetBraces(char)
	local braceOpen = ""
	local braceClose = ""
	local symE = ""
	local brIdx = GetIndexFindCharInProps("braces.open", char)
	if brIdx ~= nil then
		symE = GetCharInProps("braces.close", brIdx)
		if symE ~= nil then
			braceOpen = char
			braceClose = symE
		end
	else
		brIdx = GetIndexFindCharInProps("braces.close", char)
		if brIdx ~= nil then
			symE = GetCharInProps("braces.open", brIdx)
			if symE ~= nil then
				braceOpen = symE
				braceClose = char
			end
		end
	end
	return braceOpen, braceClose
end

local g_isPastedBraceClose = false

local function SmartBraces(char)
	if props["braces.autoclose"] ~= "1" then
		return false
	end
	local multiline = props["braces.multiline"]
	if multiline == "" then multiline = "cpp" end
	local use_multiline = string.find(","..multiline..",", ","..props["Language"]..",")
	local isSelection = editor.SelectionStart ~= editor.SelectionEnd
	local braceOpen, braceClose = GetBraces(char)
	if (braceOpen == "") or (braceClose == "") then
		return false
	end
	if isSelection == true then
		return BlockBraces(braceOpen, braceClose)
	else
		local nextsymbol = string.format("%c", editor.CharAt[editor.CurrentPos])
		if (GetIndexFindCharInProps("braces.close", nextsymbol) ~= nil) and (nextsymbol == char) then
			editor:CharRight()
			return true
		end
		if (char == braceOpen) and ((nextIsEOL(editor.CurrentPos)) or (nextIs(editor.CurrentPos, braceClose))) then
			if (char == "{") and (use_multiline) then
				editor:BeginUndoAction()
				local ln = GetCurrLineNumber()
				if ((ln > 0) and (GetLineIndentation(ln) > GetLineIndentation(ln - 1))) and (IsLineStartPos(editor.CurrentPos)) and (not IsInLineEnd(ln-1, "{")) then
					editor:BackTab()
				end
				editor:AddText("{")
				editor:NewLine()
				if GetLineIndentation(ln) == GetLineIndentation(ln + 1) then
					editor:Tab()
				end
				local pos = editor.CurrentPos
				editor:NewLine()
				if GetLineIndentation(ln + 2) == GetLineIndentation(ln + 1) then
					editor:BackTab()
				end
				editor:AddText("}")
				editor:GotoPos(pos)
				editor:EndUndoAction()
				return true
			end
			if (braceOpen == braceClose) and (math.fmod(FindCount(editor:GetCurLine(), braceOpen), 2) == 1) then
				return false
			end
			editor:BeginUndoAction()
			editor:InsertText(editor.CurrentPos, braceClose)
			editor:EndUndoAction()
			g_isPastedBraceClose = true
		end
		if char == braceClose then
			if (char == "}") and (use_multiline) then
				editor:BeginUndoAction()
				if (IsLineStartPos(editor.CurrentPos)) then
					editor:BackTab()
				end
				editor:AddText("}")
				editor:EndUndoAction()
				return true
			end
		end
	end
	return false
end

AddEventHandler("OnKey", function(key, shift, ctrl, alt, char)
	if editor.Focus then
		if (key == 8) and (g_isPastedBraceClose == true) then
			g_isPastedBraceClose = false
			editor:BeginUndoAction()
			editor:CharRight()
			editor:DeleteBack()
			editor:EndUndoAction()
			return true
		end
		g_isPastedBraceClose = false
		if char ~= "" then
			return SmartBraces(char)
		end
	end
end)
