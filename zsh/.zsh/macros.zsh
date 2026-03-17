# ~/.zsh/macros.zsh

alias gs='git status'
alias gc='git clone'
alias ll='ls -lah'

alias dt='cd /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d "\r")/Desktop'
alias od='cd /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d "\r")/OneDrive'
alias smerge="/mnt/c/Program\ Files/Sublime\ Merge/sublime_merge.exe"
alias torbrowser='/mnt/c/Users/mrflu/OneDrive/Desktop/Misc/Tor\ Browser/Browser/firefox.exe &'

alias clear-nvim-sessions='rm ~/.local/share/nvim/sessions/*.vim'
alias list-nvim-sessions='ls -lh ~/.local/share/nvim/sessions/*.vim'
alias nvim.='nvim-smart.sh'

