
--{{{ Libs
local awful = require('awful')
local gears = require('gears')
local wibox = require("wibox")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
--}}}

--{{{Time texts
local time = function(format_markup)
	 local time_widget = wibox.widget {
			format = format_markup,
			align = 'center',
			valign = 'center',
			refresh = 60,
			forced_height = 30,
			widget = wibox.widget.textclock
	 }
	 return time_widget
end

local hours = time("%H")
local minutes = time("%M")
--}}}
--{{{Separator
local separator = wibox.widget{
	 colors = beautiful.bg,
	 forced_height = 4,
	 shape  = gears.shape.rounded_bar,
	 widget = wibox.widget.separator
}
--}}}
--{{{widget generation
local widget = wibox.widget {
	 {
			hours,
			separator,
			minutes,
			layout = wibox.layout.fixed.vertical
	 },
	 bg = beautiful.widget_bg,
	 fg = beautiful.widget_fg,
	 height = 32,
	 shape  = gears.shape.rounded_bar,
	 widget = wibox.container.background
}
--}}}

return widget
