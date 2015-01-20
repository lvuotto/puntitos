-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Load Debian menu entries
require("debian.menu")

-- Localización
os.setlocale("es_AR.UTF-8")

-- Custom
-- Por ahora:
--  - Clima.
--  - Sonido.
--  - Música.
local weather = require("weather")
local sound = require("sound")
local music = require("music")


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/lv/theme.lua")
-- }}}


-- {{{
-- Naughty theme
naughty.config.icon_formats = { "png", "gif", "jpg", "svg" }
naughty.config.defaults = {
    border_width = "0",
    border_color = beautiful.bg_focus,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal
}
naughty.config.presets.low = {
    border_width = "0",
    border_color = beautiful.bg_focus,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal
}
naughty.config.presets.normal = {
    border_width = "0",
    border_color = beautiful.bg_focus,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal
}
naughty.config.presets.critical = {
    border_width = "0",
    border_color = beautiful.bg_urgent,
    bg = beautiful.bg_urgent,
    fg = beautiful.fg_urgent
}
-- }}}


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = err
        })
        in_error = false
    end)
end
-- }}}

-- This is used later as the default terminal and editor to run.
cmd = {}
cmd.terminal = "urxvt"
cmd.editor = os.getenv("EDITOR") or "editor"
cmd.editor_cmd = cmd.terminal .. " -e " .. cmd.editor
cmd.firefox = "Apps/firefox/firefox -p lv"
cmd.weechat = "weechat-wrapper"
cmd.pragha = "pragha"
cmd.dmenu = "dmenu_run -i -p 'run'"
cmd.locker = "slock"
cmd.email = "Apps/thunderbird/thunderbird -p lv"
cmd.autostart = {
    gtk = "xfsettingsd",
    red = "nm-applet",
    torrent = "transmission-gtk -m"
}

--~ -- Autoarranque de aplicaciones
--~ for _, app in pairs(cmd.autostart) do
--~     runonce(app)
--~ end

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- φψλΣπδεα
tags_conf = {
    names = {
        "main", "www",
        "mail", "sudo",
        "irc", "media",
        "img", "libre"
    },
    letras = { "φ", "ψ", "Σ", "ℓ", "π", "δ", "ε", "α" },
    layouts = {
        layouts[2], layouts[10],
        layouts[10], layouts[2],
        layouts[2], layouts[10],
        layouts[1], layouts[2]
    }
}
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags_conf.letras, s, tags_conf.layouts)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
     { "manual", cmd.terminal .. " -e man awesome" },
     { "edit config", cmd.editor_cmd .. " " .. awesome.conffile },
     { "restart", awesome.restart },
     { "quit", awesome.quit }
}

mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "Debian", debian.menu.Debian_menu.Debian },
        { "open terminal", cmd.terminal },
        { "firefox", cmd.firefox },
        { "pragha", cmd.pragha },
        { "weechat", cmd.weechat }
    }
})

mylauncher = awful.widget.launcher({
    image = image(beautiful.awesome_icon),
    menu = mymainmenu
})
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(
    { align = "right" },
    ' <span font="Fira Sans Light">%A, %d de %B - %R</span> ',
    1
)

-- Create a systray
mysystray = widget({ type = "systray" })

