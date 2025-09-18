extends Camera3D


@export var sensitivity: float = 0.1
@export var min_pitch: float = -55  # altura inicial (en grados)
@export var max_pitch: float = 90.0  # cuánto puede mirar hacia arriba

var yaw: float = 0.0
var pitch: float = 0.0

func _ready():
	# Inicializamos la posición vertical actual como min_pitch
	pitch = rotation_degrees.x
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity
		pitch -= event.relative.y * sensitivity
		# Limitamos el pitch para que no baje más del inicial
		pitch = clamp(pitch, min_pitch, max_pitch)
		rotation_degrees = Vector3(pitch, yaw, 0)
