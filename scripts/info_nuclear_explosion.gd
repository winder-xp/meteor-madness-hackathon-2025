extends Control

# Referencias a los nodos hijos del nodo de Control (interfaz grafica)
@onready var rich: RichTextLabel = $ScrollContainer/Contenedor/info
@onready var titulo: TextureRect = $"ScrollContainer/Contenedor/titulo_(nuclear_explosion)"
@onready var stand: AnimatedSprite2D = $ScrollContainer/Contenedor/standoff_explosion
@onready var surf: AnimatedSprite2D = $ScrollContainer/Contenedor/surface_explosion
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
[b]Nuclear interceptors[/b] are an asteroid deflection technique which consists of using nuclear explosions to transfer a certain amount 
of energy to a Potentially Hazardous Object (PHO), altering its velocity and, consequently, its trajectory.

There are several ways nuclear interceptors could be used for asteroid deflection. 
One option is to detonate the device at a specified [b]standoff distance[/b] from the asteroid. This would blow off a thin layer of the 
NEO’s surface, creating a reactive push that changes its velocity without causing significant fragmentation. Another approach 
involves the use of [b]surface nuclear explosives[/b], which would be more efficient in terms of momentum transfer, but it carries a 
higher risk of fracturing the asteroid into multiple hazardous pieces. The most powerful strategy would be a [b]subsurface explosion[/b]: 
burying the device to a depth of 3 to 5 meters could deliver far more energy to the asteroid, producing a much greater deflection. 
However, this approach would require the spacecraft to land, drill into the asteroid, and safely deploy the device, resulting in a 
highly complex mission which would require much more time to carry out given current technological limitation.













                                                                   [b]distant detonation[/b]                                               [b]surface explosion[/b]
				
				
•	Quantitative studies suggest that surface detonations are around 11 times more effective than standoff explosions, while 
 detonations can be up to 100 times more effective. 

•	Nuclear devices also represent the [u]most mass-efficient[/u] way to store and deliver the vast amounts of energy needed for such 
missions, as they are based in nuclear fusion which is one of the most powerful energy obtaining methods known nowadays, 
making them particularly valuable for deflecting large asteroids. 

•	If [u]warning time is very short[/u], less than three years before a possible impact, nuclear interceptors may be the only viable option, 
as other techniques require much longer timescales to produce results. As a matter of fact, the smaller an asteroid is, the harder it 
becomes to detect it well in advance. NASA’s Planetary Defense Strategy and Action Plan indicates that while about 95% of 
asteroids larger than 1 kilometer in diameter have already been discovered, only around 7% of those measuring about 50 meters, 
large enough to cause severe regional damage, are currently known.

•	However, a [u]very precise knowledge of the asetroid’s composition, structure and shape[/u] would be essential to select the safest 
and most effective nuclear strategy. For instance, if a subsurface explosive approach is chosen, the asteroid’s surface composition 
would be a key factor in terms of building the drilling device, or if a surface method is chosen, the density of the asteroid would be 
an important piece of information to weather the asteroid would break with the explosion. Ideally, this knowledge would come 
from a prior reconnaissance mission, but such preparation requires more time which may not be available. 

•	Furthermore, nuclear explosions represent a very [u]drastic approach[/u] to planetary defense, as it is nearly impossible to avoid 
fragmenting the asteroid into smaller pieces, an outcome generally considered undesirable if alternative methods are available.



To sum up, nuclear interceptors represent the most powerful and mass-efficient option for asteroid deflection, especially when 
facing large bodies or limited warning times.

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
