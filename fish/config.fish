source /usr/share/cachyos-fish-config/cachyos-config.fish
# Moje aliasy
alias v='nvim'
alias c='clear'
alias conf='cd ~/.config'
alias hypr='nvim ~/.config/hypr/hyprland.conf'
alias waybar-reload='pkill waybar && waybar &'
alias cat='bat'

# Skrót do aktualizacji wszystkiego łącznie z AUR
alias upall='paru -Syu'

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
