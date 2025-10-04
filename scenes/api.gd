extends Node

# Señal que se emitirá cuando lleguen los datos
signal datos_recibidos(radio: float, terremoto: float, onda: float)

var http_request : HTTPRequest

# Variables internas (opcional, pero puedes tenerlas también)
var radio : float = 0.0
var terremoto : float = 0.0
var onda : float = 0.0

func _ready():
	# Crear nodo HTTPRequest y conectarlo
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

# Función para llamar a la API con parámetros dinámicos
func llamar_api(lat: float, lon: float, diametro: float, densidad: float, velocidad: float, tierra: bool):
	var url_base = "http://127.0.0.1:8000/meteorito"
	var query = "?lat=%f&lon=%f&diametro=%f&densidad=%f&velocidad=%f&tierra=%s" % [
		lat, lon, diametro, densidad, velocidad, str(tierra).to_lower()
	]
	var url = url_base + query
	print("Llamando a: ", url)

	var error = http_request.request(url)
	if error != OK:
		push_error("Error en la petición: " + str(error))

# Callback cuando llega la respuesta
func _on_request_completed(_result, _response_code, _headers, body):
	var response_text = body.get_string_from_utf8()
	
	var json = JSON.new()
	var parse_error = json.parse(response_text)

	if parse_error == OK:
		var respuesta = json.get_data()
		
		# Guardar en variables
		radio = float(respuesta["radio"])
		terremoto = float(respuesta["terremoto"])
		onda = float(respuesta["onda"])
		
		# Emitir señal con los datos
		emit_signal("datos_recibidos", radio, terremoto, onda)
		print("✅ Datos recibidos y señal emitida")
	else:
		push_error("Error al parsear JSON")
