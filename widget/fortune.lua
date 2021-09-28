local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi
-- based on Fortune widget              Credits: u/EmpressNoodle, github/elenapan

buildFortune = function(length,cookies,interval)

    local fortune_command = "fortune -n " .. length .." -s " .. cookies
    local fortune = wibox.widget {
        font = beautiful.font,
        text = "You so poor you don't even have a cookie yet...",
        widget = wibox.widget.textbox
    }

    local update_fortune = function()
        awful.spawn.easy_async_with_shell(fortune_command, function(out)
            -- Remove trailing whitespaces
            out = out:gsub('^%s*(.-)%s*$', '%1')
            fortune.markup = "<i>" .. out .. "</i>"
        end)
    end

    gears.timer {
        autostart = true,
        timeout = interval,
        single_shot = false,
        call_now = true,
        callback = update_fortune
    }

    local fortune_widget = wibox.widget {
        {
            {fortune, layout = wibox.layout.flex.horizontal},
            margins = dpi(16),
            widget = wibox.container.margin
        },
        bg = beautiful.widget_bg,
        fg = beautiful.widget_fg,
        shape = panel_style,
        forced_height = dpi(112),
        widget = wibox.container.background
    }
    return fortune_widget
end
return buildFortune
