#  This file contains all my custom aliases

# Enable color output for ls and grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Some extras I use
alias neofetch='fastfetch'
alias refresh='source ~/.zshrc'
alias zshedit='nvim ~/.config/zsh/zshrc'
alias update='sudo pacman -Syu;flatpak update'
alias shutdown=poweroff
alias resetbar='pkill waybar && hyprctl dispatch exec waybar'

# Runs matlab on my local install
alias matlab='QT_QPA_PLATFORM=xcb /home/Pidguit/matlab/bin/matlab -nodesktop'

# git alias's, most are the same as the ohmyzsh git plugin
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gst='git status'
alias gp='git push'
alias grs='git restore'
alias grev='git revert'
alias gre='git reset'

# tmux alias's, most are the same as the ohmyzsh tmux plugin
alias ts='tmux new-session -s'
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tl='tmux ls'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'

