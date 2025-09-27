extends Camera3D

@export var sensitivity: float = 0.15      # Sensibilidad del ratón
@export var min_pitch: float = -30    # Altura mínima (ángulo hacia abajo)
@export var max_pitch: float = 90.0       # Altura máxima (ángulo hacia arriba)

var yaw: float = 0.0
var pitch: float = 0.0

func _ready():
	# Inicializamos la posición vertical actual como min_pitch
	pitch = rotation_degrees.x
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Bloquea el cursor

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Actualizamos yaw (horizontal) y pitch (vertical)
		yaw -= event.relative.x * sensitivity
		pitch -= event.relative.y * sensitivity
		
		# Limitamos el pitch para que no baje más del permitido
		pitch = clamp(pitch, min_pitch, max_pitch)
		
		# Aplicamos rotación
		rotation_degrees = Vector3(pitch, yaw, 0)
