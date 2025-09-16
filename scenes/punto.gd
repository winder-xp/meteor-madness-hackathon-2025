extends Node2D
func _draw():
	draw_circle(Vector2(0,0),10.0,Color.RED)
var lon = 64.1475 * 2*PI / 360
var lat = -21.935 * 2*PI / 360
var a = 0
var b = 0
var scale_factor = 1.635
func _process(delta):
	z_index = 1
	a = get_parent().get_node('MapaMundo').get_rect().size.x
	b = get_parent().get_node('MapaMundo').get_rect().size.y
	
	var x = a * (lon + PI) / (2*PI)
	var y = (-(1 - log(tan(PI/4 + lat/2))/PI) * b/2)*scale_factor
	position = Vector2(x,y)
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
	
	#if event.is_action_pressed("keyQ"):
		#scale_factor += 0.01
		#print(scale_factor)
