extends RichTextLabel

@export var texto_completo: String = "Hola mundo, esto es un test con barra baja."
@export var velocidad: float = 0.1
@export var velocidad_cursor: float = 0.8

var indice: int = 0
var escribiendo: bool = false
var mostrar_cursor: bool = true

func _ready():
	bbcode_enabled = true
	text = ""
	empezar_animacion()
	get_tree().create_timer(velocidad_cursor, true).timeout.connect(_parpadeo_cursor)

func empezar_animacion():
	indice = 0
	text = ""
	escribiendo = true
	escribir_letra()

func escribir_letra():
	if indice < texto_completo.length():
		text = texto_completo.substr(0, indice + 1)
		indice += 1
		get_tree().create_timer(velocidad).timeout.connect(escribir_letra)
	else:
		escribiendo = false

func _parpadeo_cursor():
	if escribiendo:
		if mostrar_cursor:
			text = texto_completo.substr(0, indice) + "[b]_[/b]"
		else:
			text = texto_completo.substr(0, indice)
		mostrar_cursor = !mostrar_cursor
