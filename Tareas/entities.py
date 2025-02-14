from pydantic import BaseModel, Field

# -------------------------------------------------------------- Tareas | clases



class Task(BaseModel):
    '''
    Clase creadora de tareas - propiedades:
        - tag: etiqueta principal 
        - hashtag: etiqueta secundaria
        - content: contenido de la etiqueta
        - status: (predefinido = pendiente) status actual de la tarea
    '''

    tag: str
    hashtag: str
    content: str
    status: str = Field(default="") 

    def __str__(self):
        return f"{self.tag} : {self.hashtag} -> {self.content}  {self.status}"
