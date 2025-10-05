extends MeshInstance3D # o MeshInstance3D si tu esfera es un MeshInstance3D
@onready var asteroid_set = $"../AsteroidSet"
@onready var tierra = $"../Tierra"

var velocidad_rotacion = 10.0  # grados por segundo

func _process(delta):
	pass

func _ready():
	'''
	Órbita de la Tierra
	'''
	var curve = Curve3D.new()
	for j in range(1001):
		var angle = (2*PI / 1000) * j
		
		curve.add_point(Vector3(
		tierra.MINOR_AXIS_B * sin(angle),
		0.0,
		tierra.MAJOR_AXIS_A * cos(angle),
		))

	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_LINE_STRIP)
	for p in curve.get_baked_points():
		st.add_vertex(p)
	var orbit_mesh = st.commit()

	var orbit_instance = MeshInstance3D.new()
	orbit_instance.mesh = orbit_mesh
	add_child(orbit_instance)

	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.DIM_GRAY
	mat.emission_enabled = true
	mat.emission = Color.DIM_GRAY
	mat.emission_energy_multiplier = 2.0
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	orbit_instance.set_surface_override_material(0, mat)

func _on_asteroid_2_parameters_ready():
	'''
	Dibujar la órbita
	'''
	for asteroid in asteroid_set.get_children():
		if asteroid.asteroid_id != asteroid.Asteroids._2000_DP107 and asteroid.asteroid_id != asteroid.Asteroids.Dinkinesh:
			var curve = Curve3D.new()
			for j in range(asteroid.num_orbit_points+1):
				var angle = (2*PI / asteroid.num_orbit_points) * j
				
				curve.add_point(Vector3(
				-asteroid.a*cos(angle)*cos(asteroid.i)*sin(asteroid.Omega) + asteroid.b*sin(angle)*cos(asteroid.i)*cos(asteroid.Omega),
				asteroid.a*cos(angle)*sin(asteroid.i)*sin(asteroid.Omega) - asteroid.b*sin(angle)*sin(asteroid.i)*cos(asteroid.Omega),
				asteroid.a*cos(angle)*cos(asteroid.Omega) + asteroid.b*sin(angle)*sin(asteroid.Omega)
				))

			var st = SurfaceTool.new()
			st.begin(Mesh.PRIMITIVE_LINE_STRIP)
			for p in curve.get_baked_points():
				st.add_vertex(p)
			var orbit_mesh = st.commit()

			var orbit_instance = MeshInstance3D.new()
			orbit_instance.mesh = orbit_mesh
			add_child(orbit_instance)

			var mat = StandardMaterial3D.new()
			mat.albedo_color = asteroid.asteroid_test_color
			mat.emission_enabled = true
			mat.emission = asteroid.asteroid_test_color
			mat.emission_energy_multiplier = 2.0
			mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			orbit_instance.set_surface_override_material(0, mat)
