extends Control

@onready var correo : Button = $Button

# Al pulsar el icono de gmail se abre el correo que redacta la cientifica, correo_mitigation
func _on_gmail_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/correo_mitigation.tscn")
	
func _ready() -> void:
	correo.pressed.connect(_on_gmail_pressed)
