extends Camera3D
@onready var earth_mesh: MeshInstance3D = $"../Tierra"
@onready var sun_mesh: MeshInstance3D = $"../sol final"
@onready var slider: HSlider = $"../HSlider"

@onready var rame_127 = $"../AsteroidSet/Rame127"
@onready var a_2000_dp_107 = $"../AsteroidSet/2000Dp107"
@onready var dinkinesh = $"../AsteroidSet/Dinkinesh"
@onready var bennu = $"../AsteroidSet/Bennu"
@onready var itokawa = $"../AsteroidSet/Itokawa"
@onready var btn_asteroid_select = $"../btn_asteroid_select"


## La posición del objeto en el que la cámara va a centrarse
@export var camera_lookat: Vector3 = Vector3.ZERO
var scale_factor_earth := 1.0
var scale_factor_sun := 1.0
# parámetros en esféricas de la posición de la cámara (mirar position para convenio)
## El radio en esféricas inicial de la cámara al objeto al que enfoca
@export var radius := (global_position - camera_lookat).length()
var theta := PI / 2
var phi := PI / 2

## Si se activa, se centra siempre en un nodo llamado "Tierra"
@export var is_on_earth := false

## Velocidad al moverte con WASD Espacio Shift con la cámara por el mapa
@export var movement_speed := 1.0

@onready var camera_look_at_object = earth_mesh
var rotating := false
var last_mouse_pos := Vector2.ZERO

## Sensibilidad del ratón al arrastrar la cámara
@export var mouse_sensitivity := 0.01
## Sensibilidad de la rueda del ratón al hacer zoom
@export var zoom_sensitivity := 0.001
## Activa el movimiento de la cámara con WASD Espacio Shift (para testear)
@export var test_movement := true

func _ready():
	pass

func _process(delta):
	'''
	ROTACIÓN DE LA CÁMARA
	'''
	# Inicio de la rotación, clic pulsado
	if not is_on_earth:
		if Input.is_action_just_pressed("leftClick"):
			rotating = true
			last_mouse_pos = get_viewport().get_mouse_position()
	if is_on_earth and (get_viewport().get_mouse_position().x < slider.position.x or get_viewport().get_mouse_position().x > slider.position.x + slider.size.x or get_viewport().get_mouse_position().y < slider.position.y or get_viewport().get_mouse_position().y > slider.position.y + slider.size.y):
		if Input.is_action_just_pressed("leftClick"):
			rotating = true
			last_mouse_pos = get_viewport().get_mouse_position()
	# Fin de la rotación, clic soltado
	if Input.is_action_just_released("leftClick"):
		rotating = false
	
	# Bloque de código durante la rotación
	if rotating:
		# Se calcula un "dx" del movimiento del ratón 
		var mouse_pos = get_viewport().get_mouse_position()
		var delta_mouse = mouse_pos - last_mouse_pos
		last_mouse_pos = mouse_pos
		
		# Se transforma el movimiento de mouse en rotación angular 
		phi += delta_mouse.x * mouse_sensitivity
		theta -= delta_mouse.y * mouse_sensitivity
		
		theta = clamp(theta, 0.01, PI - 0.01) # se limita el valor para que no de problemas
		
		# Se actualiza posición y rotación de la cámara
	position = camera_lookat + radius * Vector3(sin(theta) * cos(phi), cos(theta), sin(theta) * sin(phi))
	look_at(camera_lookat, Vector3.UP)
	'''
	ZOOM
	'''
	if is_on_earth:
		if radius <= 0.5:
			scale_factor_earth = 1.0
			scale_factor_sun = 1.0
			if Input.is_action_just_pressed("scrollUp"):
				radius -= zoom_sensitivity
			if Input.is_action_just_pressed("scrollDown"):
				radius += zoom_sensitivity
		else:
			if Input.is_action_just_pressed("scrollUp"):
				radius -= radius * 0.5
				scale_factor_earth -= 5.0
				scale_factor_sun -= 0.5
			if Input.is_action_just_pressed("scrollDown"):
				radius += radius * 0.5
				scale_factor_earth += 5.0
				scale_factor_sun += 0.5
		radius = clamp(radius, 0.009, INF)
	else:
		if Input.is_action_just_pressed("scrollUp"):
			radius -= zoom_sensitivity
		if Input.is_action_just_pressed("scrollDown"):
			radius += zoom_sensitivity
	'''
	MOVIMIENTO PARA TESTEAR
	'''
	if test_movement:
		if Input.is_action_pressed("keyW"):
			camera_lookat.z -= movement_speed
		if Input.is_action_pressed("keyS"):
			camera_lookat.z += movement_speed
		if Input.is_action_pressed("keyA"):
			camera_lookat.x -= movement_speed
		if Input.is_action_pressed("keyD"):
			camera_lookat.x += movement_speed
		if Input.is_action_pressed("keySpace"):
			camera_lookat.y += movement_speed
		if Input.is_action_pressed("keyShift"):
			camera_lookat.y -= movement_speed
	'''
	CENTRADO EN TIERRA (solo sistema_solar.tscn)
	'''
	if is_on_earth:
		camera_lookat = camera_look_at_object.global_position
		#earth_mesh.scale = Vector3.ONE * 1.0 * scale_factor_earth
		#sun_mesh.scale   = Vector3.ONE * 1.0 * scale_factor_sun


func _on_ryugu_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		camera_look_at_object = rame_127
		btn_asteroid_select.disabled = false

func _on_itokawa_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		camera_look_at_object = itokawa
		btn_asteroid_select.disabled = false

func _on_bennu_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		camera_look_at_object = bennu
		btn_asteroid_select.disabled = false

func _on_dinkinesh_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		camera_look_at_object = dinkinesh
		btn_asteroid_select.disabled = false

func _on_dp_107_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		camera_look_at_object = a_2000_dp_107
		btn_asteroid_select.disabled = false

func _on_earth_collider_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		camera_look_at_object = earth_mesh
		btn_asteroid_select.disabled = true

func _on_sun_collider_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		camera_look_at_object = sun_mesh
		btn_asteroid_select.disabled = true

func _on_btn_asteroid_select_pressed():
	Global.selected_asteroid_name = camera_look_at_object.Asteroids.keys()[camera_look_at_object.asteroid_id]
	Global.asteroid_velocity = camera_look_at_object.relative_velocity
	print(Global.selected_asteroid_name)
