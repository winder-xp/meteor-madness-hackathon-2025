extends Sprite2D
#var lon = 3 * 2*PI / 360
#var lat = 40 * 2*PI / 360
#var a = get_rect().size.x
#var b = get_rect().size.y
#var x = (lon + PI) / (2*PI) * a
#var y = -(1 - log(PI/4 + lat/2)/PI) * (b/2)
func _ready():
	z_index = 0
	#get_parent().get_node('punto').position = Vector2(x,y)
	#print(x)
	#print(y)
#func _input(event):
	## Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
	var map_size = Vector2()
	map_size.x = texture.get_width() * scale.x
	map_size.y = texture.get_height() * scale.y
	print("Tamaño del mapa:", map_size)
