extends MeshInstance3D # o MeshInstance3D si tu esfera es un MeshInstance3D

var velocidad_rotacion = 10.0  # grados por segundo

func _process(delta):
	rotate_y(deg_to_rad(velocidad_rotacion * delta))


"hey que pasa gente de zona"
