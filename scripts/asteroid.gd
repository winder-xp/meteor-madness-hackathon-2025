extends RigidBody3D
'''
Es necesario que este nodo se encuentre dentro de un nodo 'asteroid_set' o similar
que contenga los demás asteroides, pues se recorren con un bucle
'''
const UA_TO_METERS := 149597828677.28
const YEARS_TO_SECONDS := 31556952
const GRAVITATIONAL_CONSTANT := 6.67430e-11
const SUN_MASS := 1.989e27
const SUN_TO_METERS := 695700000
const EARTH_MASS := 5.97e24

@onready var earth_mesh = $"../../Tierra" 
@onready var camera_script: Camera3D = $"../../MovableCamera3D"
## Color de la bola
@export_color_no_alpha var asteroid_test_color: Color

var rng = RandomNumberGenerator.new()

## Posición inicial del asteroide
@export var distance = 10.0
var applied_force = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1.0
	var mat := StandardMaterial3D.new()
	mat.albedo_color = asteroid_test_color # Azul clarito (R,G,B)
	$MeshInstance3D.set_surface_override_material(0, mat)
	#position = distance * Vector3(rng.randf_range(0,1), rng.randf_range(0,1), rng.randf_range(0,1))
	linear_velocity = 10* Vector3(rng.randf_range(-1,1), rng.randf_range(-1,1), rng.randf_range(-1,1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print(str(name) + " posición: " + str(position))
	

func _physics_process(delta):
	for asteroid in get_parent().get_children():
		var R = (global_position - asteroid.global_position)
		if asteroid == self:
			continue
		if R.length() < 0.001:
			continue
		#applied_force += - R * (mass * asteroid.mass * GRAVITATIONAL_CONSTANT * YEARS_TO_SECONDS ** 2) / ((UA_TO_METERS ** 3) * R.length()**3)
		applied_force += - R * (mass * asteroid.mass * GRAVITATIONAL_CONSTANT) / (R.length()**3)
	if global_position.length() > 0.001 and camera_script.is_on_earth:
		var earth_R = global_position - earth_mesh.global_position
		applied_force = - global_position * (mass * SUN_MASS * GRAVITATIONAL_CONSTANT) / (SUN_TO_METERS * global_position.length()**3) - earth_R * (mass * EARTH_MASS * GRAVITATIONAL_CONSTANT) / (SUN_TO_METERS * earth_R.length()**3)
	apply_central_force(applied_force)
	applied_force = Vector3.ZERO
