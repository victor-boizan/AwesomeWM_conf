local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

--I don't remember from where it came from, but thats not my code

local styles = {}
local function bar_shape(size, bar)
   if bar then

       return function(cr, width, height)
                  gears.shape.rounded_rect(cr, width, height, size)
              end
   else
        return function(cr, width, height)
                   gears.shape.circle(cr, width, height,
                        false, true, false, true, 5)
               end
   end
end
styles.month   = { padding      = 5,
                   bg_color     = beautiful.widget_bg,
                   shape        = bar_shape(10,true)
}
styles.normal  = {  bg_color = beautiful.widget_bg,
                    fg_color = beautiful.widget_fg,
                    shape    = bar_shape(5) }
styles.focus   = { fg_color = beautiful.bg,
                   bg_color = beautiful.accent,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = bar_shape(5)
}
styles.header  = { fg_color = beautiful.accent,
                   bg_color = beautiful.bg,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = bar_shape(10,true)
}
styles.weekday = { fg_color = beautiful.widget_fg,
                   bg_color = beautiful.widget_bg,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = bar_shape(5)
}
local function decorate_cell(widget, flag, date)
    if flag=='monthheader' and not styles.monthheader then
        flag = 'header'
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape              = props.shape,
        shape_border_width =  0,
        fg                 = props.fg_color,
        bg                 = props.bg_color,
        widget             = wibox.container.background
    }
    return ret
end
local cal = wibox.widget {
    date     = os.date('*t'),
    fn_embed = decorate_cell,
    widget   = wibox.widget.calendar.month
}
return cal
