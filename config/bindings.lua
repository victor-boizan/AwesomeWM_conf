local awful = require('awful')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local apps = require('config.apps')

local modkey = 'Mod4'
local alt = 'Mod1'

--{{{ globalkeys
local globalKeys = awful.util.table.join(
	-- {{{ awesome
		awful.key({modkey}, 'F1', hotkeys_popup.show_help,
		{description = "show help", group = 'awesome'}),
		awful.key({ modkey, "Control" }, "q", function() awful.spawn("betterlockscreen -l")end,
		{description = "Lock the screen", group = "awesome"}),
		awful.key({modkey}, 'b', function() _G.homebar_toggle() end,
		{description = "toggle sidebar", group = 'awesome'}),
		awful.key({ modkey, "Control" }, "r", awesome.restart,
		{description = "reload awesome", group = "awesome"}),
		awful.key({}, 'Home', function() _G.dashboard_show() end,
		{description = "show dashboard", group = "awesome"}),
	-- }}}
	-- {{{ client
		awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
		{description = "focus next by index", group = "client"}),
		awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
		{description = "focus previous by index", group = "client"}),
		awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
		{description = "swap with next client by index", group = "client"}),
		awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
		{description = "swap with previous client by index", group = "client"}),
		awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "client"}),
	-- }}}
	-- {{{ Layout
		awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
		{description = "select next", group = "layout"}),
		awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
		{description = "select previous", group = "layout"}),

		awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)         end,
		{description = "increase master width factor", group = "layout"}),
		awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
		{description = "decrease master width factor", group = "layout"}),
		awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
		{description = "increase the number of master clients", group = "layout"}),
		awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
		{description = "decrease the number of master clients", group = "layout"}),
	-- }}}
--{{{ fn keys
	--backlight
		awful.key({}, "XF86MonBrightnessDown", function ()
			awful.spawn("xbacklight - 10") end,
		{description = "Decrease brightness", group = "fn keys"}),
		awful.key({}, "XF86MonBrightnessUp", function ()
			awful.spawn("xbacklight + 10") end,
		{description = "increase brightness", group = "fn keys"}),
	--volume
		awful.key({}, "XF86AudioLowerVolume", function ()
			awful.spawn("pulsemixer --change-volume -10") end,
		{description = "Decrease volume", group = "fn keys"}),
		awful.key({}, "XF86AudioRaiseVolume", function () 
			awful.spawn("pulsemixer --change-volume +10") end,
		{description = "increase volume", group = "fn keys"}),
		awful.key({}, "XF86AudioMute", function ()
			awful.spawn("pulsemixer --toggle-mute") end,
		{description = "toggle mute", group = "fn keys"}),

	--media control
--		awful.key({}, "XF86AudioPrev", function () end,
--		{description = "Previous track", group = "fn keys"}),
--		awful.key({}, "XF86AudioPlay", function () end,
--		{description = "Play/Pause track", group = "fn keys"}),
--		awful.key({}, "XF86AudioNext", function () end,
--		{description = "Nest track", group = "fn keys"}),

--}}}
-- {{{ rofi
		awful.key({modkey}, "r", function ()
			awful.spawn("rofi -show run") end,
		{description = "run a program", group = "rofi"}),
		awful.key({modkey}, "Tab", function ()
			awful.spawn("rofi -show window") end,
		{description = "show list of windows", group = "rofi"}),

-- }}}
-- {{{ quick launch
		awful.key({modkey}, "p", function ()
			awful.spawn(apps.password) end,
		{description = "password manager", group = "quick launch"}),
		awful.key({modkey}, "Return", function ()
			awful.spawn(apps.terminal) end,
		{description = "terminal", group = "quick launch"}),

-- Open default program for tag
	awful.key({modkey,"Shift"}, 'Return', function()
		awful.spawn(awful.screen.focused().selected_tag.tagapp,{
			tag = _G.mouse.screen.selected_tag,
		})
	end, {description = 'open default program for tag', group = 'tag'})
)
-- }}}
-- {{{ tags
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 0.
for i = 1, 10 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+F1)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 10 then
		descr_view = {description = 'view tag #', group = 'tag'}
		descr_toggle = {description = 'toggle tag #', group = 'tag'}
		descr_move = {description = 'move focused client to tag #', group = 'tag'}
		descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
	end

	globalKeys = awful.util.table.join(
	globalKeys,

	-- View tag only.
	awful.key({modkey}, '#' .. i + 9, function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then tag:view_only() end
	end, descr_view),
	-- Toggle tag display.
	awful.key({modkey, 'Control'}, '#' .. i + 9, function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then awful.tag.viewtoggle(tag) end
	end, descr_toggle),
	-- Move client to tag.
	awful.key({modkey, 'Shift'}, '#' .. i + 9, function()
		if _G.client.focus then
			local tag = _G.client.focus.screen.tags[i]
			if tag then _G.client.focus:move_to_tag(tag) end
		end
	end, descr_move),
	-- Toggle tag on focused client.
	awful.key({modkey, 'Control', 'Shift'}, '#' .. i + 9, function()
		if _G.client.focus then
			local tag = _G.client.focus.screen.tags[i]
			if tag then _G.client.focus:toggle_tag(tag) end
		end
	end, descr_toggle_focus))
end
--}}}
--}}}
--{{{ clientkeys
local clientkeys = awful.util.table.join(
	awful.key({ modkey,           }, "m",
		function (c)
			c.maximized = not c.maximized
			c:raise()
		end ,
		{description = "toogle maximize", group = "client"}),
	awful.key({ modkey,           }, "n"     , function (c) c.minimized = true               end,
		{description = "minimize", group = "client"}),
	awful.key({ modkey,           }, "f"     ,
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = "client"}),
	awful.key({ modkey, "Shift"   }, "space" ,              awful.client.floating.toggle        ,
		{description = "toggle floating",   group = "client"}),
	awful.key({modkey,            }, "s"     , function (c) c.sticky = not c.sticky end,
		{description = "toggle sticky"     , group = "client"}),
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
		{description = "move to master"    , group = "client"}),
	awful.key({ modkey,           }, "o"     , function (c) c:move_to_screen()               end,
		{description = "move to screen"    , group = "client"}),
	awful.key({ modkey,           }, "t"     , function (c) c.ontop = not c.ontop            end,
		{description = "toggle keep on top", group = "client"}),
	awful.key({ modkey,           }, "a"     , function (c) c.below = not c.below            end,
		{description = "toggle window below", group = "client"}),
	awful.key({ modkey, "Shift"   }, "c"     , function (c) c:kill()                         end,
		{description = "close"             , group = "client"})
)
-- }}}
-- {{{ globalbuttons
-- bind scroll to change tags
local globalbuttons = gears.table.join(
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)
-- }}}
-- {{{ clientbuttons
local clientbuttons = gears.table.join(
	awful.button({ }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
	end),
	awful.button({ modkey }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
	awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.resize(c)
	end)
)
-- }}}

buttons = { global = globalbuttons, client = clientbuttons }
keys    = { global = globalKeys,    client = clientkeys }

return {
	keys    = keys,
	buttons = buttons,
}
