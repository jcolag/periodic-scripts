#!/bin/sh
theme='solarized-light'
nlight=false
scheme=prefer-light
pop=Pop-light
redshift=$(pgrep --exact redshift)

if [ "$#" -ge 1 ]
then
  theme='pop-dark'
  nlight=true
  pop=Pop-dark
  scheme=prefer-dark
fi

# Note that you probably either want Night-light set here OR Redshift toggled
# below, not both.
gsettings set org.gnome.settings-daemon.plugins.color \
  night-light-enabled "${nlight}"
sleep 10
gsettings set org.gnome.desktop.interface color-scheme "${scheme}"
sleep 5
gsettings set org.gnome.desktop.interface gtk-theme "${pop}"
sleep 5
# Note that you probably won't need this on all systems.
gnome-control-center &
sleep 10
pkill --exact gnome-control-c
gsettings set org.gnome.gedit.preferences.editor scheme \
  "'${theme}'"
sleep 5
kill -USR1 "${redshift}"

