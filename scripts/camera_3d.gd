extends Camera3D
@onready var earth_mesh: MeshInstance3D = $"../Tierra"
@onready var sun_mesh: MeshInstance3D = $"../sol final" 
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
	if Input.is_action_just_pressed("leftClick"):
		rotating = true
		last_mouse_pos = get_viewport().get_mouse_position()
	
	# Fin de la rotación, clic soltado
	elif Input.is_action_just_released("leftClick"):
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
	if radius <= 0.5:
		scale_factor_earth = 1.0
		scale_factor_sun = 1.0
		if Input.is_action_just_pressed("scrollUp"):
			radius -= zoom_sensitivity
			print("sun: " + str(sun_mesh.scale))
		if Input.is_action_just_pressed("scrollDown"):
			radius += zoom_sensitivity
			print("sun: " + str(sun_mesh.scale))
	else:
		if Input.is_action_just_pressed("scrollUp"):
			radius -= radius * 0.5
			scale_factor_earth -= 5.0
			scale_factor_sun -= 0.5
			print("radius: " + str(radius))
			print("sun: " + str(sun_mesh.scale))
		if Input.is_action_just_pressed("scrollDown"):
			radius += radius * 0.5
			scale_factor_earth += 5.0
			scale_factor_sun += 0.5
			print("radius: " + str(radius))
			print("sun: " + str(sun_mesh.scale))
	radius = clamp(radius, 0.009, INF)
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
		camera_lookat = get_parent().get_node("Tierra").global_position
		earth_mesh.scale = Vector3.ONE * 1.0 * scale_factor_earth
		sun_mesh.scale   = Vector3.ONE * 1.0 * scale_factor_sun
