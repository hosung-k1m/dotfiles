#!/bin/bash

calendar=(
    icon.drawing=off
    label.align=right
    padding_left=0
    padding_right=5
    update_freq=30
    label.color=$BLACK
    script="$PLUGIN_DIR/calendar.sh"
    background.drawing=off
    label.shadow.drawing=off
    label.y_offset=-2
)

sketchybar --add item calendar right \
    --set calendar "${calendar[@]}" \
    --subscribe calendar system_woke
