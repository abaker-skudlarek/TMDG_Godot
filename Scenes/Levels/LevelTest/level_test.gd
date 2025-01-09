extends Node3D

# TODO: This will probably become some sort of common file that all Levels have, not just this one


func _ready() -> void:
    var camera_spawn_points: Array = _get_camera_spawn_points()
    SignalBus.emit_signal("level_loaded", camera_spawn_points)


func _get_camera_spawn_points() -> Array:
    var spawn_points := []
    for spawn_point: Node3D in $CameraSpawnPoints.get_children():
        spawn_points.append({
            "position": spawn_point.position,
            "rotation": spawn_point.rotation
        })
    return spawn_points
