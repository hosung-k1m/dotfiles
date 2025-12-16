#!/bin/sh

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$BLUE
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=􀀁
  slider.knob.drawing=on
  label.y_offset=-2
  slider.y_offset=-2
  icon.y_offset=-2
)


volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=10
  icon.drawing=off
  label.width=25
  label.align=left
  label.color=$BLACK
  label.font="$FONT:Regular:14.0"
  background.drawing=off
  icon.y_offset=-2
  label.y_offset=-2
)

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"

sketchybar --add bracket status brew github.bell wifi volume_icon \
           --set status "${status_bracket[@]}"

