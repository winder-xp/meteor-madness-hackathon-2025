extends Control

@onready var nombre: RichTextLabel = $"ScrollContainer/Control/nombre periodico"
@onready var noticia : RichTextLabel = $"ScrollContainer/Control/noticia periodico"
@onready var lin : RichTextLabel = $ScrollContainer/Control/linea
@onready var terre : TextureRect = $"ScrollContainer/Control/noticia terremoto"
@onready var tsuna : TextureRect = $"ScrollContainer/Control/tsunami ciudad"

# Variables que me tienen que llegar
var asteroide := 'Itokawa'
var sitio_de_impacto := false

# Textos 
var titulo := '_______________________________________________________________________
                                            [b][font_size=20]ECHO DAILY[/font_size][/b]'
var linea := '________________________________________________________________________'

var text := ''

var noticia_itok_tierra := '[font_size=12]Friday, 15th of August, 2030[/font_size]
                                              [u][b]Meteor Madness[/b][/u]

Yesterday, as if taken straight from a science fiction film, a meteor impact triggered a devastating earthquake in our beloved city. 
The rocky body measured approximately 330 meters in diameter. The epicenter of the quake was City Hall Square. There is now no trace left of that once charming square; in its place lies a crater roughly 6.8 kilometers wide. Despite the enormous crater caused by the impact, the resulting earthquake in the area registered a magnitude of 6 — not a particularly high value. Every vehicle within a 200-meter radius of the crater was violently displaced and severely damaged. Unsurprisingly, the nearest buildings suffered extensive damage, with partial collapses in most cases, and the total demolition of the skyscrapers due to their height. Residents living just 200 meters farther away could hardly believe their eyes when they saw their beds and wardrobes overturned. The blast wave even reached neighborhoods on the outskirts, over a kilometer away, shattering glass windows. 

Unfortunately, the disaster did not result in material damage alone—dozens of people lost their lives because of the meteor. Yet, as we all know, great catastrophes also bring forth great heroes—or in this case, a furry one. 

A few years ago, several skyscrapers were built near the downtown area of this city in an attempt to modernize the place. As explained earlier, due to their staggering height, most of them quickly succumbed to the explosion unleashed by the impact. The collapse of these giants claimed dozens of lives and left hundreds injured—both those who were inside the buildings and the passersby who had been peacefully walking the streets at that very moment. 

Among those caught in this last situation were a mother and her young son. As she later recounted, during the chaos and the wave of panic that followed, she lost sight of her child. Seconds later, she was horrified to hear her son’s heart-wrenching scream coming from the exact spot where one of the skyscrapers was collapsing. Without hesitation, she rushed toward him, only to find a heap of rubble. According to her, she had never felt such anguish as in those moments, waiting desperately for emergency services after dialing 9-1-1. 

When the firefighters finally arrived and assessed the scene, her hopes plummeted. In their view, it was nearly impossible that anyone could have survived the collapse. Shattered, she begged them to try—to try to rescue her boy, the one she loved more than anything in this universe. 

Half an hour later, everyone present was left speechless at the sight before them. They had never witnessed something so tender and so tragic at once. The child had not been directly beneath the skyscraper when it began to fall, but slightly farther away, where only fragments of debris had reached. Even so, one stone block of that size would have been enough to end any life. 

However, when the firefighters managed to lift that block of stone, what they found was not the body of a child, but of a dog. At the very last moment, the animal—alerted by the boy’s cries—had thrown itself between the child and the deadly block, shielding him in a narrow gap between two stones. In an act of purest altruism, that creature sacrificed its own life to save the innocent child.  '


var noticia_bennu_tierra := '[font_size=12]Friday, 15th of August, 2030[/font_size]
                                              [u][b]Meteor Madness[/b][/u]
											
Yesterday, as if taken straight from a science fiction film, a meteor impact triggered a devastating earthquake in our beloved city.

