extends Control

# Referencias a los nodos hijos del nodo de Control (interfaz grafica)
@onready var rich: RichTextLabel = $correo
@onready var from: RichTextLabel = $from
@onready var forr: RichTextLabel = $for
@onready var asunto: RichTextLabel = $asunto
@onready var popup: PopupMenu = $opciones_estrategias
@onready var kin_imp: Button = $kinetic_impactor
@onready var grav_trac: Button = $gravity_tractor
@onready var ion_beam: Button = $ion_beam
@onready var nuc_inter: Button = $nuclear_interceptor
@onready var email: Button = $email
@onready var send: Button = $send

var asteroide_elegido := 'Itokawa'   #CAMBIAR
var datos := []
var text := ''

# EL BOTÓN DE ENVIAR ES UN BOTÓN QUE TE PASA A LA SIGUIENTE ESCENA, CUANDO YA ESTÉ LA INFO
# COMPLETADA (HABRÁ QUE INCLUIR ALGO QUE COMPUEBE QUE TODOS LOS CAMPOS, EL MAPA Y LA ESTRATEGIA
# SE HAN MARCADO Y SI NO SE HAN HECHO SE MOSGRARÁ UN MENSJAE POR PANTALLA QUE LO DIGA

# ANIMAR EL TEXTO DEL CORREO PARA QUE SE VAYA ESCRIBIENDO POCO A POCO

# Texto del correo con el desplegable en [url=id]_____[/url]
var from_email: String = '  [font_size=14]From[/font_size]     [color=#545454]archives@jpl.nasa.gov[/color]'
var for_email: String = '    [font_size=14]To[/font_size]      [color=#545454]obs@cfa.harvard.edu[/color]'
var asunto_correo: String = '    Subject:  [color=#3b3b3b]R.E: IMMINENT CATASTROPHE[/color]'

# VOY A TENER ESTE MODELO DE TEXTO. DEPENDIENDO DE QUÉ ASTEROIDE ELIJA EL USUARIO, POR EJEMPLO A MI ME VA A 
# LLEGAR: HA ELEGIDO ITOKAWA, PUES YO ME TENGO QUE CREAR EN GLOBAL UN DICCIONARIO CON CLAVES LOS NOMBRES DE 
# LOS ASTEROIDES Y VALORES UNA LISTA CON LOS DATOS DE MASA, DIAMETRO... ORDENADOS DE MAENRA QUE ME ACUERDE Y
# SIMPLEMENTE TENER UN IF COMPROBANDO QUÉ NOMBRE DE ASTEROIDE ME HA LLEGADO Y ASIGNANDO A UNA VARIABLE LA LISTA
# CON LOS DATOS

func texto_que_mostrar() ->void:
	if asteroide_elegido == 'Itokawa':
		datos = Global.datos_asteroides['Itokawa']
		print(datos)
	elif asteroide_elegido == 'Bennu':
		datos = Global.datos_asteroides['Bennu']
		
	text = """Oh no, this can’t be true… it is unbelievable!

The situation is extremely serious and could have catastrophic consequences for humanity. I am deeply concerned and hope we proceed with speed, precision, and efficiency in avoiding this calamity.

Here is a summary of our current situation:
	
The recently discovered asteroid %s, with a mass of %s kg and a diameter of %s km poses an enormous threat to our planet. It has an approximate density of %s kg/m^3 and is primarily composed of %s a very %s material. From now, the time until the impact is about %s years %s months %s days.

Considering all this data, I believe that the most effective mitigation strategy in this case would be [b][url=b1]_________[/url][/b].

I recommend that we begin immediate planning and coordination to implement this strategy, every passing minute increases the risk of devastating consequences. 

The fate of millions depends on us; failure is not an option.

Jet Propulsion Laboratory

""" %[datos[0], datos[1], datos[2],datos[3], datos[4], datos[5], datos[6], datos[7], datos[8]]


# Opciones para el desplegable (estrategias de mitigación)
var blank_options: Dictionary = {
	"b1": ["the kinetic impactor", "the gravity tractor", "the ion beam shepherd", "the nuclear interceptor", "protection and evacuation"]}

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
	var placeholder: String = "[url=%s]_________[/url]" % blank_id
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

func _on_send_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/post_correo_mitigacion.tscn")     # CAMBIAR A LA SIGUIENTE ESCENA



func _ready() -> void:
	popup.hide()
	# Dependiendo del asteroide que haya elegido el usuario, asigno los datos y escribo el correo correspondiente
	texto_que_mostrar()
		
	# Activo BBcode para escribir 
	rich.bbcode_enabled = true
	from.bbcode_enabled = true
	forr.bbcode_enabled = true
	asunto.bbcode_enabled = true
	# Muestro el texto del correo
	rich.bbcode_text = text
	from.bbcode_text = from_email
	forr.bbcode_text = for_email
	asunto.bbcode_text = asunto_correo
	
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
	send.pressed.connect(_on_send_pressed)

	# Cerrar el popup cuando el usuario elija la estrategia de mitigación
	popup.clear()
	popup.hide_on_item_selection = true
