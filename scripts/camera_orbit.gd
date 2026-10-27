
extends Node3D

@export var mouse_sensitivity: float = 0.008
@export var touch_sensitivity: float = 0.006
@export var min_pitch: float = -0.25
@export var max_pitch: float = 0.65
@export var camera_distance: float = 7.5

var dragging := false
var pitch := 0.12

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	update_camera()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

	elif event is InputEventMouseMotion and dragging:
		rotate_camera(event.relative, mouse_sensitivity)

	elif event is InputEventScreenTouch:
		dragging = event.pressed

	elif event is InputEventScreenDrag:
		rotate_camera(event.relative, touch_sensitivity)

func rotate_camera(delta_pointer: Vector2, sensitivity: float) -> void:
	rotation.y -= delta_pointer.x * sensitivity

	pitch = clampf(
		pitch - delta_pointer.y * sensitivity,
		min_pitch,
		max_pitch
	)

	update_camera()

func update_camera() -> void:
	if not is_instance_valid(camera):
		return

	# Kamera berada di belakang dan di atas pivot.
	camera.position = Vector3(
		0.0,
		sin(pitch) * camera_distance,
		cos(pitch) * camera_distance
	)

	# Arahkan kamera ke titik aquarium di bawah pivot.
	var target := Vector3(0.0, -0.5, 0.0)

	if camera.global_position.distance_to(
		to_global(target)
	) > 0.01:
		camera.look_at(to_global(target), Vector3.UP)
