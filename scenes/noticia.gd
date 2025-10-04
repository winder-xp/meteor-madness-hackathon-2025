extends Control

@onready var nombre: RichTextLabel = $"nombre periodico"
@onready var noticia : RichTextLabel = $"noticia periodico"
@onready var lin : RichTextLabel = $"linea"

var asteroide := 'Itokawa'
var titulo := '_________________________________________________________________
                                         [b][font_size=20]ECHO DAILY[/font_size][/b]'
var linea := '_________________________________________________________________'

var text := ''

var noticia_itok := ' '
var noticia_bennu := ''
var noticia_rame := ' '


func _ready() -> void:
	# Activo BBcode para escribir 
	nombre.bbcode_enabled = true
	nombre.scroll_active = false

	noticia.bbcode_enabled = true
	noticia.scroll_active = false
	
	lin.bbcode_enabled = true
	lin.scroll_active = false
	
	if asteroide == 'Itokawa':
		text = noticia_itok
	elif asteroide == 'Bennu':
		text = noticia_bennu
	elif asteroide == 'Rame-127':
		text = noticia_rame
	
	# Muestro el texto del correo
	nombre.bbcode_text = titulo
	noticia.bbcode_text = text
	lin.bbcode_text = linea
	
	
	
