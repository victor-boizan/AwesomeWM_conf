local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')

local buildStatus = function(cmd,button,time)
	local status = wibox.widget{
		widget = wibox.widget.progressbar,
		shape = gears.shape.rounded_bar,
		max_value = 100,
		value = 50
	}
	local update_status = function()
		awful.spawn.easy_async_with_shell(
			cmd,
			function(out)
				status.value = tonumber(out)
			end
		)
	end
	gears.timer {
		autostart = true,
		timeout = time,
		single_shot = false,
		call_now = true,
		callback = update_status
	}
	local status_widget = wibox.widget {
		{
			{button, status,layout = wibox.layout.fixed.horizontal},
			margins = 5,
			widget = wibox.container.margin
		},
		bg = beautiful.widget_bg,
		fg = beautiful.widget_fg,
		shape = gears.shape.rounded_rect,
		widget = wibox.container.background
	}
	return status_widget
end

return buildStatus
