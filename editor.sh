#!/bin/sh
tempfile=$(mktemp --suffix=.txt)
echo "Time to wake up!" > "$tempfile"
handler=$(mimetype -b "$tempfile" | xargs xdg-mime query default)
editor=

if echo "$handler" | grep -q ".desktop$" > /dev/null
then
  editor=$(grep -w Exec "/usr/share/applications/$handler" | head -1 | cut -f2 -d'=' | cut -f1 -d' ' | xargs whereis -b | cut -f2 -d' ')
else
  editor=$(whereis -b "$handler" | cut -f2 -d' ')
fi

for file in "$@"
do
  sleep 0.25
  (nohup "$editor" "$file" 2>/dev/null &)
done

rm "${tempfile}" nohup.out

