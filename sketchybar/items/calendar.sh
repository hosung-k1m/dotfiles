#!/bin/bash

calendar=(
    icon=􀐫
    icon.font="$FONT:Black:12.0"
    icon.padding_right=0
    label.align=right
    padding_left=15
    update_freq=30
    icon.color=$BLACK
    label.color=$BLACK
    script="$PLUGIN_DIR/calendar.sh"
    click_script="$PLUGIN_DIR/zen.sh"
    background.drawing=off
    icon.y_offset=-1
    label.y_offset=-1
)

sketchybar --add item calendar right \
    --set calendar "${calendar[@]}" \
    --subscribe calendar system_woke
