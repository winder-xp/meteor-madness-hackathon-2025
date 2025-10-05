extends Node3D
@onready var animation_player3: AnimationPlayer = $CanvasLayer/ColorRect/Label/ColorRect/AnimationPlayer
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect/Label/ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var bolapoyo = true
var jose = 0
var jose2 = false

func _ready():
	if jose2==false:
		animation_player3.play("desvanecerse")
		jose2 = true


func _process(delta):
	if Input.is_action_just_pressed("letraE"):
		if bolapoyo:
			animation_player.play("ordenador abrir")
			bolapoyo = false
		else:
			animation_player.play_backwards("ordenador abrir")
			bolapoyo = true


func _on_timer_timeout() -> void:
	color_rect.visible = false
