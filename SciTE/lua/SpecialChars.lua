SpecialChars = EventClass:new(Common)

function SpecialChars:OnStartup()
	self.cp = 1
	self.table = {
		' ', '  ',  '&nbsp;',
		'&', '& ',  '&amp;',
		'"', '" ',  '&quot;',
		'<', '< ',  '&lt;',
		'>', '> ',  '&gt;',
		'�', '‘',  '&lsquo;',
		'�', '’', '&rsquo;',
		'�', '“', '&ldquo;',
		'�', '”', '&rdquo;',
		'�', '‹', '&lsaquo;',
		'�', '›', '&rsaquo;',
		'�', '«',  '&laquo;',
		'�', '»',  '&raquo;',
		'�', '„', '&bdquo;',
		'�', '‚', '&sbquo;',
		'�', '·',  '&middot;',
		'�', '…', '&hellip;',
		'�', '§',  '&sect;',
		'�', '©',  '&copy;',
		'�', '®',  '&reg;',
		'�', '™', '&trade;',
		'�', '¦',  '&brvbar;',
		'�', '†', '&dagger;',
		'�', '‡', '&Dagger;',
		'�', '¬',  '&not;',
		'�', '­',  '&shy;',
		'�', '±',  '&plusmn;',
		'�', 'µ',  '&micro;',
		'�', '‰', '&permil;',
		'�', '°',  '&deg;',
		'�', '€', '&euro;',
		'�', '¤',  '&curren;',
		'�', '•', '&bull;',
	}
end

function SpecialChars:Char2Html(char)
	local function f(index, value)
		if value == char then html = self.table[index - self.cp + 3] end
	end
	table.foreachi(self.table, f)
	return html
end

function SpecialChars:InsertSpecialChar(sel_value)
	local pos = editor.CurrentPos
	if editor.Lexer == SCLEX_HTML then sel_value = SpecialChars:Char2Html(sel_value) end
	editor:InsertText(pos, sel_value)
	pos = pos + string.len(sel_value)
	editor:SetSel(pos, pos)
end

function SpecialChars:SpecialChar()
	if editor.CodePage == 0 then
		self.cp = 1
	else
		self.cp = 2
	end
	local user_list = ''
	local sep = ';'
	local n = table.getn(self.table)
	for i = self.cp, n - 3, 3 do
		user_list = user_list .. self.table[i] .. sep
	end
	user_list = user_list .. self.table[n + self.cp - 3]
	editor.AutoCSeparator = string.byte(sep)
	editor:UserListShow(12, user_list)
	editor.AutoCSeparator = string.byte(' ')
end

function SpecialChars:OnUserListSelection(tp, sel_value)
	if tp == 12 then
		SpecialChars:InsertSpecialChar(sel_value)
	end
end
