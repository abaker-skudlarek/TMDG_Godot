extends Node3D

var cameras_in_level: Array
var current_camera_index: int = 0


func _ready() -> void:
    # TODO: May want to have the thing spawning the levels checking this, not a player
    var levels := get_tree().get_nodes_in_group("level")
    assert(levels.size() == 1, "The number of levels {%s} in the main scene != 1" %levels.size())

    cameras_in_level = levels[0].cameras
    print_debug(cameras_in_level)
    cameras_in_level[current_camera_index].camera.current = true  # Set the first camera to be on by default



func _unhandled_key_input(event: InputEvent) -> void:
    if event.is_action_pressed("next_camera"):
        switch_to_next_camera()
    elif event.is_action_pressed("previous_camera"):
        switch_to_previous_camera()


func switch_to_next_camera() -> void:
    current_camera_index += 1
    if current_camera_index >= cameras_in_level.size():
        current_camera_index = 0
    cameras_in_level[current_camera_index].camera.current = true


func switch_to_previous_camera() -> void:
    current_camera_index -= 1
    if current_camera_index < 0:
    current_camera_index = cameras_in_level.size() - 1
    cameras_in_level[current_camera_index].camera.current = true
