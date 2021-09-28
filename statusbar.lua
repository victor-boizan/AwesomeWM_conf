--{{{ Libs
local awful = require('awful')
local gears = require('gears')
local wibox = require("wibox")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
--}}}
--{{{ Require Widget
local buildtaglist=require('widget.taglist')
local buildButton = require('widget.button')
local battery = require('widget.battery')
local clock = require('widget.clock')
--}}}
local icons = require("theme.ressources.icons")
--{{{ taglist buttons
local taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ }, 2, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)
--}}}
--{{{1 bar generation 
awful.screen.connect_for_each_screen(function(s)
--{{{2 bar shape definition	
	local barshape = function(cr, width, height)
		 gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 30)
	end
--}}}2
--{{{2 homebar definition
	s.homebar = awful.wibar({
		position = "left",
		screen = s,
		width = 30,
		shape = barshape,
		bg = beautiful.bg,
		border_color = "transparent"
	})
--}}}2
--{{{2 toggle function
	function homebar_toggle()
		s.homebar.visible = not s.homebar.visible
	end
--}}}2
--{{{2 widget creation
--{{{3 separator
	separator = wibox.widget.separator {
		opacity = 0,
		shape  = gears.shape.circle,
		span_ratio = 0,
	}
--}}}3
--{{{3 home button
	local home_button = buildButton(icons.user, 5, 30)
	home_button:connect_signal('button::release', function() _G.dashboard_show() end)
	local home = wibox.widget {
		{
			home_button,
			layout = wibox.layout.fixed.vertical
		},
		visible = true,
		shape = gears.shape.circle,
		bg = beautiful.bg,
		widget = wibox.widget.background
	}
--}}}3
--{{{3 tags
--{{{4 filters
	function isgeneral_filter(t)
		return t.isgeneral
	end
	function isnotgeneral_filter(t)
		return not t.isgeneral
	end
--}}}
--{{{4 build taglist parts
	s.generaltaglist = buildtaglist(isgeneral_filter,s,taglist_buttons)
	s.typetaglist = buildtaglist(isnotgeneral_filter,s,taglist_buttons)
--}}}4
--{{{4 final taglist
	s.tagslists = wibox.widget{
		{
			s.generaltaglist,
			s.typetaglist,
			layout = wibox.layout.fixed.vertical
		},
		bg = beautiful.bg,
		shape  = gears.shape.rounded_bar,
		widget = wibox.widget.background
	}
--}}}4
--}}}3
--{{{3 systray
systray = require('widget.systray')
--}}}3
--}}}2
--{{{2 homebar setup
	s.homebar:setup{
		layout = wibox.layout.align.vertical,
		{
			layout = wibox.layout.fixed.vertical,
			home_button,
			s.tagslists,
		},
		{
			{
				layout = wibox.layout.fixed.vertical,
				clock,
				battery,
				systray,
			},
			widget = wibox.container.place,
			valign = "bottom",
		}
	}
--}}}2
end)
--}}}1

