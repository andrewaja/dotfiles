# Enable Powerlevel10k instant prompt (keep near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Keep PATH entries unique
typeset -U path PATH

# Core environment
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export NVM_DIR="$HOME/.nvm"

# Add personal/system paths once
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  /opt/nvim/bin
  $path
)
export PATH

# Load tmux/Nvim workspace helpers
[ -f "$HOME/.tmux/tmux-workspaces.zsh" ] && source "$HOME/.tmux/tmux-workspaces.zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k config
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Custom aliases/macros
[ -f "$HOME/.zsh/macros.zsh" ] && source "$HOME/.zsh/macros.zsh"

# Node Version Manager
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Optional behavior
# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_AUTO_TITLE="true"
# DISABLE_LS_COLORS="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="yyyy-mm-dd"

# Oh My Zsh update behavior
# zstyle ':omz:update' mode disabled
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder
# zstyle ':omz:update' frequency 13
