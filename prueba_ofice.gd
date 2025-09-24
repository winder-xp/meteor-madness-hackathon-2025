extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var bolapoyo = true
var jose = 0
func _process(delta):
	if Input.is_action_just_pressed("E"):
		if bolapoyo:
			animation_player.play("ordenador abrir")
			bolapoyo = false
		else:
			animation_player.play_backwards("ordenador abrir")
			bolapoyo = true
			print("viva bolapoyo")
