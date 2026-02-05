#!/bin/bash
# Change brightness (5% up or down)
pamixer set 2%$1
# Get current brightness percentage
current=$(pamixer get)
max=$(pamixer max)
percent=$((current * 100 / max))
# Send notification
dunstify -h "int:value:$percent" -h "string:x-dunst-stack-tag:volume" "Volume" "$percent%"
