extends Node

var camera_spawn_points: Array
var spy_spawn_point: Vector3


func _ready() -> void:
	SignalBus.connect("level_loaded", _on_level_loaded)


# TODO: I KIND OF HATE ALL OF THIS BUT MAYBE IT WORKS??
func _on_level_loaded(camera_spawn_points_in: Array, spy_spawn_point_in: Vector3) -> void:
	camera_spawn_points = camera_spawn_points_in
	spy_spawn_point = spy_spawn_point_in
