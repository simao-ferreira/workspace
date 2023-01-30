local awful = require("awful")

local _run = {}

function _run.start_if_not_running(command, callback)
	awful.spawn.easy_async_with_shell(string.format("ps aux | grep '%s' | grep -v 'grep'", command), function(stdout)
		if stdout == "" or stdout == nil then
			callback()
		end
	end)
end

return _run