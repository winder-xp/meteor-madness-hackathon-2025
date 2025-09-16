extends MeshInstance3D3D  #rotación del sol

var velocidad_rotacion = 10.0  # grados por segundo

func _process(delta):
	rotate_y(deg_to_rad(velocidad_rotacion * delta))
