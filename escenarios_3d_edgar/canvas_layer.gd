extends CanvasLayer
@onready var animation_player: AnimationPlayer = $ColorRect/Label/ColorRect/AnimationPlayer
var jose = false

func _process(delta):
	if jose==false:
		animation_player.play("desvanecerse")
		jose = true
