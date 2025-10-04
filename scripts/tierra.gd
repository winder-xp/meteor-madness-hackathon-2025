extends MeshInstance3D
const ECCENTRICITY = 0.016
const MAJOR_AXIS_A = 429.782952422 / 2
const MINOR_AXIS_B = MAJOR_AXIS_A*sqrt(1-ECCENTRICITY**2)
const YEAR_TO_UNIT = 365.25*24*3600 # segundos
const OMEGA = 2*PI/YEAR_TO_UNIT

@onready var directional_light_3d = $"../DirectionalLight3D"

var time := 0.0
var linear_velocity = Vector3.ZERO
var previous_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	previous_position = position
	position = Vector3(
		MINOR_AXIS_B * sin(OMEGA * time ),
		0.0,
		MAJOR_AXIS_A * cos(OMEGA * time ),
	)
	linear_velocity = Vector3(
		MINOR_AXIS_B * OMEGA * cos(OMEGA * time ),
		0.0,
		-MAJOR_AXIS_A * OMEGA * sin(OMEGA * time ),
	)
	#linear_velocity = (position - previous_position)/delta
	
	directional_light_3d.rotation.y = PI + acos(global_position.z/global_position.length())
