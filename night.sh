#!/bin/sh
theme='solarized-light'
nlight=false
scheme=prefer-light

if [ "$#" -ge 1 ]
then
  theme='solarized-dark'
  nlight=true
  scheme=prefer-dark
fi

gsettings set org.gnome.gedit.preferences.editor scheme \
  "'${theme}'"
gsettings set org.gnome.settings-daemon.plugins.color \
  night-light-enabled "${nlight}"
sleep 15
gsettings set org.gnome.desktop.interface color-scheme "${scheme}"
sleep 5
gnome-control-center &
sleep 10
pkill --exact gnome-control-c

