extends Camera3D

@export var pan_speed := 0.01
@export var zoom_speed := 0.5
@export var min_zoom := 1.0
@export var max_zoom := 50.0
@export var distancia := 2.0
var dragging := false
var draggin2 := false
var last_mouse_pos := Vector2.ZERO
@export var punto := Vector3.ZERO


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			last_mouse_pos = event.position
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			translate(-transform.basis.z * zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			translate(transform.basis.z * zoom_speed)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			draggin2 = event.pressed
			last_mouse_pos = event.position
			
		
	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_pos
		punto = global_transform.origin - global_transform.basis.z * distancia
		last_mouse_pos = event.position
		# Pan horizontal y vertical
		translate(Vector3(-delta.x * pan_speed, delta.y * pan_speed, 0))
	
	elif event is InputEventMouseMotion and draggin2: 
		var delta = event.position - last_mouse_pos
		last_mouse_pos = event.position
		global_position += Vector3(-delta.x * pan_speed,delta.y * pan_speed,(-(2*(global_position.x-punto.x)*delta.x * pan_speed+2*(global_position.y-punto.y)*delta.y * pan_speed))/(2*(global_position.z-punto.z)))
		var deltatotal = Vector3(-delta.x * pan_speed,delta.y * pan_speed,(-(2*(global_position.x-punto.x)*delta.x * pan_speed+2*(global_position.y-punto.y)*delta.y * pan_speed))/(2*(global_position.z-punto.z)))
		look_at(punto)
		print(global_position)
		
