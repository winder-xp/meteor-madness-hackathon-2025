extends Node2D

const TILE_SIZE = 256
var zoom = 3
var tile_x = 2
var tile_y = 2

func _ready():
	var url = "https://tile.openstreetmap.org/%d/%d/%d.png" % [zoom, tile_x, tile_y]
	var image_texture = load_image_from_url(url)
	image_texture.connect("completed", Callable(self, "_on_image_loaded"))

func load_image_from_url(url):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request(url)
	return http_request

func _on_image_loaded(result, response_code, headers, body):
	if response_code == 200:
		var img = Image.new()
		var err = img.load_png_from_buffer(body)
		if err == OK:
			var tex = ImageTexture.new()
			tex.create_from_image(img)
			var sprite = Sprite2D.new()
			sprite.texture = tex
			sprite.position = Vector2(tile_x * TILE_SIZE, tile_y * TILE_SIZE)
			add_child(sprite)
		else:
			 print("Error loading tile: ", response_code)
