local awful = require("awful")
local wibox = require("wibox")

local volume_attributes = require("helpers.volume")
local widgets = require("helpers.dashboardwidgets")

-- Volume
local volume_icon = widgets.simple_icon("󰕾")
local volume_slider = widgets.slider(153) -- Max volume is 153%
local volume_text = widgets.simple_text()
local volume = widgets.bar_group(volume_icon, volume_slider, volume_text)

volume_slider:connect_signal("property::value", function(_, value)
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. value .. "%", false)
end)

-- Brightness Level
local brightness_icon = widgets.simple_icon("󰖙")
local brightness_slider = widgets.slider(100)
local brightness_text = widgets.simple_text()
local brightness = widgets.bar_group(brightness_icon, brightness_slider, brightness_text)

brightness_slider:connect_signal("property::value", function(_, value)
    awful.spawn("brightnessctl set " .. value .. "%", false)
end)

-- Stats
local function get_stats()
    awesome.connect_signal("signal::volume", function(vol, muted)
        att = volume_attributes.pick(vol, muted)
        volume_slider.value = vol
        volume_icon.markup = att.icon
        volume_slider.bar_active_color = att.widget_color
        volume_slider.handle_color = att.widget_color
        volume_text.markup = att.text
    end)

    awesome.connect_signal("signal::brightness", function(brightness_level)
        brightness_slider.value = brightness_level
        brightness_text.markup = widgets.recolor(brightness_level .. "%", Color.fg)
    end)
end

get_stats()

return widgets.wrapping_widget(wibox.widget {
    volume,
    brightness,
    spacing = Xdpi(20),
    layout = wibox.layout.fixed.vertical,
})
