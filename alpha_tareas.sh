#! /bin/zsh

# .......................... Lista de Tareas | CLI ........................... 
# Lista de tareas sencila para gestionar desde terminal 



# -------------------------------------------------------------------- funciones
# función príncipal - renderiza lista de tareas actualizada
function main(){

    TAREA=$(cat /home/guscode/scripts/tareas.txt | gum choose --height=30)

    echo -e "tarea seleccionada: ${turquoise}${TAREA}"

    OPCION=$(gum choose "nueva" "completar" "desmarcar" "eliminar" "salir")

    # diccionario de opciones
    declare -A dict
    dict[nueva]=nueva_tarea
    dict[completar]=completar_tarea
    dict[desmarcar]=desmarcar_tarea
    dict[eliminar]=eliminar_tarea


    if [[ ${dict[$OPCION]} ]]; then
        eval ${dict[$OPCION]}
    else
        echo "hasta luego ..."
    fi

}



# Marcar tarea como completada
function completar_tarea(){

    TAREA_COMPLETA=$(echo "$TAREA" | sed 's/^\\s*//')
    echo "${TAREA_COMPLETA}"
    awk -v tarea="${TAREA_COMPLETA}" \
    'index($0, tarea) {
        gsub(/\/, "", $0)
    }
    {
        print
    }' /home/guscode/scripts/tareas.txt > /home/guscode/scripts/tareas_tmp.txt && mv /home/guscode/scripts/tareas_tmp.txt /home/guscode/scripts/tareas.txt
 
    main
}



# Desmarcar tarea para colocar pendiente
function desmarcar_tarea() {

    TAREA_COMPLETA_PENDIENTE=$(echo "$TAREA"| sed 's/^\\s*//')
    echo "${TAREA_COMPLETA_PENDIENTE}"
    awk -v tarea="${TAREA_COMPLETA_PENDIENTE}" \
    'index($0, tarea) {
        gsub(/\/, "", $0)
    }
    {
        print
    }' /home/guscode/scripts/tareas.txt > /home/guscode/scripts/tareas_tmp.txt && mv /home/guscode/scripts/tareas_tmp.txt /home/guscode/scripts/tareas.txt

    main
}



# Crear una nueva tarea
function nueva_tarea(){
    etiqueta=$(gum input --placeholder "etiqueta" )
    descripcion=$(gum input --placeholder "descripción de la tarea")
    formato="%-15s| %s\n"

    # Formatear la cadena y la etiqueta
    TAREA_NEW=$(printf "$formato" "$etiqueta" "$descripcion")

    # Guardar el mensaje en un archivo
    echo " ${TAREA_NEW}" >> /home/guscode/scripts/tareas.txt
    
    main
}



# Eliminar una tarea completada o pendiente
function eliminar_tarea(){
    TAREA_ELIMINAR=$(echo "$TAREA" | sed 's/\[.\]//g')
    echo "tarea a eliminar: ${TAREA_ELIMINAR}"
    sed -i "/${TAREA_ELIMINAR}/d" /home/guscode/scripts/tareas.txt
    
    main
}



# ---------------------------------------------- variables globales y de entorno

export GUM_CHOOSE_CURSOR=" "
export GUM_CHOOSE_CURSOR_FOREGROUND="#9dff00"
export GUM_CHOOSE_HEADER_FOREGROUND="#40e0d0"
export GUM_CHOOSE_ITEM_FOREGROUND="#40e0d0"
export GUM_CHOOSE_SELECTED_FOREGROUND="#40e0d0"
turquoise="\e[0;36m\033[1m"
blanco="\033[0m\e[0m"

echo -e "\n${turquoise}------------------------------ GUScode | lista de tareas $"

main

