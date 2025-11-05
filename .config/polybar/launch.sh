#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Detect CPU temperature hwmon path
HWMON_PATH=$(for d in /sys/class/hwmon/hwmon*/; do
  if [[ $(<"$d/name") == "k10temp" ]]; then
    echo "$d/temp1_input"
  fi
done)

# Launch polybar
HWMON_PATH="$HWMON_PATH" polybar mybar &
