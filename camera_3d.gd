extends Camera3D
@export var sensitivity: float = 0.2
@export var min_pitch: float = -90  # altura inicial (en grados)
@export var max_pitch: float = 90.0  # cuánto puede mirar hacia arriba
@onready var bone_attachment_3d: BoneAttachment3D = $"../Ch22_nonPBR_Walk With Briefcase/Skeleton3D/BoneAttachment3D"

var yaw: float = rotation.y
var pitch: float = rotation.x


func _ready():
	# Inicializamos la posición vertical actual como min_pitch
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		
		pitch -= event.relative.y * sensitivity
		# Limitamos el pitch para que no baje más del inicial
		pitch = clamp(pitch, min_pitch, max_pitch)
		rotation_degrees = Vector3(pitch, 0, 0)

func _process(delta):
	global_position= bone_attachment_3d.global_position+Vector3(0,0.4,0)
	position.z=position.z-0.6
