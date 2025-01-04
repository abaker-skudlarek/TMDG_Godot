extends Node3D

# TODO:
#	1. Might not want to instantiate the agent inside the level. Right now, it's the best way I can think of to give the agent access to the cameras

@onready var cameras: Array[Node] = get_tree().get_nodes_in_group("cameras")
var current_camera_index: int = 0


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("next_camera"):
		switch_to_next_camera()
	elif event.is_action_pressed("previous_camera"):
		switch_to_previous_camera()	


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
