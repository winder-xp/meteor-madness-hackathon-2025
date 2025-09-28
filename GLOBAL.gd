extends Node

# Su contenido se actualiza cuando el usuario selecciona en la escena de correo_mitiga ion
var selections: Dictionary = {} 
# Datos de los asteroides, las claves son sus nombres y el orden es: NOMBRE, MASA, DIAMETRO, DENSIDAD, COMPOSICIÓN, DESCRIPCIÓN, AÑOS, DIAS MESES [IMPACTO], RESPUESTA CORRECTA
var datos_asteroides: Dictionary = {'Itokawa': ['Itokawa',3.15e10,0.33,1.9e3,'silicates and rock-forming minerals such as olivine and pyroxene','porus and therefore easily fragmenting material',7,2,3,'the kinetic impactor'], 'Bennu': ['Bennu',7.33e10,0.48,1.19e3,'hydrated materials and organic compounds that easily reacts with other molecules, mainly carbonaceous','porus and heterogeneous material',15,6,27,'the gravity tractor']}
