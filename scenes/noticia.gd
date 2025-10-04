extends Control

@onready var nombre: RichTextLabel = $"ScrollContainer/Control/nombre periodico"
@onready var noticia : RichTextLabel = $"ScrollContainer/Control/noticia periodico"
@onready var lin : RichTextLabel = $ScrollContainer/Control/linea

var asteroide := 'Itokawa'
var titulo := '_________________________________________________________________
                                         [b][font_size=20]ECHO DAILY[/font_size][/b]'
var linea := '_________________________________________________________________'

var text := ''

var noticia_itok := '[b]Meteor Madness[/b]

Yesterday, as if taken straight from a science fiction film, a meteor impact triggered a devastating earthquake in our beloved city. 
The rocky body measured approximately 6,700 meters in diameter. The epicenter of the quake was City Hall Square. There is now no trace left of that once charming square; in its place lies a crater roughly 6.8 kilometers wide. Despite the enormous crater caused by the impact, the resulting earthquake in the area registered a magnitude of 6 — not a particularly high value. Every vehicle within a 200-meter radius of the crater was violently displaced and severely damaged. Unsurprisingly, the nearest buildings suffered extensive damage, with partial collapses in most cases, and the total demolition of the skyscrapers due to their height. Residents living just 200 meters farther away could hardly believe their eyes when they saw their beds and wardrobes overturned. The blast wave even reached neighborhoods on the outskirts, over a kilometer away, shattering glass windows. 

Unfortunately, the disaster did not result in material damage alone—dozens of people lost their lives because of the meteor. Yet, as we all know, great catastrophes also bring forth great heroes—or in this case, a furry one. 

A few years ago, several skyscrapers were built near the downtown area of this city in an attempt to modernize the place. As explained earlier, due to their staggering height, most of them quickly succumbed to the explosion unleashed by the impact. The collapse of these giants claimed dozens of lives and left hundreds injured—both those who were inside the buildings and the passersby who had been peacefully walking the streets at that very moment. 

Among those caught in this last situation were a mother and her young son. As she later recounted, during the chaos and the wave of panic that followed, she lost sight of her child. Seconds later, she was horrified to hear her son’s heart-wrenching scream coming from the exact spot where one of the skyscrapers was collapsing. Without hesitation, she rushed toward him, only to find a heap of rubble. According to her, she had never felt such anguish as in those moments, waiting desperately for emergency services after dialing 9-1-1. 

When the firefighters finally arrived and assessed the scene, her hopes plummeted. In their view, it was nearly impossible that anyone could have survived the collapse. Shattered, she begged them to try—to try to rescue her boy, the one she loved more than anything in this universe. 

Half an hour later, everyone present was left speechless at the sight before them. They had never witnessed something so tender and so tragic at once. The child had not been directly beneath the skyscraper when it began to fall, but slightly farther away, where only fragments of debris had reached. Even so, one stone block of that size would have been enough to end any life. 

However, when the firefighters managed to lift that block of stone, what they found was not the body of a child, but of a dog. At the very last moment, the animal—alerted by the boy’s cries—had thrown itself between the child and the deadly block, shielding him in a narrow gap between two stones. In an act of purest altruism, that creature sacrificed its own life to save the innocent child.  '
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
	
	# Activo que reciba eventos del ratón
	noticia.mouse_filter = Control.MOUSE_FILTER_STOP
	
	
	
	
	
