#! /bin/zsh

# .................................. TASK's .................................. 
# Tareas generales y sencillas automatizadas

# estilos para gum
export GUM_CHOOSE_CURSOR=" "
export GUM_CHOOSE_CURSOR_FOREGROUND="#9dff00"
export GUM_CHOOSE_HEADER_FOREGROUND="#a7c796"
export GUM_CHOOSE_ITEM_FOREGROUND="#a7c796"
export GUM_CHOOSE_SELECTED_FOREGROUND="#a7c796"



function seleccionar_proyecto(){
    # Da una lista de los proyectos y dirige hacia el seleccionado
    PROYECTO=$(proyectos | gum choose)
    cd /home/guscode/Code/Proyectos/${PROYECTO}
}


declare -A dict_plantillas
dict_plantillas[󰌝__html]="html_template.html"
dict_plantillas[__css]="css_template.css"
dict_plantillas[󰝴__jinja]="jinja_template.html"
dict_plantillas[󰝴__base_jinja]="base_jinja_template.html"
dict_plantillas[󰍔__md]="md_template.md"
dict_plantillas[󰡨__docker]="docker_template.txt"

function plantilla(){
    # Copia plantillas a nuevos archivos
    PLANTILLA=$(gum choose "󰌝__html" "__css" "󰝴__jinja" "󰝴__base_jinja" "󰍔__md" "󰡨__docker")
    NEW_FILE=$(gum input --placeholder="nombre de nuevo archivo .>")

    if [[ ${dict_plantillas[$PLANTILLA]} ]]; then
        cp /home/guscode/Plantillas/${dict_plantillas[$PLANTILLA]} ${NEW_FILE}
        echo "Se creó la plantilla ${NEW_FILE}"
    else
        echo "No se pudo crear la plantilla ..."
    fi
    
}

function permisos(){
    # Da permisos al archivo indicado
    FILE=$(gum file --all)
    chmod +x ${FILE}
    echo "Se han otorgado permisos de ejecución al archivo ${FILE}"
}

function ejecutar_java(){
    # Compila y ejecuta la clase o archivo de java indicado
    JAVA_FILE=$(gum input --placeholder="nombre de clase java sin terminación .>")
    javac ${JAVA_FILE}.java
    java ${JAVA_FILE}
    echo "La clase ${JAVA_FILE} ha sido ejecutada"
}

function ejecutar_chromium(){
    # ejecuta en chromium el archivo indicado
    FILE=$(gum file --all)
    chromium --new-tab ${FILE} &
}

function ejecutar_firefox(){
    # ejecuta en firefox el archivo indicado
    FILE=$(gum file --all)
    firefox-developer-edition --new-tab ${FILE} &
}

function estructura_web(){
    mkdir -p static/css/fonts static/img/logos static/js
    touch  notas.md
    echo "Creada estructura básica de carpetas"
}

function ejecutar_postgres(){
    chromium --new-tab http://127.0.0.1:5050/ &
    source pgadmin4/bin/activate
    pgadmin4 &
    xdotool search --onlyvisible --class chromium windowactivate --sync && xdotool key F5
    }

function ejecutar_mysql(){
    chromium --new-tab http://localhost/phpmyadmin/ &
    echo "Abriendo en chromium"
}



# .................................... ejecución de script 

declare -A dict_opciones
dict_opciones[Seleccionar_Proyecto]=seleccionar_proyecto
dict_opciones[Nueva_Plantilla]=plantilla
dict_opciones[Permisos_Ejecución]=permisos
dict_opciones[Ejecutar_Chromium]=ejecutar_chromium
dict_opciones[Ejecutar_Firefox]=ejecutar_firefox
dict_opciones[Ejecutar_JAVA]=ejecutar_java
dict_opciones[Servidor_NGROK]="ngrok http 8000"
dict_opciones[Estructura_Web]=estructura_web
dict_opciones[PostgresSQL]=ejecutar_postgres
dict_opciones[MySQL]=ejecutar_mysql
dict_opciones[salir]="clear"


gum style \
	--foreground '#9dff00' --border-foreground '#9dff00' --border double \
	--align center --width 70 --margin "2 1" --padding "0.5 4" \
	"TASK's" "tareas rápidas 󰚩"

OPCIONES=$(gum choose "Seleccionar_Proyecto" "Nueva_Plantilla" \
    "Permisos_Ejecución" "Servidor_NGROK" "Ejecutar_JAVA" \
    "Ejecutar_Chromium" "Ejecutar_Firefox" "Estructura_Web" \
    "PostgresSQL" "MySQL" "salir" --height=15)   

if [[ ${dict_opciones[$OPCIONES]} ]]; then
    eval ${dict_opciones[$OPCIONES]}
else
    echo "hasta luego ..."
fi
