#!/bin/sh

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
numlockx on &
# mpd & mpc
export MPD_HOST="$HOME/.config/mpd/socket"

#~ # dwm
#~ xsetbg -onroot -center "Imágenes/dwm.png" &
#~ xfsettingsd &
#~ nm-applet &
#~ transmission-gtk -m &
#~ pgrep mpd 2>&1 > /dev/null || mpd &
#~ $HOME/.local/bin/weechat-wrapper &
#~ $HOME/.local/bin/ncmpcpp-wrapper &
#~ $HOME/.local/bin/dwmstatus &
#~ exec $HOME/.local/bin/dwm

# awesome
xfsettingsd &
nm-applet &
transmission-gtk -m &
pgrep mpd 2>&1 > /dev/null || mpd &
$HOME/.local/bin/tmux-session-launcher weechat weechat &
$HOME/.local/bin/tmux-session-launcher ncmpcpp ncmpcpp &
exec /usr/bin/awesome
