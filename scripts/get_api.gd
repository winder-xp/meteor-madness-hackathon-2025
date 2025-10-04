extends Control
@onready var http_request = $HTTPRequest
var url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2025-09-18&end_date=2025-09-25&api_key=3RQfbqpnfnaYLhpEdl9pm5eMGOmZJGlRdPUDc9bd"

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request.request(url)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_http_request_request_completed(result, response_code, headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	var neos = data["near_earth_objects"]
	for date in neos.keys():
		print("Fecha:", date)
		for asteroid in neos[date]:
			print("  Nombre:", asteroid["name"])
			print("  Magnitud absoluta:", asteroid["absolute_magnitude_h"])
			print("  Peligroso?:", asteroid["is_potentially_hazardous_asteroid"])
			print("  Diámetro min (m):", asteroid["estimated_diameter"]["meters"]["estimated_diameter_min"])
			
			# datos de aproximación
			var approach = asteroid["close_approach_data"][0]
			print("  Fecha de aproximación:", approach["close_approach_date_full"])
			print("  Velocidad km/s:", approach["relative_velocity"]["kilometers_per_second"])
