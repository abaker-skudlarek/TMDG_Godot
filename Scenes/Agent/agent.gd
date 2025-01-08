extends Node3D
class_name Agent

@export var player_controlled_camera_scene: PackedScene

var cameras: Array = []
var current_camera_index: int = 0


func _ready() -> void:
	spawn_cameras(Globals.camera_spawn_points)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("next_camera"):
		switch_to_next_camera()
	elif event.is_action_pressed("previous_camera"):
		switch_to_previous_camera()	


func spawn_cameras(spawn_points: Array) -> void:
	for spawn_point: Dictionary in spawn_points:
		var camera: PlayerControlledCamera = player_controlled_camera_scene.instantiate()
		camera.position = spawn_point["position"]
		camera.rotation = spawn_point["rotation"]
		add_child(camera)
		cameras.append(camera)
	assert(cameras.size() == spawn_points.size(), 
			"Amount of spawned cameras {%s} doesn't equal amount of received camera spawn points {%s}" % [cameras.size(), spawn_points.size()])


func switch_to_next_camera() -> void:
	current_camera_index += 1
	if current_camera_index >= cameras.size():
		current_camera_index = 0
	cameras[current_camera_index].camera.current = true


func switch_to_previous_camera() -> void:
	current_camera_index += 1
	if current_camera_index >= cameras.size():
		current_camera_index = 0
	cameras[current_camera_index].camera.current = true
