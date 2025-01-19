extends Control

const PORT: int = 9999 
const ADDRESS: String = "localhost"
const MAX_PLAYERS: int = 2

@export var spy_scene: PackedScene

var enet_peer := ENetMultiplayerPeer.new()


func _on_join_game_pressed() -> void:
	join_game()


func _on_host_game_pressed() -> void:
	host_game()


func host_game() -> void:
	hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(spawn_player)
	spawn_player(multiplayer.get_unique_id())


# TODO: THIS ISN"T WORKING FOR SOME REASON IDK WHY THE CLIENT ISN"T SPAWNING
# TODO: Might have to revert back to main and try this all again following the "Online Multiplayer FPS From Scratch" video


func join_game() -> void:
	hide()
	enet_peer.create_client(ADDRESS, PORT)
	print("client created")
	multiplayer.multiplayer_peer = enet_peer
	print("enet peer set")


func spawn_player(peer_id: int) -> void:
	print_debug("id: {%s} spawning player" % multiplayer.get_unique_id())
	var player: Node3D = spy_scene.instantiate()
	player.name = str(peer_id)
	get_tree().root.get_node("Main").add_child(player)
