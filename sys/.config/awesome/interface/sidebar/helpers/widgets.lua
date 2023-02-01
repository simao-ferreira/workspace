local wibox = require("wibox")
local gears = require("gears")

local _widgets = {}

local function bar()
    return function(cr, w, h)
        gears.shape.rounded_bar(cr, w, h)
    end
end

local function handle(radius)
    return function(cr, w, h)
        gears.shape.circle(cr, w, h, radius)
    end
end

-- Common to progressbar and sliders
local bar_color = Color.blue
local bar_background = Color.fg
local bar_height = xdpi(10)
local bar_width = xdpi(200)

function _widgets.wrapping_widget(widget)
    return wibox.widget {
        nil,
        {
            nil,
            widget,
            expand = "none",
            layout = wibox.layout.align.horizontal,
        },
        expand = "none",
        layout = wibox.layout.align.vertical,
    }
end

function _widgets.basic_icon(icon)
    return wibox.widget({
        markup = icon,
        font = Bold_Font,
        align = "center",
        widget = wibox.widget.textbox,
    })
end

function _widgets.basic_text()
    return wibox.widget {
        markup = "<span foreground='" .. Color.fg .. "'> ! </span>",
        valign = "center",
        halign = "center",
        widget = wibox.widget.textbox,
    }
end

function _widgets.basic_markup(value, symbol)
    text = tostring(value)
    return "<span foreground='" .. Color.fg .. "'>" .. text .. symbol .. "</span>"
end

function _widgets.horizontal_group(icon, widget, label)
    return wibox.widget {
        icon,
        widget,
        label,
        forced_height = bar_height,
        spacing = xdpi(5),
        layout = wibox.layout.fixed.horizontal,
    }
end

function _widgets.basic_progressbar(max_bar_value)
    return wibox.widget {
        forced_height = brightness,
        forced_width = bar_width,
        color = bar_color,
        background_color = bar_background,
        shape = bar(),
        bar_shape = bar(),
        max_value = max_bar_value,
        widget = wibox.widget.progressbar,
    }
end

function _widgets.basic_slider(max_bar_value)
    return wibox.widget {
        --forced_height = bar_height,
        forced_width = bar_width,
        bar_color = bar_background,
        bar_active_color = bar_color,
        bar_shape = bar(),
        bar_margins = xdpi(2),
        handle_color = bar_color,
        handle_shape = handle(bar_height / 2), -- radius
        shape = bar(),
        minimum = 0,
        maximum = max_bar_value,
        widget = wibox.widget.slider,
    }
end

-- TODO: delete if unused
--function _widgets.basic_stack(slider, text)
--    return wibox.widget {
--        slider,
--        text,
--        forced_height = bar_height,
--        layout = wibox.layout.stack
--    }
--end
--
--function _widgets.grouping_widget(icon, widget)
--    return wibox.widget {
--        icon,
--        widget,
--        spacing = xdpi(10),
--        layout = wibox.layout.fixed.horizontal,
--    }
--end

return _widgets