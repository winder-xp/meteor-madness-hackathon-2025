extends Control

@onready var video = $VideoStreamPlayer

func _on_video_finished():
	pass

# Simplemente ejecuta el video
func _ready() -> void:
	video.play()  # inicia el video
	video.finished.connect(_on_video_finished)
