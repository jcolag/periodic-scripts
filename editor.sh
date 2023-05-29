#!/bin/bash
tempfile=$(mktemp --suffix=.txt)
echo "Time to wake up!" > "$tempfile"
editor=$(mimetype -b "$tempfile" | xargs xdg-mime query default | xargs whereis -b | cut -f2 -d' ')

for file in "$@"
do
  sleep 0.25
  (nohup "$editor" "$file" 2>/dev/null &)
done

rm "${tempfile}" nohup.out

