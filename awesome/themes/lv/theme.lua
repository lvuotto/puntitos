---------------------------
-- Default awesome theme --
---------------------------

theme = {}

-- Base16 Eighties
theme.base00 = "#2d2d2d"
theme.base01 = "#393939"
theme.base02 = "#515151"
theme.base03 = "#747369"
theme.base04 = "#a09f93"
theme.base05 = "#d3d0c8"
theme.base06 = "#e8e6df"
theme.base07 = "#f2f0ec"
theme.base08 = "#f2777a"
theme.base09 = "#f99157"
theme.base0A = "#ffcc66"
theme.base0B = "#99cc99"
theme.base0C = "#66cccc"
theme.base0D = "#6699cc"
theme.base0E = "#cc99cc"
theme.base0F = "#d27b53"

--~ -- Base16 Ocean
--~ theme.base00 = "#2b303b"
--~ theme.base01 = "#343d46"
--~ theme.base02 = "#4f5b66"
--~ theme.base03 = "#65737e"
--~ theme.base04 = "#a7adba"
--~ theme.base05 = "#c0c5ce"
--~ theme.base06 = "#dfe1e8"
--~ theme.base07 = "#eff1f5"
--~ theme.base08 = "#bf616a"
--~ theme.base09 = "#d08770"
--~ theme.base0A = "#ebcb8b"
--~ theme.base0B = "#a3be8c"
--~ theme.base0C = "#96b5b4"
--~ theme.base0D = "#8fa1b3"
--~ theme.base0E = "#b48ead"
--~ theme.base0F = "#ab7967"

--~ -- Base16 Mocha 
--~ theme.base00 = "#3b3228"
--~ theme.base01 = "#534636"
--~ theme.base02 = "#645240"
--~ theme.base03 = "#7e705a"
--~ theme.base04 = "#b8afad"
--~ theme.base05 = "#d0c8c6"
--~ theme.base06 = "#e9e1dd"
--~ theme.base07 = "#f5eeeb"
--~ theme.base08 = "#cb6077"
--~ theme.base09 = "#d28b71"
--~ theme.base0A = "#f4bc87"
--~ theme.base0B = "#beb55b"
--~ theme.base0C = "#7bbda4"
--~ theme.base0D = "#8ab3b5"
--~ theme.base0E = "#a89bb9"
--~ theme.base0F = "#bb9584"

--~ -- Base16 Tomorrow
--~ theme.base00 = "#1d1f21"
--~ theme.base01 = "#282a2e"
--~ theme.base02 = "#373b41"
--~ theme.base03 = "#969896"
--~ theme.base04 = "#b4b7b4"
--~ theme.base05 = "#c5c8c6"
--~ theme.base06 = "#e0e0e0"
--~ theme.base07 = "#ffffff"
--~ theme.base08 = "#cc6666"
--~ theme.base09 = "#de935f"
--~ theme.base0A = "#f0c674"
--~ theme.base0B = "#b5bd68"
--~ theme.base0C = "#8abeb7"
--~ theme.base0D = "#81a2be"
--~ theme.base0E = "#b294bb"
--~ theme.base0F = "#a3685a"

theme.font          = "Fira Mono 9"

theme.bg_normal     = theme.base00
theme.bg_focus      = theme.base0D
theme.bg_urgent     = theme.base08
theme.bg_minimize   = theme.base01

theme.fg_normal     = theme.base05
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.base03

theme.border_width  = "1"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
--~ theme.taglist_squares_sel   = "/home/lv/.config/awesome/themes/lv/img/square-sel.png"
--~ theme.taglist_squares_unsel = "/home/lv/.config/awesome/themes/lv/img/square-unsel.png"
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg -a Imágenes/fondo.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
