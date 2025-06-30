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

# git alias's, most borrowed from the ohmyzsh git plugin
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