The rocky body measured approximately 484.44 meters in diameter. The epicenter of the quake was City Hall Square. There is now no trace left of that once charming square; in its place lies a crater roughly 5.9 kilometers wide. Despite the enormous crater caused by the impact, the resulting earthquake in the area registered a magnitude of 6 — not a particularly high value. Every vehicle within a 200-meter radius of the crater was violently displaced and severely damaged. Unsurprisingly, the nearest buildings suffered extensive damage, with partial collapses in most cases, and the total demolition of the skyscrapers due to their height. Residents living just 200 meters farther away could hardly believe their eyes when they saw their beds and wardrobes overturned. The blast wave even reached neighborhoods on the outskirts, over a kilometer away, shattering glass windows.

Unfortunately, the disaster did not result in material damage alone—dozens of people lost their lives because of the meteor. Yet, as we all know, great catastrophes also bring forth great heroes—or in this case, a furry one.

A few years ago, several skyscrapers were built near the downtown area of this city in an attempt to modernize the place. As explained earlier, due to their staggering height, most of them quickly succumbed to the explosion unleashed by the impact. The collapse of these giants claimed dozens of lives and left hundreds injured—both those who were inside the buildings and the passersby who had been peacefully walking the streets at that very moment.

Among those caught in this last situation were a mother and her young son. As she later recounted, during the chaos and the wave of panic that followed, she lost sight of her child. Seconds later, she was horrified to hear her son’s heart-wrenching scream coming from the exact spot where one of the skyscrapers was collapsing. Without hesitation, she rushed toward him, only to find a heap of rubble. According to her, she had never felt such anguish as in those moments, waiting desperately for emergency services after dialing 9-1-1.
When the firefighters finally arrived and assessed the scene, her hopes plummeted. In their view, it was nearly impossible that anyone could have survived the collapse. Shattered, she begged them to try—to try to rescue her boy, the one she loved more than anything in this universe.
Half an hour later, everyone present was left speechless at the sight before them. They had never witnessed something so tender and so tragic at once. The child had not been directly beneath the skyscraper when it began to fall, but slightly farther away, where only fragments of debris had reached. Even so, one stone block of that size would have been enough to end any life.

However, when the firefighters managed to lift that block of stone, what they found was not the body of a child, but of a dog. At the very last moment, the animal—alerted by the boy’s cries—had thrown itself between the child and the deadly block, shielding him in a narrow gap between two stones. In an act of purest altruism, that creature sacrificed its own life to save the innocent child.
'

var noticia_rame_tierra := '[font_size=12]Friday, 15th of August, 2030[/font_size]
                                              [u][b]Meteor Madness[/b][/u]
											
Yesterday, as if taken straight from a science fiction film, a meteor impact triggered a devastating earthquake in our beloved city.

The rocky body measured approximately 872 meters in diameter. The epicenter of the quake was City Hall Square. There is now no trace left of that once charming square; in its place lies a crater roughly 9.9 kilometers wide. Despite the enormous crater caused by the impact, the resulting earthquake in the area registered a magnitude of 7 — not a particularly high value. Every vehicle within a 200-meter radius of the crater was violently displaced and severely damaged. Unsurprisingly, the nearest buildings suffered extensive damage, with partial collapses in most cases, and the total demolition of the skyscrapers due to their height. Residents living just 200 meters farther away could hardly believe their eyes when they saw their beds and wardrobes overturned. The blast wave even reached neighborhoods on the outskirts, over a kilometer away, shattering glass windows.

Unfortunately, the disaster did not result in material damage alone—dozens of people lost their lives because of the meteor. Yet, as we all know, great catastrophes also bring forth great heroes—or in this case, a furry one.

A few years ago, several skyscrapers were built near the downtown area of this city in an attempt to modernize the place. As explained earlier, due to their staggering height, most of them quickly succumbed to the explosion unleashed by the impact. The collapse of these giants claimed dozens of lives and left hundreds injured—both those who were inside the buildings and the passersby who had been peacefully walking the streets at that very moment.

