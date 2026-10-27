
extends Node3D

func _ready() -> void:
	# Kamera
	var camera := Camera3D.new()
	add_child(camera)
	camera.position = Vector3(0, 3.5, 8)
	camera.look_at(Vector3.ZERO, Vector3.UP)
	camera.current = true

	# Pencahayaan
	var light := DirectionalLight3D.new()
	add_child(light)
	light.rotation_degrees = Vector3(-35, -25, 0)
	light.light_energy = 1.5

	# Lantai pasir
	var sand := MeshInstance3D.new()
	var sand_mesh := BoxMesh.new()
	sand_mesh.size = Vector3(6, 0.2, 3)
	sand.mesh = sand_mesh
	sand.position = Vector3(0, -1.5, 0)
	add_child(sand)

	var sand_mat := StandardMaterial3D.new()
	sand_mat.albedo_color = Color("#d8bd83")
	sand.material_override = sand_mat

	# Air aquarium
	var water := MeshInstance3D.new()
	var water_mesh := BoxMesh.new()
	water_mesh.size = Vector3(5.8, 2.8, 2.8)
	water.mesh = water_mesh
	water.position = Vector3(0, 0, 0)

	var water_mat := StandardMaterial3D.new()
	water_mat.albedo_color = Color(0.05, 0.55, 0.8, 0.25)
	water_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	water.material_override = water_mat
	add_child(water)

	# Ikan sederhana
	for i in range(5):
		var fish := MeshInstance3D.new()
		var fish_mesh := SphereMesh.new()
		fish_mesh.radius = 0.22
		fish_mesh.height = 0.4
		fish.mesh = fish_mesh

		var fish_mat := StandardMaterial3D.new()
		fish_mat.albedo_color = Color.from_hsv(
			randf(), 0.8, 0.95
		)
		fish.material_override = fish_mat

		fish.position = Vector3(
			randf_range(-2, 2),
			randf_range(-0.8, 0.8),
			randf_range(-0.8, 0.8)
		)
		add_child(fish)
