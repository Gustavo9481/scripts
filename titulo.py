# ------------------------------------------- GUScode | titulos personalizados 󰌠

def imprimir(lenguaje, titulo):


    opciones = {
        "py":["# ", 78, 58, 76, "󰌠"],
        "html":["<!-- ", 71, 51, 69, " -->"],
        "css":["/* ", 74, 54, 72,"󰌜 */"],
        "rs":["// ", 77, 57, 75, "󱘗"],
        "js":["// ", 77, 57, 75, ""],
        "bs":["# ", 78, 58, 76, ""],
        "txt":["..", 78, 58, 76, "🖿"]
    }

    

    if lenguaje in opciones:
        caracter = opciones[lenguaje][0]
        longitud = opciones[lenguaje][1]
        subtitulo = opciones[lenguaje][2]
        centrado = opciones[lenguaje][3]
        icono = opciones[lenguaje][4]
        
        print("\ncentrado")
        print(f"{caracter}{' ' + titulo + ' ':.^{centrado}} {icono}")

        if lenguaje == "html": 
                    
            print("\ntitulo")
            print(f"{caracter}{' ' + titulo:->{longitud}} -->")
        
            print("\nsubtitulo")
            print(f"{caracter}{' ' + titulo:.>{subtitulo}} -->")
        
            print("\nnota")
            print(f"{caracter}🠶 {titulo} -->")
        
        elif lenguaje == "css":

            print("\ntitulo")
            print(f"{caracter}{' ' + titulo:->{longitud}} */")
        
            print("\nsubtitulo")
            print(f"{caracter}{' ' + titulo:.>{subtitulo}} */")
        
            print("\nnota")
            print(f"{caracter}🠶 {titulo} */")

        
        else:
        
            print("\ntitulo")
            print(f"{caracter}{' ' + titulo:->{longitud}}")
        
            print("\nsubtitulo")
            print(f"{caracter}{' ' + titulo:.>{subtitulo}}")
        
            print("\nnota")
            print(f"{caracter}🠶 {titulo}")

    else:
        print("lenguaje errado")




lenguaje = input("lengaje: ")
titulo = input("titulo: ")

imprimir(lenguaje, titulo)
print("*" * 80)

