--{{{1 awesome libs
local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local dpi = beautiful.xresources.apply_dpi
--}}}1
local builder = function(status_command)
	local arc_widget = wibox.widget{
		widget = wibox.container.arcchart,
		start_angle = 3*math.pi/2,
		thickness = 10,
		rounded_edge = true,
		min_value=0,
		max_value=100,
		value = 50
	}

	local update_arc = function()
		awful.spawn.easy_async_with_shell(
			status_command,
			function(out)
				arc_widget.value = tonumber(out)
			end
		)
	end

	gears.timer {
		autostart = true,
		timeout = 10,
		single_shot = false,
		call_now = true,
		callback = update_arc
	}

	local widget = wibox.widget {
		{
			{arc_widget, layout = wibox.layout.flex.horizontal},
			margins = 5,
			widget = wibox.container.margin
		},
		bg = beautiful.widget_bg,
		fg = beautiful.widget_fg,
		shape = panel_style,
		widget = wibox.container.background
	}


	return widget
end
return builder
