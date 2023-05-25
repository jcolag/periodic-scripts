#!/bin/bash
tempfile=$(mktemp --suffix=.txt)
echo "Time to wake up!" > "$tempfile"
editor=$(mimetype -b "$tempfile" | xargs xdg-mime query default | xargs whereis -b | cut -f2 -d' ')
editor=/usr/bin/gedit
(nohup "$editor" ~/Workshop/MailingList/$(date +"%Y-%m").md 2>/dev/null &)
sleep 0.25
(nohup "$editor" "/home/john/Dropbox/journal/$(date +%Y-%m-%d).md" 2>/dev/null &)
rm "${tempfile}"

