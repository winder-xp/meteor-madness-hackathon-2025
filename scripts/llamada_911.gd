extends Control

@onready var rich : RichTextLabel = $"texto llamada"
@onready var rich2 : RichTextLabel = $"texto caller"
@onready var button : Button = $next


var text_911 := '
[b][font_size=25]9-1-1 DISPATCHER:[/font_size][/b]
	-	9-1-1 What’s your emergency?'

var text_caller :='
[b][font_size=25]CALLER: [/font_size][/b]
-	[font_size=20]My child! You have to save him! We were walking down the street when suddenly the buildings started shaking. It all happened so fast—I can hardly remember anything. People were running everywhere, and I couldn’t see my son until I heard him screaming. Then the nearest skyscraper collapsed and now… I can’t find him! Please, call the firefighters, the police—anyone! Please, bring me back my son. He’s my whole life, please![/font_size]
'

func _on_next_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/noticia.tscn")


func _ready() -> void:
	# Activo BBcode para escribir 
	rich.bbcode_enabled = true
	rich.scroll_active = false
	
	rich2.bbcode_enabled = true
	rich2.scroll_active = false
	
	# Muestro el texto del correo
	rich.bbcode_text = text_911
	rich2.bbcode_text = text_caller
	
	button.pressed.connect(_on_next_pressed)
