extends Area2D
@onready var camera_2d: Camera2D = $"../Camera2D"
func _process(delta: float) -> void:
	position = camera_2d.get_global_mouse_position()
	
	
	
#lomgitud, latitud, diametro meteorito, densidad, velocidad de entrada, si mar=0, tierra=1

#radio cráter: radio
#Magnitud maxima: terremeto
#Onda maxima: omda
