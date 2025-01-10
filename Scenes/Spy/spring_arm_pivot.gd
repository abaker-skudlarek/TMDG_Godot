extends Node3D

const CAMERA_BLEND: float = 0.05
const MOUSE_SENS: float = 0.003

@onready var spring_arm : SpringArm3D = $SpringArm3D
@onready var camera : Camera3D = $SpringArm3D/Camera3D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENS)
		spring_arm.rotate_x(-event.relative.y * MOUSE_SENS)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -PI/4, PI/4)
	# TODO: This is for debugging and allowing us to switch between windows easier when the game is running
	elif event.is_action_pressed("release_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("capture_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
