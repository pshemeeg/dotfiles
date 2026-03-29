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
fish_add_path ~/.cargo/bin

function dotfiles-sync
    cp ~/.config/hypr/hyprland.conf ~/dotfiles/hypr/
    cp ~/.config/hypr/hyprpaper.conf ~/dotfiles/hypr/
    cp ~/.config/hypr/hyprlock.conf ~/dotfiles/hypr/
    cp ~/.config/hypr/hypridle.conf ~/dotfiles/hypr/
    cp ~/.config/waybar/config.jsonc ~/dotfiles/waybar/
    cp ~/.config/waybar/style.css ~/dotfiles/waybar/
    cp ~/.config/waybar/power_menu.sh ~/dotfiles/waybar/
    cp ~/.config/kitty/kitty.conf ~/dotfiles/kitty/
    cp ~/.config/dunst/dunstrc ~/dotfiles/dunst/
    cp ~/.config/fish/config.fish ~/dotfiles/fish/
    cp ~/.config/nvim/init.lua ~/dotfiles/nvim/
    cp ~/.config/nvim/lua/config/options.lua ~/dotfiles/nvim/lua/config/
    cp ~/.config/nvim/lua/config/keymaps.lua ~/dotfiles/nvim/lua/config/
    cp ~/.config/nvim/lua/config/lazy.lua ~/dotfiles/nvim/lua/config/
    cp ~/.config/tmux/tmux.conf ~/dotfiles/tmux/
    cd ~/dotfiles
    git add .
    git commit -m "sync: $(date '+%Y-%m-%d %H:%M')"
    git push
    cd -
end
