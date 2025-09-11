extends Camera3D

@export var camera_lookat: Vector3 = Vector3.ZERO

# parámetros en esféricas de la posición de la cámara (mirar position para convenio)
var radius := (position - camera_lookat).length()
var theta := PI / 2
var phi := PI / 2

var rotating := false
var last_mouse_pos := Vector2.ZERO
var sensitivity := 0.01
var zoom_sensitivity := 0.5

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
		phi -= delta_mouse.x * sensitivity
		theta -= delta_mouse.y * sensitivity
		
		theta = clamp(theta, 0.01, PI - 0.01) # se limita el valor para que no de problemas
		
		# Se actualiza posición y rotación de la cámara
	position = camera_lookat + radius * Vector3(sin(theta) * cos(phi), cos(theta), sin(theta) * sin(phi))
	look_at(camera_lookat, Vector3.UP)
	'''
	ZOOM
	'''
	if Input.is_action_just_pressed("scrollUp"):
		radius -= zoom_sensitivity
	if Input.is_action_just_pressed("scrollDown"):
		radius += zoom_sensitivity
	radius = clamp(radius, 0.0, INF)
	
