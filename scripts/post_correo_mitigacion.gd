extends Control

@onready var video = $VideoStreamPlayer

func _on_video_finished():
	get_tree().change_scene_to_file("res://scenes/resp_corr_itokawa.tscn")
	
func _ready() -> void:
	video.play()  # inicia el video
	video.finished.connect(_on_video_finished)
