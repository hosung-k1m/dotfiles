#!/bin/sh

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:15.0"
  icon.padding_right=3
  padding_right=2
  padding_left=2
  label.drawing=on
  label.font="$FONT:Semibold:13.0"
  label.color=$BLACK
  update_freq=120
  updates=on
  background.drawing=off
  icon.y_offset=-2
  label.y_offset=-2
)

sketchybar --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
