#!/usr/bin/env bash

DISPLAY_NUM="${DISPLAY_NUM:-:1}"
RESOLUTION="${RESOLUTION:-1024x768}"

Xephyr -br -ac -noreset -screen "${RESOLUTION}" "${DISPLAY_NUM}" &
XEPHYR_PID=$!

sleep 1

env -u WAYLAND_DISPLAY \
    -u XDG_RUNTIME_DIR \
    DISPLAY="${DISPLAY_NUM}" \
    dbus-run-session -- "$@"

kill "$XEPHYR_PID" 2>/dev/null

