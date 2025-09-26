extends RigidBody3D
'''
Es necesario que este nodo se encuentre dentro de un nodo 'asteroid_set' o similar
que contenga los demás asteroides, pues se recorren con un bucle
'''

enum Asteroids {
	Itokawa,
	Bennu,
	Dinkinesh,
	Ryugu,
	_2000_DP107,
}

signal parameters_ready

## Nombre del asteroide (se toman sus datos)
@export var asteroid_id: Asteroids

## Número de puntos de la elipse dibujada
@export var num_orbit_points: int = 1000

const UA_TO_METERS := 149597828677.28
#const YEARS_TO_SECONDS := 31556952
#const GRAVITATIONAL_CONSTANT := 6.67430e-11
#const SUN_MASS := 1.989e30
const SUN_TO_METERS := 695700000
#const EARTH_MASS := 5.97e24
#const TIME_UNIT_TO_SECONDS := 1.0
#const CONVERSION_FACTOR := 1.0 / (SUN_TO_METERS * SUN_TO_METERS)
const UA_TO_SUN := UA_TO_METERS / SUN_TO_METERS
const DAYS := 86400
const DEGREES := PI/180

var e: float 		#excentricidad
var a: float		#semieje mayor
var b: float		#semieje menor
var period: float	#periodo de órbita
var omega: float	#velocidad angular
var Omega: float	#ángulo ascending node
var i: float		#ángulo con la eclíptica
var time = 0.0

## Color de la bola
@export_color_no_alpha var asteroid_test_color: Color
## Activar sólo en sistema_solar.tscn
@export var is_on_solar_scene := false


# Called when the node enters the scene tree for the first time.
func _ready():
	'''
	Color del asteroide
	'''
	var mat := StandardMaterial3D.new()
	mat.emission_enabled = true
	mat.emission = asteroid_test_color
	mat.albedo_color = asteroid_test_color
	$MeshInstance3D.set_surface_override_material(0, mat)
	'''
	Propiedades del asteroide según el tipo
	'''
	get_node("Label3D").text = str(Asteroids.keys()[asteroid_id])
	get_node("Label3D").modulate = asteroid_test_color
	if asteroid_id == Asteroids.Itokawa:
		e = 0.2801500981413037
		a = 1.324135178668783 * UA_TO_SUN
		b = a*sqrt(1-e**2)
		period = 556.5406776413872 * DAYS
		omega = 2*PI/period
		Omega = 69.07562356929041 * DEGREES
		i = 1.620938690165939 * DEGREES
		
	if asteroid_id == Asteroids.Bennu:
		e = 0.2037450762416414
		a = 1.126391025894812 * UA_TO_SUN
		b = a*sqrt(1-e**2)
		period = 436.6487281120201 * DAYS
		omega = 2*PI/period
		Omega = 2.06086619569642 * DEGREES
		i = 6.03494377024794 * DEGREES
	
	if asteroid_id == Asteroids.Ryugu:
		e = 0.1910626231558206
		a = 1.190921090916117 * UA_TO_SUN
		b = a*sqrt(1-e**2)
		period = 474.7040169452296 * DAYS
		omega = 2*PI/period
		Omega = 251.2915331553314 * DEGREES
		i = 5.866551865769142 * DEGREES
		
	if asteroid_id == Asteroids.Dinkinesh:
		e = 0.1124284065862418
		a = 2.191191485816249 * UA_TO_SUN
		b = a*sqrt(1-e**2)
		period = 1184.728741267934 * DAYS
		omega = 2*PI/period
		Omega = 21.36622643061029 * DEGREES
		i = 2.093263841326789 * DEGREES
		
	if asteroid_id == Asteroids._2000_DP107:
		e = 0.3766974919175901
		a = 1.365050355029763 * UA_TO_SUN
		b = a*sqrt(1-e**2)
		period = 582.5342104930165 * DAYS
		omega = 2*PI/period
		Omega = 358.6173858501047 * DEGREES
		i = 8.67167565580244 * DEGREES
	
	emit_signal("parameters_ready")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var theta = omega * time
	
	position = Vector3(
		-a*cos(theta)*cos(i)*sin(Omega) + b*sin(theta)*cos(i)*cos(Omega),
		a*cos(theta)*sin(i)*sin(Omega) - b*sin(theta)*sin(i)*cos(Omega),
		a*cos(theta)*cos(Omega) + b*sin(theta)*sin(Omega)
	)
	
	

#func _physics_process(delta):
	#for asteroid in get_parent().get_children():
		#var R = (global_position - asteroid.global_position)
		#if asteroid == self:
			#continue
		#if R.length() < 0.001:
			#continue
		##applied_force += - R * (mass * asteroid.mass * GRAVITATIONAL_CONSTANT * YEARS_TO_SECONDS ** 2) / ((UA_TO_METERS ** 3) * R.length()**3)
		#applied_force += - R * CONVERSION_FACTOR * (mass * asteroid.mass * GRAVITATIONAL_CONSTANT) / (R.length()**3)
	#if is_on_solar_scene:
		#var earth_mesh = $"../../Tierra"
		#var earth_R = global_position - earth_mesh.global_position
		#
		#if earth_R.length() > 1e-6:
			#applied_force += - CONVERSION_FACTOR * ( global_position * (mass * SUN_MASS * GRAVITATIONAL_CONSTANT) / (global_position.length()**3) ) - CONVERSION_FACTOR * earth_R * (mass * EARTH_MASS * GRAVITATIONAL_CONSTANT) / (earth_R.length()**3)
			#
			##print(str(self.name) + ": " + str(earth_R))
			##print(applied_force)
			##print(linear_velocity)
		#else:
			#print("COLISIÓN")
	#apply_central_force(applied_force)
	#applied_force = Vector3.ZERO
