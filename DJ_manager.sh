#! /bin/zsh
# .............................. Gestor Django ............................... 
# lista de selección de los comandos más comunes de Django

# estilos para gum
export GUM_CHOOSE_CURSOR=" "
export GUM_CHOOSE_CURSOR_FOREGROUND="#41B7AB"
export GUM_CHOOSE_HEADER_FOREGROUND="#7a8b79"
export GUM_CHOOSE_ITEM_FOREGROUND="#7a8b79"
export GUM_CHOOSE_SELECTED_FOREGROUND="#7a8b79"



function enviroment(){
    python -m virtualenv venv
    entorno
    pip install Django
}

function startproject(){
    proyecto=$(gum input --placeholder "nombre del proyecto =>" )
    django-admin startproject ${proyecto}
}

function startapp(){
    app=$(gum input --placeholder "nombre de la app =>")
    python manage.py startapp ${app}
}


# diccionario de opciones
declare -A dict
dict[enviroment]=enviroment
dict[startproject]=startproject
dict[runserver]="python manage.py runserver"
dict[startapp]=startapp
dict[makemigrations]="python manage.py makemigrations"
dict[migrate]="python manage.py migrate"
dict[createsuperuser]="python manage.py createsuperuser"
dict[shell]="python manage.py shell"
dict[collectstatic]="python manage.py collectstatic"
dict[salir]="clear"


# .................................... ejecución de script 

gum style \
	--foreground '#41B7AB' --border-foreground '#41B7AB' --border double \
	--align center --width 70 --margin "2 1" --padding "0.5 4" \
	"Django Manager" "gestor de proyectos Django "

OPCIONES=$(gum choose "enviroment" "startproject" "runserver" "startapp" "makemigrations" "migrate"  "createsuperuser" "shell" "collectstatic" "salir")



if [[ ${dict[$OPCIONES]} ]]; then
    eval ${dict[$OPCIONES]}
else
    echo "hasta luego ..."
fi
