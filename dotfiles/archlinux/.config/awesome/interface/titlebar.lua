local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"

----- Titlebar
client.connect_signal("request::titlebars", function(c)
    -- Button interactions
    local buttons = gears.table.join {
        awful.button({}, 1, function()
            c:activate { context = "titlebar", action = "mouse_move" }
        end),
        awful.button({}, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize" }
        end),
    }

    awful
        .titlebar(c, {
            position = "top",
            size = Xdpi(30),
            bg_normal = Color.bg,
            fg_normal = Color.gray,
            bg_focus = Color.bg,
            fg_focus = Color.blue,
        })
        :setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Middle
                { -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c),
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal,
            },
            {
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal(),
            },
            layout = wibox.layout.align.horizontal,
        }
end)

client.connect_signal("focus", function(c)
    c.border_color = Color.bg
end)
client.connect_signal("unfocus", function(c)
    c.border_color = Color.bg
end)
