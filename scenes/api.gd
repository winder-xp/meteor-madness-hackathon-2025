extends Node

var http_request
var resultado_api = []  # Aquí guardaremos los valores que recibamos

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_on_request_completed")
	

# Función para enviar datos a la API con variables que recibimos como argumentos
func enviar_datos_a_api(lat, lon,diametro, densidad, velocidad, tierra= true):
	var url = "https://127.0.0.1.8000/meteorito"
	var datos = {
		"lat": lat,
		"lon": lon,
		"diametro": diametro,
		'densidad': densidad,
		'velocidad': velocidad,
		'tierra': tierra}
	var json_data = JSON.stringify(datos)
	
	
	var headers = ["Content-Type: application/json"]
	
	var error = http_request.request(url, headers, false, HTTPClient.METHOD_POST, json_data)
	if error != OK:
		print("Error al hacer la solicitud:", error)

# Función que recibe la respuesta de la API
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var response_text = body.get_string_from_utf8()
		var respuesta_json = parse_json(response_text)
		
		if typeof(respuesta_json) == TYPE_ARRAY:
			resultado_api = respuesta_json
			print("Datos recibidos:", resultado_api)
			
			# Aquí puedes llamar a otra función para usar esos datos en el programa
			usar_datos(resultado_api)
		else:
			print("Respuesta no es una lista.")
	else:
		print("Error en la respuesta:", response_code)

# Ejemplo de función que usa los datos recibidos
func usar_datos(datos):
	for i in range(datos.size()):
		print("Valor ", i, ": ", datos[i])
		# Aquí puedes hacer lo que necesites con esos datos en tu programa
