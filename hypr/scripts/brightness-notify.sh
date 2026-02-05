#!/bin/bash
# Change brightness (5% up or down)
brightnessctl set 5%$1
# Get current brightness percentage
current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current * 100 / max))
# Send notification
dunstify -h "int:value:$percent" -h "string:x-dunst-stack-tag:brightness" "Brightness" "$percent%"
