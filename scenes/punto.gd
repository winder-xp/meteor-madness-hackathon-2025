extends Node2D
func _draw():
	draw_circle(Vector2(0,0),10.0,Color.RED)
var lon = 133.775136 * 2*PI / 360
var lat = -25.274398 * 2*PI / 360
var a = 0
var b = 0
var scale_factor = 1.635
func _process(delta):
	z_index = 1
	a = get_parent().get_node('MapaMundo').get_rect().size.x
	b = get_parent().get_node('MapaMundo').get_rect().size.y
	
	var x = a * lon/(2*PI)
	var y = -log(tan(PI/4 + lat/2))*b/(2*PI)
	position = Vector2(x,y)
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
	
	#if event.is_action_pressed("keyQ"):
		#scale_factor += 0.01
		#print(scale_factor)
