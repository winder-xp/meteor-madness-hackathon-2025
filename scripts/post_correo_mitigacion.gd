extends Control

@onready var video = $VideoStreamPlayer
@onready var ia = $ia

var asteroide = Global.selected_asteroid_name 

var texto = 'AI generated'
# Si la respuesta del usuario coincide con la respuesta correcta (almacenada en el diccionario de Global)
# se cambia la escena a la de las respuestas correctas, si no, se cambia a la de las erroneas
func _on_video_finished():
	if Global.selections["b1"] == Global.datos_asteroides[asteroide][-1]:
		get_tree().change_scene_to_file("res://scenes/resp_corr.tscn")
	elif Global.selections["b1"] != Global.datos_asteroides[asteroide][-1]:
		get_tree().change_scene_to_file("res://scenes/resp_erron.tscn")
	
func _ready() -> void:
	video.play()  # inicia el video
	video.finished.connect(_on_video_finished)
	
	ia.bbcode_text = texto
