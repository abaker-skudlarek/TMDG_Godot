extends Node3D

# TODO: This will probably become some sort of common file that all Levels have, not just this one


func _ready() -> void:
    broadcast_camera_spawn_points()


func broadcast_camera_spawn_points() -> void:
    var spawn_points := []
    for spawn_point: Node3D in $CameraSpawnPoints.get_children():
        spawn_points.append({
            "position": spawn_point.position,
            "rotation": spawn_point.rotation
        })
    SignalBus.emit_signal("broadcast_camera_spawn_points", spawn_points)