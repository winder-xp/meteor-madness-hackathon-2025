extends Node3D

@onready var ch_22_non_pbr_walk_with_briefcase: Node3D = $"."
@onready var animation_player2: AnimationPlayer = $AnimationPlayer
@export var bolapoyo2 = true

func _process(delta):
	if Input.is_action_pressed("keyW"):
		animation_player2.play("mixamo_com",-1,0.7,false)
	else:
		animation_player2.play("Take 001")
