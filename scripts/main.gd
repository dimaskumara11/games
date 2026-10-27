
extends Node3D

const FISH_SCENE: PackedScene = preload(
    "res://scenes/Fish.tscn"
)

var food_count := 10
var fish_list: Array[Node3D] = []

@onready var fish_container: Node3D = $FishContainer
@onready var feed_button: Button = $UI/Control/FeedButton

func _ready() -> void:
	randomize()

	setup_lighting()
	spawn_fish(6)
	create_test_object()

	feed_button.text = "Beri Makan (%d)" % food_count
	feed_button.pressed.connect(feed_fish)

func create_test_object() -> void:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = "TestCube"

	var cube := BoxMesh.new()
	cube.size = Vector3(1.0, 1.0, 1.0)
	mesh_instance.mesh = cube

	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color.ORANGE
	mesh_instance.material_override = mat

	add_child(mesh_instance)
	mesh_instance.position = Vector3(0, 0, 0)
	
func setup_lighting() -> void:
	var light := $DirectionalLight3D as DirectionalLight3D
	light.rotation_degrees = Vector3(-35, -25, 0)
	light.light_energy = 1.2

func spawn_fish(amount: int) -> void:
	for i in range(amount):
		var fish := FISH_SCENE.instantiate() as Node3D
		fish.position = Vector3(
			randf_range(-1.8, 1.8),
			randf_range(-0.8, 0.8),
			randf_range(-0.6, 0.6)
		)

		fish_container.add_child(fish)
		fish_list.append(fish)

func feed_fish() -> void:
	if food_count <= 0:
		feed_button.text = "Makanan Habis"
		return

	food_count -= 1
	feed_button.text = "Beri Makan (%d)" % food_count

	# Prototipe: beri respons visual sederhana.
	for fish in fish_list:
		if is_instance_valid(fish):
			fish.swim_speed = 0.9
