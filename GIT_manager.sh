#! /bin/zsh
# .............................. Gestor Django ............................... 
# lista de selección de los comandos más comunes de Django

# estilos para gum
export GUM_CHOOSE_CURSOR=" "
export GUM_CHOOSE_CURSOR_FOREGROUND="#EA7E55"
export GUM_CHOOSE_HEADER_FOREGROUND="#cbc2b3"
export GUM_CHOOSE_ITEM_FOREGROUND="#cbc2b3""
export GUM_CHOOSE_SELECTED_FOREGROUND="#cbc2b3""



function init(){
    message_commit=$(gum input --placeholder "commit de inicio:")
    repo=$(gum input --placeholder "link de repositorio")

    git init
    git add .
    git commit -m "${message_commit}"
    eval $(ssh-agent -s) 
    ssh-add ~/id_rsa
    eval "git remote add origin ${repo}"
    git branch -M main
    git push -u origin main
}

function update(){
    message_commit=$(gum input --placeholder "commit de inicio:")
    
    eval $(ssh-agent -s) 
    ssh-add ~/id_rsa 
    git add .
    git commit -m "${message_commit}"
    git push
}



declare -A dict
dict[init]=init
dict[status]="git status"
dict[update]=update
dict[salir]="clear"

gum style \
	--foreground '#EA7E55' --border-foreground '#EA7E55' --border double \
	--align center --width 70 --margin "2 1" --padding "0.5 4" \
	"Git Manager" "gestor de repositorio Git y Github 󰊢"

OPCIONES=$(gum choose "init" "status" "update" "salir")



if [[ ${dict[$OPCIONES]} ]]; then
    eval ${dict[$OPCIONES]}
else
    echo "hasta luego ..."
fi
