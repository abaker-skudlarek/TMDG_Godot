extends Node3D
class_name PlayerControlledCamera

const MOUSE_SENS: float = 0.0005
const X_LOWER_CLAMP: int = -20
const X_UPPER_CLAMP: int = 0
const Y_LOWER_CLAMP: int = -45
const Y_UPPER_CLAMP: int = 45

@onready var rotation_point := $RotationPoint
@onready var camera := $RotationPoint/Camera3D

func _unhandled_input(event: InputEvent) -> void:
	# If window is clicked, capture mouse. Release capture after pressing "esc" 
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)	
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion and camera.current:
			# Rotate
			rotation_point.rotate_y(-event.relative.x * MOUSE_SENS)
			camera.rotate_x(-event.relative.y * MOUSE_SENS)
			# Clamp rotation
			rotation_point.rotation.y = clamp(rotation_point.rotation.y, deg_to_rad(Y_LOWER_CLAMP), deg_to_rad(Y_UPPER_CLAMP))
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(X_LOWER_CLAMP), deg_to_rad(X_UPPER_CLAMP))
