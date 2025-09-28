extends Control

@onready var richi: RichTextLabel = $"texto respuesta erronea"

var asteroide := 'Bennu'   # CAMBIAR, DATO DEL USUARIO --------------------------------------------
var texto := ''

# Un texto  para cada uno de los asteroides y cada una de las respuestas incorrectas
#------------------------------------------ ITOKAWA ----------------------------

var text_gravity_itokawa: String = '                        [b][font_size=30]Houston… we have a problem. Oh wait, that’s us.[/font_size] [/b]

[font_size=14]The gravity tractor was not the best way to act against this approaching asteroid.

Itokawa is a relatively small asteroid, with low density and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

If the warning period had been longer, gravity tractor would have likely been the best option, since they carry no risk of fragmenting the asteroid. However, with only a seven-year lead time, there wasn’t enough time for the spacecraft to deflect the asteroid using the force of gravity. A minimum lead time of around 20 years would have been necessary to carry out such a procedure.

In this scenario, one or more carefully planned and precisely executed kinetic impactors would have been the best choice in this case: the risk of fragmentation would have been low, and the approach would have been achievable within a seven-year timeframe.

[b]Asteroid: 1. Humanity: 0.[/b][/font_size]'


var text_ion_itokawa: String = '                       [b][font_size=30]Houston… we have a problem. Oh wait, that’s us.[/font_size] [/b]

[font_size=14]The ion beam shepherd was not the best way to act against this upcoming asteroid.

Itokawa is a relatively small asteroid, with low density and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

If the warning period had been longer, an ion beam shepherd would have likely been the best option, since they carry no risk of fragmenting the asteroid. However, with only a seven-year lead time, there wouldn’t have been enough time for the spacecraft to deflect the asteroid using the force of gravity. A minimum lead time of around 20 years would have been necessary to carry out such a procedure.

In this scenario, one or more carefully planned and precisely executed kinetic impactors would have been the best choice in this case: the risk of fragmentation would have been low, and the approach would have been achievable within a seven-year timeframe.

[b]Asteroid: 1. Humanity: 0.[/b][/font_size]'


var text_nuclear_itokawa: String = '                   [b][font_size=30]Houston… we have a problem. Oh wait, that’s us.[/font_size] [/b]

[font_size=14]The nuclear interceptor was not the best way to act against this upcoming asteroid.

Itokawa is a relatively small asteroid, with low density and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

For this reason, the nuclear explosion has fragmented the asteroid into smaller, uncontrollable pieces, creating a chaotic shower of deadly debris. It is not a desirable ending at all.

In this scenario, one or more carefully planned and precisely executed kinetic impactors would the best choice in this case: the risk of fragmentation would have been low, and the approach would have been achievable within a seven-year timeframe.

[b]Asteroid: 1. Humanity: 0.[/b][/font_size]'


var text_evacuation_itokawa: String = '                           [b][font_size=30]Everybody, grab a helmet![/font_size] [/b]

[font_size=14]Protection and evacuation was not the best way to act against this upcoming asteroid. Due to its magnitude, the damages done by the impact were terrible, and with a seven-year lead, they could have certainly be avoided.

Itokawa is a relatively small asteroid, with low density and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

In this scenario, one or more carefully planned and precisely executed kinetic impactors would the best choice in this case: the risk of fragmentation would have been low, and the approach would have been achievable within a seven-year timeframe.

[b]Good news: we stopped the asteroid. Bad news: it stopped right on Earth.[/b][font_size]
'


#---------------------------------------- BENNU --------------------------------
var text_kinetic_bennu: String = '[b][font_size=30]Attention passengers: this is your captain speaking… brace for asteroid.[/font_size] [/b]

[font_size=14]The kinetic impactor was not the best way to act against this upcoming asteroid.

Bennu is a medium sized asteroid, with low density (slightly higher than water) and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

For this reason, a kinetic impactor would have carried some risk of fragmenting it, which could be avoided by using a contactless deflection method, such as the gravity tractor, given the 15-year lead time. 

[b]Goodbye world… it was fun while it lasted.[/b][/font_size]'


var text_ion_bennu: String = '[b][font_size=30]Alert: asteroid scheduled to arrive earlier than your Amazon package.[/font_size] [/b]

[font_size=14]The ion beam shepherd was not the best way to act against this upcoming asteroid.

Bennu is a medium sized asteroid, with low density (slightly higher than water) and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

For this reason, a contactless deflection method would have been the best option given the 15 years lead time. However, since the efficiency of the ion beam shepherd still remains theoretical and the technology required to implement it is not yet mature, a much longer lead time would have been necessary to ensure this technique could work. That’s why, in this case, the most efficient strategy would have been a gravity tractor.

[b]Countdown complete. Boom incoming.[/b][/font_size]'


var text_nuclear_bennu: String = '                                                         [b][font_size=30]Goodbye Earth, rocks win.[/font_size] [/b]

[font_size=14]The nuclear interceptor was not the best way to act against this upcoming asteroid.

Bennu is a medium sized asteroid, with low density (slightly higher than water) and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

For this reason, the nuclear explosion has fragmented the asteroid into smaller, uncontrollable pieces, creating a chaotic shower of deadly debris. It is not a desirable ending at all.

In this case, since the warning period was long, approximately 15 years, the best option was a gravity tractor: it avoided the risk of fragmenting the asteroid while having enough time to deflect it using gravitational force.

[b]Mission failed, asteroid says hi.[/b][/font_size]'


var text_evacuation_bennu: String = '                   [b][font_size=30]Breaking news: Earth applies for crater status.[/font_size] [/b]

[font_size=14]Protection and evacuation was not the best way to act against this upcoming asteroid. Due to its magnitude, the damages done by the impact were terrible, and with a 15-year lead, they could have certainly be avoided.

Bennu is a medium sized asteroid, with low density (slightly higher than water) and high porosity. That’s why it is often described as a ‘rubble pile’: a celestial body made up of numerous pieces of debris which have collapsed and stuck together due to the force of gravity. 

For this reason, since the warning period was long, approximately 15 years, the best option was a gravity tractor: it avoided the risk of fragmenting the asteroid while having enough time to deflect it using gravitational force.

[b]Earth tried to survive… you clearly had other plans.[/b][/font_size]'

func _ready() -> void:
	# Activo BBcode para escribir 
	richi.bbcode_enabled = true
	richi.scroll_active = false
	# Itokawa
	if asteroide == 'Itokawa':
		if Global.selections["b1"] == 'the gravity tractor':
			texto = text_gravity_itokawa
		elif Global.selections["b1"] == 'the ion beam shepherd': 
			texto = text_ion_itokawa
		elif Global.selections["b1"] == 'the nuclear interceptor':
			texto = text_nuclear_itokawa
		elif Global.selections["b1"] == 'protection and evacuation':
			texto = text_evacuation_itokawa
	# Bennu
	elif asteroide == 'Bennu':
		if Global.selections["b1"] == 'the kinetic impactor':
			texto = text_kinetic_bennu
		elif Global.selections["b1"] == 'the ion beam shepherd': 
			texto = text_ion_bennu
		elif Global.selections["b1"] == 'the nuclear interceptor':
			texto = text_nuclear_bennu
		elif Global.selections["b1"] == 'protection and evacuation':
			texto = text_evacuation_bennu
	
	# Muestro el texto del correo
	richi.bbcode_text = texto
