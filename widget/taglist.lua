local awful = require('awful')
local gears = require('gears')
local wibox = require("wibox")
local beautiful = require("beautiful")

buildtaglist = function(tags_filter,a_screen,tagbuttons)
	local tag_list = {
		awful.widget.taglist {
			screen  = a_screen,
			filter  = tags_filter,
			style = {shape = gears.shape.circle},
			layout   = {
				spacing = 3,
				layout  = wibox.layout.fixed.vertical
			},
			widget_template = {
				{
					id     = 'icon_role',
					widget = wibox.widget.imagebox,
					resize = true,
				},
				id     = 'background_role',
				widget = wibox.container.background,
			},
			buttons = tagbuttons
		},
		bg     = beautiful.widget_bg,
		shape  = gears.shape.rounded_bar,
		widget = wibox.container.background
	}
	return tag_list
end
return buildtaglist
