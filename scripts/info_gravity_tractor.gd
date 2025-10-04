extends Control

# Referencias a los nodos hijos del nodo de Control (interfaz grafica)
@onready var rich: RichTextLabel = $ScrollContainer/Contenedor/info
@onready var titulo: TextureRect = $"ScrollContainer/Contenedor/titulo_(gravity_tractor)"
@onready var anim: AnimatedSprite2D = $ScrollContainer/Contenedor/AnimatedSprite2D
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
A [b]gravity tractor[/b] is a theoretical asteroid deflection technique based on gravitational force. 
It involves a spacecraft with a mass large enough, relative to the asteroid, to subtly alter 
the asteroid’s trajectory over time using their mutual gravitational attraction. 
In essence, the spacecraft would act as if it were “towing” the asteroid using gravity as an 
invisible towline.

In its basic form, a gravity tractor uses a [color=#c73232][u]pair of thrusters[/u][/color] that are canted relative to the 
direction of the force to be applied on the asteroid. This is necessary to prevent exhaust 
plumes from directly striking the asteroid, which would counteract the gravitational 
tugging effect. 
However, the canting of the thrusters means that a considerable amount of thrust does not contribute directly to the asteroid’s 
deflection, making the gravity tractor relatively inefficient in terms of fuel use. 


There are [color=#c73232][b]two main types of gravity tractors[/b][/color]: stationary and dynamic. 
The [b]stationary gravity tractor[/b] is positioned at a fixed location relative to the asteroid, allowing the gravitational force it exerts on 
the asteroid to be constant over time and gradually shift its trajectory. The main disadvantage of this approach is that it requires 
continuous propellant consumption to maintain the spacecraft’s position. In contrast, a [b]dynamic gravity tractor[/b] follows what is 
known as a non-Keplerian orbit around the asteroid. This means that the spacecraft would be moving around the asteroid in an 
artificial orbit designed to exert a consistent gravitational pull on the asteroid (unlike in Keplerian orbits where no net gravitational 
force is exerced). This method would consume less propellent than the static approach but would require a longer period of time 
to achieve the same magnitude of gravitational force.



•	One of the key advantages of this method is that [color=#c73232][u]it does not depend on the asteroid’s composition[/u][/color]. It would therefore be 
especially useful in cases where a direct impact might risk breaking the asteroid into smaller fragments, something we would want 
to avoid. 

•	Gravity tractors would be generally more effective for [color=#c73232][u]smaller asteroids[/u][/color], since the larger the asteroid, the more massive the 
spacecraft must be to produce a significant gravitational force to deflect its trajectory.

•	In addition, since the force exerted by a gravity tractor is smaller than that of a kinetic impact, it allows a [color=#c73232][u]greater control[/u][/color] over 
the amount by which the asteroid’s trajectory is modified. 

•	However, unlike with other deflection methods like the kinetic impactor, [color=#c73232][u]the result is not instantaneous[/u][/color]. It would take a certain 
amount of time for the asteroid to start shifting its movement due to the gravitational force exerted by the spacecraft, so this 
approach would only be viable if there is enough time between the detection of the asteroid and a potential collision with Earth, a minimum of 15 years

•	Another drawback of this method is that [color=#c73232][u]extremely precise navigation control[/u][/color] would be needed, since in order for the spacecraft 
to exert a measurable gravitational force on the asteroid, the distance between them must be minimized, and therefore the risk of 
collision if something goes wrong is very high.



However, gravity tractors [u]have not yet been tested experimentally[/u], and their effectiveness remains theoretical.

In conclusion, while gravity tractors require longer timescales and significant fuel resources, they provide a safe option when the 
asteroid’s composition or structure makes other techniques less desirable.

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
