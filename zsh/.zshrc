# Enable Powerlevel10k instant prompt (keep near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load tmux/Nvim workspace helpers
[ -f ~/.tmux/tmux-workspaces.zsh ] && source ~/.tmux/tmux-workspaces.zsh

# Oh My Zsh core setup
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User config

# Custom aliases/macros
source "$HOME/.zsh/macros.zsh"

# Environment
export PATH="$HOME/bin:/opt/nvim:$PATH"
export TERM="xterm-256color"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Optional: Uncomment to adjust behavior
# CASE_SENSITIVE="true"            # Case-sensitive completion
HYPHEN_INSENSITIVE="true"        # Treat - and _ as the same
# ENABLE_CORRECTION="true"         # Command auto-correction
COMPLETION_WAITING_DOTS="true"   # Show dots while completing
# DISABLE_AUTO_TITLE="true"        # Don't set terminal title
# DISABLE_LS_COLORS="true"         # Don't colorize `ls` output
# DISABLE_MAGIC_FUNCTIONS="true"   # Fix for broken paste behavior
# DISABLE_UNTRACKED_FILES_DIRTY="true" # Speed up VCS status
# HIST_STAMPS="yyyy-mm-dd"         # History timestamp format

# Uncomment one of these to change update behavior
# zstyle ':omz:update' mode disabled
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder
# zstyle ':omz:update' frequency 13

export PATH="$HOME/.local/bin:$PATH"
