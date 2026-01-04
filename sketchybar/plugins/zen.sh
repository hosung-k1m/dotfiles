#!/bin/bash

zen_on() {
  sketchybar --set calendar drawing=off \
             --set volume_icon drawing=off \
             --set volume drawing=off
}

zen_off() {
  sketchybar --set calendar drawing=on \
             --set volume_icon drawing=on \
             --set volume drawing=on
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query calendar | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi