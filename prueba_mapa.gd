extends Node2D

const TILE_SIZE = 256

@export var zoom_level := 3
var zoom_scale := 1.0

@export var center_lat := 40.4168
@export var center_lon := -3.7038

var tiles = {}
var tiles_to_request = []
var requesting = false

var dragging := false
var drag_start_pos := Vector2.ZERO
var map_start_pos := Vector2.ZERO

var http_request : HTTPRequest
var tile_container : Node2D
var camera : Camera2D

func _ready():
	http_request = $HTTPRequest
	tile_container = $TileContainer
	camera = $Camera2D

	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	update_map()

func update_map():
	# Limpiar tiles viejos
	for sprite in tiles.values():
		sprite.queue_free()
	tiles.clear()

	tiles_to_request.clear()

	if zoom_level == 0:
		# Mundo entero es un solo tile 0/0/0
		tiles_to_request.append(Vector2i(0, 0))
		tile_container.position = Vector2.ZERO
		tile_container.scale = Vector2.ONE
	else:
		var center_tile = latlon_to_tile(center_lat, center_lon, zoom_level)
		var max_tile = (1 << zoom_level) - 1

		var range_size := 3
		if zoom_level <= 5:
			range_size = 1
		elif zoom_level <= 10:
			range_size = 3
		else:
			range_size = 5

		var half_range = range_size / 2
		var x_start = max(center_tile.x - half_range, 0)
		var x_end = min(center_tile.x + half_range, max_tile)
		var y_start = max(center_tile.y - half_range, 0)
		var y_end = min(center_tile.y + half_range, max_tile)

		for x in x_start : 
			x_end + 1
			for y in y_start : 
				y_end + 1
				tiles_to_request.append(Vector2i(x, y))

		tile_container.position = Vector2(-center_tile.x * TILE_SIZE, -center_tile.y * TILE_SIZE)
		tile_container.scale = Vector2.ONE

	requesting = false
	_request_next_tile()

func _request_next_tile():
	if requesting or tiles_to_request.is_empty():
		return

	var tile = tiles_to_request.pop_front()
	request_tile(zoom_level, tile.x, tile.y)
	requesting = true

func request_tile(z: int, x: int, y: int):
	var max_tile = (1 << z) - 1
	if x < 0 or y < 0 or x > max_tile or y > max_tile:
		requesting = false
		_request_next_tile()
		return

	var url = "https://tile.openstreetmap.org/%d/%d/%d.png" % [z, x, y]
	http_request.set_meta("tile_info", {"z": z, "x": x, "y": y})
	http_request.request(url)

func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray):
	requesting = false
	if response_code != 200 or result != OK:
		print("Error cargando tile:", response_code)
		_request_next_tile()
		return

	var img = Image.new()
	var err = img.load_png_from_buffer(body)
	if err != OK:
		print("Error cargando imagen tile")
		_request_next_tile()
		return

	var tex = ImageTexture.create_from_image(img)

	var info = http_request.get_meta("tile_info")
	if info == null:
		print("No info de tile")
		_request_next_tile()
		return

	var x = info.x
	var y = info.y

	var sprite = Sprite2D.new()
	sprite.texture = tex
	sprite.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
	tile_container.add_child(sprite)

	tiles[Vector2(x, y)] = sprite

	_request_next_tile()

func latlon_to_tile(lat: float, lon: float, zoom: int) -> Vector2i:
	var n = 1 << zoom
	var xtile = int(((lon + 180.0) / 360.0) * n)
	var lat_rad = deg_to_rad(lat)
	var a = tan(lat_rad) + (1.0 / cos(lat_rad))
	var b = log(a) / PI
	var c = (1.0 - b) / 2.0
	var ytile = int(c * n)
	return Vector2i(xtile, ytile)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MASK_LEFT:
			if event.pressed:
				dragging = true
				drag_start_pos = event.position
				map_start_pos = tile_container.position
			else:
				dragging = false
		elif event.button_index == MOUSE_BUTTON_LEFT:
			zoom_camera(event.position, 0.8)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_camera(event.position, 1.25)
	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - drag_start_pos
		tile_container.position = map_start_pos + delta

func zoom_camera(mouse_pos: Vector2, zoom_factor: float) -> void:
	zoom_scale = clamp(zoom_scale * zoom_factor, 0.25, 4)
	camera.zoom = Vector2(zoom_scale, zoom_scale)

	var new_zoom_level = clamp(19 - int(log(zoom_scale) / log(2)), 0, 19)
	if new_zoom_level != zoom_level:
		zoom_level = new_zoom_level
		update_map()

	if zoom_level == 0:
		var screen_size = get_viewport().get_visible_rect().size
		var scale_factor = screen_size.x / TILE_SIZE
		tile_container.scale = Vector2(scale_factor, scale_factor)
		tile_container.position = Vector2.ZERO
	else:
		tile_container.scale = Vector2.ONE
		var center_tile = latlon_to_tile(center_lat, center_lon, zoom_level)
		tile_container.position = Vector2(-center_tile.x * TILE_SIZE, -center_tile.y * TILE_SIZE)

	# Opcional: ajustar posición para que el zoom se centre en el cursor
	# (puedes eliminar esta parte si da problemas)
	var before = camera.get_global_mouse_position()
	var after = camera.get_global_mouse_position()
	var diff = before - after
	tile_container.position += diff
