extends Node3D

@export var cameras: Array[Node] = []

var current_camera_index: int = 0

func _ready() -> void:
	cameras[current_camera_index].camera.current = true  # Set the first camera to be on by default


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
	print(current_camera_index)
	

func switch_to_previous_camera() -> void:
	current_camera_index -= 1
	if current_camera_index < 0:
		current_camera_index = cameras.size() - 1
	cameras[current_camera_index].camera.current = true
	print(current_camera_index)
