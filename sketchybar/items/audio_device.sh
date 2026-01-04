#!/bin/sh

audio_device=(
  script="$PLUGIN_DIR/audio_device.sh"
  padding_left=5
  padding_right=0
  icon.font="$FONT:Regular:14.0"
  icon.color=$BLACK
  icon.width=20
  label.drawing=off
  background.drawing=off
  icon.y_offset=-2.6
  update_freq=3
  updates=on
)

sketchybar --add item audio_device right \
           --set audio_device "${audio_device[@]}" \
           --subscribe audio_device volume_change system_woke

