extends Camera2D

# Configuración de zoom
var zoom_speed := 0.1
var min_zoom := 0.6
var max_zoom := 4.0
var zoom_smooth := 8.0

# Configuración de pan
var pan_smooth := 5.0
var dragging := false
var last_mouse_pos := Vector2()

# Tamaño del mapa
var map_width := 2058
var map_height := 2058

# Variables objetivo
var target_position := Vector2()
var target_zoom := Vector2(1, 1)

func _ready():
	target_position = global_position
	target_zoom = zoom

func _unhandled_input(event):
	# Zoom centrado en ratón
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos_before := get_global_mouse_position()

		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom += Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom -= Vector2(zoom_speed, zoom_speed)
		target_zoom.x = clamp(target_zoom.x, min_zoom, max_zoom)
		target_zoom.y = clamp(target_zoom.y, min_zoom, max_zoom)

		var mouse_pos_after := get_global_mouse_position()
		target_position += mouse_pos_before - mouse_pos_after

	# Arrastre con botón izquierdo
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			if dragging:
				last_mouse_pos = event.position

func _process(delta):
	var viewport_size := Vector2(1152,648)
	var half_viewport := viewport_size / 2 / zoom

	var limit_left := -map_width/2 + half_viewport.x
	var limit_right := map_width/2 - half_viewport.x
	var limit_top := -map_height/2 + half_viewport.y
	var limit_bottom := map_height/2 - half_viewport.y
	
	# Movimiento de pan
	if dragging:
		var mouse_pos := get_viewport().get_mouse_position()
		var delta_screen := last_mouse_pos - mouse_pos
		target_position += delta_screen * target_zoom/zoom.x**2
		target_position.x = clamp(target_position.x,limit_left,limit_right)
		target_position.y = clamp(target_position.y,limit_top,limit_bottom)
		last_mouse_pos = mouse_pos





	# Suavizado (inercia) de cámara y zoom
	global_position = global_position.lerp(target_position, pan_smooth * delta)
	zoom = zoom.lerp(target_zoom, zoom_smooth * delta)
	global_position.x = clamp(global_position.x,limit_left,limit_right)
	global_position.y = clamp(global_position.y,limit_top,limit_bottom)
