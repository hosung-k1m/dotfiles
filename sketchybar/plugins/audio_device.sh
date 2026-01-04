#!/bin/bash

AUDIO_DEVICE=$(SwitchAudioSource -c 2>/dev/null)

if [ -z "$AUDIO_DEVICE" ]; then
  sketchybar --set "$NAME" icon="" drawing=off
  exit 0
fi

if [[ "$AUDIO_DEVICE" =~ "MacBook" ]] || [[ "$AUDIO_DEVICE" =~ "Built-in" ]] || [[ "$AUDIO_DEVICE" =~ "Internal" ]] || [[ "$AUDIO_DEVICE" =~ "Speakers" ]]; then
  sketchybar --set "$NAME" icon="" drawing=off
else
  sketchybar --set "$NAME" icon="􀪷" drawing=on
fi

