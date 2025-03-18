#!/bin/sh

colors=(
  '0xfffd6883'
  '0xfff9cc6c'
  '0xffadda78'
  '0xff66d9ef'
)
shapes=(
  '󰔶'
  '󰝤'
  ''
)

datetimestamp=$(date '+%Y-%m-%d %H:%M')
datestamp=${datetimestamp:0:10}
timestamp=${datetimestamp:11:5}
hourstamp=$(echo ${datetimestamp:11:2} | sed 's/^0*//')
minutestamp=$(echo ${datetimestamp:14:2} | sed 's/^0*//')

date=(
  icon.drawing=off
  label="$datestamp"
  label.color='0xff72696a'
  padding_right=-5
)

time=(
  icon.drawing=off
  label="$timestamp"
)

hour=(
  icon=${shapes[$(( hourstamp % ${#shapes[@]}))]}
  icon.color=${colors[$(( hourstamp % ${#colors[@]}))]}
  label.drawing=off
)

minute=(
  icon=${shapes[$(( minutestamp % ${#shapes[@]}))]}
  icon.color=${colors[$(( minutestamp % ${#colors[@]}))]}
  label.drawing=off
)

sketchybar  --set clock.date "${date[@]}"     \
            --set clock.time "${time[@]}"     \
            --set clock.hour "${hour[@]}"     \
            --set clock.minute "${minute[@]}" \

