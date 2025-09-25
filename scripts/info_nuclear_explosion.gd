extends Control

# Referencias a los nodos hijos del nodo de Control (interfaz grafica)
@onready var rich: RichTextLabel = $ScrollContainer/Contenedor/info
@onready var titulo: TextureRect = $"ScrollContainer/Contenedor/titulo_(ion_beam)"
@onready var imag: TextureRect = $ScrollContainer/Contenedor/imagen1
@onready var kin_imp: Button = $kinetic_impactor
@onready var grav_trac: Button = $gravity_tractor
@onready var ion_beam: Button = $ion_beam
@onready var nuc_inter: Button = $nuclear_interceptor
@onready var email: Button = $email

# EL BOTÓN DE ENVIAR ES UN BOTÓN QUE TE PASA A LA SIGUIENTE ESCENA, CUANDO YA ESTÉ LA INFO
# COMPLETADA (HABRÁ QUE INCLUIR ALGO QUE COMPUEBE QUE TODOS LOS CAMPOS, EL MAPA Y LA ESTRATEGIA
# SE HAN MARCADO Y SI NO SE HAN HECHO SE MOSGRARÁ UN MENSJAE POR PANTALLA QUE LO DIGA)

# Texto del correo con el desplegable en [url=id]_____[/url]
var text: String = """
The [b]ion beam shepherd[/b] is a theoretical asteroid deflection technique in which a spacecraft equipped with ion engines continuously 
bombards the surface of an asteroid. The impact of these high-velocity ions creates a pressure on the asteroid’s surface by 
transferring their momentum through inelastic collisions, which would ‘’push the asteroid” changing its orbital velocity and, 
consequently, its trajectory.














•	One of the key advantages of this method is that, like other deflection techniques such as the gravity tractor, [u]it does not depend 
on the asteroid’s composition[/u]. It would therefore be particularly useful when a direct impact might risk fragmenting the asteroid, 
which is generally undesirable. 

•	Furthermore, this method is [u]less sensitive to asteroid size[/u], because the magnitude of the force exerted by the spacecraft only 
depends on the capability of the electric propulsion system.

•	This method significantly [u]reduces the required spacecraft’s mass[/u] compared to a gravity tractor, as much less propellant is 
needed to achieve the same deflection.

•	Moreover, since an ion beam [u]exerts a smaller force[/u] than a kinetic impact, it allows more precise control over how the asteroid’s 
trajectory is altered. 

•	In addition, the ability to target different specific areas on the asteroid’s surface for [u]optimized momentum transfer[/u] is possible.

•	However, as with other non-impact methods, [u]the effect is not instantaneous[/u]. The asteroid’s motion shifts gradually in response 
to the applied force, meaning this approach would only be viable if there is enough lead time between the detection of the asteroid 
and a potential collision with Earth.



For comparison, the ion beam shepherd can deflect a typical 200-meter asteroid given a 20-year lead time, resulting in more than 
an order of magnitude of mass savings compared to the gravity tractor, with the difference increasing the smaller the asteroid 
diameter.

All in all, the ion beam shepherd offers a precise and efficient method for asteroid deflection, allowing controlled trajectory 
changes with reduced spacecraft mass, though it requires long lead times to achieve significant results.

"""

# ------------- Handlers ---------------
# Camabiar a las pestañas de Google con más info de las estrategias de mitigación [HACER]
func _on_kin_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/info_kinetic_impact.tscn")

func _on_grav_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/info_gravity_tractor.tscn")
	
func _on_ion_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/info_ion_beam.tscn")
	
func _on_nuclear_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/info_nuclear_explosion.tscn")

func _on_email_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/correo_mitigation.tscn")


func _ready() -> void:
	# Activo BBcode para escribir 
	rich.bbcode_enabled = true
	rich.scroll_active = false
	# Muestro el texto del correo
	rich.bbcode_text = text

	# Activo que reciba eventos del ratón
	rich.mouse_filter = Control.MOUSE_FILTER_STOP

	kin_imp.pressed.connect(_on_kin_pressed)         # Pestañas de Google con más info
	grav_trac.pressed.connect(_on_grav_pressed)
	ion_beam.pressed.connect(_on_ion_pressed)
	nuc_inter.pressed.connect(_on_nuclear_pressed)
	email.pressed.connect(_on_email_pressed)
