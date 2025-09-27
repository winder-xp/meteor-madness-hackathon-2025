extends CharacterBody3D
@onready var character_body_3d: CharacterBody3D = $"."
@onready var animation_player2: AnimationPlayer = $"Ch22_nonPBR_Walk With Briefcase/AnimationPlayer"

@export var dios: float = 3
@export var sensitivity: float = 0.2
var yaw := 0.0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity
		rotation_degrees = Vector3(0, yaw, 0)

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("keyW"):
		direction -= global_transform.basis.z
	if Input.is_action_pressed("keyS"):
		direction += global_transform.basis.z
	if Input.is_action_pressed("keyA"):
		direction -= global_transform.basis.x
	if Input.is_action_pressed("keyD"):
		direction += global_transform.basis.x

	direction = direction.normalized()

	# usamos la propiedad 'velocity' que ya trae CharacterBody3D
	velocity.x = direction.x * dios
	velocity.z = direction.z * dios

	# ¡solo la llamas, sin asignar!
	move_and_slide()

	
