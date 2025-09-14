extends RigidBody3D
'''
Es necesario que este nodo se encuentre dentro de un nodo 'asteroid_set' o similar
que contenga los demás asteroides, pues se recorren con un bucle
'''
const UA_TO_METERS := 149597828677.28
const YEARS_TO_SECONDS := 31556952
const GRAVITATIONAL_CONSTANT := 1.0#6.67430e-11

var applied_force = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	inertia = Vector3()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	for asteroid in get_parent().get_children():
		var R = (global_position - asteroid.global_position)
		if asteroid == self:
			continue
		if R.length() < 0.001:
			continue
		#applied_force += - R * (mass * asteroid.mass * GRAVITATIONAL_CONSTANT * YEARS_TO_SECONDS ** 2) / ((UA_TO_METERS ** 3) * R.length()**3)
		applied_force += - R * (mass * asteroid.mass * GRAVITATIONAL_CONSTANT) / (R.length()**3)
	apply_central_force(applied_force)
