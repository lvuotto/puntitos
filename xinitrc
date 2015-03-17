#!/bin/sh

runonce() {
    p=$(echo "${1:-}" | cut -c -15)
    [ -n "$p" ] || return
    pgrep -x "$p" 2>&1 > /dev/null || exec "$@"
}

[ -f ~/.env ] && . ~/.env
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
numlockx on
xsetbg "$HOME/Imágenes/dwm-1280x720.png"
xset s 600
$HOME/.scripts/xsidle.sh &

runonce xfsettingsd &
runonce transmission-daemon &
runonce mpd 2> "$HOME/.mpd-log" &

tmux new -d &
$HOME/.scripts/tmux-session-launcher weechat &
$HOME/.scripts/tmux-session-launcher media &
$HOME/.scripts/tmux-session-launcher lv &

pkill dwmstatus
$HOME/.scripts/dwmstatus 2> "$HOME/.dwmstatus-err" &

#~ exec /usr/bin/awesome
exec dwm 2> "$HOME/.dwm-err"
