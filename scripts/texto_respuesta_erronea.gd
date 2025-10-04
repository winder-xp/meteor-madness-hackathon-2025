extends Control

@onready var richi: RichTextLabel = $"texto respuesta erronea"
@onready var impact: Button = $"impact consequences"

var asteroide := 'Rame-127'   # CAMBIAR, DATO DEL USUARIO --------------------------------------------
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


# ---------------------------------- RAME-127 ----------------------------------------------------
var text_kinetic_rame := '                                               [b][font_size=30]Dinosaurs: part II, featuring you.[/font_size] [/b]

[font_size=14]The kinetic impactor was not the best way to act against this upcoming asteroid.

Rame-127 is a massive medium sized asteroid, with an exceptionally high density due to its composition of iron- and magnesium-rich silicates. This makes it extremely compact and rocky, meaning it is not likely to break apart easily.

For this reason, a single kinetic impactor didn’t have enough energy to produce a measurable deflection. Multiple spacecrafts impacting the asteroid would have been required to transfer sufficient momentum to alter the asteroid’s trajectory, which would have been unfeasible given such a short warning period.

Instead, a standoff nuclear explosion could have provided enough energy to deflect the asteroid without carrying a high risk of breaking it, thanks to its compact composition. With six years of lead time, there would have been enough time to plan and execute the entire mission.

[b]This is not a drill… actually, drills won’t help either[/b][/font_size].
'

var text_ion_rame := '                                               [b][font_size=30]Dinosaurs: part II, featuring you.[/font_size] [/b]

[font_size=14]The ion beam shepherd was not the best way to act against this upcoming asteroid.

Rame-127 is a massive medium sized asteroid, with an exceptionally high density due to its composition of iron- and magnesium-rich silicates. This makes it extremely compact and rocky, meaning it is not likely to break apart easily.

Due to its enormous mass, an ion beam shepherd would have needed a few decades to make a measurable deflection, not to mention that the technology needed for such a complex mission is still very inmature. 

Instead, a standoff nuclear explosion could have provided enough energy to deflect the asteroid without carrying a high risk of breaking it, thanks to its compact composition. With six years of lead time, there would have been enough time to plan and execute the entire mission.

[b]Asteroid: 1. Humanity: 0.[/b][/font_size]
'


var text_gravity_rame := '[b][font_size=30]Good evening, Earth. Tonight’s forecast: 100% chance of asteroid showers.[/font_size] [/b]
[font_size=14]The gravity tractor was not the best way to act against this approaching asteroid.

Rame-127 is a massive medium sized asteroid, with an exceptionally high density due to its composition of iron- and magnesium-rich silicates. This makes it extremely compact and rocky, meaning it is not likely to break apart easily.

Due to its enormous mass, a gravity tractor would have needed a few decades to make a measurable deflection, and an enormous mass to exert a significant gravitational force in the asteroid, which would have been unfeasible with the technology available today. 

Instead, a standoff nuclear explosion could have provided enough energy to deflect the asteroid without carrying a high risk of breaking it, thanks to its compact composition. With six years of lead time, there would have been enough time to plan and execute the entire mission.

[b]Earth update: patch 2.0 includes one giant hole.[/b][/font_size]
'

var text_evacuation_rame := '[b][font_size=30]Mission accomplished… if the goal was Earth’s destruction.[/font_size] [/b]

[font_size=14]Protection and evacuation was not the best way to act against this upcoming asteroid. Due to its magnitude, the damages done by the impact were terrible, and with a seven-year lead, they could have certainly be avoided.

Rame-127 is a massive medium sized asteroid, with an exceptionally high density due to its composition of iron- and magnesium-rich silicates. This makes it extremely compact and rocky, meaning it is not likely to break apart easily.

Given these factors, the nuclear interceptor was the most suitable strategy. It provided the immense force needed to alter the asteroid’s course within the short warning period, making it the only realistic option against an object of such enormous mass.

[b]Earth tried to survive… you clearly had other plans.[/b][/font_size]
'

# Si el usuario pulsa el botón de simular impacto empieza la animación del asteroide impactando
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pre_impacto.tscn")
	

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
	# Rame-127
	elif asteroide == 'Rame-127':
		if Global.selections["b1"] == 'the kinetic impactor':
			texto = text_kinetic_rame
		elif Global.selections["b1"] == 'the ion beam shepherd': 
			texto = text_ion_rame
		elif Global.selections["b1"] == 'the gravity tractor':
			texto = text_gravity_rame
		elif Global.selections["b1"] == 'protection and evacuation':
			texto = text_evacuation_rame
	# Muestro el texto del correo
	richi.bbcode_text = texto

	# Respuesta al botón
	impact.pressed.connect(_on_button_pressed)
