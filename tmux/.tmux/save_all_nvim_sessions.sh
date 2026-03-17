#!/bin/bash

# If inside tmux, use the current session
if [ -n "$TMUX" ]; then
    sessions=$(tmux display-message -p '#S')
else
    # If outside tmux, fallback to all active sessions
    sessions=$(tmux list-sessions -F '#S')
fi

for session in $sessions; do
    echo "Checking session: $session"

    # For each pane in the session
    tmux list-panes -t "$session" -F '#{pane_id} #{pane_current_command}' 2>/dev/null | while read -r pane cmd; do
        # Only target panes running nvim
        if [[ "$cmd" == "nvim" ]]; then
            echo "Saving Neovim session in $pane (session: $session)"
            # Send Escape first in case user is in insert mode
            # Run :wa and then :SessionSave
            tmux send-keys -t "$pane" Escape ':wa | echo "Wrote all buffers..." | SessionSave' Enter
        fi
    done
done
