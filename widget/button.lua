local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')

button = function(icon, marge, size)
	local a_button = wibox.widget {
		{
			{
				{
					{image = icon, widget = wibox.widget.imagebox},
					margins = marge,
					widget = wibox.container.margin
				},
				bg = beautiful.button_bg,
				widget = wibox.container.background
			},
			shape = gears.shape.rounded_rect,
			forced_width = size,
			forced_height = size,
			visible = true,
			widget = clickable_container
		},
		visible = true,
		shape = gears.shape.rounded_rect,
		widget = wibox.container.background
	}
	return a_button
end

return button