Among those caught in this last situation were a mother and her young son. As she later recounted, during the chaos and the wave of panic that followed, she lost sight of her child. Seconds later, she was horrified to hear her son’s heart-wrenching scream coming from the exact spot where one of the skyscrapers was collapsing. Without hesitation, she rushed toward him, only to find a heap of rubble. According to her, she had never felt such anguish as in those moments, waiting desperately for emergency services after dialing 9-1-1.
When the firefighters finally arrived and assessed the scene, her hopes plummeted. In their view, it was nearly impossible that anyone could have survived the collapse. Shattered, she begged them to try—to try to rescue her boy, the one she loved more than anything in this universe.
Half an hour later, everyone present was left speechless at the sight before them. They had never witnessed something so tender and so tragic at once. The child had not been directly beneath the skyscraper when it began to fall, but slightly farther away, where only fragments of debris had reached. Even so, one stone block of that size would have been enough to end any life.

However, when the firefighters managed to lift that block of stone, what they found was not the body of a child, but of a dog. At the very last moment, the animal—alerted by the boy’s cries—had thrown itself between the child and the deadly block, shielding him in a narrow gap between two stones. In an act of purest altruism, that creature sacrificed its own life to save the innocent child.
'


var noticia_itok_mar := '[font_size=12]Wednesday, 28th of July, 2028[/font_size]
                                              [u][b]Meteor Madness[/b][/u]

Just a few days ago, a meteor impacted in the middle of the sea, roughly 60 km offshore from our beaches. The wave produced by the submarine earthquake reached roughly 10 meters in height, which explains why our neighbors’ basements were completely floaded even 15 kilometers inland.

This unbelievable episode was caused by the NASA recent-discovered asteroid Itokawa. Despite the mitigation strategies scientists all over the world developed to avoid these threats coming true, they could not help this spatial rocky body to land on Earth. 

At 4:37 PM on that tragic day, pedestrians along the promenade and especially those citizens who were sunbathing on the beach, stared confused as the sea suddenly receded by dozens of meters—vanishing without warning. Those who understood the terrifying significance of this phenomenon ran for their lives. But it was in vain. Just five minutes later, the first wave struck.
The beachfront homes were the first to be detroyed. Their destruction only added to the tsunami’s devastating power, as the incoming waves swept up debris—turning wood, metal, and stone into deadly projectiles. Homes, businesses, monuments, and vehicles were all swallowed by the surge.
Such was the force of the tsunami that water and debris reached nearly 15 kilometers inland. The material losses are estimated in the millions, but far more chilling is the current death toll: 15,678 lives lost.

Our beloved city became the very image of chaos. And yet—just as Deimos, the god of terror, was born of Aphrodite—it should come as no surprise that in the wake of fear, love walks hand in hand.
That love now takes the form of support and solidarity. As residents struggle to pump water from the streets, hundreds of volunteers and donations continue to pour in. But love also reveals itself in heartbreaking ways.

One firefighter, visibly shaken, recounted how his team managed to pry open a car swept inland by the waves. Inside, they found a young couple, hands still clasped together. Between them, a wedding ring.
For better or worse, their final act was a vow of eternal love.
'

var noticia_bennu_mar := '[font_size=12]Wednesday, 28th of July, 2028[/font_size]
                                              [u][b]Meteor Madness[/b][/u]
											
Just a few days ago, a meteor impacted in the middle of the sea, roughly 60 km offshore from our beaches. The wave produced by the submarine earthquake reached roughly 10 meters in height, which explains why our neighbors’ basements were completely floaded even 15 kilometers inland.

This unbelievable episode was caused by the NASA recent-discovered asteroid Bennu. Despite the mitigation strategies scientists all over the world developed to avoid these threats coming true, they could not help this spatial rocky body to land on Earth. 

At 4:37 PM on that tragic day, pedestrians along the promenade and especially those citizens who were sunbathing on the beach, stared confused as the sea suddenly receded by dozens of meters—vanishing without warning. Those who understood the terrifying significance of this phenomenon ran for their lives. But it was in vain. Just five minutes later, the first wave struck.
The beachfront homes were the first to be destroyed. Their destruction only added to the tsunami’s devastating power, as the incoming waves swept up debris—turning wood, metal, and stone into deadly projectiles. Homes, businesses, monuments, and vehicles were all swallowed by the surge.
Such was the force of the tsunami that water and debris reached nearly 15 kilometers inland. The material losses are estimated in the millions, but far more chilling is the current death toll: 15,678 lives lost.

