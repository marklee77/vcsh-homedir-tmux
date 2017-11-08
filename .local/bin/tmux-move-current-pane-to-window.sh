#!/bin/bash
target_window="$1"

join_pain="$(tmux list-panes -F '#{pane_id}' -t ":${target_window}" 2>/dev/null | tail -1)"
if [ -n "${join_pain}" ]; then
    tmux join-pane -h -t "${join_pain}" 2>/dev/null
    exit 0
fi

source_window="$(tmux break-pane -P -F '#{window_id}')"
if [ -n "${source_window}" ]; then
   tmux move-window -s "${source_window}" -t ":${target_window}" 2>/dev/null
   exit 0
fi

tmux move-window -t ":${target_window}" 2>/dev/null
exit 0
