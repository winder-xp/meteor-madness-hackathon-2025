extends Control

@onready var rich = $"texto respuesta correcta"

var text: String = '                                                                       [b][font_size=30]CONGRATULATIONS[/font_size] [/b]
[font_size=14]The kinetic impactor was indeed the most effective way to deflect this asteroid. 

Itokawa is a relatively small asteroid, with low density and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

If the warning period had been longer, an ion beam shepherd or a gravity tractor would have likely been the best options, since they carry no risk of fragmenting the asteroid. However, with only a seven-year lead time, it wouldn’t have been realistic to launch such a system and still expect a measurable deflection in time.

By contrast, a nuclear interceptor would have certainly fragmented the asteroid, as it is a very hard to control deflection method.

That’s why one or more carefully planned and precisely executed kinetic impactors were the best choice in this case: the risk of fragmentation was low, and the approach was achievable within a seven-year timeframe.

Not all heroes wear capes. Some just throw big things at bigger rocks.[/font_size]
'

func _ready() -> void:
	# Activo BBcode para escribir 
	rich.bbcode_enabled = true
	rich.scroll_active = false
	# Muestro el texto del correo
	rich.bbcode_text = text
