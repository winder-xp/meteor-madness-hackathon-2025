extends Control

# Referencias a los nodos hijos del nodo de Control (interfaz grafica)
@onready var rich: RichTextLabel = $info
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
The gravity tractor
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
	# Muestro el texto del correo
	rich.bbcode_text = text

	# Activo que reciba eventos del ratón
	rich.mouse_filter = Control.MOUSE_FILTER_STOP

	kin_imp.pressed.connect(_on_kin_pressed)         # Pestañas de Google con más info
	grav_trac.pressed.connect(_on_grav_pressed)
	ion_beam.pressed.connect(_on_ion_pressed)
	nuc_inter.pressed.connect(_on_nuclear_pressed)
	email.pressed.connect(_on_email_pressed)
