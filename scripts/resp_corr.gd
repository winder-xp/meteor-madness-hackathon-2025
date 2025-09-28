extends Control

@onready var rich: RichTextLabel = $"texto respuesta correcta"

var asteroide := 'Bennu'   # CAMBIAR, DATO DEL USUARIO --------------------------------------------
var text := ''

# BOTÓN O ALGO DE QUÉ PASARIA SI...

# Un texto correcto para cada uno de los asteroides (se supone que si el juego ha cambiado a esta escena
# es porque el usuario ha acertado con la estrategia de mitigación)
var text_correcto_itokawa: String = '                                                                       [b][font_size=30]CONGRATULATIONS[/font_size] [/b]
[font_size=14]The kinetic impactor was indeed the most effective way to deflect this asteroid. 

Itokawa is a relatively small asteroid, with low density and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

If the warning period had been longer, an ion beam shepherd or a gravity tractor would have likely been the best options, since they carry no risk of fragmenting the asteroid. However, with only a seven-year lead time, it wouldn’t have been realistic to launch such a system and still expect a measurable deflection in time.
By contrast, a nuclear interceptor would have certainly fragmented the asteroid, as it is a very hard to control deflection method.

That’s why one or more carefully planned and precisely executed kinetic impactors were the best choice in this case: the risk of fragmentation was low, and the approach was achievable within a seven-year timeframe.

[b]Not all heroes wear capes. Some just throw big things at bigger rocks.[/b][/font_size]
'


var text_correcto_bennu := '                                                                       [b][font_size=30]CONGRATULATIONS[/font_size] [/b]
[font_size=14]The gravity tractor was indeed the most effective way to deflect this asteroid.

Bennu is a medium sized asteroid, with low density (slightly higher than water) and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

For this reason, a kinetic impactor would have carried some risk of fragmenting it, which could be avoided by using a contactless deflection method, given the 15-year lead time. Furthermore, a nuclear explosion would have certainly fragmented it, which would have been highly undesirable.

Since the warning period was long, approximately 15 years, the best option was a gravity tractor: it avoided the risk of fragmenting the asteroid while having enough time to deflect it using gravitational force. The spacecraft had to “tow” Bennu for 10 years to achieve a measurable deflection, but 5 years were enough to build the entire spacecraft on Earth. An ion beam shepherd would have also been a good option if the technology needed was more developed.

[b]Great work! You just beat space at its own game.[/b][/font_size]'


func _ready() -> void:
	# Activo BBcode para escribir 
	rich.bbcode_enabled = true
	rich.scroll_active = false
	# Muestro el texto del correo
	if asteroide == 'Itokawa':
		text = text_correcto_itokawa
	elif asteroide == 'Bennu':
		text = text_correcto_bennu
	rich.bbcode_text = text
