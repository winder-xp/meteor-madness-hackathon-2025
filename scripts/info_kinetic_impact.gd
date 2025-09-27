extends Control

# Referencias a los nodos hijos del nodo de Control (interfaz grafica)
@onready var rich: RichTextLabel = $ScrollContainer/Contenedor/info
@onready var titulo: TextureRect = $"ScrollContainer/Contenedor/titulo_(kinetic_impactor)"
@onready var anim: AnimatedSprite2D = $ScrollContainer/Contenedor/AnimatedSprite2D
@onready var imag1: TextureRect = $ScrollContainer/Contenedor/imagen1
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
The [b]kinetic impactor[/b] is an asteroid deflecting technique that involves deliberately 
crashing an object, like a spacecraft, into an asteroid to change its hazardous trajectory 
so that its new orbit misses the Earth. 

The [color=#25778a][b]theoretical approach[/b][/color] relies on the concept of an inelastic collision: when the 
spacecraft impacts the asteroid, it transfers a certain momentum to it, slightly altering 
its orbital speed and therefore its trajectory. The result is that, over time, the asteroid 
no longer poses a threat of impact with our planet.



•	Kinetic impactors are most effective for targeting objects ranging from several hundred meters up to about one kilometer in 
[color=#25778a][u]diameter[/u][/color].

•	Their effectiveness also depends on the object’s [color=#25778a][u]mass, composition and structure[/u][/color]. For instance, if the asteroid is made of a hard 
rocky material, a kinetic impact would be less likely to break it into smaller potentially hazardous pieces than if it was made by a 
less dense material. 

•	It is the only deflection method that has been tried out and [color=#25778a][u]proved to work[/u][/color]. 

•	Furthermore, the spacecraft required for this method wouldn’t be so different from a conventional spacecraft, meaning that less 
time would be needed for its design and development. However, the whole mission would take a [color=#25778a][u]minimum of 5 years[/u][/color].

•	Another key factor to consider is [color=#25778a][u]distance[/u][/color]: the farther away from Earth the asteroid is at the time of impact, the smaller the 
deflection required for it to miss our planet, so therefore the less speed needed by the spacecraft and the less propellent needed.

Given warning times in the decade-scale, velocity changes on the order of a few millimeters per second are enough to successfully 
perturb the orbit from a collision course with the Earth. 




Furthermore, the kinetic impactor is the only asteroid deflecting technique that has been tested to date, with [b]NASA’s Double 
Asteroid Redirection Test (DART)[/b] in 2022. The mission targeted a binary asteroid composed of a smaller body, known as moonlet, 
called [color=#25778a]Dimorphos[/color], orbiting a larger one, called Didymos. The goal was to crash the spacecraft into Dimorphos in order to study 
how much its orbit around Didymos would change as a result of the impact. 

The spacecraft was around 19 meters across, while Dimporphos was approximately 160 meters in diameter. For comparison, 
planetary scientist and astrobiologist Jorge Nuñez from the Johns Hopkins Applied Physics Laboratory described the event as being 
“like crashing a car into the Great Pyramid of Giza.” 













                                                                                       [color=#696969]DART spacecraft approaching the asteroid[/color]

The whole process, from the design to the end of the mission lasted around 8 years. DART was launched on November 24, 2021 
from Vandenberg Space Force Base in California. 61 days before the impact, the onboard Didymos Reconnaissance and Asteroid 
Camera for Optical navigation (DRACO) first identified Didymos, and 30 days before the impact it began capturing images of the 
asteroid every five hours. 
Finally, 4 hours and 5 minutes before collision, the spacecraft’s Small-body Manouvering Autonomus Real Time Navigation system 
(SMART Nav) took control of DART, switching from ground-directed to autonomous mode, processing DRACO’s images onboard to 
identify Dimorphos and precisely crash into it. The last full image of Dimorphos was acquired 1.818 seconds before the impact on 
September 26, 2022, nearly one year after the launch of the spaceship.

The results were extraordinary, exceeding expectations. Scientists concluded that [color=#25778a]the impact shortened Dimorphos’s orbital period 
by 32 minutes[/color] from its original 11 hours and 50 minutes. This was 22 minutes more than anticipated. Beyond its technical success, 
DART demonstrated that planetary defense is not just a theoretical concept but a practical capability.

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
