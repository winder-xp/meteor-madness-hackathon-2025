extends MeshInstance3D

@export var pan_speed := 0.01

@export var velocidad_orbita := 0.005
@onready var cam = $Camera3D
var dragging := false
var draggin2 := false
var last_mouse_pos := Vector2.ZERO



func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			last_mouse_pos = event.position
		
	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_pos
		last_mouse_pos = event.position
		# Pan horizontal y vertical
		translate(Vector3(-delta.x * pan_speed, delta.y * pan_speed, 0))
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		# Girar el pivot según el movimiento del ratón
		rotation.y -= event.relative.x * velocidad_orbita  # yaw
		rotation.x -= event.relative.y * velocidad_orbita  # pitch
