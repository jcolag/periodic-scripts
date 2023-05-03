#!/bin/sh
path=$(jq -r .journal.location config.json)
weekday=$(date +%w)
journal="${path}$(date +%Y-%m-%d).md"

# Create the day's journal entry and load into a text editor.
tempfile=$(mktemp --suffix=.txt)
echo "Time to go!" > "$tempfile"
editor=$(mimetype -b "$tempfile" | xargs xdg-mime query default | xargs whereis -b | cut -f2 -d':')

if [ -z $editor ]
then
  editorkey=$(mimetype -b "$tempfile" | xargs xdg-mime query default)
  editor=$(grep 'Exec=' "/usr/share/applications/${editorkey}" | head -1 | cut -f2 -d'=' | cut -f1 -d' ' | xargs which)
fi

cat > "$journal" <<HERE
How was today?  😦😐😊

HERE

if [ $weekday -eq 0 ]
then
  cat >> "$journal" <<HERE
Identify three (3) people in your life---past or present---to be grateful to.  Be sure to include the reason.

1.  
2.  
3.  

HERE
elif [ $weekday -eq 1 ]
then
  cat >> "$journal" <<HERE
Here's part-one of the weekly wellbeing check-in from <mhfaengland.org>.

* How do I feel this week?
 * Mentally:
 * Physically:
* Am I drinking enough water and eating a balanced diet?
* How did I sleep last night?
* Did I feel rested when I woke up?
* Is there anything I can improve?

HERE
elif [ $weekday -eq 2 ]
then
  cat >> "$journal" <<HERE
Here's part-two of the weekly wellbeing check-in from <mhfaengland.org>.

* How are my thoughts making me feel?
* Am I having unhelpful thoughts?
* How full is my stress container?
* Am I using successful coping strategies, such as exercise, fun, novelty, sharing, and focusing?
* Are they working?

HERE
elif [ $weekday -eq 4 ]
then
  cat >> "$journal" <<HERE
Identify a happy memory of the week:  

HERE
elif [ $weekday -eq 5 ]
then
  cat >> "$journal" <<HERE
Identify something that you are looking forward to:  

HERE
else
  echo "" >> "$journal"
fi

cat >> "$journal" <<HERE
# Early

This morning, I...

 * 

And I came downstairs at 

# Watched

In approximately the following order, I watched some things.  I only talk about renewal for television episodes that are (or at least seem to be) season finales.

|Title|Service|Gut|Reaction|Renew?|
|-----|-------|---|--------|------|
|****||🤮😡👎🥱🫤👌😊👍💖✊||👎🫤👍|
|****||🤮😡👎🥱🫤👌😊👍💖✊||👎🫤👍|
|****||🤮😡👎🥱🫤👌😊👍💖✊||👎🫤👍|
|****||🤮😡👎🥱🫤👌😊👍💖✊||👎🫤👍|

# Food

 * Breakfast:  
 * Dinner:  

# Remainder of Day

For the rest of the day, I...

 * 

# Miscellaneous



HERE

nohup "$editor" "$journal"
rm "${tempfile}" "nohup.out"

