extends Control

# Referencias a los nodos hijos del nodo de Control (interfaz grafica)
@onready var rich: RichTextLabel = $correo
@onready var popup: PopupMenu = $opciones_estrategias
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
bla
bla
bla asetroides bla
bla
bla
The best mitigation strategy in this case is: [url=b1]_____[/url].
"""

# Opciones para el desplegable (estrategias de mitigación)
var blank_options: Dictionary = {
	"b1": ["kinetic impactor", "gravity tractor", "ion beam shepheard", "nuclear explosion", "protection and evacuation"]}

# Información proporcionada por el usuario
var current_blank_id: String = ""        # id del hueco
var selections: Dictionary = {}           # guarda las selecciones hechas { "b1":"manzana", ... }


# ------------- Handlers ---------------
# Se llama cuando el usuario hace clic en un desplegable
func _on_rich_meta_clicked(meta: Variant) -> void:
	current_blank_id = meta
	var options: Array = blank_options.get(current_blank_id, [])
	
	# Escribo las opciones en el popup (nodo menú desplegable)
	popup.clear()                  # Borro las que haya escritas de antemano (por si clicas y te sales que no te salgan repetidas)
	for opt in options:
		popup.add_item(opt)

	# Posicion el menú de opciones donde esté el ratón (una vez haya clicado en el hueco)
	var mouse_local = rich.get_local_mouse_position()                
	popup.popup(Rect2(mouse_local, Vector2.ZERO))


# Se llama cuando el usuario selecciona una opción del menú popup (id_opcion es el id de la opcion del menú elegida por el usuario)
func _on_popup_id_pressed(id_popup_opcion: int) -> void:
	var mitigation_strategy: String = popup.get_item_text(id_popup_opcion)
	
	# Reemplaza el hueco por la opción del popup seleccionada por el usuario
	_apply_selection_to_blank(current_blank_id, mitigation_strategy)
	# Guarda la selección para referirse a ella en el futuro
	selections[current_blank_id] = mitigation_strategy
	current_blank_id = ""


# Reemplazo sólo la primera aparición exacta del placeholder por la selección
func _apply_selection_to_blank(blank_id: String, selection: String) -> void:
	var placeholder: String = "[url=%s]_____[/url]" % blank_id
	var idx: int = text.find(placeholder)

	# Reconstruyo el texto reemplazando el hueco por la selección
	var before: String = text.substr(0, idx)
	var after: String = text.substr(idx + placeholder.length())
	text = before + selection + after

	# Actualizo la etiqueta para que lo muestre en pantalla
	rich.bbcode_text = text


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
	popup.hide()
	# Activo BBcode para escribir 
	rich.bbcode_enabled = true
	# Muestro el texto del correo
	rich.bbcode_text = text

	# Activo que reciba eventos del ratón
	rich.mouse_filter = Control.MOUSE_FILTER_STOP

	# Conecto las señales de las posibles acciones señales
	rich.meta_clicked.connect(_on_rich_meta_clicked)   # Clicar en el hueco
	popup.id_pressed.connect(_on_popup_id_pressed)     # Seleccionar estrategia de mitigación
	kin_imp.pressed.connect(_on_kin_pressed)         # Pestañas de Google con más info
	grav_trac.pressed.connect(_on_grav_pressed)
	ion_beam.pressed.connect(_on_ion_pressed)
	nuc_inter.pressed.connect(_on_nuclear_pressed)
	email.pressed.connect(_on_email_pressed)

	# Cerrar el popup cuando el usuario elija la estrategia de mitigación
	popup.clear()
	popup.hide_on_item_selection = true
