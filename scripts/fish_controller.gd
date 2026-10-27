
extends Node3D

@export var swim_speed: float = 0.65
@export var turn_speed: float = 2.0

@export var min_bound := Vector3(-2.2, -1.0, -0.85)
@export var max_bound := Vector3(2.2, 1.0, 0.85)

var target_position := Vector3.ZERO
var idle_time := 0.0

func _ready() -> void:
	randomize()
	choose_target()

func choose_target() -> void:
	target_position = Vector3(
		randf_range(min_bound.x, max_bound.x),
		randf_range(min_bound.y, max_bound.y),
		randf_range(min_bound.z, max_bound.z)
	)

func _process(delta: float) -> void:
	var direction := target_position - position
	direction.y *= 0.65

	if direction.length() < 0.12:
		choose_target()
		return

	direction = direction.normalized()

	# Arahkan kepala ikan ke tujuan.
	var target_basis := Basis.looking_at(
		direction,
		Vector3.UP
	)
	basis = basis.slerp(
		target_basis,
		clampf(turn_speed * delta, 0.0, 1.0)
	)

	# Gerakan maju.
	position += -global_basis.z * swim_speed * delta

	# Hindari keluar dari area aquarium.
	position.x = clampf(position.x, min_bound.x, max_bound.x)
	position.y = clampf(position.y, min_bound.y, max_bound.y)
	position.z = clampf(position.z, min_bound.z, max_bound.z)
