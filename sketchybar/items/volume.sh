#!/bin/sh

volume_icon=(
  script="$PLUGIN_DIR/volume.sh"
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=10
  padding_right=0
  icon.font="$FONT:Regular:14.0"
  icon.color=$BLACK
  icon.width=25
  label.drawing=off
  background.drawing=off
  icon.y_offset=-2.6
)

sketchybar --add item volume_icon right \
           --set volume_icon "${volume_icon[@]}" \
           --subscribe volume_icon volume_change