Our beloved city became the very image of chaos. And yet—just as Deimos, the god of terror, was born of Aphrodite—it should come as no surprise that in the wake of fear, love walks hand in hand.
That love now takes the form of support and solidarity. As residents struggle to pump water from the streets, hundreds of volunteers and donations continue to pour in. But love also reveals itself in heartbreaking ways.

One firefighter, visibly shaken, recounted how his team managed to pry open a car swept inland by the waves. Inside, they found a young couple, hands still clasped together. Between them, a wedding ring.
For better or worse, their final act was a vow of eternal love.
'

var noticia_rame_mar := '[font_size=12]Wednesday, 28th of July, 2028[/font_size]
                                              [u][b]Meteor Madness[/b][/u]
Just a few days ago, a meteor impacted in the middle of the sea, roughly 60 km offshore from our beaches. The wave produced by the submarine earthquake reached roughly 10 meters in height, which explains why our neighbors’ basements were completely floaded even 15 kilometers inland.

This unbelievable episode was caused by the NASA recent-discovered asteroid Rame-127. Despite the mitigation strategies scientists all over the world developed to avoid these threats coming true, they could not help this spatial rocky body to land on Earth. 

At 4:37 PM on that tragic day, pedestrians along the promenade and especially those citizens who were sunbathing on the beach, stared confused as the sea suddenly receded by dozens of meters—vanishing without warning. Those who understood the terrifying significance of this phenomenon ran for their lives. But it was in vain. Just five minutes later, the first wave struck.
The beachfront homes were the first to be destroyed. Their destruction only added to the tsunami’s devastating power, as the incoming waves swept up debris—turning wood, metal, and stone into deadly projectiles. Homes, businesses, monuments, and vehicles were all swallowed by the surge.
Such was the force of the tsunami that water and debris reached nearly 15 kilometers inland. The material losses are estimated in the millions, but far more chilling is the current death toll: 15,678 lives lost.

Our beloved city became the very image of chaos. And yet—just as Deimos, the god of terror, was born of Aphrodite—it should come as no surprise that in the wake of fear, love walks hand in hand.
That love now takes the form of support and solidarity. As residents struggle to pump water from the streets, hundreds of volunteers and donations continue to pour in. But love also reveals itself in heartbreaking ways.

One firefighter, visibly shaken, recounted how his team managed to pry open a car swept inland by the waves. Inside, they found a young couple, hands still clasped together. Between them, a wedding ring.

For better or worse, their final act was a vow of eternal love.
'


func _ready() -> void:
	terre.visible = false 
	tsuna.visible = false # Lo oculta
	
	# Activo BBcode para escribir 
	nombre.bbcode_enabled = true
	nombre.scroll_active = false

	noticia.bbcode_enabled = true
	noticia.scroll_active = false
	
	lin.bbcode_enabled = true
	lin.scroll_active = false

	if asteroide == 'Itokawa':
		if sitio_de_impacto == true:
			text = noticia_itok_tierra
			terre.visible = true
			tsuna.visible = false
		if sitio_de_impacto == false:
			text = noticia_itok_mar
			tsuna.visible = true
			terre.visible = false
	elif asteroide == 'Bennu':
		if sitio_de_impacto == true:
			text = noticia_bennu_tierra
			terre.visible = true
			tsuna.visible = false
		if sitio_de_impacto == false:
			text = noticia_bennu_mar
			tsuna.visible = true
			terre.visible = false
	elif asteroide == 'Rame-127':
		if sitio_de_impacto == true:
			text = noticia_rame_tierra
			terre.visible = true
			tsuna.visible = false
		if sitio_de_impacto == false:
			text = noticia_rame_mar
			tsuna.visible = true
			terre.visible = false
		
	# Muestro el texto del correo
	nombre.bbcode_text = titulo
	noticia.bbcode_text = text
	lin.bbcode_text = linea
	
	# Activo que reciba eventos del ratón
	noticia.mouse_filter = Control.MOUSE_FILTER_STOP
	
	
	
	
	
