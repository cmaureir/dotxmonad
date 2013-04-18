Section "InputClass"
    Identifier "Keyboard Defaults"
    MatchIsKeyboard "yes"
    Option  "XkbLayout" "us"
    Option  "XkbVariant" "altgr-intl"
EndSection

# cursor
xsetroot -cursor_name left_ptr

# Wallpaper
feh --bg-scale /home/cmaureir/img/wallpaper-2589548.jpg &

# Keyboard layout
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl &

# Trayer, for systray icons
exec trayer --edge top --align right --widthtype pixel --width 100 --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x000000 --expand true --heighttype pixel --height 16 &

# NetworkManager applet
(/usr/bin/nm-applet --sm-disable) &

exec xmonad
