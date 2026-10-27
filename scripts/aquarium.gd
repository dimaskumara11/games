
extends Node3D

const TANK_WIDTH := 5.0
const TANK_HEIGHT := 3.0
const TANK_DEPTH := 2.5
const GLASS_THICKNESS := 0.035

func _ready() -> void:
	create_tank()

func make_material(
	color: Color,
	roughness: float = 0.8
) -> StandardMaterial3D:
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.roughness = roughness
	return mat

func add_box(
	object_name: String,
	size: Vector3,
	pos: Vector3,
	mat: Material
) -> MeshInstance3D:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = object_name

	var mesh := BoxMesh.new()
	mesh.size = size
	mesh_instance.mesh = mesh
	mesh_instance.position = pos
	mesh_instance.material_override = mat

	add_child(mesh_instance)
	return mesh_instance

func create_tank() -> void:
	var glass := StandardMaterial3D.new()
	glass.albedo_color = Color(0.55, 0.85, 0.95, 0.16)
	glass.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	glass.roughness = 0.08
	glass.cull_mode = BaseMaterial3D.CULL_DISABLED

	var sand := make_material(Color("#c8ad7f"))

	# Lantai aquarium
	add_box(
		"Sand",
		Vector3(TANK_WIDTH, 0.12, TANK_DEPTH),
		Vector3(0, -TANK_HEIGHT / 2.0, 0),
		sand
	)

	# Kaca kiri dan kanan
	for side in [-1.0, 1.0]:
		add_box(
			"SideGlass",
			Vector3(
				GLASS_THICKNESS,
				TANK_HEIGHT,
				TANK_DEPTH
			),
			Vector3(
				side * TANK_WIDTH / 2.0,
				0,
				0
			),
			glass
		)

	# Kaca depan dan belakang
	for side in [-1.0, 1.0]:
		add_box(
			"FrontBackGlass",
			Vector3(
				TANK_WIDTH,
				TANK_HEIGHT,
				GLASS_THICKNESS
			),
			Vector3(
				0,
				0,
				side * TANK_DEPTH / 2.0
			),
			glass
		)

	# Tutup atas aquarium
	add_box(
		"TopGlass",
		Vector3(
			TANK_WIDTH,
			GLASS_THICKNESS,
			TANK_DEPTH
		),
		Vector3(0, TANK_HEIGHT / 2.0, 0),
		glass
	)
