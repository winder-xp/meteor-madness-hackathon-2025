extends Node3D
@onready var animation_player3: AnimationPlayer = $CanvasLayer/ColorRect/Label/ColorRect/AnimationPlayer
@onready var canvas_layer_2: CanvasLayer = $"../CanvasLayer2"

@onready var timer: Timer = $"../Timer"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _process(delta):
	if Input.is_action_just_pressed("letraE") and Global.sentado==true:
		if Global.macarena==false:
			animation_player.play_backwards("ordenador abrir")
			Global.macarena = true
		if Global.macarena:
			animation_player.play("ordenador abrir")
			Global.macarena = false
			timer.start()



func _on_timer_timeout() -> void:
	canvas_layer_2.visible = true
