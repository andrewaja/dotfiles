# Save the current tmux environment to a named snapshot
save_tmux_workspace() {
  local name="$1"
  local resurrect_dir="$HOME/.tmux/resurrect"
  local script="$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh"
  mkdir -p "$resurrect_dir"

  # If no name provided, default to current tmux session name
  if [ -z "$name" ]; then
    if [ -n "$TMUX" ]; then
      name=$(tmux display-message -p '#S')
    else
      echo "Not inside a tmux session and no name was provided."
      return 1
    fi
  fi

  # Trigger tmux-resurrect save
  tmux run-shell "$script"
  sleep 1  # Give it a moment to write files

  if [ -f "$resurrect_dir/last" ]; then
    cp "$resurrect_dir/last" "$resurrect_dir/${name}.snapshot"
    echo "Saved workspace as '$name.snapshot'"
  else
    echo "Error: tmux-resurrect did not generate a snapshot."
    return 1
  fi

  # Save matching pane_contents
  if [ -f "$resurrect_dir/pane_contents.tar.gz" ]; then
    cp "$resurrect_dir/pane_contents.tar.gz" "$resurrect_dir/${name}.panes.tar.gz"
    echo "Saved pane contents as '${name}.panes.tar.gz'"
  fi
}

# Prompt & save (calls save)
prompt_and_save_workspace() {
  local skip="$1"

  if [ "$skip" = "skip" ]; then
    echo "Skipping workspace save."
    return
  fi

  if [ -n "$ZSH_VERSION" ]; then
    printf "Save tmux workspace as (leave empty to use session name): "
    read name
  else
    read -rp "Save tmux workspace as (leave empty to use session name): " name
  fi

  save_tmux_workspace "$name"
}

# Load a named tmux environment
load_tmux_workspace() {
  local name="$1"
  local resurrect_dir="$HOME/.tmux/resurrect"
  local snapshot="$resurrect_dir/${name}.snapshot"
  local panes="$resurrect_dir/${name}.panes.tar.gz"
  local script="$HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh"

  if [ -z "$name" ]; then
    echo "usage: load_tmux_workspace <name>"
    return 1
  fi

  if [ ! -f "$snapshot" ]; then
    echo "No saved workspace named '$name' found."
    return 1
  fi

  cp "$snapshot" "$resurrect_dir/last"
  echo "Restoring workspace '$name'..."

  # Restore matching pane contents if available
  if [ -f "$panes" ]; then
    cp "$panes" "$resurrect_dir/pane_contents.tar.gz"
    echo "Restored pane contents from '${name}.panes.tar.gz'"
  fi

  tmux run-shell "$script"
}

# List all saved workspaces
list_tmux_workspaces() {
  local resurrect_dir="$HOME/.tmux/resurrect"

  if [ ! -d "$resurrect_dir" ]; then
    echo "No tmux-resurrect directory found."
    return 1
  fi

  local snapshots=("$resurrect_dir"/*.snapshot)

  if [ ${#snapshots[@]} -eq 0 ]; then
    echo "No saved tmux workspaces found."
    return 0
  fi

  echo "Saved tmux workspaces:"
  for snap in "${snapshots[@]}"; do
    basename "$snap" .snapshot
  done
}

# Delete a saved workspace
delete_tmux_workspace() {
  local name="$1"
  local resurrect_dir="$HOME/.tmux/resurrect"
  local snapshot="$resurrect_dir/${name}.snapshot"
  local panes="$resurrect_dir/${name}.panes.tar.gz"

  if [ -z "$name" ]; then
    echo "Usage: delete_tmux_workspace <name>"
    return 1
  fi

  if [ ! -f "$snapshot" ]; then
    echo "No saved workspace named '$name' found."
    return 1
  fi

  rm "$snapshot"
  echo "Deleted tmux workspace '$name.snapshot'."

  if [ -f "$panes" ]; then
    rm "$panes"
    echo "Deleted pane contents '$name.panes.tar.gz'."
  fi
}

# Kill session
tmux-kill-session() {
  local session_name="$1"
  local skip_save="$2"

  # If no session name, and we're inside tmux, use current session
  if [ -z "$session_name" ]; then
    if [ -n "$TMUX" ]; then
      session_name=$(tmux display-message -p '#S')
    else
      echo "Session name required when not inside tmux."
      return 1
    fi
  fi

  # Support calling with ! as first arg (e.g. tmux-kill-session !)
  if [ "$session_name" = "!" ]; then
    skip_save="skip"
    session_name=$(tmux display-message -p '#S')
  fi

  # Support calling with ! as second arg (e.g. tmux-kill-session mysession !)
  if [ "$skip_save" = "!" ]; then
    skip_save="skip"
  fi

  # Save session unless skip is requested
  prompt_and_save_workspace "$skip_save"
  ~/.tmux/save_all_nvim_sessions.sh

  echo "Killing tmux session: $session_name"
  tmux kill-session -t "$session_name"
}

# Kill server
tmux-kill-server() {
    if [[ "$1" == "!" ]]; then
        skip="skip"
    fi
    prompt_and_save_workspace "$skip"
    ~/.tmux/save_all_nvim_sessions.sh
    tmux kill-server
}

# Detach from session
tmux-detach() {
    if [[ "$1" == "!" ]]; then
        skip="skip"
    fi
    prompt_and_save_workspace "$skip"
    ~/.tmux/save_all_nvim_sessions.sh
    tmux detach
}

# Tab complete for saving/loading workspaces
_tmux_workspace_completions() {
    local snaps=(${(f)"$(list_tmux_workspaces | tail -n +2)"})
    _describe 'tmux workspace' snaps
}
compdef _tmux_workspace_completions load_tmux_workspace
compdef _tmux_workspace_completions save_tmux_workspace
