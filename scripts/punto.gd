extends Node2D

@onready var get_api: Control = $"../GetApi"

 #Zona peligro maximo
var radio_terremoto = 15 #Zona peligro
var radio_onda = 25 #Donde se rompen cristales

var METROS_PIXELES = 0

var lon1 = 133.775136 * 2*PI / 360
var lat1 = 80 * 2*PI / 360
var a = 0
var b = 0
var scale_factor = 1.635

signal is_tierra(cierto_falso)

var tiempo = 0

@onready var camera_2d: Camera2D = $"../Camera2D"

@onready var mapa_mundo: Sprite2D = $"../MapaMundo"



func lat_lon_conversion(lon,lat):
	a = mapa_mundo.get_rect().size.x* mapa_mundo.scale.x
	b = mapa_mundo.get_rect().size.y* mapa_mundo.scale.y
	
	return Vector2(a * lon/(2*PI),-log(tan(PI/4 + lat/2))*b/(2*PI))
	
func lat_lon_conversion_inversa(x,y):
	a = mapa_mundo.get_rect().size.x* mapa_mundo.scale.x
	b = mapa_mundo.get_rect().size.y* mapa_mundo.scale.y
	
	return Vector2(2*PI*x/a,2*atan(exp(-2*PI*y/b))-PI/2)

var radio_rojo = 697.8

func _draw():
	
	#var conversion_elipse = (40074 * mapa_mundo.get_rect().size.x) / (mapa_mundo.get_rect().size.y * 2*PI*6378) 
	var conversion_elipse=1
	
	#draw_set_transform(Vector2(0,0),0,Vector2(conversion_elipse*1,1))
	
	draw_circle(Vector2(0,0),radio_onda,Color(0,255,255/11*scale_onda))
	draw_circle(Vector2(0,0),radio_terremoto,Color(255,0,255/11*(scale_terremoto)))
	draw_circle(Vector2(0,0),radio_rojo,Color(Color.BLACK))

func _ready():
	
	z_index = 1
	
	METROS_PIXELES = mapa_mundo.get_rect().size.x*mapa_mundo.scale.x/(2*PI*6378000)
	
	position = lat_lon_conversion(lon1,lat1)

	add_child(parallax)
	layer.motion_scale = Vector2(0, 0)  # no se mueve ni con la cámara ni con zoom
	parallax.add_child(layer)
	layer.add_child(rich_text_label)
	
	rich_text_label.z_index = 2
	
	texture_rect.visible = false

	
	
var parallax = ParallaxBackground.new()

var layer = ParallaxLayer.new()

func _process(delta):
	radio_rojo = radioapi*METROS_PIXELES*10
	radio_terremoto = radio_rojo*1.6
	radio_onda = radio_rojo * 2.6
	queue_redraw()
	if activateDelta:
		tiempo += delta
	if tiempo > 0.5:
		tiempo = 0
		activateDelta = false
	emit_signal("is_tierra", terreno)
	
@onready var rich_text_label: RichTextLabel = $"../CanvasLayer/TextureRect/RichTextLabel"
	
@onready var texture_rect: TextureRect = $"../CanvasLayer/TextureRect"





var activateDelta = false 

func _input(event):
	# Mouse in viewport coordinates.
	rich_text_label.scale = Vector2(2,2)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		activateDelta = true	
		
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and activateDelta and tiempo>1e-3:
		position = camera_2d.get_global_mouse_position()
		var x = lat_lon_conversion_inversa(camera_2d.get_global_mouse_position().x,0).x
		var y = lat_lon_conversion_inversa(0,camera_2d.get_global_mouse_position().y).y
		
		get_api.llamar_api(x*180/PI,y*180/PI,3353,9000,2000,true)
		
		
	#if event.is_action_pressed("keyQ"):
		#scale_factor += 0.01
		#print(scale_factor)

var terreno = true

#func _on_area_2d_mouse_entered() -> void:
	#terreno = true
	#
#func _on_area_2d_mouse_exited() -> void:
	#terreno = false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print('Tierra \n') # Replace with function body.0
	
@onready var area_raton: Area2D = $"../AreaRaton"



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == area_raton:
		terreno = true
		Global.terreno = terreno


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == area_raton:
		terreno = false
		Global.terreno = terreno

var radioapi = 0
var scale_terremoto = 0
var scale_onda = 0

func _on_get_api_datos_recibidos(radio: float, terremoto: float, onda: float) -> void:
	radioapi = get_api.radio
	scale_terremoto = get_api.terremoto
	scale_onda = get_api.onda
	
	texture_rect.visible = true
	
	rich_text_label.text = '[outline_size={5}]BREAKING NEWS[/outline_size]'
	
