extends CharacterBody3D


var rot_vel_grad: float=30

func _process(delta):
	rotate_z(deg_to_rad(rot_vel_grad*delta))
