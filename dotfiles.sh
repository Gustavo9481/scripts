#! /bin/zsh

function update_repo() {
    eval $(ssh-agent -s)
    ssh-add ~/id_rsa
    git add .
    git commit -m "$(date "+%d-%m-%Y %H:%M:%S")"
    git push
}

# rutas de archivos de configuración

# wezterm -> terminal
cp ~/.wezterm.lua ~/Dotfiles/
# i3 gaps -> window manager
cp -r ~/.config/i3/ ~/Dotfiles/
# picom -> gestor de transparencias
cp -r ~/.config/picom/ ~/Dotfiles/
# nvim -> lazyvim
cp -r ~/.config/nvim/ ~/Dotfiles/
# zsh -> shell
cp ~/.zshrc ~/Dotfiles/
# starship -> prompt personalizado
cp ~/.config/starship.toml ~/Dotfiles/
# polybar -> barra de estado
cp -r ~/.config/polybar/ ~/Dotfiles/

sleep 3

echo "Archivos copiados a Dotfiles"

sleep 3

update_repo

echo "Backup realizado"
