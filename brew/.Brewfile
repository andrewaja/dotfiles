# Homebrew packages for a macOS machine. Stowed to ~/.Brewfile (the
# `brew bundle --global` location) and installed by
# script/install-deps-macos. Add to this file rather than to the script.
#
#   brew bundle --global            install anything missing
#   brew bundle check --global      is everything installed?
#   brew bundle cleanup --global    list what's installed but not in here
#
# The Nerd Font cask is intentionally NOT here: script/install-nerd-font
# owns it so the font name lives in one place across all OSes.

# ---- dotfiles ----
brew "stow"
brew "tmux"
brew "ripgrep"
brew "fd"
brew "neovim"

# ---- ~/research tooling ----
brew "poppler"     # pdftotext / pdfinfo for the heilmeier-extractor skill
brew "yq"          # proxmox-mgmt runbooks
brew "python"      # modern python3; system one is 3.9 with no PyYAML
