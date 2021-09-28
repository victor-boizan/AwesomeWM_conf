-- {{{ dependancies
local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local naughty = require('naughty')
local icons = require('theme.ressources.icons')
-- }}}
-- {{{ constant
local capacity_cmd = 'bash -c "cat /sys/class/power_supply/BAT0/capacity"'
-- }}}
-- {{{ widget creation
local textbox = wibox.widget{
	align = 'center',
	valign = 'center',
	--forced_width = 30, 
	widget = wibox.widget.textbox
}

local bg_text = wibox.container.background(textbox)
bg_text.bg = "#00000000"
local battery_widget = wibox.widget{
	bg_text,
	visible = true,
   min_value = 0,
   max_value = 100,
   value = 84,
   rounded_edge = true,
   start_angle = 3*math.pi/2,
	widget = wibox.container.arcchart
}
-- }}}
-- {{{ update function
local update_status = function()
	awful.spawn.easy_async_with_shell(capacity_cmd,
		function(out)
			local low = false
			if tonumber(out) == 100 then
				textbox:set_markup_silently("")
				battery_widget.value = 100
			else

				if tonumber(out) <= 25 then
					-- {{{2 Notification
						naughty.notify ({
							text = "The battery is low (" .. out .. "%).",
							title = "WARNING:",
							timeout = 0,
							icon = icons.battery_empty, 
							icon_size = 100,
							bg = beautiful.urgent,
							ignore_suspend = true,})
					-- }}}2
				end
				textbox:set_markup_silently(out)
				battery_widget.value = tonumber(out)
			end

		end)
end
-- }}}

-- {{{ Update timer	
gears.timer {
	autostart = true,
	timeout = 15,
	single_shot = false,
	call_now = true,
	callback = update_status
}
-- }}}

return battery_widget
