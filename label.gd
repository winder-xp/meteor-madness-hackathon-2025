extends Label

@export var texto_completo: String = "Have you ever wondered how asteroids are detected? \n I guess the answer is probably no- who cares, right? \n However, if I told you that an enormous rock may land in your backyard,\n our lack of curiosity would certainly change.\n \n Fortunately, I’m here to guide you through this fascinating process. "
@export var velocidad: float = 0.08      # tiempo entre letras
@export var velocidad_cursor: float = 0.12 # parpadeo del cursor

var indice: int = 0
var parcial: String = ""
var escribiendo: bool = false
var mostrar_cursor: bool = true

func _ready() -> void:
	text = ""
	escribir_letras_async()
	parpadeo_cursor_async()


func escribir_letras_async() -> void:
	escribiendo = true
	indice = 0
	parcial = ""
	while indice < texto_completo.length():
		parcial = texto_completo.substr(0, indice + 1)  # primeros (indice+1) caracteres
		# mostramos parcial + cursor (si toca)
		if mostrar_cursor:
			text = parcial + "_"
		else:
			text = parcial
		indice += 1
		await get_tree().create_timer(velocidad).timeout
	escribiendo = false
	text = texto_completo  # al final sin cursor

func parpadeo_cursor_async() -> void:
	mostrar_cursor = true
	while escribiendo:
		# alterna visual del cursor sobre el texto parcial
		if mostrar_cursor:
			text = parcial + "_"
		else:
			text = parcial
		mostrar_cursor = !mostrar_cursor
		await get_tree().create_timer(velocidad_cursor).timeout
	# al salir, aseguramos que no quede el guion bajo
	text = parcial

# tecla para mostrar todo al instante (opcional)
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if escribiendo:
			escribiendo = false
			parcial = texto_completo
			text = texto_completo
