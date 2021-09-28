-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- {{{1 require
-- {{{2 basic awesome libs
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
-- }}}2
-- Keybindings
local binds = require('config.bindings')
require("awful.hotkeys_popup.keys")
-- }}}1
-- {{{ Error handling
-- Check if awesome encountered an error during startup and

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true
		naughty.notify({ preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)
		})
		in_error = false
	end)
end
-- }}}
-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")
modkey="Mod4"

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
-- Wallpaper
	set_wallpaper(s)
	require('config.tags')
	require('statusbar')
	require('dashboard')
end)
-- }}}
-- {{{ Bindings
root.keys(binds.keys.global)
root.buttons(binds.buttons.global)
-- }}}
require('config.rules')
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end
	--gears.surface.apply_shape_bounding (c, gears.shape.rounded_rect)
	if awesome.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position then
			-- Prevent clients from being unreachable after screen count changes.
			awful.placement.no_offscreen(c)
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