-- {{{ Timers y textos.
-- Espaciador
myspacer = widget({ type = "textbox", name = "myspacer" })
myspacer.text = " "

-- Clima
local weather_format = function (w)
    if w.t == math.huge then
        return '<span font="Fira Sans">n/a</span>'
    end
    local c = ""
    if     w.t <=  0 then c = theme.base0E
    elseif w.t <= 10 then c = theme.base0D
    elseif w.t <= 15 then c = theme.base0C
    elseif w.t <= 25 then c = theme.base0B
    elseif w.t <= 32 then c = theme.base0A
    elseif w.t <= 40 then c = theme.base09
    else                  c = theme.base08 end
    local ret = '<span font="Weather Icons">' .. weather.icon(w.i) .. '</span>'
    if w.f ~= nil then
        ret = ret .. '<span font="Weather Icons" color="' .. theme.base03 ..
              '">' .. weather.icon(w.f) .. '</span>'
    end
    ret = ret ..  ' <span font="Fira Sans" color="' .. c .. '">' ..
              string.format("%.1f", w.t) .. ' ºC</span>'
    return ret
end
box_clima = widget({ type = "textbox", name = "box_clima" })
box_clima.text = weather_format(weather.update())
box_clima:buttons(awful.util.table.join(
    awful.button({}, 1, function ()
        box_clima.text = weather_format(weather.update())
    end)
))

-- Sonido
local spark_chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
local sound_format = function (l, m)
    local r, c = "", ""
    if m == "off" then
        r = "⌧"
        c = theme.base08
    else
        local i = 1 + 7 * l / 100
        if i - math.floor(i) < 0.5 then
            i = math.floor(i)
        else
            i = math.ceil(i)
        end
        r = spark_chars[i]
        if     i <= 1 then c = theme.base0F
        elseif i <= 3 then c = theme.base08
        elseif i <= 5 then c = theme.base09
        elseif i <= 7 then c = theme.base0A
        else               c = theme.base0B end
    end
    return '<span color="' .. c .. '">' .. r .. '</span>'
end
box_sonido = widget({ type = "textbox", name = "box_sonido" })
box_sonido.text = sound_format(sound.update())
box_sonido:buttons(awful.util.table.join(
    awful.button({}, 1, function ()
        awful.util.spawn(cmd.terminal .. " -e alsamixer")
    end),
    awful.button({}, 3, function ()
        box_sonido.text = sound_format(sound.toggle())
        timer_sonido:again()
    end),
    awful.button({}, 4, function ()
        box_sonido.text = sound_format(sound.inc())
        timer_sonido:again()
    end),
    awful.button({}, 5, function ()
        box_sonido.text = sound_format(sound.dec())
        timer_sonido:again()
    end)
))

-- Pragha
box_music = {
    prev = widget({ type = "textbox", name = "box_music.prev" }),
    play = widget({ type = "textbox", name = "box_music.play" }),
    stop = widget({ type = "textbox", name = "box_music.stop" }),
    next = widget({ type = "textbox", name = "box_music.next" }),
    playlist = widget({ type = "textbox", name = "box_music.playlist" })
}
box_music.prev.text = '⬅ '
box_music.play.text = '► '
box_music.stop.text = '■ '
box_music.next.text = '➡ '
box_music.playlist.text = '♪ '
box_music.prev:buttons(awful.util.table.join(
    awful.button({}, 1, music.previous)
))
box_music.play:buttons(awful.util.table.join(
    awful.button({}, 1, music.toggle)
))
box_music.stop:buttons(awful.util.table.join(
    awful.button({}, 1, music.stop)
))
box_music.next:buttons(awful.util.table.join(
    awful.button({}, 1, music.next)
))
box_music.playlist:buttons(awful.util.table.join(
    awful.button({}, 1, music.playlists)
))


timer_clima = timer({ timeout = 1800 })
timer_clima:add_signal("timeout",function ()
    box_clima.text = weather_format(weather.update(vicente_lopez))
end)
timer_clima:start()

timer_sonido = timer({ timeout = 60 })
timer_sonido:add_signal("timeout", function ()
    box_sonido.text = sound_format(sound.update())
end)
timer_sonido:start()
-- }}}

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            if not c:isvisible() then
                awful.tag.viewonly(c:tags()[1])
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ width=250 })
        end
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end)
)

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
    ))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    --~ mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons, { font = "Fira Mono 9" })

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
        return awful.widget.tasklist.label.currenttags(c, s)
    end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20 })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        --mylayoutbox[s],
        myspacer,
        box_sonido,
        box_music.playlist,
        box_music.next,
        box_music.stop,
        box_music.play,
        box_music.prev,
        mytextclock,
        box_clima,
        myspacer,
        s == 1 and mysystray or nil,
        --mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j", function ()
        awful.client.focus.byidx( 1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey,           }, "k", function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    --~ awful.key({ modkey, "Shift"   }, "w", function () mymainmenu:show({ keygrabber = true }) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab", function ()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(cmd.terminal) end),
    awful.key({ modkey,           }, "p", function () awful.util.spawn(cmd.dmenu) end),
    awful.key({ modkey, "Shift"   }, ".", function () awful.util.spawn(cmd.locker) end),
    awful.key({ modkey,           }, "w", function () awful.util.spawn(cmd.firefox) end),
    awful.key({ modkey, "Shift"   }, "w", function () awful.util.spawn(cmd.weechat) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x", function ()
        awful.prompt.run({ prompt = "Run Lua code: " },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end),
    
    -- Custom shortcuts.
    awful.key({ modkey,           }, "<", music.previous),
    awful.key({ modkey, "Shift"   }, "<", music.next)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n", function (c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end),
    -- Unminize all windows.
    -- https://bbs.archlinux.org/viewtopic.php?pid=838153#p838153
    -- Needs at least one open and not minimized client.
    awful.key({ modkey, "Shift"   }, "n", function ()
        local t = awful.tag.selected()
        for i = 1, #t:clients() do
            t:clients()[i].minimized = false
            t:clients()[i]:redraw()
        end
    end),
    awful.key({ modkey, "Shift"   }, "m", function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical   = not c.maximized_vertical
    end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
    keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function ()
            local screen = mouse.screen
            if tags[screen][i] then
                awful.tag.viewonly(tags[screen][i])
            end
        end),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function ()
            local screen = mouse.screen
            if tags[screen][i] then
                awful.tag.viewtoggle(tags[screen][i])
            end
        end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
            if client.focus and tags[client.focus.screen][i] then
              awful.client.movetotag(tags[client.focus.screen][i])
            end
        end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function ()
            if client.focus and tags[client.focus.screen][i] then
              awful.client.toggletag(tags[client.focus.screen][i])
            end
        end)
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
      -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule_any = { class = {"MPlayer", "pinetry", "gimp" } },
      properties = { floating = true } },
    --[[{ rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },]]
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
    { rule_any = { class = { "Firefox", "firefox" } },
      properties = { tag = tags[1][2] } },
    { rule = { class = "Firefox", role = "browser" },
      properties = { maximized_horizontal = true, maximized_vertical = true } },
    { rule = { instance = "weechat" },
      properties = { tag = tags[1][5] } },
    { rule = { instance = "ncmpcpp" },
      properties = { tag = tags[1][6] } },
    { rule_any = { class = { "Thunderbird", "thunderbird" } },
      properties = { tag = tags[1][3] } },
    { rule_any = {
      class = { "Thunderbird", "thunderbird" },
      except = { instance = "Mail" } },
      properties = { floating = true } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
