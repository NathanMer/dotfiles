#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

/usr/bin/start-pulseaudio-x11
#/usr/bin/xscreensaver -no-splash &
#/home/nathan/.lightsOn/lightsOn.sh 590 &
xcompmgr &
setxkbmap -option compose:ralt
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec i3
