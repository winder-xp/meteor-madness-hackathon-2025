extends Node

# Variables que quiero utilizar en varias escenas
var selections: Dictionary = {} 
# Datos de los asteroides, las claves son sus nombres y el orden es: NOMBRE, MASA, DIAMETRO, DENSIDAD, COMPOSICIÓN, DESCRIPCIÓN, AÑOS, DIAS MESES [IMPACTO]
var datos_asteroides: Dictionary = {'Itokawa': ['Itokawa',3.15e10,0.33,1.9e3,'silicates and rock-forming minerals such as olivine and pyroxene','porus and therefore easily fragmenting',7,2,3], 'Bennu': ['Bennu',7.33e10,0.48,1.19e3,'blablabla','bliblibli',4,4,4]}
