extends Control

@onready var video = $VideoStreamPlayer
@onready var ia = $ia

# Marca de agua de la ia
var texto = 'AI generated'

func _on_video_finished():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/mapa.tscn")

# Simplemente ejecuta el video
func _ready() -> void:
	# Marca de agua de la ia
	ia.bbcode_text = texto
	
	video.play()  # inicia el video
	video.finished.connect(_on_video_finished)
