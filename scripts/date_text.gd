extends RichTextLabel
@onready var itokawa = $"../AsteroidSet/Itokawa"
@onready var seconds = 23328000 + 2025 * 365*24*3600 + itokawa.time
var minutes = 0
var hours = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func es_bisiesto(year):
	return year % 400 == 0 or (year % 4 == 0 and year % 100 != 0)

func doble_cifra(number):
	if len(str(number)) == 1:
		return "0" + str(number)
	else:
		return str(number)

func segundos_a_fecha(segundos):
	var dias = int(segundos / 86400)

	var year = 0
	while true:
		var dias_en_anio = 366 if es_bisiesto(year) else 365
		if dias >= dias_en_anio:
			dias -= dias_en_anio
			year += 1
		else:
			break

	# calcular el mes
	var meses = [31, 29 if es_bisiesto(year) else 28, 31, 30, 31, 30,
				31, 31, 30, 31, 30, 31]

	var month = 1
	for dim in meses:
		if dias >= dim:
			dias -= dim
			month += 1
		else:
			break
	var day = dias + 1  # porque los días empiezan en 1
	return str(year) + "-" + doble_cifra(month) + "-" + doble_cifra(day)

	# Ejemplo: 86400 segundos = 1 día -> 0000-01-02
	print(segundos_a_fecha(86400))  # (0, 1, 2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	seconds = 63925977600 + int(itokawa.time)
	minutes = int(seconds / 60)
	hours = int(minutes / 60)
	text = segundos_a_fecha(seconds) + "  " + doble_cifra(hours%24) + ":" + doble_cifra(minutes%60) + ":" + doble_cifra(seconds%60)
