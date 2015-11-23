local last_lexer

AddEventHandler("OnUpdateUI", function()
	if props["FileName"] ~= "" then
		local cur_lexer = string.upper(props["Language"])
		if cur_lexer ~= last_lexer then
			if cur_lexer == "HYPERTEXT" then
				props["scite.lexer.name"] = "HTML"
			else
				props["scite.lexer.name"] = cur_lexer
			end
			last_lexer = cur_lexer
		end
	end
end)
