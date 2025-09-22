extends MeshInstance3D
const MAJOR_AXIS_A = 429.782952422 / 2
const MINOR_AXIS_B = 215.032
# 1 mes = 30 días
const YEAR_TO_UNIT = 365.0*24*3600
const OMEGA = 2*PI/YEAR_TO_UNIT


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector3(
		MAJOR_AXIS_A * cos(OMEGA * Time.get_ticks_msec() / 1000),
		0.0,
		MINOR_AXIS_B * sin(OMEGA * Time.get_ticks_msec() / 1000)
	)
