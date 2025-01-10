extends Node

var spy_scene: PackedScene = load("res://Scenes/Spy/spy.tscn")
var connected_players := {}


func _ready() -> void:
	SignalBus.connect("level_loaded", _on_level_loaded)


# TODO: Probably want something else to handle the spawning of players, but this is fine for now
func _on_level_loaded(_camera_spawn_points: Array, spy_spawn_points: Array) -> void:
	spawn_players(spy_spawn_points)


func add_player_to_connected_players(player_name: String, player_id: int) -> void:
	# TODO: if the player id is already in the list, maybe we should check to see if the 
	# 		sent in information is different, and if it is, update it
	if connected_players.has(player_id):
		return
	connected_players[player_id] = {
		"name": player_name,
		"id": player_id
	}
	print("{%s} (id: {%s}) added to connected_players" % [player_name, player_id])


func spawn_players(spawn_points: Array) -> void:
	var index := 0
	for key: int in connected_players:
		var player: Node3D = spy_scene.instantiate()
		player.position = spawn_points[index]
		get_tree().root.add_child(player)
		index += 1
