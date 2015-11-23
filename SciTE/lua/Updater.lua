require "shell"

AddEventHandler("OnInit", function()
	shell.exec('"'..props['SciteDefaultHome']..'\\Tools\\SciTE Updater\\SciTE Updater.exe'..'" /s /t')
end)
