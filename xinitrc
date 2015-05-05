#!/bin/sh

runonce() {
    p=$(echo "${1:-}" | cut -c -15)
    [ -n "$p" ] || return
    pgrep -x "$p" 2>&1 > /dev/null || exec "$@"
}

# Common.
[ -f ~/.env ] && . ~/.env
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Keyboard.
setxkbmap "us(intl)"
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
numlockx on

# Look & feel.
xsetbg "${HOME}/Imágenes/dwm-1280x720.png"
xset s 600
~/.scripts/xsidle.sh slock &

# Daemons.
runonce xfsettingsd &
runonce transmission-daemon &
runonce mpd 2> "${HOME}/.mpd-err" &

# Tmux sessions.
runonce tmux new -d &
~/.scripts/tmux-session-launcher weechat &
~/.scripts/tmux-session-launcher media &
~/.scripts/tmux-session-launcher lv &

# dwm status bar.
pkill dwmstatus
~/.scripts/dwmstatus 2> "${HOME}/.dwmstatus-err" &

# Dwm
exec ~/.local/bin/dwm 2> "${HOME}/.dwm-err"
