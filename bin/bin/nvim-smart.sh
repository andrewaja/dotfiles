#!/bin/bash

# Get CWD
cwd=$(pwd)

# Encode slashes to match auto-session naming
session_name=$(echo "$cwd" | sed 's/\//%2F/g')
session_file="$HOME/.local/share/nvim/sessions/${session_name}.vim"

clear

if [ -f "$session_file" ]; then
    echo "Session found for $cwd"
    nvim "$@"
else
    echo "No session found, opening nvim-tree"
    nvim .
fi

